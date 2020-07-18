import 'dart:math';

import '../all_utils.dart';

abstract class Cartesion3Tuple {
  final double x, y, z;
  const Cartesion3Tuple(this.x, this.y, this.z);
  double operator [](int i) => i == 0 ? x : i == 1 ? y : z;
  @override
  String toString() {
    return '$x $y $z';
  }
}

// class Point extends Cartesion3Tuple {
//   const Point(double x, double y, double z) : super(x, y, z);
//   Vector operator -(Point v) => Vector(x - v.x, y - v.y, z - v.z);
//   Vector operator +(Point v) => Vector(x + v.x, y + v.y, z + v.z);
// }

class Vector extends Cartesion3Tuple {
  const Vector(double x, double y, double z) : super(x, y, z);
  Vector.random() : this(rand.randDouble, rand.randDouble, rand.randDouble);
  Vector.randomRange(double min, double max)
      : this(rand.randRange(min, max), rand.randRange(min, max),
            rand.randRange(min, max));
  factory Vector.randInUnitSphere() {
    while (true) {
      final p = Vector.randomRange(-1, 1);
      if (p.lengthSquared >= 1) {
        continue;
      }
      return p;
    }
  }
  factory Vector.randInUnitDisk() {
    while (true) {
      final p = Vector(rand.randRange(-1, 1), rand.randRange(-1, 1), 0);
      if (p.lengthSquared >= 1) {
        continue;
      }
      return p;
    }
  }
  factory Vector.randomUnitVector() {
    final a = rand.randRange(0, 2 * pi);
    final z = rand.randRange(-1, 1);
    final r = sqrt(1 - z * z);
    return Vector(r * cos(a), r * sin(a), z);
  }
  Vector randomInHemisphere() {
    final unitSphere = Vector.randInUnitSphere();
    if (unitSphere.dot(this) > 0) {
      return unitSphere;
    } else {
      return -unitSphere;
    }
  }

  Vector operator -() => Vector(-x, -y, -z);
  Vector operator -(Vector v) => Vector(x - v.x, y - v.y, z - v.z);
  Vector operator +(Vector v) => Vector(x + v.x, y + v.y, z + v.z);
  Vector operator *(double t) => Vector(x * t, y * t, z * t);
  Vector vecMul(Vector v) => Vector(x * v.x, y * v.y, z * v.z);
  Vector operator /(double t) => Vector(x, y, z) * (1 / t);
  double dot(Vector v) => x * v.x + y * v.y + z * v.z;
  Vector cross(Vector v) =>
      Vector(y * v.z - z * v.y, z * v.x - x * v.z, x * v.y - y * v.x);
  Vector get unit => this / length;
  double get length => sqrt(lengthSquared);
  double get lengthSquared => x * x + y * y + z * z;
}
