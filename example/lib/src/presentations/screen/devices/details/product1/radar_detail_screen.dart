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
                "????? s??ng khi kh??ng v?? c?? ng?????i",
                style: TextStyles.defaultStyle.regular,
              ),
              trailing: TextButton(
                  onPressed: () {},
                  child: Text(
                    "C??i ?????t",
                    style: TextStyles.defaultStyle.regular.blueTextColor,
                  )),
            ),
            const Divider(),
            ListTile(
              title: Text(
                "C??i ?????t m??u s???c l??c c?? ng?????i v?? kh??ng c?? ng?????i",
                style: TextStyles.defaultStyle.regular,
              ),
              trailing: TextButton(
                  onPressed: () {},
                  child: Text(
                    "C??i ?????t",
                    style: TextStyles.defaultStyle.regular.blueTextColor,
                  )),
            ),
            const Divider(),
            ListTile(
              title: Text(
                "????? t???i m??i tr?????ng",
                style: TextStyles.defaultStyle.regular,
              ),
              trailing: TextButton(
                  onPressed: () {},
                  child: Text(
                    "C??i ?????t",
                    style: TextStyles.defaultStyle.regular.blueTextColor,
                  )),
            ),
            const Divider(),
            ListTile(
              title: Text(
                "Th???i gian ????n duy tr?? m???c s??ng cao(s)",
                style: TextStyles.defaultStyle.regular,
              ),
              trailing: TextButton(
                  onPressed: () {},
                  child: Text(
                    "C??i ?????t",
                    style: TextStyles.defaultStyle.regular.blueTextColor,
                  )),
            ),
            const Divider(),
            ListTile(
              title: Text(
                "C??i ?????t ????? nh???y c???a c???m bi???n 0-15",
                style: TextStyles.defaultStyle.regular,
              ),
              trailing: TextButton(
                  onPressed: () {},
                  child: Text(
                    "C??i ?????t",
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
                      "Nh???p nh??y ????n LED tr??n c???m bi???n",
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
                      "N??ng c???p ph???n m???m",
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
                      "C??i ?????t chi ti???t",
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
