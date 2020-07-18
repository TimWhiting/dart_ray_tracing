import 'utils/all_utils.dart';

Color _rayColor(Ray r, Hittable world, [int depth = 50]) {
  if (depth == 0) {
    return Color(0, 0, 0);
  }
  var rec = world.hit(r, 0.001, double.infinity);
  if (rec.hit) {
    final scatter = rec.material.scatter(r, rec);
    if (scatter.wasScattered) {
      return scatter.attenuation
          .vecMul(_rayColor(scatter.scattered, world, depth - 1));
    }
    return Color(0, 0, 0);
  }

  final dir = r.direction.unit;
  final t = .5 * (dir.y + 1);
  return Color(1, 1, 1) * (1 - t) + Color(.5, .7, 1) * t;
}

extension RayColor on Ray {
  Color rayColor(Hittable world, [int depth = 50]) {
    return _rayColor(this, world, depth);
  }
}
