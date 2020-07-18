import 'dart:math';

import 'all_utils.dart';

class Camera {
  Vector horizontal, vertical;
  Vector llc;
  final Vector lookFrom, lookAt;
  final Vector vUp;
  final double vFov, aspectRatio, aperture, focusDist, lensRadius;
  Vector u, v;
  Camera(
      {this.lookFrom,
      this.lookAt,
      this.vUp = const Vector(0, 1, 0),
      this.vFov,
      this.aspectRatio = 16 / 9,
      this.aperture,
      this.focusDist})
      : lensRadius = aperture / 2 {
    final theta = vFov.radians;
    final h = tan(theta / 2);
    final viewportHeight = 2.0 * h;
    final viewportWidth = aspectRatio * viewportHeight;
    final w = (lookFrom - lookAt).unit;
    u = vUp.cross(w).unit;
    v = w.cross(u);
    horizontal = u * viewportWidth * focusDist;
    vertical = v * viewportHeight * focusDist;
    llc = lookFrom - horizontal / 2 - vertical / 2 - w * focusDist;
  }
  Ray getRay(double s, double t) {
    final rd = Vector.randInUnitDisk() * lensRadius;
    final offset = u * rd.x + v * rd.y;
    return Ray(lookFrom + offset,
        llc + horizontal * s + vertical * t - lookFrom - offset);
  }
}
