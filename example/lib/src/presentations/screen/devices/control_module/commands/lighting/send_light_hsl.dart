import 'dart:async';

import 'package:nordic_nrf_mesh/nordic_nrf_mesh.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class SendLightHsl extends StatefulWidget {
  final MeshManagerApi meshManagerApi;
  final int sequence;

  const SendLightHsl({Key? key, required this.meshManagerApi, required this.sequence}) : super(key: key);

  @override
  State<SendLightHsl> createState() => _SendLightHslState();
}

class _SendLightHslState extends State<SendLightHsl> {
  int? selectedElementAddress;

  int? selectedLightness = 0;
  int? selectedHue = 0;
  int? selectedSaturation = 0;

  ///
  double valueLightness = 0;
  double valueHue = 0;
  double valueSaturation = 0;

  ///
  final List<ColorLabelType> _labelTypes = [ColorLabelType.hsl];
  final PaletteType _paletteType = PaletteType.hsl;
  Color currentColor = Colors.amber;
  void changeColor(Color color) => setState(() {
        currentColor = color;
      });

  // @override
  // void initState() {
  //   super.initState();
  //   selectedLightness = valueLightness.round();
  //   selectedHue = valueHue.round();
  //   selectedSaturation = valueSaturation.round();
  // }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      key: const ValueKey('module-send-light-hsl-form'),
      title: const Text('Send light HSL'),
      children: <Widget>[
        TextField(
          key: const ValueKey('module-send-light-hsl-address'),
          decoration: const InputDecoration(hintText: 'Element Address'),
          onChanged: (text) {
            selectedElementAddress = int.parse(text);
          },
        ),
        const SizedBox(
          height: 20,
        ),
        ColorPicker(
          pickerColor: currentColor,
          onColorChanged: changeColor,
          colorPickerWidth: 300,
          pickerAreaHeightPercent: 0.7,
          enableAlpha: false,
          labelTypes: _labelTypes,
          portraitOnly: true,
          displayThumbColor: false,
          paletteType: _paletteType,
          pickerAreaBorderRadius: const BorderRadius.only(
            topLeft: Radius.circular(2),
            topRight: Radius.circular(2),
          ),
          hexInputBar: false,
        ),
        Row(
          children: [
            Text('Lightness: ${valueLightness.round()}'),
            Slider(
              value: valueLightness,
              onChanged: (value) {
                setState(() {
                  valueLightness = value;
                  selectedLightness = int.tryParse(value.round().toString());
                });
              },
              max: 65535,
              min: 0,
            ),
          ],
        ),
        Row(
          children: [
            Text('Hue: ${valueHue.round()}'),
            Slider(
              value: valueHue,
              onChanged: (value) {
                setState(() {
                  valueHue = value;
                  selectedHue = int.tryParse(value.round().toString());
                });
              },
              max: 65535,
              min: 0,
            ),
          ],
        ),
        Row(
          children: [
            Text('Saturation: ${valueSaturation.round()}'),
            Slider(
              value: valueSaturation,
              onChanged: (value) {
                setState(() {
                  valueSaturation = value;
                  selectedSaturation = int.tryParse(value.round().toString());
                });
              },
              max: 65535,
              min: 0,
            ),
          ],
        ),
        TextButton(
          onPressed: selectedHue != null && selectedLightness != null && selectedSaturation != null
              ? () async {
                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  debugPrint(
                      'send Hue:$selectedHue Lightness:$selectedLightness Saturation:$selectedSaturation to $selectedElementAddress');
                  try {
                    await widget.meshManagerApi
                        .sendLightHsl(
                          selectedElementAddress!,
                          selectedLightness!,
                          selectedHue!,
                          selectedSaturation!,
                          widget.sequence,
                        )
                        .timeout(const Duration(seconds: 40));
                    // scaffoldMessenger.showSnackBar(const SnackBar(content: Text('OK')));
                  } on TimeoutException catch (_) {
                    scaffoldMessenger.showSnackBar(const SnackBar(content: Text('Board didn\'t respond')));
                  } on PlatformException catch (e) {
                    scaffoldMessenger.showSnackBar(SnackBar(content: Text('${e.message}')));
                  } catch (e) {
                    scaffoldMessenger.showSnackBar(SnackBar(content: Text(e.toString())));
                  }
                }
              : null,
          child: const Text('Send hsl'),
        )
      ],
    );
  }
}
