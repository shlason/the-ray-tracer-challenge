import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dart_ray_tracer/canvas/canvas.dart';
import 'package:dart_ray_tracer/color/color.dart';
import 'package:dart_ray_tracer/dart_ray_tracer.dart';
import 'package:dart_ray_tracer/intersection/intersection.dart';
import 'package:dart_ray_tracer/light/light.dart';
import 'package:dart_ray_tracer/point/point.dart';
import 'package:dart_ray_tracer/ray/ray.dart';
import 'package:dart_ray_tracer/sphere/sphere.dart';
import 'package:dart_ray_tracer/transform/transform.dart';
import 'package:dart_ray_tracer/tuple/tuple.dart';
import 'package:dart_ray_tracer/vector/vector.dart';

void main(List<String> arguments) {
  // 1.
  // drawProjectileImage();

  // 2.
  // drawAnalogClock();

  // 3.
  // drawSphere();

  // 4.
  drawSphereWithLighting();
}

void drawProjectileImage() {
  const t = Duration(milliseconds: 1);
  const int width = 900;
  const int height = 550;

  final Point start = Point(0, 1, 0);
  final Vector velocity = Vector(1, 1.8, 0).normalize() * 11.25;
  final Vector gravity = Vector(0, -0.1, 0);
  final Vector wind = Vector(-0.01, 0, 0);
  final Map env = enviroment(gravity, wind);
  final Canvas canvas = Canvas(width, height);
  final Color color = Color(1, 0.5, 0.5);

  Map proj = projectile(start, velocity);

  canvas.writePixel(proj['position'].x, height - proj['position'].y, color);

  Timer.periodic(t, (Timer timer) {
    final num x = proj['position'].x;
    final num y = proj['position'].y;
    print('x: $x, y: $y');

    if (y <= 0) {
      timer.cancel();
      var file = File('projectile-image.ppm').openWrite();
      file.write(canvas.toPPM());
      file.close();

      return;
    }
    canvas.writePixel(x, height - y, color);
    proj = tick(env, proj);
  });
}

void drawAnalogClock() {
  const int width = 100;
  const int height = 100;
  const int centerX = width ~/ 2;
  const int centerY = height ~/ 2;
  const int circularDegree = 360;
  const num radius = width * (3 / 8);
  const int count = 12;

  final Point startPoint = Point(0, 1, 0);
  final Canvas canvas = Canvas(width, height);
  final Color color = Color(1, 1, 1);
  print('Radius: $radius');
  for (int i = 1; i < circularDegree ~/ count; i++) {
    final num currentRadians = (i * (pi / 6));
    final Tuple currentPoint = RotateZ(currentRadians) * startPoint;
    print(currentPoint.x);
    print(currentPoint.y);
    canvas.writePixel(
      currentPoint.x * radius + centerX,
      currentPoint.y * radius + centerY,
      color,
    );
  }

  var file = File('analog-clock.ppm').openWrite();
  file.write(canvas.toPPM());
  file.close();
}

void drawSphere() {
  const int canvasPixels = 100;
  const num wallSize = 7;
  const num halfOfWall = wallSize / 2;
  const num pixelSize = wallSize / canvasPixels;
  const num wallZ = 10;

  final Point rayOrigin = Point(0, 0, -5);
  final Canvas canvas = Canvas(canvasPixels, canvasPixels);
  final Color color = Color(1, 0, 0);
  final Sphere sphere = Sphere();

  // Transform effects
  // sphere.transform = Scale(1, 0.5, 1);
  // sphere.transform = Scale(0.5, 1, 1);
  // sphere.transform = RotateZ(pi / 4) * Scale(0.5, 1, 1);
  // sphere.transform = Skew(1, 0, 0, 0, 0, 0) * Scale(0.5, 1, 1);

  for (int y = 0; y < canvasPixels; y++) {
    final num worldY = halfOfWall - pixelSize * y;

    for (int x = 0; x < canvasPixels; x++) {
      final num worldX = halfOfWall - pixelSize * x;
      final Point position = Point(worldX, worldY, wallZ);
      final Vector rayVector = position - rayOrigin;
      final Ray ray = Ray(rayOrigin, rayVector.normalize());
      final List<Intersection> xs = intersect(sphere, ray);

      if (hit(xs) != null) {
        canvas.writePixel(x, y, color);
      }
    }
  }

  var file = File('sphere-cast.ppm').openWrite();
  file.write(canvas.toPPM());
  file.close();
}

void drawSphereWithLighting() {
  const int canvasPixels = 600;
  const num wallSize = 7;
  const num halfOfWall = wallSize / 2;
  const num pixelSize = wallSize / canvasPixels;
  const num wallZ = 10;

  final Point rayOrigin = Point(0, 0, -5);
  final Canvas canvas = Canvas(canvasPixels, canvasPixels);
  final Sphere sphere = Sphere();
  final Color sphereMaterialColor = Color(1, 0.2, 1);
  final Point lightPosition = Point(-10, 10, -10);
  final Color lightColor = Color(1, 1, 1);
  final PointLight pointLight = PointLight(lightPosition, lightColor);

  sphere.material.color = sphereMaterialColor;

  // Transform effects
  // sphere.transform = Scale(1, 0.5, 1);
  // sphere.transform = Scale(0.5, 1, 1);
  // sphere.transform = RotateZ(pi / 4) * Scale(0.5, 1, 1);
  // sphere.transform = Skew(1, 0, 0, 0, 0, 0) * Scale(0.5, 1, 1);

  for (int y = 0; y < canvasPixels; y++) {
    final num worldY = halfOfWall - pixelSize * y;

    for (int x = 0; x < canvasPixels; x++) {
      final num worldX = halfOfWall - pixelSize * x;
      final Point position = Point(worldX, worldY, wallZ);
      final Vector rayVector = position - rayOrigin;
      final Ray ray = Ray(rayOrigin, rayVector.normalize());
      final List<Intersection> xs = intersect(sphere, ray);
      final Intersection? hittedIntersection = hit(xs);

      if (hittedIntersection != null) {
        final Point point = Ray.position(ray, hittedIntersection.t);
        final Vector normalV = Sphere.normalAt(
          hittedIntersection.object,
          point,
        );
        final Vector eyeV = Vector(
          0 - ray.direction.x,
          0 - ray.direction.y,
          0 - ray.direction.z,
        ).normalize();
        final Color color = lighting(
          hittedIntersection.object.material,
          pointLight,
          point,
          eyeV,
          normalV,
        );
        canvas.writePixel(x, y, color);
      }
    }
  }

  var file = File('sphere-cast-with-lighting.ppm').openWrite();
  file.write(canvas.toPPM());
  file.close();
}
