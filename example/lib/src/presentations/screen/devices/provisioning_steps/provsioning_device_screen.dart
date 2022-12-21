import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:settings_ui/settings_ui.dart';

import '../../../../config/text_style.dart';
import '../../../widget/app_bar.dart';

class ProvisioningDeviceScreen extends StatefulWidget {
  final DiscoveredDevice device;

  const ProvisioningDeviceScreen({Key? key, required this.device}) : super(key: key);

  @override
  State<ProvisioningDeviceScreen> createState() => _ProvisioningDeviceScreenState();
}

class _ProvisioningDeviceScreenState extends State<ProvisioningDeviceScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// build body
    Widget buildBody() {
      return SettingsList(
        physics: const BouncingScrollPhysics(),
        sections: [
          SettingsSection(
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                onPressed: (context) {},
                leading: const Icon(Icons.label),
                title: Text('Tên', style: TextStyles.defaultStyle.semibold),
                value: Text('nodeName', style: TextStyles.defaultStyle),
              ),
            ],
          ),
          SettingsSection(
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.list_alt_rounded),
                title: Text('Element 1', style: TextStyles.defaultStyle.semibold),
                value: Text('12', style: TextStyles.defaultStyle),
              ),
            ],
          ),
          SettingsSection(
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: const Icon(Icons.key_sharp),
                title: Text('Network Keys', style: TextStyles.defaultStyle.semibold),
                value: Text('1', style: TextStyles.defaultStyle),
              ),
              SettingsTile.navigation(
                leading: const Icon(Icons.key_rounded),
                title: Text('Application Keys', style: TextStyles.defaultStyle.semibold),
                value: Text('0', style: TextStyles.defaultStyle),
              ),
            ],
          ),
        ],
      );
    }

    return Scaffold(
      appBar: CustomAppBar(
        title: "Cấu hình thiết bị",
        centerTitle: false,
        listAction: [
          GestureDetector(
            onTap: () {},
            child: const Text("Ghép nối"),
          )
        ],
      ),
      body: buildBody(),
    );
  }
}
