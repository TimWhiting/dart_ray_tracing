import '../all_utils.dart';

class Lambertian extends Material {
  final Color albedo;

  Lambertian(this.albedo);
  @override
  ScatterInfo scatter(Ray r, HitInfo hitInfo) {
    final scatterDir = hitInfo.normal + Vector.randomUnitVector();
    final scattered = Ray(hitInfo.p, scatterDir);
    return ScatterInfo(
        attenuation: albedo, scattered: scattered, wasScattered: true);
  }
}
