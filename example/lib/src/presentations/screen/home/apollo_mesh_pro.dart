import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../config/router.dart';

import '../devices/provider/scanning/ble_logger.dart';
import '../devices/provider/scanning/ble_logger2.dart';
import '../devices/provider/scanning/ble_scanner.dart';
import '../devices/provider/scanning/ble_scanner2.dart';

class ApolloMeshPro extends StatelessWidget {
  const ApolloMeshPro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bleLogger = BleLogger();
    final bleLogger2 = BleLogger2();
    final ble = FlutterReactiveBle();
    final scanner = BleScanner(ble: ble, logMessage: bleLogger.addToLog);
    final scanner2 = BleScanner2(ble: ble, logMessage: bleLogger.addToLog);
    return MultiProvider(
      providers: [
        Provider.value(value: scanner),
        Provider.value(value: scanner2),
        Provider.value(value: bleLogger),
        Provider.value(value: bleLogger2),
        StreamProvider<BleScannerState?>(
          create: (_) => scanner.state,
          initialData: const BleScannerState(
            discoveredDevices: [],
            scanIsInProgress: false,
          ),
        ),
        StreamProvider<BleScanner2State?>(
          create: (_) => scanner2.state,
          initialData: const BleScanner2State(
            discoveredDevices: [],
            scanIsInProgress: false,
          ),
        ),
      ],
      child: GetMaterialApp(
        title: 'ApolloMeshApp',
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ),
        initialRoute: AppRouters.getSplashScreen(),
        getPages: AppRouters.routes,
      ),
    );
  }
}
