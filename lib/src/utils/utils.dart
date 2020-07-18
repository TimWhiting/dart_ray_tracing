import 'dart:math';

final rand = Random();

extension RandomUtils on Random {
  double get randDouble => nextDouble();
  double randRange(double min, double max) => min + (max - min) * randDouble;
}

extension DoubleXX on double {
  double get radians => (this * pi) / 180;
}
