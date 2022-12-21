// import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
// import 'package:flutter/material.dart';

// import '../../../../config/text_style.dart';
// import 'provisioned_node.dart';

// class ListProvisionedNodes extends StatefulWidget {
//   final IMeshNetwork? meshNetwork;

//   const ListProvisionedNodes({Key? key, required this.meshNetwork}) : super(key: key);

//   @override
//   State<ListProvisionedNodes> createState() => _ListProvisionedNodesState();
// }

// class _ListProvisionedNodesState extends State<ListProvisionedNodes> {
//   late List<ProvisionedMeshNode> _nodes = [];

//   @override
//   void initState() {
//     super.initState();
//     widget.meshNetwork!.nodes.then((value) => setState(() => _nodes = value));
//   }

//   @override
//   void didUpdateWidget(covariant ListProvisionedNodes oldWidget) {
//     super.didUpdateWidget(oldWidget);
//     // nodes, provisioners and groups may have changed
//     widget.meshNetwork!.nodes.then((value) => setState(() => _nodes = value));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 20),
//         Text(
//           'Tổng số node (${_nodes.length})',
//           style: TextStyles.defaultStyle.bold,
//         ),
//         const Divider(endIndent: 15, indent: 15, thickness: 2, color: Colors.redAccent),
//         Expanded(
//           child: ListView.builder(
//             physics: const BouncingScrollPhysics(),
//             padding: const EdgeInsets.only(bottom: 100, top: 10, left: 8, right: 8),
//             itemCount: _nodes.length,
//             itemBuilder: (context, index) {
//               return ProvisionedNodeItems(
//                 // nrfMesh: widget.nrfMesh,
//                 meshNetwork: widget.meshNetwork!,
//                 node: _nodes[index],
//                 testKey: 'node-${_nodes.indexOf(_nodes[index])}',
//               );
//             },
//           ),
//         )
//       ],
//     );
//   }
// }
