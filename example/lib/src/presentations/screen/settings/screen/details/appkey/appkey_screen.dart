import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../../../../../config/palettes.dart';
import '../../../../../../config/text_style.dart';
import '../../../../../../data/model/mesh_network/mesh_data.dart';
import '../../../../../widget/app_bar.dart';
import 'appkey_detail.dart';

class AppkeyScreen extends StatefulWidget {
  final List<AppKeys> appKeys;
  final MeshManagerApi meshManagerApi;
  const AppkeyScreen({Key? key, required this.meshManagerApi, required this.appKeys}) : super(key: key);

  @override
  State<AppkeyScreen> createState() => _AppkeyScreenState();
}

class _AppkeyScreenState extends State<AppkeyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        centerTitle: false,
        title: "AppKeys",
      ),
      body: ListView.builder(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 100),
        itemCount: widget.appKeys.length,
        itemBuilder: (context, index) {
          return Slidable(
            // The end action pane is the one at the right or the bottom side.
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  autoClose: true,
                  onPressed: (context) async {},
                  backgroundColor: Palettes.p7,
                  foregroundColor: Colors.white,
                  icon: Icons.delete_sweep_rounded,
                  label: 'Xoá',
                ),
              ],
            ),
            child: InkWell(
                // chuyển sang trang cấu hình
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => AppkeyDetail(
                          appKeys: widget.appKeys[index],
                        ),
                      ),
                    ),
                child: ListTile(
                  leading: const Icon(
                    Icons.key_rounded,
                    color: Palettes.p7,
                  ),
                  subtitle: Text(
                    widget.appKeys[index].key!,
                    style: TextStyles.defaultStyle.regular,
                  ),
                  title: Text(
                    widget.appKeys[index].name!,
                    style: TextStyles.defaultStyle.fontTitle,
                  ),
                )),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Thêm AppKey mới'),
        icon: const Icon(CupertinoIcons.add),
        onPressed: () async {
          // final iMeshNet = widget.meshManagerApi.meshNetwork;
          // iMeshNet!.addProvisioner(0x0002, 123456, 123456, 123, name: "HungNguyen");
          // setState(() {});
        },
      ),
    );
  }
}
