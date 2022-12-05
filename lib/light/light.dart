import 'dart:math';

import 'package:dart_ray_tracer/color/color.dart';
import 'package:dart_ray_tracer/material/material.dart';
import 'package:dart_ray_tracer/point/point.dart';
import 'package:dart_ray_tracer/vector/vector.dart';

abstract class Light {
  final Point position;
  final Color intensity;

  const Light(this.position, this.intensity);
}

class PointLight extends Light {
  const PointLight(Point position, Color intensity)
      : super(position, intensity);
}

Color lighting(
  Material material,
  Light light,
  Point position,
  Vector eyeV,
  Vector normalV,
) {
  final Color black = Color(0, 0, 0);
  final Color effectiveColor = material.color * light.intensity;
  final Vector lightV = (light.position - position).normalize();
  final Color ambient = effectiveColor * material.ambient;
  final num lightDotNormal = lightV * normalV;

  Color diffuse;
  Color specular;

  if (lightDotNormal < 0) {
    diffuse = black;
    specular = black;
  } else {
    diffuse = effectiveColor * material.diffuse * lightDotNormal;

    final Vector reflectV =
        Vector(0 - lightV.x, 0 - lightV.y, 0 - lightV.z).reflect(normalV);
    final num reflectDotEye = reflectV * eyeV;

    if (reflectDotEye <= 0) {
      specular = black;
    } else {
      final num factor = pow(reflectDotEye, material.shininess);

      specular = light.intensity * material.specular * factor;
    }
  }

  return ambient + diffuse + specular;
}
