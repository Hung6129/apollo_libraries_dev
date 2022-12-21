import 'package:flutter/cupertino.dart';

import '../../../../config/animations/data_not_found_animation_view.dart';
import '../../../../config/strings.dart';
import '../../../../config/text_style.dart';

class NoGroupFound extends StatelessWidget {
  const NoGroupFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          Strings.noGroup,
          style: TextStyles.defaultStyle.bold.blueTextColor,
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          Strings.noGroupRecommending,
          style: TextStyles.defaultStyle.italic.light,
        ),
        const DataNotFoundAnimationView(),
      ],
    );
  }
}
