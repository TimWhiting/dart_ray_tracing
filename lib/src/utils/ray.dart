import 'geometry.dart/vec3.dart';

class Ray {
  final Vector origin;
  final Vector direction;

  Ray(this.origin, this.direction);
  Vector at(double t) => origin + direction * t;
}
