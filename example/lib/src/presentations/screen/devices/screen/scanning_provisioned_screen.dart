// import 'dart:async';
// import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
// import 'package:provider/provider.dart';
// import '../../../../config/strings.dart';
// import '../../../../repo/permissions.dart';
// import '../../../widget/app_bar.dart';
// import '../../../widget/no_found_screen.dart';
// import '../control_module/device_module.dart';
// import '../provider/scanning/ble_scanner.dart';
// import '../widget/discovered_node.dart';

// class ScanProvisionedDevice extends StatelessWidget {
//   final NordicNrfMesh nrfMesh;

//   const ScanProvisionedDevice({Key? key, required this.nrfMesh}) : super(key: key);

//   @override
//   Widget build(BuildContext context) => Consumer2<BleScanner2, BleScanner2State?>(
//         builder: (_, bleScanner, bleScannerState, __) => _DeviceList(
//           nrfMesh: nrfMesh,
//           scannerState: bleScannerState ??
//               const BleScanner2State(
//                 discoveredDevices: [],
//                 scanIsInProgress: false,
//               ),
//           startScan: bleScanner.startScanProvisioned,
//           stopScan: bleScanner.stopScan,
//         ),
//       );
// }

// class _DeviceList extends StatefulWidget {
//   const _DeviceList({
//     required this.scannerState,
//     required this.startScan,
//     required this.stopScan,
//     required this.nrfMesh,
//   });
//   final NordicNrfMesh nrfMesh;

//   final BleScanner2State scannerState;
//   final void Function(List<Uuid>) startScan;
//   final VoidCallback stopScan;

//   @override
//   _DeviceListState createState() => _DeviceListState();
// }

// class _DeviceListState extends State<_DeviceList> {
//   late MeshManagerApi meshManagerApi;

//   @override
//   void initState() {
//     super.initState();
//     Permissions().checkAndAskPermissions();
//     meshManagerApi = widget.nrfMesh.meshManagerApi;
//     widget.startScan([]);
//   }

//   @override
//   void dispose() {
//     widget.stopScan();
//     super.dispose();
//   }

// // chuyển tới trang cấu hình thiết bị
//   Future<void> navToProvisionedNode(DiscoveredDevice device) async {
//     widget.stopScan();
//     await Navigator.push(
//       context,
//       MaterialPageRoute<void>(
//         builder: (BuildContext context) => DeviceModule(
//           meshManagerApi: widget.nrfMesh.meshManagerApi,
//           device: device,
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) => Scaffold(
//         backgroundColor: Colors.white,
//         appBar: const CustomAppBar(
//           title: Strings.scanTitle,
//           centerTitle: false,
//           subTitle: Strings.scanSubTitleProvisioned,
//         ),
//         body: Column(
//           children: [
//             widget.scannerState.discoveredDevices.isEmpty
//                 ? const NoFoundScreen(
//                     isSearchingForNode: true,
//                     iconData: Icons.bluetooth,
//                     title: Strings.noFoundNode,
//                     subTitle: Strings.noFoundNodeRecommending,
//                   )
//                 : Expanded(
//                     child: ListView.builder(
//                       physics: const BouncingScrollPhysics(),
//                       padding: const EdgeInsets.only(bottom: 100),
//                       // shrinkWrap: true,
//                       itemCount: widget.scannerState.discoveredDevices.length,
//                       itemBuilder: (context, index) => GestureDetector(
//                         onTap: () async => await navToProvisionedNode(
//                           widget.scannerState.discoveredDevices[index],
//                         ),
//                         child: DiscoveredNode(
//                             isProvisionedNode: true, device: widget.scannerState.discoveredDevices.elementAt(index)),
//                       ),
//                     ),
//                   ),
//           ],
//         ),
//       );
// }

import 'dart:async';

import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import '../../../../config/strings.dart';
import '../../../../repo/permissions.dart';
import '../../../widget/app_bar.dart';
import '../../../widget/no_found_screen.dart';
import '../control_module/device_module.dart';
import '../widget/discovered_node.dart';

class ProvisionedDevices extends StatefulWidget {
  final NordicNrfMesh nordicNrfMesh;

  const ProvisionedDevices({Key? key, required this.nordicNrfMesh}) : super(key: key);

  @override
  State<ProvisionedDevices> createState() => _ProvisionedDevicesState();
}

class _ProvisionedDevicesState extends State<ProvisionedDevices> {
  late MeshManagerApi _meshManagerApi;
  final _devices = <DiscoveredDevice>{};
  bool isScanning = false;
  StreamSubscription<DiscoveredDevice>? _scanSubscription;

  DiscoveredDevice? _device;

  @override
  void initState() {
    super.initState();
    _meshManagerApi = widget.nordicNrfMesh.meshManagerApi;
    _scanProvisionned();
  }

  @override
  void dispose() {
    super.dispose();
    _scanSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(
        title: Strings.scanTitle,
        centerTitle: false,
        subTitle: Strings.scanSubTitleProvisioned,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          if (isScanning) {
            return Future.value();
          }
          return _scanProvisionned();
        },
        child: Column(
          children: [
            if (isScanning) const LinearProgressIndicator(),
            if (_device == null) ...[
              if (isScanning && _devices.isEmpty)
                const NoFoundScreen(
                  isSearchingForNode: true,
                  iconData: Icons.bluetooth,
                  title: Strings.noFoundNode,
                  subTitle: Strings.noFoundNodeRecommending,
                ),
              if (_devices.isNotEmpty)
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(8),
                    children: [
                      for (var i = 0; i < _devices.length; i++)
                        GestureDetector(
                            onTap: () async {
                              _scanSubscription?.cancel();
                              await Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) => DeviceModule(
                                      device: _devices.elementAt(i),
                                      meshManagerApi: _meshManagerApi,
                                      onDisconnect: () {
                                        _device = null;
                                        _scanProvisionned();
                                      }),
                                ),
                              );
                            },
                            child: DiscoveredNode(
                              device: _devices.elementAt(i),
                              isProvisionedNode: true,
                              key: ValueKey('node-$i'),
                            )),
                    ],
                  ),
                ),
            ]
          ],
        ),
      ),
    );
  }

  Future<void> _scanProvisionned() async {
    setState(() {
      _devices.clear();
    });
    await Permissions().checkAndAskPermissions();
    _scanSubscription = widget.nordicNrfMesh.scanForProxy().listen((device) async {
      final dS = device.serviceData[meshProxyUuid]!;
      if (_devices.every((d) => d.id != device.id) &&
          (await widget.nordicNrfMesh.meshManagerApi.networkIdMatches(dS) ||
              await widget.nordicNrfMesh.meshManagerApi.nodeIdentityMatches(dS))) {
        setState(() {
          _devices.add(device);
        });
      }
    });
    setState(() {
      isScanning = true;
    });
    return Future.delayed(const Duration(seconds: 20), _stopScan);
  }

  Future<void> _stopScan() async {
    await _scanSubscription?.cancel();
    isScanning = false;
    if (mounted) {
      setState(() {});
    }
  }
}
