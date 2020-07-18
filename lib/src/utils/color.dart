import 'dart:math';

import 'all_utils.dart';

class Color {
  static const colorMult = 255.999;
  final double r, g, b;
  Color(this.r, this.g, this.b);
  Color.random() : this(rand.randDouble, rand.randDouble, rand.randDouble);
  Color.randomRange(double min, double max)
      : this(rand.randRange(min, max), rand.randRange(min, max),
            rand.randRange(min, max));

  Color operator *(double t) => Color(r * t, g * t, b * t);
  Color vecMul(Color v) => Color(r * v.r, g * v.g, b * v.b);
  Color operator +(Color v) => Color(r + v.r, g + v.g, b + v.b);

  String colorString(int samplesPerPixel) {
    final scale = 1.0 / samplesPerPixel;
    int getNormalized(double color) {
      return ((sqrt(color * scale)).clamp(0, 0.999) * 256).toInt();
    }

    return '${getNormalized(r)} ${getNormalized(g)} ${getNormalized(b)}';
  }
}
