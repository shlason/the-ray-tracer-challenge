import 'dart:math';

import 'package:dart_ray_tracer/color/color.dart';
import 'package:dart_ray_tracer/light/light.dart';
import 'package:dart_ray_tracer/material/material.dart';
import 'package:dart_ray_tracer/point/point.dart';
import 'package:dart_ray_tracer/vector/vector.dart';
import 'package:test/test.dart';

void main() {
  final Material baseMaterial = Material();
  final Point basePosition = Point(0, 0, 0);

  test('The default material', () {
    final Material m = Material();

    expect(m.color.equalTo(Color(1, 1, 1)), true);
    expect(m.ambient == 0.1, true);
    expect(m.diffuse == 0.9, true);
    expect(m.specular == 0.9, true);
    expect(m.shininess == 200.0, true);
  });

  test('Lighting with the eye between the light and the surface', () {
    final Vector eyeV = Vector(0, 0, -1);
    final Vector normalV = Vector(0, 0, -1);
    final PointLight light = PointLight(Point(0, 0, -10), Color(1, 1, 1));
    final Color result =
        lighting(baseMaterial, light, basePosition, eyeV, normalV);

    expect(Color(1.9, 1.9, 1.9).equalTo(result), true);
  });
  test(
    'Lighting with the eye between the light and the surface, eye offset 45 degree',
    () {
      final Vector eyeV = Vector(0, sqrt(2) / 2, -(sqrt(2) / 2));
      final Vector normalV = Vector(0, 0, -1);
      final PointLight light = PointLight(Point(0, 0, -10), Color(1, 1, 1));
      final Color result =
          lighting(baseMaterial, light, basePosition, eyeV, normalV);

      expect(Color(1.0, 1.0, 1.0).equalTo(result), true);
    },
  );
  test(
    'Lighting with eye opposite surface, light offset 45 degree',
    () {
      final Vector eyeV = Vector(0, 0, -1);
      final Vector normalV = Vector(0, 0, -1);
      final PointLight light = PointLight(Point(0, 10, -10), Color(1, 1, 1));
      final Color result =
          lighting(baseMaterial, light, basePosition, eyeV, normalV);

      expect(
        Color(0.7363961030678927, 0.7363961030678927, 0.7363961030678927)
            .equalTo(result),
        true,
      );
    },
  );
  test('Lighting with the eye in the path of the reflection vector', () {
    final Vector eyeV = Vector(0, -(sqrt(2) / 2), -(sqrt(2) / 2));
    final Vector normalV = Vector(0, 0, -1);
    final PointLight light = PointLight(Point(0, 10, -10), Color(1, 1, 1));
    final Color result =
        lighting(baseMaterial, light, basePosition, eyeV, normalV);

    expect(
      Color(1.6363961030678928, 1.6363961030678928, 1.6363961030678928)
          .equalTo(result),
      true,
    );
  });
  test('Lighting with the light behind the surface', () {
    final Vector eyeV = Vector(0, 0, -1);
    final Vector normalV = Vector(0, 0, -1);
    final PointLight light = PointLight(Point(0, 0, 10), Color(1, 1, 1));
    final Color result =
        lighting(baseMaterial, light, basePosition, eyeV, normalV);

    expect(Color(0.1, 0.1, 0.1).equalTo(result), true);
  });
}
