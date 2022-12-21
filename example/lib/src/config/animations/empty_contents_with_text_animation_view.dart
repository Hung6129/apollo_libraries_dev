import 'package:flutter/material.dart';
import 'package:nordic_nrf_mesh_example/src/config/text_style.dart';

import 'data_not_found_animation_view.dart';

class EmptyContentsWithTextAnimationView extends StatelessWidget {
  final String text;
  const EmptyContentsWithTextAnimationView({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              text,
              style: TextStyles.defaultStyle,
            ),
          ),
          const DataNotFoundAnimationView(),
        ],
      ),
    );
  }
}
