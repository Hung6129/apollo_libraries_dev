import 'dart:async';

import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import '../../../../config/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import '../../../../config/palettes.dart';
import 'commands/generic/send_generic_level_get.dart';
import 'commands/generic/send_generic_on_off_set.dart';
import 'commands/pub-sub/send_config_model_publication_add.dart';
import 'commands/pub-sub/send_config_model_subscription_add.dart';

import 'commands/send_deprovisioning.dart';

import 'commands/lighting/send_light_hsl.dart';

class DeviceModule extends StatefulWidget {
  final DiscoveredDevice device;
  final MeshManagerApi meshManagerApi;
  final VoidCallback onDisconnect;
  const DeviceModule({
    Key? key,
    required this.device,
    required this.meshManagerApi,
    required this.onDisconnect,
  }) : super(key: key);

  @override
  State<DeviceModule> createState() => _DeviceModuleState();
}

class _DeviceModuleState extends State<DeviceModule> {
  final bleMeshManager = BleMeshManager();
  late int intSeq = 0;
  bool isLoading = true;
  late List<ProvisionedMeshNode> nodes;

  // auto set blind appkey
  Future<void> _init() async {
    bleMeshManager.callbacks = DoozProvisionedBleMeshManagerCallbacks(widget.meshManagerApi, bleMeshManager);
    await bleMeshManager.connect(widget.device);
    // get nodes (ignore first node which is the default provisioner)
    nodes = (await widget.meshManagerApi.meshNetwork!.nodes).skip(1).toList();
    // will bind app keys (needed to be able to configure node)
    for (final node in nodes) {
      final elements = await node.elements;
      for (final element in elements) {
        for (final model in element.models) {
          if (model.boundAppKey.isEmpty) {
            if (element == elements.first && model == element.models.first) {
              continue;
            }
            final unicast = await node.unicastAddress;
            debugPrint('need to bind app key');
            intSeq = await widget.meshManagerApi.getSequenceNumber(node);
            debugPrint('Sequence num: $intSeq');
            await widget.meshManagerApi.sendConfigModelAppBind(
              unicast,
              element.address,
              model.modelId,
            );
          }
        }
      }
    }

    setState(() {
      isLoading = false;
    });
  }

  void _deinit() async {
    await bleMeshManager.disconnect();
    await bleMeshManager.callbacks!.dispose();
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  void dispose() {
    _deinit();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// build appbar
    PreferredSizeWidget buildAppBar() {
      return AppBar(
        // title: Text(widget.device.name, style: TextStyles.defaultStyle.bold),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: Palettes.gradientAppBar),
        ),
        centerTitle: false,
      );
    }

    //build body
    Widget buildBody() {
      return SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              title: Text("Tên thiết bị", style: TextStyles.defaultStyle.bold),
              subtitle: Text(widget.device.name, style: TextStyles.defaultStyle.regular),
            ),
            SendGenericLevel(meshManagerApi: widget.meshManagerApi),
            SendGenericOnOffSet(meshManagerApi: widget.meshManagerApi),
            SendConfigModelPublicationAdd(widget.meshManagerApi),
            SendConfigModelSubscriptionAdd(widget.meshManagerApi),
            SendLightHsl(meshManagerApi: widget.meshManagerApi, sequence: intSeq),
            SendDeprovisioning(meshManagerApi: widget.meshManagerApi),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: buildAppBar(),
      body: isLoading
          ? Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: const [
              CircularProgressIndicator(),
              Text('Connecting ...'),
            ]))
          : buildBody(),
    );
  }
}

class DoozProvisionedBleMeshManagerCallbacks extends BleMeshManagerCallbacks {
  final MeshManagerApi meshManagerApi;
  final BleMeshManager bleMeshManager;

  late StreamSubscription<ConnectionStateUpdate> onDeviceConnectingSubscription;
  late StreamSubscription<ConnectionStateUpdate> onDeviceConnectedSubscription;
  late StreamSubscription<BleManagerCallbacksDiscoveredServices> onServicesDiscoveredSubscription;
  late StreamSubscription<DiscoveredDevice> onDeviceReadySubscription;
  late StreamSubscription<BleMeshManagerCallbacksDataReceived> onDataReceivedSubscription;
  late StreamSubscription<BleMeshManagerCallbacksDataSent> onDataSentSubscription;
  late StreamSubscription<ConnectionStateUpdate> onDeviceDisconnectingSubscription;
  late StreamSubscription<ConnectionStateUpdate> onDeviceDisconnectedSubscription;
  late StreamSubscription<List<int>> onMeshPduCreatedSubscription;

  DoozProvisionedBleMeshManagerCallbacks(this.meshManagerApi, this.bleMeshManager) {
    onDeviceConnectingSubscription = onDeviceConnecting.listen((event) {
      debugPrint('onDeviceConnecting $event');
    });
    onDeviceConnectedSubscription = onDeviceConnected.listen((event) {
      debugPrint('onDeviceConnected $event');
    });

    onServicesDiscoveredSubscription = onServicesDiscovered.listen((event) {
      debugPrint('onServicesDiscovered');
    });

    onDeviceReadySubscription = onDeviceReady.listen((event) async {
      debugPrint('onDeviceReady ${event.id}');
    });

    onDataReceivedSubscription = onDataReceived.listen((event) async {
      debugPrint('onDataReceived ${event.device.id} ${event.pdu} ${event.mtu}');
      await meshManagerApi.handleNotifications(event.mtu, event.pdu);
    });
    onDataSentSubscription = onDataSent.listen((event) async {
      debugPrint('onDataSent ${event.device.id} ${event.pdu} ${event.mtu}');
      await meshManagerApi.handleWriteCallbacks(event.mtu, event.pdu);
    });

    onDeviceDisconnectingSubscription = onDeviceDisconnecting.listen((event) {
      debugPrint('onDeviceDisconnecting $event');
    });
    onDeviceDisconnectedSubscription = onDeviceDisconnected.listen((event) {
      debugPrint('onDeviceDisconnected $event');
    });

    onMeshPduCreatedSubscription = meshManagerApi.onMeshPduCreated.listen((event) async {
      debugPrint('onMeshPduCreated $event');
      await bleMeshManager.sendPdu(event);
    });
  }

  @override
  Future<void> dispose() => Future.wait([
        onDeviceConnectingSubscription.cancel(),
        onDeviceConnectedSubscription.cancel(),
        onServicesDiscoveredSubscription.cancel(),
        onDeviceReadySubscription.cancel(),
        onDataReceivedSubscription.cancel(),
        onDataSentSubscription.cancel(),
        onDeviceDisconnectingSubscription.cancel(),
        onDeviceDisconnectedSubscription.cancel(),
        onMeshPduCreatedSubscription.cancel(),
        super.dispose(),
      ]);

  @override
  Future<void> sendMtuToMeshManagerApi(int mtu) => meshManagerApi.setMtu(mtu);
}
