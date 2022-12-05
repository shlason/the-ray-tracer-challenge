import 'dart:math';

import 'package:dart_ray_tracer/matrices/matrices.dart';
import 'package:dart_ray_tracer/tuple/tuple.dart';
import 'package:test/test.dart';

import 'package:dart_ray_tracer/transform/transform.dart';
import 'package:dart_ray_tracer/vector/vector.dart';
import 'package:dart_ray_tracer/point/point.dart';

void main() {
  test('Multiplying by a translation matrix', () {
    final Translation translation = Translation(5, -3, 2);
    final Point point = Point(-3, 4, 5);

    expect(Point(2, 1, 7).equalTo(translation * point), true);
  });
  test('Multiplying by the inverse of a translation matrix', () {
    final Translation translation = Translation(5, -3, 2);
    final Matrices inversedTranslation = translation.inverse();
    final point = Point(-3, 4, 5);

    expect(Point(-8, 7, 3).equalTo(inversedTranslation * point), true);
  });
  test('Translation does not affect vectors', () {
    final Translation translation = Translation(5, -3, 2);
    final Vector vector = Vector(-3, 4, 5);

    expect(Vector(-3, 4, 5).equalTo(translation * vector), true);
  });
  test('A scaling matrix applied to a point', () {
    final Scale scale = Scale(2, 3, 4);
    final Point point = Point(-4, 6, 8);

    expect(Point(-8, 18, 32).equalTo(scale * point), true);
  });
  test('A scaling matrix applied to a vector', () {
    final Scale scale = Scale(2, 3, 4);
    final Vector vector = Vector(-4, 6, 8);

    expect(Vector(-8, 18, 32).equalTo(scale * vector), true);
  });
  test('Multiplying by the inverse of a scaling matrix', () {
    final Scale scale = Scale(2, 3, 4);
    final Matrices inversedScale = scale.inverse();
    final Vector vector = Vector(-4, 6, 8);

    expect(Vector(-2, 2, 2).equalTo(inversedScale * vector), true);
  });
  test('Reflection is scaling by a negative value', () {
    final Scale scale = Scale(-1, 1, 1);
    final Point point = Point(2, 3, 4);

    expect(Point(-2, 3, 4).equalTo(scale * point), true);
  });
  test('Rotating a point around the x axis', () {
    final Point point = Point(0, 1, 0);
    final RotateX halfQuarter = RotateX(pi / 4);
    final RotateX fullQuarter = RotateX(pi / 2);

    expect(
      Point(0, sqrt(2) / 2, sqrt(2) / 2).equalTo(halfQuarter * point),
      true,
    );
    expect(Point(0, 0, 1).equalTo(fullQuarter * point), true);
  });
  test('The inverse of an x-rotation rotates in the opposite direction', () {
    final Point point = Point(0, 1, 0);
    final RotateX halfQuarter = RotateX(pi / 4);
    final Matrices inversedHalfQuarter = halfQuarter.inverse();

    expect(
      Point(0, sqrt(2) / 2, -sqrt(2) / 2).equalTo(inversedHalfQuarter * point),
      true,
    );
  });
  test('Rotating a point around the y axis', () {
    final Point point = Point(0, 0, 1);
    final RotateY halfQuarter = RotateY(pi / 4);
    final RotateY fullQuarter = RotateY(pi / 2);

    expect(
      Point(sqrt(2) / 2, 0, sqrt(2) / 2).equalTo(halfQuarter * point),
      true,
    );
    expect(
      Point(1, 0, 0).equalTo(fullQuarter * point),
      true,
    );
  });
  test('Rotating a point around the Z axis', () {
    final Point point = Point(0, 1, 0);
    final RotateZ halfQuarter = RotateZ(pi / 4);
    final RotateZ fullQuarter = RotateZ(pi / 2);

    expect(
      Point(-sqrt(2) / 2, sqrt(2) / 2, 0).equalTo(halfQuarter * point),
      true,
    );
    expect(
      Point(-1, 0, 0).equalTo(fullQuarter * point),
      true,
    );
  });
  test('A shearing transformation moves x in proportion to y', () {
    final Point point = Point(2, 3, 4);
    final Skew transform = Skew(1, 0, 0, 0, 0, 0);

    expect(Point(5, 3, 4).equalTo(transform * point), true);
  });
  test('A shearing transformation moves x in proportion to z', () {
    final Point point = Point(2, 3, 4);
    final Skew transform = Skew(0, 1, 0, 0, 0, 0);

    expect(Point(6, 3, 4).equalTo(transform * point), true);
  });
  test('A shearing transformation moves y in proportion to x', () {
    final Point point = Point(2, 3, 4);
    final Skew transform = Skew(0, 0, 1, 0, 0, 0);

    expect(Point(2, 5, 4).equalTo(transform * point), true);
  });
  test('A shearing transformation moves y in proportion to z', () {
    final Point point = Point(2, 3, 4);
    final Skew transform = Skew(0, 0, 0, 1, 0, 0);

    expect(Point(2, 7, 4).equalTo(transform * point), true);
  });
  test('A shearing transformation moves z in proportion to x', () {
    final Point point = Point(2, 3, 4);
    final Skew transform = Skew(0, 0, 0, 0, 1, 0);

    expect(Point(2, 3, 6).equalTo(transform * point), true);
  });
  test('A shearing transformation moves z in proportion to y', () {
    final Point point = Point(2, 3, 4);
    final Skew transform = Skew(0, 0, 0, 0, 0, 1);

    expect(Point(2, 3, 7).equalTo(transform * point), true);
  });
  test('Individual transformations are applied in sequence', () {
    final RotateX rotateX = RotateX(pi / 2);
    final Scale scale = Scale(5, 5, 5);
    final Translation translation = Translation(10, 5, 7);
    Tuple point = Point(1, 0, 1);

    point = rotateX * point;
    expect(Point(1, -1, 0).equalTo(point), true);

    point = scale * point;
    expect(Point(5, -5, 0).equalTo(point), true);

    point = translation * point;
    expect(Point(15, 0, 7).equalTo(point), true);
  });
  test('Chained transformations must be applied in reverse order', () {
    final Point point = Point(1, 0, 1);
    final RotateX rotateX = RotateX(pi / 2);
    final Scale scale = Scale(5, 5, 5);
    final Translation translation = Translation(10, 5, 7);

    expect(
      Point(15, 0, 7).equalTo((translation * scale * rotateX) * point),
      true,
    );
  });
}

num converNumToSpecificFixedNum(num n, int fixedPoint) {
  return num.parse(n.toStringAsFixed(fixedPoint));
}
