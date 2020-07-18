import 'dart:math';

import '../all_utils.dart';

class Sphere extends Hittable {
  final Vector center;
  final double radius;
  final Material material;
  Sphere(this.center, this.radius, this.material);

  @override
  HitInfo hit(Ray r, double tMin, double tMax) {
    final oc = r.origin - center;
    final a = r.direction.lengthSquared;
    final half_b = oc.dot(r.direction);
    final c = oc.lengthSquared - radius * radius;
    final disc = half_b * half_b - a * c;
    if (disc < 0) {
      return HitInfo(hit: false);
    }
    final root = sqrt(disc);
    var temp = (-half_b - root) / a;
    if (temp < tMax && temp > tMin) {
      final p = r.at(temp);
      return HitInfo(t: temp, p: p, hit: true, material: material)
        ..setFaceNormal(r, (p - center) / radius);
    }
    temp = (-half_b + root) / a;
    if (temp < tMax && temp > tMin) {
      final p = r.at(temp);
      return HitInfo(t: temp, p: p, hit: true, material: material)
        ..setFaceNormal(r, (p - center) / radius);
    }
    return HitInfo(hit: false);
  }
}
