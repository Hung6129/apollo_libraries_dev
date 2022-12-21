import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import '../../../../config/animations/data_not_found_animation_view.dart';
import '../../../widget/fab_widget.dart';
import 'package:flutter/material.dart';
import '../../../../config/text_style.dart';
import '../../../widget/app_bar_main.dart';
import '../widget/provisioned_node.dart';
import 'scanning_unprovision_screen.dart';

class DeviceScreen extends StatefulWidget {
  final IMeshNetwork meshNetwork;
  final NordicNrfMesh nrfMesh;
  const DeviceScreen({
    Key? key,
    required this.meshNetwork,
    required this.nrfMesh,
  }) : super(key: key);

  @override
  State<DeviceScreen> createState() => _DeviceScreenState();
}

class _DeviceScreenState extends State<DeviceScreen> {
  List<ProvisionedMeshNode> _nodes = [];

  @override
  void initState() {
    super.initState();
    widget.meshNetwork.nodes.then((value) => setState(() => _nodes = value.reversed.toList()));
  }

  @override
  void didUpdateWidget(covariant DeviceScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.meshNetwork.nodes.then((value) => setState(() => _nodes = value.reversed.toList()));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBarMain(
        centerTitle: true,
        nrfMesh: widget.nrfMesh,
        title: "Thiết bị",
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            _nodes.length == 1 ? 'Tổng số node (0)' : 'Tổng số node (${_nodes.skip(1).length})',
            style: TextStyles.defaultStyle.bold,
          ),
          const Divider(endIndent: 15, indent: 15, thickness: 2, color: Colors.redAccent),
          _nodes.length == 1
              ? const Expanded(
                  child: DataNotFoundAnimationView(),
                )
              : Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 100, top: 10, left: 8, right: 8),
                    itemCount: _nodes.skip(1).length,
                    itemBuilder: (context, index) {
                      return ProvisionedNodeItems(
                        nrfMesh: widget.nrfMesh,
                        meshNetwork: widget.meshNetwork,
                        node: _nodes[index],
                        testKey: 'node-${_nodes.indexOf(_nodes[index])}',
                      );
                    },
                  ),
                )
        ],
      ),
      // floating btn
      floatingActionButton: FabWidget(
        voidCallBack: () {
          Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) {
            return ScanUnProvisionedDevice(
              nrfMesh: widget.nrfMesh,
            );
          })).then((value) {
            setState(() {
              // widget.meshNetwork.nodes.then((value) => setState(() => _nodes = value));
            });
          });
        },
        title: 'Thêm thiết bị mới',
      ));
}
