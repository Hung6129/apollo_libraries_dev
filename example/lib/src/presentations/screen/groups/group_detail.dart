import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:flutter/material.dart';

import '../../widget/app_bar.dart';

class GroupDetailScreen extends StatefulWidget {
  final GroupData groupData;
  const GroupDetailScreen({
    Key? key,
    required this.groupData,
  }) : super(key: key);

  @override
  State<GroupDetailScreen> createState() => _GroupDetailScreenState();
}

class _GroupDetailScreenState extends State<GroupDetailScreen> {
  @override
  Widget build(BuildContext context) {
    /// build appbar
    PreferredSizeWidget buildAppBar() {
      return CustomAppBar(
        title: widget.groupData.name,
        centerTitle: false,
        subTitle: '0x${widget.groupData.address.toRadixString(16).padLeft(4, "0")}',
      );
    }

    /// build boody
    Widget buildBody() {
      return const Center(
        child: Text("Tính năng đang phát triển"),
      );
    }

    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }
}
