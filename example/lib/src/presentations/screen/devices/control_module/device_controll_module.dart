import 'dart:async';
import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import '../../../../config/strings.dart';
import '../../../../presentations/widget/app_bar.dart';
import 'package:flutter/material.dart';
import '../../../../config/text_style.dart';
import '../widget/element_data.dart';

class DeviceControllModule extends StatefulWidget {
  final ProvisionedMeshNode nodeData;
  final MeshManagerApi meshManagerApi;

  const DeviceControllModule({
    Key? key,
    required this.meshManagerApi,
    required this.nodeData,
  }) : super(key: key);

  @override
  State<DeviceControllModule> createState() => _DeviceControllModuleState();
}

class _DeviceControllModuleState extends State<DeviceControllModule> {
  final bleMeshManager = BleMeshManager();

  late String nodeName = 'Loading...';
  bool isLoading = true;
  late List<ProvisionedMeshNode> nodes;
  List<ElementData> _elements = [];
  int uniCast = 0;
  String deviceKey = "";

  void _deinit() async {}

  @override
  void initState() {
    super.initState();
    _init();
    widget.nodeData.name.then((value) => setState(() => nodeName = value));
    widget.nodeData.elements.then((value) => setState(() => _elements = value));
    widget.nodeData.unicastAddress.then((value) => setState(() => uniCast = value));
  }

  @override
  void dispose() {
    _deinit();
    super.dispose();
  }

  @override
  void didUpdateWidget(DeviceControllModule oldWidget) {
    super.didUpdateWidget(oldWidget);
    _init();
    widget.nodeData.name.then((value) => setState(() => nodeName = value));
    widget.nodeData.elements.then((value) => setState(() => _elements = value));
    widget.nodeData.unicastAddress.then((value) => setState(() => uniCast = value));
  }

  // auto set blind appkey
  Future<void> _init() async {}

  @override
  Widget build(BuildContext context) {
    /// build boody
    Widget buildBody() {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(nodeName, style: TextStyles.defaultStyle),
            Text(widget.nodeData.uuid, style: TextStyles.defaultStyle),
            Text(_elements.length.toString(), style: TextStyles.defaultStyle),
            Text(uniCast.toRadixString(16).padLeft(4, '0').toString(), style: TextStyles.defaultStyle),
            ..._elements.map(
              (e) => ElementNodeData(elmentData: e),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: Strings.nodeConfig,
        centerTitle: false,
        subTitle: Strings.nodeConfigSub(nodeName),
      ),
      body: buildBody(),
    );
  }
}
