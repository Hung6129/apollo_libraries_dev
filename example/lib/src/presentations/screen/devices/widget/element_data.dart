import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:flutter/material.dart';

import 'model_node.dart';

class ElementNodeData extends StatelessWidget {
  final ElementData elmentData;
  const ElementNodeData({Key? key, required this.elmentData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // debugPrint(elmentData.models.map((e) => e.modelId.toRadixString(16)).toString());
    // debugPrint(elmentData.models.map((e) => e.boundAppKey).toString());
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [Text('Models: ${elmentData.models.length}'), ...elmentData.models.map((e) => ModelNode(e))],
    );
  }
}
