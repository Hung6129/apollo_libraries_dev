import 'dart:async';

import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

import 'reactive_state.dart';

class BleScanner implements ReactiveState<BleScannerState> {
  BleScanner({
    required FlutterReactiveBle ble,
    required Function(String message) logMessage,
  })  : _ble = ble,
        _logMessage = logMessage;

  final FlutterReactiveBle _ble;
  final void Function(String message) _logMessage;
  final StreamController<BleScannerState> _stateStreamController = StreamController();

  final _devices = <DiscoveredDevice>[];

  @override
  Stream<BleScannerState> get state => _stateStreamController.stream;

  void startScanUnProvisioned(List<Uuid> serviceIds) {
    final apolloLib = NordicNrfMesh();
    _logMessage('Bắt đầu quét tìm unprovisioned node 🤖🤖🤖');
    _devices.clear();
    _subscription?.cancel();
    _subscription = apolloLib.scanForUnprovisionedNodes().listen((device) {
      final showedDevice = _devices.indexWhere((d) => d.id == device.id);
      if (showedDevice >= 0) {
        _devices[showedDevice] = device;
      } else {
        _devices.add(device);
      }
      _pushState();
    }, onError: (Object e) => _logMessage('Dò tìm thiết bị lỗi 💢: $e'));
    _pushState();
  }

  void _pushState() {
    _stateStreamController.add(
      BleScannerState(
        discoveredDevices: _devices,
        scanIsInProgress: _subscription != null,
      ),
    );
  }

  Future<void> stopScan() async {
    _logMessage('Dừng quá trình quét 🛑🛑🛑');

    await _subscription?.cancel();
    _subscription = null;
    _pushState();
  }

  Future<void> dispose() async {
    await _stateStreamController.close();
  }

  StreamSubscription? _subscription;
}

@immutable
class BleScannerState {
  const BleScannerState({
    required this.discoveredDevices,
    required this.scanIsInProgress,
  });

  final List<DiscoveredDevice> discoveredDevices;
  final bool scanIsInProgress;
}
