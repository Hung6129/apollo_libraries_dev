import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../config/animations/data_not_found_animation_view.dart';
import '../../../config/text_style.dart';
import '../../widget/app_bar_main.dart';
import '../../widget/fab_widget.dart';
import 'widget/group_widget.dart';

class GroupScreen extends StatefulWidget {
  final NordicNrfMesh nrfMesh;
  final IMeshNetwork meshNetwork;
  final MeshManagerApi meshManagerApi;
  const GroupScreen({
    Key? key,
    required this.meshNetwork,
    required this.meshManagerApi,
    required this.nrfMesh,
  }) : super(key: key);

  @override
  State<GroupScreen> createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  List<GroupData> _groups = [];

  @override
  void initState() {
    super.initState();
    widget.meshNetwork.groups.then((value) => setState(() => _groups = value.reversed.toList()));
  }

  @override
  void didUpdateWidget(covariant GroupScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.meshNetwork.groups.then((value) => setState(() => _groups = value.reversed.toList()));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// build boody
    Widget buildBody() {
      return Column(children: [
        const SizedBox(height: 20),
        // hiển thị tổng số nhóm
        Text('Tổng số nhóm (${_groups.length})', style: TextStyles.defaultStyle.bold),
        const Divider(endIndent: 15, indent: 15, thickness: 2, color: Colors.redAccent),
        _groups.isEmpty
            ? const Expanded(
                child: DataNotFoundAnimationView(),
              )
            : Expanded(
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200,
                      childAspectRatio: 1,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: _groups.length,
                    itemBuilder: (context, index) => GroupWidget(
                          group: _groups[index],
                          meshNetWork: widget.meshNetwork,
                        )),
              )
      ]);
    }

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBarMain(
        centerTitle: true,
        nrfMesh: widget.nrfMesh,
        title: "Nhóm",
      ),
      body: buildBody(),
      floatingActionButton: FabWidget(
        title: 'Thêm nhóm mới',
        voidCallBack: () async {
          final groupName = await showDialog<String>(
              context: context,
              builder: (c) {
                String? groupName;
                return AlertDialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  title: Text(
                    "Tạo nhóm",
                    style: TextStyles.defaultStyle.bold.fontHeader.redTextColor,
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        autofocus: true,
                        // controller: textGroupName,
                        style: TextStyles.defaultStyle,
                        decoration: InputDecoration(
                          labelText: "Nhập tên nhóm mới",
                          prefixIcon: const Icon(Icons.group_work_sharp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onChanged: (textGroupName) => groupName = textGroupName,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextField(
                        readOnly: true,
                        enableInteractiveSelection: false,
                        style: TextStyles.defaultStyle,
                        decoration: InputDecoration(
                          hintText: _groups.length < 10
                              ? '0xC00${_groups.length}'
                              : _groups.length > 100
                                  ? '0xC${_groups.length}'
                                  : '0xC0${_groups.length}',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        // onChanged: (textGroupName) =>
                        //     groupName = textGroupName,
                      ),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(c, groupName);
                      },
                      child: Text(
                        'OK',
                        style: TextStyles.defaultStyle,
                      ),
                    ),
                  ],
                );
              });
          if (groupName != null && groupName.isNotEmpty) {
            try {
              await widget.meshManagerApi.meshNetwork!.addGroupWithName(groupName);
              Get.snackbar(
                "Thông báo",
                "Tạo nhóm $groupName thành công",
                icon: const Icon(Icons.done, color: Colors.green),
                backgroundColor: Colors.white,
                snackPosition: SnackPosition.TOP,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                duration: const Duration(seconds: 2),
                isDismissible: true,
              );
              widget.meshNetwork.groups.then((value) => setState(() => _groups = value.reversed.toList()));
            } on PlatformException catch (e) {
              debugPrint(e.toString());
              Get.snackbar(
                "Lỗi",
                'erorr: ${e.message}',
                icon: const Icon(Icons.error_rounded, color: Colors.yellowAccent),
                backgroundColor: Colors.white,
                snackPosition: SnackPosition.TOP,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                duration: const Duration(seconds: 2),
                isDismissible: true,
              );
            } catch (e) {
              debugPrint(e.toString());
              Get.snackbar(
                "Lỗi",
                'erorr: ${e.toString()}',
                icon: const Icon(Icons.warning_amber_rounded, color: Colors.redAccent),
                backgroundColor: Colors.white70,
                snackPosition: SnackPosition.TOP,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                duration: const Duration(seconds: 2),
                isDismissible: true,
              );
            }
          } else {
            Get.snackbar(
              "Thông báo",
              'Bạn chưa đặt tên nhóm',
              icon: const Icon(Icons.format_shapes_outlined, color: Colors.blueAccent),
              backgroundColor: Colors.white,
              snackPosition: SnackPosition.TOP,
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              duration: const Duration(seconds: 2),
              isDismissible: true,
            );
          }
        },
      ),
    );
  }
}
