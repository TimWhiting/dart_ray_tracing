import 'package:meta/meta.dart';

import '../all_utils.dart';

abstract class Hittable {
  HitInfo hit(Ray r, double tMin, double tMax);
}

class HitInfo {
  final Vector p;
  final double t;
  final bool hit;
  Vector normal;
  bool frontFace;
  final Material material;
  void setFaceNormal(Ray r, Vector outwardNormal) {
    frontFace = r.direction.dot(outwardNormal) < 0;
    normal = frontFace ? outwardNormal : -outwardNormal;
  }

  HitInfo({this.p, this.t, @required this.hit, this.material});
}

class HittableList extends Hittable {
  final List<Hittable> objects = [];
  void add(Hittable h) => objects.add(h);
  void clear() => objects.clear();

  @override
  HitInfo hit(Ray r, double tMin, double tMax) {
    var closestSoFar = tMax;
    HitInfo aggInfo;
    for (final o in objects) {
      final hitInfo = o.hit(r, tMin, closestSoFar);
      if (hitInfo.hit) {
        closestSoFar = hitInfo.t;
        aggInfo = hitInfo;
      }
    }
    return aggInfo ?? HitInfo(hit: false);
  }
}
