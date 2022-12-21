import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widget/app_bar_main.dart';

class SceneScreen extends StatefulWidget {
  final NordicNrfMesh nrfMesh;

  const SceneScreen({Key? key, required this.nrfMesh}) : super(key: key);

  @override
  State<SceneScreen> createState() => _SceneScreenState();
}

class _SceneScreenState extends State<SceneScreen> {
  @override
  Widget build(BuildContext context) {
    /// build boody
    Widget buildBody() {
      return const Center(child: Text("Tính năng đang được phát triển"));
    }

    /// build floating btn
    void floatingActionBtnOnTapped() {
      debugPrint("Tapped");
    }

    Widget buildFloatingActionBtn() {
      return FloatingActionButton.extended(
        label: const Text('Thêm ngữ cảnh'),
        icon: const Icon(CupertinoIcons.add),
        onPressed: () => floatingActionBtnOnTapped(),
      );
    }

    return Scaffold(
      appBar: CustomAppBarMain(
        centerTitle: true,
        nrfMesh: widget.nrfMesh,
        title: "Ngữ cảnh",
      ),
      body: buildBody(),
      floatingActionButton: buildFloatingActionBtn(),
    );
  }
}
