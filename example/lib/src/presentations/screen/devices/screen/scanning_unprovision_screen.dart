import 'dart:async';
import 'dart:io';
import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:provider/provider.dart';
import '../../../../config/palettes.dart';
import '../../../../config/strings.dart';
import '../../../../config/text_style.dart';
import '../../../../repo/permissions.dart';
import '../../../widget/app_bar.dart';
import '../../../widget/get_snack_bar.dart';
import '../../../widget/no_found_screen.dart';
import '../provider/scanning/ble_scanner2.dart';
import '../widget/discovered_node.dart';

class ScanUnProvisionedDevice extends StatelessWidget {
  final NordicNrfMesh nrfMesh;

  const ScanUnProvisionedDevice({Key? key, required this.nrfMesh}) : super(key: key);

  @override
  Widget build(BuildContext context) => Consumer2<BleScanner, BleScannerState?>(
        builder: (_, bleScanner, bleScannerState, __) => _DeviceList(
          nrfMesh: nrfMesh,
          scannerState: bleScannerState ??
              const BleScannerState(
                discoveredDevices: [],
                scanIsInProgress: false,
              ),
          startScan: bleScanner.startScanUnProvisioned,
          stopScan: bleScanner.stopScan,
        ),
      );
}

class _DeviceList extends StatefulWidget {
  const _DeviceList({
    required this.scannerState,
    required this.startScan,
    required this.stopScan,
    required this.nrfMesh,
  });
  final NordicNrfMesh nrfMesh;

  final BleScannerState scannerState;
  final void Function(List<Uuid>) startScan;
  final VoidCallback stopScan;

  @override
  _DeviceListState createState() => _DeviceListState();
}

class _DeviceListState extends State<_DeviceList> {
  late MeshManagerApi _meshManagerApi;

  @override
  void initState() {
    super.initState();
    Permissions().checkAndAskPermissions();
    _meshManagerApi = widget.nrfMesh.meshManagerApi;
    widget.startScan([]);
  }

  @override
  void dispose() {
    widget.stopScan();
    super.dispose();
  }

// hàm thực thi provisionig
  Future<void> provisionDevice(DiscoveredDevice device) async {
    widget.stopScan();
    try {
      // Android is sending the mac Adress of the device, but Apple generates
      // an UUID specific by smartphone.
      String deviceUUID;
      if (Platform.isAndroid) {
        deviceUUID =
            Uuid.parse(_meshManagerApi.getDeviceUuid(device.serviceData[meshProvisioningUuid]!.toList())).toString();
        debugPrint("Thiết bị đang ghép nối trên nền tảng android có uuid là $deviceUUID");
      } else if (Platform.isIOS) {
        deviceUUID = device.id.toString();
        debugPrint("Thiết bị đang ghép nối trên nền tảng ios có uuid là $deviceUUID");
      } else {
        throw UnimplementedError('device uuid on platform : ${Platform.operatingSystem}');
      }
      final provisioningEvent = ProvisioningEvent();
      // start to provisioning
      final provisionedMeshNodeF = widget.nrfMesh
          .provisioning(_meshManagerApi, BleMeshManager(), device, deviceUUID, events: provisioningEvent)
          // limit is 1 min
          .timeout(const Duration(seconds: 50));
      unawaited(provisionedMeshNodeF.then((node) async {
        Navigator.of(context).pop();
        showCustomSnackBar(
            Strings.dialogTitleAddNodeSuccess, Strings.dialogTitleSuccessMess(device.name), Colors.green, Icons.done);
        await Future.delayed(
          const Duration(milliseconds: 1000),
          () => Navigator.of(context).pop(),
        )
            // .whenComplete(() => Navigator.push(
            //     context,
            //     MaterialPageRoute<void>(
            //         builder: (BuildContext context) =>
            //             DeviceModule(meshManagerApi: widget.nrfMesh.meshManagerApi, device: device))))
            ;
      }).catchError((_) {
        Navigator.of(context).pop();
        showCustomSnackBar(Strings.dialogTitleFail, _.toString(), Colors.red, Icons.error_outline_rounded);
        widget.startScan([]);
      }));
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => ProvisioningDialog(provisioningEvent: provisioningEvent),
      );
    } catch (e) {
      showCustomSnackBar(Strings.dialogTitleFail, e.toString(), Colors.red, Icons.error_outline_rounded);
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.white,
        appBar: const CustomAppBar(
          title: Strings.scanTitle,
          centerTitle: false,
          subTitle: Strings.scanSubTitleUnProvisioned,
        ),
        body: Column(
          children: [
            widget.scannerState.discoveredDevices.isEmpty
                ? const NoFoundScreen(
                    isSearchingForNode: true,
                    iconData: Icons.bluetooth,
                    title: Strings.noFoundNode,
                    subTitle: Strings.noFoundNodeRecommending,
                  )
                : Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.only(bottom: 100, top: 10, left: 8, right: 8),
                      // shrinkWrap: true,
                      itemCount: widget.scannerState.discoveredDevices.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                            onTap: () => provisionDevice(widget.scannerState.discoveredDevices.elementAt(index)),
                            child: DiscoveredNode(
                              isProvisionedNode: false,
                              device: widget.scannerState.discoveredDevices.elementAt(index),
                            ));
                      },
                    ),
                  )
          ],
        ),
      );
}

/// events
// meshnetwork dialog
class ProvisioningDialog extends StatelessWidget {
  final ProvisioningEvent provisioningEvent;

  const ProvisioningDialog({Key? key, required this.provisioningEvent}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  LoadingAnimationWidget.threeRotatingDots(color: Palettes.p7, size: 40),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      ProvisioningState(
                        text: 'onProvisioningCapabilities',
                        stream: provisioningEvent.onProvisioningCapabilities.map((event) => true),
                      ),
                      ProvisioningState(
                        text: 'onProvisioning',
                        stream: provisioningEvent.onProvisioning.map((event) => true),
                      ),
                      ProvisioningState(
                        text: 'onProvisioningReconnect',
                        stream: provisioningEvent.onProvisioningReconnect.map((event) => true),
                      ),
                      ProvisioningState(
                        text: 'onConfigCompositionDataStatus',
                        stream: provisioningEvent.onConfigCompositionDataStatus.map((event) => true),
                      ),
                      ProvisioningState(
                        text: 'onConfigAppKeyStatus',
                        stream: provisioningEvent.onConfigAppKeyStatus.map((event) => true),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// meshnetwork state
class ProvisioningState extends StatelessWidget {
  final Stream<bool> stream;
  final String text;

  const ProvisioningState({Key? key, required this.stream, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: false,
      stream: stream,
      builder: (context, snapshot) {
        return Row(
          children: [
            Text(
              text,
              style: TextStyles.defaultStyle,
            ),
            const Spacer(),
            Checkbox(
              value: snapshot.data,
              onChanged: null,
            ),
          ],
        );
      },
    );
  }
}
