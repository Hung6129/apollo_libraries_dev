import 'dart:convert';
import 'dart:io';
import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nordic_nrf_mesh_example/src/presentations/widget/get_snack_bar.dart';
import 'package:settings_ui/settings_ui.dart';
import '../../../../config/palettes.dart';
import '../../../../config/strings.dart';
import '../../../../config/text_style.dart';
import '../../../../data/model/mesh_network/mesh_data.dart';
import 'details/appkey/appkey_screen.dart';
import 'details/netkey/netkey_screen.dart';
import 'details/provisioner/provisioner_screen.dart';
import 'export_screen.dart';

class SettingScreen extends StatefulWidget {
  final IMeshNetwork meshNetwork;
  final MeshManagerApi meshManagerApi;
  const SettingScreen({
    Key? key,
    required this.meshNetwork,
    required this.meshManagerApi,
  }) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool indexIV = false;
  late String name = "loading...";
  late String netKeyLen = "loading...";
  late String appKeyLen = "loading...";
  late String provisioner = "loading...";
  late String scences = "loading...";
  late String lastReset = "loading...";
  late String version = "loading...";
  late List<Provisioner> provisioners = [];
  late List<NetKeys> networkKey = [];
  late List<AppKeys> appKey = [];

  @override
  void initState() {
    super.initState();
    widget.meshNetwork.name.then((value) => setState(() => name = value));
    widget.meshNetwork.provisioners.then((value) => setState(() => provisioners = value));
    getDataFormJsonData();
  }

  Future<MeshModel> getDataFormJsonData() async {
    final data = await widget.meshManagerApi.exportMeshNetwork();
    final jsonData = await jsonDecode(data!);
    lastReset = jsonData['timestamp'].toString();
    MeshModel meshModel = MeshModel.fromJson(jsonData);
    networkKey = meshModel.netKeys!;
    appKey = meshModel.appKeys!;
    appKeyLen = meshModel.appKeys!.length.toString();
    netKeyLen = meshModel.netKeys!.length.toString();
    return meshModel;
  }

  @override
  void didUpdateWidget(covariant SettingScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    widget.meshNetwork.name.then((value) => setState(() => name = value));
    widget.meshNetwork.provisioners.then((value) => setState(() => provisioners = value));
    // widget.meshNetwork.networkKeys.then((value) => setState(() => networkKey = value));
  }

