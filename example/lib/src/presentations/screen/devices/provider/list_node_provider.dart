import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final listNodeProvider = FutureProvider.autoDispose<List<ProvisionedMeshNode>>((ref) async {
  final apolloDev = NordicNrfMesh();
  final meshNet = await apolloDev.meshManagerApi.loadMeshNetwork();
  final listNodes = await meshNet.nodes;
  return listNodes;
});
