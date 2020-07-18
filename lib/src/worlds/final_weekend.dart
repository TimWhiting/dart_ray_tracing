import '../utils/all_utils.dart';

HittableList createWeekendFinalWorld() {
  final world = HittableList();
  final groundMaterial = Lambertian(Color(.5, .5, .5));
  world.add(Sphere(Vector(0, -1000, 0), 1000, groundMaterial));
  for (var a = -11; a < 11; a++) {
    for (var b = -11; b < 11; b++) {
      final chooseMat = rand.randDouble;
      final center =
          Vector(a + .9 * rand.randDouble, .2, b + .9 * rand.randDouble);
      if ((center - Vector(4, .2, 0)).length > .9) {
        if (chooseMat < .8) {
          // diffuse
          final albedo = Color.random().vecMul(Color.random());
          final material = Lambertian(albedo);
          world.add(Sphere(center, .2, material));
        } else if (chooseMat < .95) {
          // metal
          final albedo = Color.randomRange(.5, 1);
          final fuzz = rand.randRange(0, .5);
          final material = Metal(albedo, fuzz);
          world.add(Sphere(center, .2, material));
        } else {
          // glass
          final material = Dielectric.random();
          world.add(Sphere(center, .2, material));
        }
      }
    }
  }
  final material1 = Dielectric.glass(1.5);
  world.add(Sphere(Vector(0, 1, 0), 1, material1));

  final material2 = Lambertian(Color(.4, .2, .1));
  world.add(Sphere(Vector(-4, 1, 0), 1.0, material2));

  final material3 = Metal(Color(.7, .6, .5), 0);
  world.add(Sphere(Vector(4, 1, 0), 1, material3));
  return world;
}