  @override
  Widget build(BuildContext context) {
    /// build appbar
    PreferredSizeWidget buildAppBar() {
      return AppBar(
        title: Text(
          'Cài đặt',
          style: TextStyles.defaultStyle.fontHeader.whiteTextColor.bold.textSpacing(1),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: Palettes.gradientAppBar),
        ),
        centerTitle: true,
        actions: [
          // menu pop up
          PopupMenuButton<int>(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            icon: const Icon(CupertinoIcons.folder_fill),
            itemBuilder: (context) => [
              /// Xuất dữ liệu (file json)
              PopupMenuItem(
                  onTap: () {
                    // chuyển sang trang xuất dữ file json
                    Future.delayed(
                        const Duration(milliseconds: 0),
                        () => Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) {
                              return ExportScreen(meshManagerApi: widget.meshManagerApi);
                            })));
                  },
                  child: const Text(Strings.export)),

              // Nhập dữ liệu json
              PopupMenuItem(
                onTap: () async {
                  Future.delayed(
                    const Duration(seconds: 0),
                    () => Get.dialog(
                      AlertDialog(
                        title: Text('Nhập dữ liệu mới', style: TextStyles.defaultStyle.bold),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(Strings.importData1, style: TextStyles.defaultStyle),
                            const SizedBox(height: 5),
                            Text(Strings.importData2, style: TextStyles.defaultStyle.italic),
                            const SizedBox(height: 5),
                            Text(Strings.importData3, style: TextStyles.defaultStyle),
                          ],
                        ),
                        actions: [
                          TextButton(
                            child: Text(Strings.cancelText, style: TextStyles.defaultStyle.redTextColor),
                            onPressed: () => Get.back(),
                          ),
                          TextButton(
                            onPressed: () async {
                              Future.delayed(const Duration(seconds: 0), (() async {
                                Get.back();
                                final filePath = await FilePicker.platform.pickFiles(type: FileType.any);
                                if (filePath == null) {
                                  setState(() {
                                    getDataFormJsonData();
                                  });
                                  return showCustomSnackBar(Strings.dialogTitleData, Strings.dialogImportDataFail,
                                      Colors.redAccent, Icons.info);
                                }
                                final file = File(filePath.paths.first!);
                                final json = await file.readAsString();
                                await widget.meshManagerApi.importMeshNetworkJson(json);
                                setState(() {
                                  getDataFormJsonData();
                                });
                                showCustomSnackBar(Strings.dialogTitleData, Strings.dialogImportDataSuccess,
                                    Colors.greenAccent, Icons.import_export_rounded);
                              }));
                            },
                            child: Text(
                              Strings.continueText,
                              style: TextStyles.defaultStyle.blueTextColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: const Text(Strings.import),
              ),

              // Đặt lại hệ thống
              PopupMenuItem(
                onTap: () {
                  Future.delayed(
                    const Duration(seconds: 0),
                    () => Get.dialog(
                      AlertDialog(
                        title: const Text('Đặt lại hệ thống'),
                        content: const Text(Strings.importData1),
                        actions: [
                          TextButton(
                              child: Text(Strings.cancelText, style: TextStyles.defaultStyle.redTextColor),
                              onPressed: () => Get.back()),
                          TextButton(
                            onPressed: (() {
                              Future.delayed(const Duration(milliseconds: 500), widget.meshManagerApi.resetMeshNetwork)
                                  .whenComplete(() async {
                                Get.back();
                                showCustomSnackBar(Strings.dialogTitleData, Strings.dialogResetDataSuccess,
                                    Colors.greenAccent, Icons.restart_alt_rounded);
                                setState(() {
                                  getDataFormJsonData();
                                });
                              });
                            }),
                            child: Text(Strings.continueText, style: TextStyles.defaultStyle.blueTextColor),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                child: const Text(Strings.reset),
              ),
            ],
            offset: const Offset(0, 50),
            color: Colors.white,
            elevation: 2,
          ),
        ],
      );
    }

    /// build boody
    Widget buildBody() {
      return SettingsList(
        physics: const BouncingScrollPhysics(),
        sections: [
          SettingsSection(
            tiles: <SettingsTile>[
              // hện tên mesh network
              SettingsTile.navigation(
                leading: const Icon(Icons.label),
                title: Text(Strings.settingName, style: TextStyles.defaultStyle.semibold),
                value: Text(name, style: TextStyles.defaultStyle),
              ),

              // hiện tổng số provisioner
              SettingsTile.navigation(
                onPressed: (context) => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => ProvisionerScreen(
                      meshNetwork: widget.meshNetwork,
                      meshManagerApi: widget.meshManagerApi,
                    ),
                  ),
                ),
                leading: const Icon(Icons.list_rounded),
                title: Text(Strings.settingProvisioners, style: TextStyles.defaultStyle.semibold),
                value: Text(provisioners.length.toString(), style: TextStyles.defaultStyle),
              ),

              // hiện tổng số netkey
              SettingsTile.navigation(
                onPressed: (context) => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => NetkeyScreen(
                      netKey: networkKey,
                      meshManagerApi: widget.meshManagerApi,
                    ),
                  ),
                ),
                leading: const Icon(Icons.key_rounded),
                title: Text(Strings.settingNetKeys, style: TextStyles.defaultStyle.semibold),
                value: Text(netKeyLen, style: TextStyles.defaultStyle),
              ),

              // hiện tổng số appkey
              SettingsTile.navigation(
                onPressed: (context) => Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => AppkeyScreen(
                      appKeys: appKey,
                      meshManagerApi: widget.meshManagerApi,
                    ),
                  ),
                ),
                leading: const Icon(Icons.app_registration),
                title: Text(Strings.settingAppKeys, style: TextStyles.defaultStyle.semibold),
                value: Text(appKeyLen, style: TextStyles.defaultStyle),
              ),

              // hiện tổng số ngữ cảnh
              SettingsTile.navigation(
                leading: const Icon(Icons.view_array),
                title: Text(Strings.settingSences, style: TextStyles.defaultStyle.semibold),
                value: Text('0', style: TextStyles.defaultStyle),
              ),

              // set index IV
              SettingsTile.switchTile(
                leading: const Icon(Icons.switch_access_shortcut_rounded),
                onToggle: (value) {
                  setState(() {
                    indexIV = value;
                  });
                },
                initialValue: indexIV,
                title: Text(Strings.settingIVMode, style: TextStyles.defaultStyle.semibold),
              ),

              // lastime reset
              SettingsTile.navigation(
                leading: const Icon(Icons.change_circle_rounded),
                title: Text(Strings.settingLastRest, style: TextStyles.defaultStyle.semibold),
                value: Text(lastReset, style: TextStyles.defaultStyle),
              ),
            ],
          ),
          SettingsSection(
            tiles: <SettingsTile>[
              // app version
              SettingsTile.navigation(
                leading: const Icon(Icons.info),
                title: Text(Strings.settingAppVersion, style: TextStyles.defaultStyle.semibold),
                value: Text('1.0.0', style: TextStyles.defaultStyle),
              ),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(),
      body: buildBody(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.light_mode_rounded),
        label: const Text('  Day '),
      ),
    );
  }
}
