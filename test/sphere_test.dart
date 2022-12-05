import 'dart:math';

import 'package:dart_ray_tracer/intersection/intersection.dart';
import 'package:dart_ray_tracer/material/material.dart';
import 'package:dart_ray_tracer/matrices/matrices.dart';
import 'package:dart_ray_tracer/ray/ray.dart';
import 'package:dart_ray_tracer/sphere/sphere.dart';
import 'package:dart_ray_tracer/transform/transform.dart';
import 'package:dart_ray_tracer/vector/vector.dart';
import 'package:test/test.dart';

import 'package:dart_ray_tracer/point/point.dart';

void main() {
  test('A ray intersects a sphere at two points', () {
    final Ray r = Ray(Point(0, 0, -5), Vector(0, 0, 1));
    final Sphere s = Sphere();
    final List<Intersection> xs = intersect(s, r);

    expect(xs.length, 2);
    expect(xs[0].t, 4);
    expect(xs[1].t, 6);
  });
  test('A ray intersects a sphere at a tangent', () {
    final Ray r = Ray(Point(0, 1, -5), Vector(0, 0, 1));
    final Sphere s = Sphere();
    final List<Intersection> xs = intersect(s, r);

    expect(xs.length, 2);
    expect(xs[0].t, 5);
    expect(xs[1].t, 5);
  });
  test('A ray misses a sphere', () {
    final Ray r = Ray(Point(0, 2, -5), Vector(0, 0, 1));
    final Sphere s = Sphere();
    final List<Intersection> xs = intersect(s, r);

    expect(xs.length, 0);
  });
  test('A ray originates inside a sphere', () {
    final Ray r = Ray(Point(0, 0, 0), Vector(0, 0, 1));
    final Sphere s = Sphere();
    final List<Intersection> xs = intersect(s, r);

    expect(xs.length, 2);
    expect(xs[0].t, -1);
    expect(xs[1].t, 1);
  });
  test('A sphere is behind a ray', () {
    final Ray r = Ray(Point(0, 0, 5), Vector(0, 0, 1));
    final Sphere s = Sphere();
    final List<Intersection> xs = intersect(s, r);

    expect(xs.length, 2);
    expect(xs[0].t, -6);
    expect(xs[1].t, -4);
  });
  test('Intersect sets the object on the intersection', () {
    final Ray r = Ray(Point(0, 0, -5), Vector(0, 0, 1));
    final Sphere s = Sphere();
    final List<Intersection> xs = intersect(s, r);

    expect(xs.length, 2);
    expect(xs[0].object, s);
    expect(xs[1].object, s);
  });
  test('A sphere\'s default transformation', () {
    final Sphere s = Sphere();

    expect(s.transform == Matrices.identityMatrix, true);
  });
  test('Changing a sphere\'s transformation', () {
    final Sphere s = Sphere();

    s.transform = Translation(2, 3, 4);

    expect(s.transform == Translation(2, 3, 4), true);
  });
  test('Intersecting a scaled sphere with a ray', () {
    final Ray ray = Ray(Point(0, 0, -5), Vector(0, 0, 1));
    final Sphere s = Sphere();

    s.transform = Scale(2, 2, 2);

    final List<Intersection> xs = intersect(s, ray);

    expect(xs.length == 2, true);
    expect(xs[0].t == 3, true);
    expect(xs[1].t == 7, true);
  });
  test('Intersecting a translated sphere with a ray', () {
    final Ray ray = Ray(Point(0, 0, -5), Vector(0, 0, 1));
    final Sphere s = Sphere();

    s.transform = Translation(5, 0, 0);
    final List<Intersection> xs = intersect(s, ray);

    expect(xs.isEmpty, true);
  });
  test('The normal on a sphere at a point on the x axis', () {
    final Sphere s = Sphere();
    final Vector v = Sphere.normalAt(s, Point(1, 0, 0));

    expect(v.equalTo(Vector(1, 0, 0)), true);
  });
  test('The normal on a sphere at a point on the y axis', () {
    final Sphere s = Sphere();
    final Vector v = Sphere.normalAt(s, Point(0, 1, 0));

    expect(v.equalTo(Vector(0, 1, 0)), true);
  });
  test('The normal on a sphere at a point on the z axis', () {
    final Sphere s = Sphere();
    final Vector v = Sphere.normalAt(s, Point(0, 0, 1));

    expect(v.equalTo(Vector(0, 0, 1)), true);
  });
  test('The normal on a sphere at a nonaxial point', () {
    final Sphere s = Sphere();
    final Vector v =
        Sphere.normalAt(s, Point(sqrt(3) / 3, sqrt(3) / 3, sqrt(3) / 3));

    expect(v.equalTo(Vector(sqrt(3) / 3, sqrt(3) / 3, sqrt(3) / 3)), true);
  });
  test('The normal is a normalized vector', () {
    final Sphere s = Sphere();
    final Vector v =
        Sphere.normalAt(s, Point(sqrt(3) / 3, sqrt(3) / 3, sqrt(3) / 3));

    expect(v.normalize().equalTo(v), true);
  });
  test('Computing the normal on a translated sphere', () {
    final Sphere s = Sphere();

    s.transform = Translation(0, 1, 0);

    final n = Sphere.normalAt(s, Point(0, 1.70711, -0.70711));

    expect(n.equalTo(Vector(0, 0.7071067811865475, -0.7071067811865476)), true);
  });
  test('Computing the normal on a transformed sphere', () {
    final Sphere s = Sphere();

    s.transform = Scale(1, 0.5, 1) * RotateZ(pi / 5);

    final n = Sphere.normalAt(s, Point(0, sqrt(2) / 2, -sqrt(2) / 2));

    expect(
        n.equalTo(Vector(0, 0.9701425001453319, -0.24253562503633294)), true);
  });
  test('A sphere has a default material', () {
    final Sphere s = Sphere();
    final Material m = Material();

    expect(s.material == m, true);
  });
  test('A sphere may be assigned a material', () {
    final Sphere s = Sphere();
    final Material m = Material();

    m.ambient = 1;
    s.material = m;

    expect(s.material == m, true);
  });
}
