import 'package:flutter/material.dart';

import '../../../../../config/palettes.dart';
import '../../../../../config/text_style.dart';

class TubDetailScreen extends StatefulWidget {
  const TubDetailScreen({Key? key}) : super(key: key);

  @override
  State<TubDetailScreen> createState() => _TubDetailScreenState();
}

class _TubDetailScreenState extends State<TubDetailScreen> {
  double _value = 0;
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
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        gradient: Palettes.gradientBtn,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Bật",
                          style: TextStyles.defaultStyle.whiteTextColor,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Container(
                      height: 50,
                      width: 150,
                      decoration: BoxDecoration(
                        gradient: Palettes.gradientBtn,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Tắt",
                          style: TextStyles.defaultStyle.whiteTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Stack(alignment: AlignmentDirectional.center, children: [
                  Container(
                      height: 100,
                      width: 100,
                      decoration:
                          BoxDecoration(gradient: Palettes.gradientCircle, borderRadius: BorderRadius.circular(20))),
                  Image.asset("assets/icons/person-stand.png", height: 50, width: 50),
                  Positioned(bottom: 0, child: Text("Người dùng 1", style: TextStyles.defaultStyle.small)),
                  const Positioned(right: 0, top: 0, child: Icon(Icons.settings, size: 30))
                ]),
                Stack(alignment: AlignmentDirectional.center, children: [
                  Container(
                      height: 100,
                      width: 100,
                      decoration:
                          BoxDecoration(gradient: Palettes.gradientCircle, borderRadius: BorderRadius.circular(20))),
                  Image.asset("assets/icons/person-stand.png", height: 50, width: 50),
                  Positioned(bottom: 0, child: Text("Người dùng 2", style: TextStyles.defaultStyle.small)),
                  const Positioned(right: 0, top: 0, child: Icon(Icons.settings, size: 30))
                ]),
                Stack(alignment: AlignmentDirectional.center, children: [
                  Container(
                      height: 100,
                      width: 100,
                      decoration:
                          BoxDecoration(gradient: Palettes.gradientCircle, borderRadius: BorderRadius.circular(20))),
                  Image.asset("assets/icons/bagua-mirror.png", height: 50, width: 50),
                  Positioned(bottom: 0, child: Text("Phong thuỷ", style: TextStyles.defaultStyle.small)),
                  const Positioned(right: 0, top: 0, child: Icon(Icons.settings, size: 30))
                ]),
              ],
            ),
            const SizedBox(height: 20),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Stack(alignment: AlignmentDirectional.center, children: [
                Container(
                    height: 100,
                    width: 100,
                    decoration:
                        BoxDecoration(gradient: Palettes.gradientCircle, borderRadius: BorderRadius.circular(20))),
                Image.asset("assets/icons/heartbeat.png", height: 50, width: 50),
                Positioned(bottom: 0, child: Text("Sức khoẻ", style: TextStyles.defaultStyle.small)),
                const Positioned(right: 0, top: 0, child: Icon(Icons.settings, size: 30))
              ]),
              Stack(alignment: AlignmentDirectional.center, children: [
                Container(
                    height: 100,
                    width: 100,
                    decoration:
                        BoxDecoration(gradient: Palettes.gradientCircle, borderRadius: BorderRadius.circular(20))),
                Image.asset("assets/icons/rgb.png", height: 50, width: 50),
                Positioned(bottom: 0, child: Text("Đổi màu", style: TextStyles.defaultStyle.small)),
                const Positioned(right: 0, top: 0, child: Icon(Icons.settings, size: 30))
              ]),
              Stack(alignment: AlignmentDirectional.center, children: [
                Container(
                    height: 100,
                    width: 100,
                    decoration:
                        BoxDecoration(gradient: Palettes.gradientCircle, borderRadius: BorderRadius.circular(20))),
                Image.asset("assets/icons/rgb-mode.png", height: 50, width: 50),
                Positioned(bottom: 0, child: Text("Chế dộ", style: TextStyles.defaultStyle.small)),
                const Positioned(right: 0, top: 0, child: Icon(Icons.settings, size: 30))
              ]),
            ]),
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
