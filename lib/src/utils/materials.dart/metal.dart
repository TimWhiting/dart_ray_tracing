import '../all_utils.dart';

extension Reflect on Vector {
  Vector reflect(Vector n) {
    return this - n * dot(n) * 2;
  }
}

class Metal extends Material {
  final Color albedo;
  final double fuzz;

  Metal(this.albedo, double f) : fuzz = f < 1 ? f : 1;
  @override
  ScatterInfo scatter(Ray r, HitInfo hitInfo) {
    final reflected = Reflect(r.direction).reflect(hitInfo.normal);
    final scattered =
        Ray(hitInfo.p, reflected + Vector.randInUnitSphere() * fuzz);
    return ScatterInfo(
        scattered: scattered,
        attenuation: albedo,
        wasScattered: scattered.direction.dot(hitInfo.normal) > 0);
  }
}
