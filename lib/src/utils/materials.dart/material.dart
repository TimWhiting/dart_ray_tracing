import '../all_utils.dart';
export 'lambertian.dart';
export 'metal.dart';
export 'dielectric.dart';

abstract class Material {
  const Material();
  ScatterInfo scatter(Ray r, HitInfo hitInfo);
}

class ScatterInfo {
  final Color attenuation;
  final Ray scattered;
  final bool wasScattered;

  ScatterInfo({this.attenuation, this.scattered, this.wasScattered});
}
