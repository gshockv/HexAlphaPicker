import 'package:flutter/material.dart' show Color, Colors;

class OverlayColorModel {
  double defaultAlphaValue = 0.5;

  final hexTransparencyCodes = const {
    100: "FF",
    95: "F2",
    90: "E6",
    85: "D9",
    80: "CC",
    75: "BF",
    70: "B3",
    65: "A6",
    60: "99",
    55: "8C",
    50: "80",
    45: "73",
    40: "66",
    35: "59",
    30: "4D",
    25: "40",
    20: "33",
    15: "26",
    10: "1A",
    5: "0D",
    0: "00"
  };

  final _overlayColors = const {
    0xFF000000: "000000",
    0xFF9804A2: "9804A2",
    0xFF0D47A1: "0D47A1",
    0xFF01220B: "01220B",
    0xFF400455: "400455",
    0xFF53031A: "53031A",
    0xFF478309: "478309",
    0xFF775502: "775502",
  };

  Color overlayColor = Colors.transparent;
  String overlayColorHuman = "#";

  overlayColorsCount() => _overlayColors.length;

  int getOverlayColorCode(int position) {
    return _overlayColors.keys.elementAt(position);
  }

  void calculateOverlayColor(
      int alphaValue, int selectedOverlayColorIndex) {
    final alpha = hexTransparencyCodes[alphaValue];
    final colorKey = _overlayColors.keys.elementAt(selectedOverlayColorIndex);
    overlayColorHuman = "#" + alpha + _overlayColors[colorKey];
    overlayColor = Color(_hexToColor(overlayColorHuman));
  }

  int _hexToColor(String code) {
    code = code.replaceFirst('#', '');
    code = code.length == 6 ? 'ff' + code : code;
    int val = int.parse(code, radix: 16);
    return val;
  }
}
