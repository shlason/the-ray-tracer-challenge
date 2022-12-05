import 'dart:math';

import 'package:dart_ray_tracer/ray/ray.dart';
import 'package:dart_ray_tracer/sphere/sphere.dart';
import 'package:dart_ray_tracer/vector/vector.dart';

class Intersection {
  final num t;
  final Sphere object;

  const Intersection(this.t, this.object);

  static List<Intersection> fromList(List<Intersection> list) {
    return list;
  }
}

List<Intersection> intersect(Sphere sphere, Ray ray) {
  final Ray transformedRay = Ray.transform(ray, sphere.transform.inverse());
  final Vector sphereToRay = transformedRay.origin - sphere.origin;
  final num a = transformedRay.direction * transformedRay.direction;
  final num b = 2 * (transformedRay.direction * sphereToRay);
  final num c = sphereToRay * sphereToRay - 1;
  final num discriminant = pow(b, 2) - 4 * a * c;

  if (discriminant < 0) {
    return [];
  }

  return [
    Intersection((-b - sqrt(discriminant)) / (2 * a), sphere),
    Intersection((-b + sqrt(discriminant)) / (2 * a), sphere)
  ];
}

Intersection? hit(List<Intersection> list) {
  final filteredList = [...list].where((_) => _.t > 0).toList();

  if (filteredList.isEmpty) {
    return null;
  }

  filteredList.sort((a, b) => a.t.compareTo(b.t));

  return filteredList[0];
}
