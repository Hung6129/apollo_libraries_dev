import 'dart:async';

import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final scanningUnProvisionedNodeProvider = StreamProvider<DiscoveredDevice>((ref) async* {
  final apolloDev = NordicNrfMesh();
  StreamSubscription sub;

  sub = apolloDev.scanForUnprovisionedNodes().listen((device) {
    debugPrint(device.name);
  });

  ref.onDispose(() {
    sub.cancel();
  });
  return;
});
