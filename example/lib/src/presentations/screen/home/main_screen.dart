import 'dart:async';
import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:flutter/material.dart';
import '../../../repo/permissions.dart';
import '../devices/screen/device_screen.dart';
import '../groups/group_screen.dart';
import '../scenes/context_screen.dart';
import '../settings/screen/setting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late IMeshNetwork _meshNetwork;
  late MeshManagerApi _meshManagerApi;
  final nrfMesh = NordicNrfMesh();

  ///
  late final StreamSubscription<IMeshNetwork?> onNetworkUpdateSubscription;
  late final StreamSubscription<IMeshNetwork?> onNetworkImportSubscription;
  late final StreamSubscription<IMeshNetwork?> onNetworkLoadingSubscription;

  ///
  void loadMeshData(MeshManagerApi meshManagerApi) async {
    Future.delayed(
      const Duration(seconds: 1),
      () async => await meshManagerApi.loadMeshNetwork(),
    ).whenComplete(
      () => _meshNetwork = _meshManagerApi.meshNetwork!,
    );
    await meshManagerApi.loadMeshNetwork();
  }

  @override
  void initState() {
    super.initState();
    Permissions().checkAndAskPermissions();
    _meshManagerApi = nrfMesh.meshManagerApi;
    loadMeshData(_meshManagerApi);
    onNetworkUpdateSubscription = _meshManagerApi.onNetworkUpdated.listen((event) {
      setState(() {
        _meshNetwork = event;
      });
    });
    onNetworkImportSubscription = _meshManagerApi.onNetworkImported.listen((event) {
      setState(() {
        _meshNetwork = event;
      });
    });
    onNetworkLoadingSubscription = _meshManagerApi.onNetworkLoaded.listen((event) {
      setState(() {
        _meshNetwork = event;
      });
    });
  }

  @override
  void dispose() {
    onNetworkUpdateSubscription.cancel();
    onNetworkLoadingSubscription.cancel();
    onNetworkImportSubscription.cancel();
    super.dispose();
  }

  int _selectedIndex = 0;

  List<Widget> _buildScreens() {
    return [
      SceneScreen(nrfMesh: nrfMesh),
      GroupScreen(
        meshNetwork: _meshNetwork,
        meshManagerApi: _meshManagerApi,
        nrfMesh: nrfMesh,
      ),
      DeviceScreen(
        nrfMesh: nrfMesh,
        meshNetwork: _meshNetwork,
      ),
      SettingScreen(meshManagerApi: _meshManagerApi, meshNetwork: _meshNetwork),
    ];
  }

  List<BottomNavigationBarItem> _navBarsItems() {
    return [
      const BottomNavigationBarItem(
        icon: Icon(Icons.movie_filter),
        label: ("Ngữ cảnh"),
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.group_work_rounded),
        label: ("Nhóm"),
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.now_widgets_sharp),
        label: ("Thiết bị"),
      ),
      const BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: ("Cài đặt"),
      ),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildScreens().elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        elevation: 4,
        type: BottomNavigationBarType.fixed,
        items: _navBarsItems(),
        currentIndex: _selectedIndex,
        showUnselectedLabels: false,
        selectedItemColor: Colors.redAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
