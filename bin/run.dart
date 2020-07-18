import 'dart:io';

import 'package:dart_ray_tracing/dart_ray_tracing.dart';
import 'package:dart_ray_tracing/src/worlds/final_weekend.dart';

void main() {
  const aspectRatio = 16 / 9;
  const imageWidth = 384;
  const imageHeight = imageWidth ~/ aspectRatio;
  const samplesPerPixel = 100;
  final lookFrom = Vector(13, 2, 3);
  final lookAt = Vector(0, 0, 0);
  final camera = Camera(
      lookFrom: lookFrom,
      lookAt: lookAt,
      vFov: 20,
      aperture: .1,
      focusDist: 10);
  final world = createWeekendFinalWorld();
  print('P3\n$imageWidth $imageHeight\n255');
  for (var j = imageHeight - 1; j >= 0; --j) {
    stderr.writeln('Scanlines remaining: $j');
    for (var i = 0; i < imageWidth; ++i) {
      var pixel = Color(0, 0, 0);
      for (var s = 0; s < samplesPerPixel; ++s) {
        final u = (i + rand.randDouble) / (imageWidth - 1);
        final v = (j + rand.randDouble) / (imageHeight - 1);
        (imageHeight - 1);
        final ray = camera.getRay(u, v);
        pixel += ray.rayColor(world);
      }
      print(pixel.colorString(samplesPerPixel));
    }
  }
  stderr.writeln('\nDone.\n');
}
