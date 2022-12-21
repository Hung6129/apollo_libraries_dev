import 'package:get/get.dart';
import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';

import '../presentations/screen/home/main_screen.dart';
import '../presentations/screen/splash/splash_screen.dart';

final apolloLibrariesDev = NordicNrfMesh();

class AppRouters {
  static String splashScreen = "/splash";
  static String mainScreen = "/main";
  static String scanAndProvisionedScreen = "/scanAndProvisioned";
  static String scanAndUnprovisionedScreen = "/scanAndUnprovisioned";
  static String loadingScreen = "/loading";

  static String getSplashScreen() => splashScreen;
  static String getMainScreen() => mainScreen;
  static String getLoadingScreen() => mainScreen;
  static String scanProvisionedScreen() => scanAndProvisionedScreen;
  static String scanUnprovisionScreen() => scanAndUnprovisionedScreen;
  static String getLoading() => loadingScreen;

  static List<GetPage> routes = [
    GetPage(
      name: splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: mainScreen,
      page: () => const MainScreen(),
    ),
    // GetPage(
    //   name: scanAndProvisionedScreen,
    //   page: () => ScanningProvisionedScreen(),
    // ),
    // GetPage(
    //   name: scanAndUnprovisionedScreen,
    //   page: () => const ScanningUnprovisionScreen(),
    // ),
    // GetPage(
    //   name: loadingScreen,
    //   page: () => LoadingScreen(),
    // ),
  ];
}
