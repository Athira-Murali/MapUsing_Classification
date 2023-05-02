import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

double getHeightForText(String text, TextStyle? style, double width) {
  final fontSize = (style?.fontSize ?? 20);
  TextPainter textPainter = TextPainter()
    ..text = TextSpan(text: text, style: style?.copyWith(fontSize: fontSize))
    ..textDirection = TextDirection.ltr
    ..layout(minWidth: 0, maxWidth: width);
  return textPainter.size.height;
}

double getWidthForText(String text, TextStyle? style) {
  final fontSize = (style?.fontSize ?? 20);
  TextPainter textPainter = TextPainter()
    ..text = TextSpan(text: text, style: style?.copyWith(fontSize: fontSize))
    ..textDirection = TextDirection.ltr
    ..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size.width;
}

//

double getHeightWithTextScaleFactor(
    String text, TextStyle? style, double width) {
  final fontSize = (style?.fontSize ?? 20) * Get.textScaleFactor;
  TextPainter textPainter = TextPainter()
    ..text = TextSpan(text: text, style: style?.copyWith(fontSize: fontSize))
    ..textDirection = TextDirection.ltr
    ..layout(minWidth: 0, maxWidth: width);
  return textPainter.size.height;
}

TextStyle? getFontSizeForText(
    List<String> texts, TextStyle? style, double width, double height) {
  double fontSize = style?.fontSize ?? 0;
  var newStyle = style;
  if (fontSize != 0) {
    double newHeight = 0;

    for (String text in texts) {
      do {
        newStyle = style?.copyWith(fontSize: fontSize);

        TextPainter textPainter = TextPainter()
          ..text = TextSpan(text: text, style: style)
          ..textDirection = TextDirection.ltr
          ..layout(minWidth: 0, maxWidth: width);

        newHeight = max(height, textPainter.size.height);

        fontSize = fontSize - 1;
      } while (height < newHeight);
    }
  }

  return newStyle;
}
