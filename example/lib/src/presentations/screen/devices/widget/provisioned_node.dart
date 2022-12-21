import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../config/palettes.dart';
import '../../../../config/strings.dart';
import '../../../../config/text_style.dart';
import '../../../widget/get_snack_bar.dart';
import '../control_module/device_controll_module.dart';

class ProvisionedNodeItems extends StatefulWidget {
  final IMeshNetwork meshNetwork;
  final NordicNrfMesh nrfMesh;
  final ProvisionedMeshNode node;
  final String testKey;
  const ProvisionedNodeItems(
      {Key? key, required this.node, required this.testKey, required this.meshNetwork, required this.nrfMesh})
      : super(key: key);

  @override
  State<ProvisionedNodeItems> createState() => _ProvisionedNodeItemsState();
}

class _ProvisionedNodeItemsState extends State<ProvisionedNodeItems> {
  String _name = 'loading...';
  List<ElementData> _elements = [];
  int _unicast = 0;

  @override
  void initState() {
    super.initState();
    widget.node.elements.then((value) => setState(() => _elements = value));
    widget.node.unicastAddress.then((value) => setState(() => _unicast = value));
    widget.node.name.then((value) => setState(() => _name = value.toString()));
  }

  @override
  void didUpdateWidget(covariant ProvisionedNodeItems oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.node.elements.then((value) => setState(() => _elements = value));
    widget.node.unicastAddress.then((value) => setState(() => _unicast = value));
    widget.node.name.then((value) => setState(() => _name = value.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // chuyển sang trang cấu hình
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => DeviceControllModule(
            meshManagerApi: widget.nrfMesh.meshManagerApi,
            nodeData: widget.node,
          ),
        ),
      ),
      // xoá thủ công thiết bị
      onLongPress: () => Get.bottomSheet(
        SizedBox(
          height: 150,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Text('Bạn muốn ?', style: TextStyles.defaultStyle.fontHeader.redTextColor.bold),
              TextButton(
                  onPressed: () async {
                    await widget.meshNetwork.deleteNode(widget.node.uuid);
                    Get.back();
                    setState(() {});
                    showCustomSnackBar(
                        Strings.dialogTitleUpdated, Strings.dialogTitleUpdatedDelete(_name), Colors.green, Icons.done);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.delete, color: Palettes.p7),
                      const SizedBox(width: 10),
                      Text('Xoá thiết bị thủ công', style: TextStyles.defaultStyle.redTextColor),
                    ],
                  )),
              TextButton(
                  onPressed: () async {},
                  child: Row(
                    children: [
                      const Icon(Icons.restart_alt, color: Palettes.p7),
                      const SizedBox(width: 10),
                      Text('Reset thiết bị', style: TextStyles.defaultStyle.redTextColor),
                    ],
                  )),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 3,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
      ),
      child: Card(
        key: Key(widget.testKey),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: ListTile(
          title: Text(_name, style: TextStyles.defaultStyle.bold),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText(widget.node.uuid.toUpperCase(), maxLines: 1),
              Text("Element: ${_elements.length}"),
              Text("Address: ${_unicast.toRadixString(16).padLeft(4, '0')}"),
              // ..._elements.map(
              //   (e) => ElementNodeData(elmentData: e),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
