import 'dart:math';

import 'material.dart';
import '../all_utils.dart';

extension on Vector {
  Vector refract(Vector n, double etaiOverEtat) {
    final cosTheta = (-this).dot(n);
    final rOutParallel = (this + n * cosTheta) * etaiOverEtat;
    final rOutPerp = n * -sqrt(1 - rOutParallel.lengthSquared);
    return rOutParallel + rOutPerp;
  }
}

double schlick(double cosine, double refIdx) {
  var r0 = (1 - refIdx) / (1 + refIdx);
  r0 = r0 * r0;
  return r0 + (1 - r0) * pow(1 - cosine, 5);
}

class Dielectric extends Material {
  final double refIdx;

  const Dielectric(this.refIdx);
  @override
  ScatterInfo scatter(Ray r, HitInfo hitInfo) {
    final attenuation = Color(1, 1, 1);
    final etaiOverEtat = hitInfo.frontFace ? 1 / refIdx : refIdx;
    final unitDir = r.direction.unit;
    final cosTheta = min((-unitDir).dot(hitInfo.normal), 1);
    final sinTheta = sqrt(1 - cosTheta * cosTheta);
    if (etaiOverEtat * sinTheta > 1 ||
        rand.randDouble < schlick(cosTheta, etaiOverEtat)) {
      final reflected = Reflect(unitDir).reflect(hitInfo.normal);
      final scattered = Ray(hitInfo.p, reflected);
      return ScatterInfo(
          attenuation: attenuation, scattered: scattered, wasScattered: true);
    }
    final refracted = unitDir.refract(hitInfo.normal, etaiOverEtat);
    final scattered = Ray(hitInfo.p, refracted);
    return ScatterInfo(
        attenuation: attenuation, scattered: scattered, wasScattered: true);
  }

  const Dielectric.air() : refIdx = 1;
  const Dielectric.glass(this.refIdx) : assert(refIdx > 1.3 && refIdx < 1.7);
  const Dielectric.diamond() : refIdx = 2.4;
  factory Dielectric.random() {
    final type = rand.nextInt(3);
    switch (type) {
      case 0:
        return Dielectric.air();
      case 1:
        return Dielectric.diamond();
      default:
        return Dielectric.glass(rand.randRange(1.3, 1.7));
    }
  }
}
