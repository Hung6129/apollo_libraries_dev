import 'package:flutter/material.dart';

import '../../../../../config/palettes.dart';
import '../../../../../config/text_style.dart';

class RadarDetailScreen extends StatefulWidget {
  const RadarDetailScreen({Key? key}) : super(key: key);

  @override
  State<RadarDetailScreen> createState() => _RadarDetailScreenState();
}

class _RadarDetailScreenState extends State<RadarDetailScreen> {
  @override
  Widget build(BuildContext context) {
    //** build appbar */
    PreferredSizeWidget buildAppBar() {
      return AppBar(
        title: Text(
          "Mesh",
          style: TextStyles.defaultStyle.fontHeader.whiteTextColor,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: Palettes.gradientAppBar),
        ),
        centerTitle: true,
      );
    }

    //** build body */
    Widget buildBody() {
      return SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 90,
                  width: 90,
                  decoration: const BoxDecoration(
                    gradient: Palettes.gradientCircle,
                    shape: BoxShape.circle,
                  ),
                  child: const Center(child: Text("Active")),
                ),
                Stack(
                  children: [
                    Container(
                      height: 90,
                      width: 90,
                      decoration: const BoxDecoration(gradient: Palettes.gradientCircle, shape: BoxShape.circle),
                    ),
                    Image.asset(
                      "assets/icons/radar.png",
                      height: 40,
                      width: 40,
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Image.asset(
                        "assets/icons/people.png",
                        height: 70,
                        width: 70,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 90,
                  width: 90,
                  decoration: const BoxDecoration(gradient: Palettes.gradientCircle, shape: BoxShape.circle),
                  child: const Center(child: Text("80")),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Container(
                height: 90,
                width: 90,
                decoration: const BoxDecoration(gradient: Palettes.gradientCircle, shape: BoxShape.circle),
                child: const Center(child: Text("Timer")),
              ),
              Container(
                height: 90,
                width: 90,
                decoration: const BoxDecoration(gradient: Palettes.gradientCircle, shape: BoxShape.circle),
                child: const Center(
                    child: Text(
                  "Darkess Level",
                  textAlign: TextAlign.center,
                )),
              ),
              Container(
                height: 90,
                width: 90,
                decoration: const BoxDecoration(gradient: Palettes.gradientCircle, shape: BoxShape.circle),
                child: const Center(child: Text("inActive")),
              ),
              Container(
                height: 90,
                width: 90,
                decoration: const BoxDecoration(gradient: Palettes.gradientCircle, shape: BoxShape.circle),
                child: const Center(child: Text("Sensing")),
              ),
            ]),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            ListTile(
              title: Text(
                "Độ sáng khi không và có người",
                style: TextStyles.defaultStyle.regular,
              ),
              trailing: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Cài đặt",
                    style: TextStyles.defaultStyle.regular.blueTextColor,
                  )),
            ),
            const Divider(),
            ListTile(
              title: Text(
                "Cài đặt màu sắc lúc có người và không có người",
                style: TextStyles.defaultStyle.regular,
              ),
              trailing: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Cài đặt",
                    style: TextStyles.defaultStyle.regular.blueTextColor,
                  )),
            ),
            const Divider(),
            ListTile(
              title: Text(
                "Độ tối môi trường",
                style: TextStyles.defaultStyle.regular,
              ),
              trailing: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Cài đặt",
                    style: TextStyles.defaultStyle.regular.blueTextColor,
                  )),
            ),
            const Divider(),
            ListTile(
              title: Text(
                "Thời gian đèn duy trì mức sáng cao(s)",
                style: TextStyles.defaultStyle.regular,
              ),
              trailing: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Cài đặt",
                    style: TextStyles.defaultStyle.regular.blueTextColor,
                  )),
            ),
            const Divider(),
            ListTile(
              title: Text(
                "Cài đặt độ nhạy của cảm biến 0-15",
                style: TextStyles.defaultStyle.regular,
              ),
              trailing: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Cài đặt",
                    style: TextStyles.defaultStyle.regular.blueTextColor,
                  )),
            ),
            const Divider(),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: TextButton(
                onPressed: () {},
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: Palettes.gradientBtn,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Nhấp nháy đèn LED trên cảm biến",
                      style: TextStyles.defaultStyle.whiteTextColor,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: TextButton(
                onPressed: () {},
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: Palettes.gradientBtn,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Nâng cấp phần mềm",
                      style: TextStyles.defaultStyle.whiteTextColor,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: TextButton(
                onPressed: () {},
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: Palettes.gradientBtn,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Cài đặt chi tiết",
                      style: TextStyles.defaultStyle.whiteTextColor,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      );
    }

    return SafeArea(
        child: Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    ));
  }
}
