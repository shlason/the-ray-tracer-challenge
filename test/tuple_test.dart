import 'dart:math';
import 'package:test/test.dart';

import 'package:dart_ray_tracer/tuple/tuple.dart';
import 'package:dart_ray_tracer/point/point.dart';
import 'package:dart_ray_tracer/vector/vector.dart';

void main() {
  test('A tuple with w = 1.0 is a point.', () {
    const num x = 4.3;
    const num y = -4.2;
    const num z = 3.1;
    const num w = 1.0;

    final Tuple tuple = Tuple(x, y, z, w);

    expect(tuple.equalTo(Tuple(x, y, z, w)), true);
    expect(tuple.x, x);
    expect(tuple.y, y);
    expect(tuple.z, z);
    expect(tuple.w, w);
    expect(tuple.isPoint(), true);
    // Alternative testing
    expect(tuple.isVector(), false);
  });
  test('A tuple with w = 0.0 is a vector.', () {
    const num x = 4.3;
    const num y = -4.2;
    const num z = 3.1;
    const num w = 0.0;

    final Tuple tuple = Tuple(x, y, z, w);

    expect(tuple.equalTo(Tuple(x, y, z, w)), true);
    expect(tuple.x, x);
    expect(tuple.y, y);
    expect(tuple.z, z);
    expect(tuple.w, w);
    expect(tuple.isVector(), true);
    // Alternative testing
    expect(tuple.isPoint(), false);
  });
  test('Two tuples should be equal', () {
    const num x = 1;
    const num y = 2;
    const num z = 3;
    const num w = 4;

    final Tuple tupleA = Tuple(x, y, z, w);
    final Tuple tupleB = Tuple(x, y, z, w);

    expect(tupleA.x, tupleB.x);
    expect(tupleA.y, tupleB.y);
    expect(tupleA.z, tupleB.z);
    expect(tupleA.w, tupleB.w);

    expect(tupleA.equalTo(tupleB), true);
  });
  test('Adding two tuples', () {
    const num x = 4.3;
    const num y = -4.2;
    const num z = 3.1;
    const num w = 1.0;

    final Tuple tupleA = Tuple(x, y, z, w);
    final Tuple tupleB = Tuple(x, y, z, w);

    final Tuple result = tupleA + tupleB;

    expect(result.x, x + x);
    expect(result.y, y + y);
    expect(result.z, z + z);
    expect(result.w, w + w);
  });
  test('Subtracting two tuples', () {
    const num p1x = 3.0;
    const num p1y = 2.0;
    const num p1z = 1.0;

    const num p2x = 5.0;
    const num p2y = 6.0;
    const num p2z = 7.0;

    final Tuple pointA = Point(p1x, p1y, p1z);
    final Tuple pointB = Point(p2x, p2y, p2z);
    final Tuple resultVector = Vector(p1x - p2x, p1y - p2y, p1z - p2z);

    final Tuple result = pointA - pointB;

    expect(result.x, p1x - p2x);
    expect(result.y, p1y - p2y);
    expect(result.z, p1z - p2z);
    expect(result.w, 0.0);

    expect(result.equalTo(resultVector), true);

    expect(result.isVector(), true);
    // Alternative testing
    expect(result.isPoint(), false);
  });
  test('Subtracting a vector from a point', () {
    const num px = 3;
    const num py = 2;
    const num pz = 1;

    const num vx = 5;
    const num vy = 6;
    const num vz = 7;

    final Point point = Point(px, py, pz);
    final Vector vector = Vector(vx, vy, vz);
    final Point expectedResult = Point(px - vx, py - vy, pz - vz);

    final Tuple result = point - vector;

    expect(result.x, px - vx);
    expect(result.y, py - vy);
    expect(result.z, pz - vz);
    expect(result.w, 1.0);

    expect(result.equalTo(expectedResult), true);

    expect(result.isPoint(), true);
    // Alternative testing
    expect(result.isVector(), false);
  });
  test('Subtracting two vectors', () {
    const num v1x = 3;
    const num v1y = 2;
    const num v1z = 1;

    const num v2x = 5;
    const num v2y = 6;
    const num v2z = 7;

    final Tuple vector1 = Vector(v1x, v1y, v1z);
    final Tuple vector2 = Vector(v2x, v2y, v2z);

    final Vector expectedResult = Vector(v1x - v2x, v1y - v2y, v1z - v2z);

    final Tuple result = vector1 - vector2;

    expect(result.x, v1x - v2x);
    expect(result.y, v1y - v2y);
    expect(result.z, v1z - v2z);
    expect(result.w, 0.0);

    expect(result.equalTo(expectedResult), true);

    expect(result.isVector(), true);
    // Alternative testing
    expect(result.isPoint(), false);
  });
  test('Subtracting a vector form the zero vector', () {
    const num zero = 0;

    const num x = 1;
    const num y = -2;
    const num z = 3;

    final Tuple zeroVector = Vector(zero, zero, zero);
    final Tuple vector = Vector(x, y, z);

    final Tuple result = zeroVector - vector;

    expect(result.x, zero - x);
    expect(result.y, zero - y);
    expect(result.z, zero - z);
    expect(result.w, zero - 0.0);

    expect(result.isVector(), true);
    // Alternative testing
    expect(result.isPoint(), false);
  });
  test('Negating a tuple', () {
    const num x = 1;
    const num y = -2;
    const num z = 3;
    const num w = -4;

    final Tuple tuple = Tuple(x, y, z, w);
    final Tuple expectedResult = Tuple(-x, -y, -z, -w);

    final Tuple result = tuple.negate();

    expect(result.equalTo(expectedResult), true);
  });
  test('Multiplying a tuple by a scalar', () {
    const num scalar = 3.5;

    const num x = 1;
    const num y = -2;
    const num z = 3;
    const num w = -4;

    final Tuple tuple = Tuple(x, y, z, w);
    final Tuple result = tuple * scalar;

    expect(result.x, x * scalar);
    expect(result.y, y * scalar);
    expect(result.z, z * scalar);
    expect(result.w, w * scalar);
  });
  test('Multiplying a tuple by a fraction', () {
    const num fraction = 0.5;

    const num x = 1;
    const num y = -2;
    const num z = 3;
    const num w = -4;

    final Tuple tuple = Tuple(x, y, z, w);
    final Tuple result = tuple * fraction;

    expect(result.x, x * fraction);
    expect(result.y, y * fraction);
    expect(result.z, z * fraction);
    expect(result.w, w * fraction);
  });
  test('Dividing a tuple by a scalar', () {
    const num scalar = 2;

    const num x = 1;
    const num y = -2;
    const num z = 3;
    const num w = -4;

    final Tuple tuple = Tuple(x, y, z, w);
    final Tuple result = tuple / scalar;

    expect(result.x, x / scalar);
    expect(result.y, y / scalar);
    expect(result.z, z / scalar);
    expect(result.w, w / scalar);
  });
  test('Computing the magnitude of vector(1, 0, 0)', () {
    const num expectedResult = 1;
    final Vector vector = Vector(1, 0, 0);

    final num result = vector.magnitude();

    expect(result, expectedResult);
  });
  test('Computing the magnitude of vector(0, 1, 0)', () {
    const num expectedResult = 1;
    final Vector vector = Vector(0, 1, 0);

    final num result = vector.magnitude();

    expect(result, expectedResult);
  });
  test('Computing the magnitude of vector(0, 0, 1)', () {
    const num expectedResult = 1;
    final Vector vector = Vector(0, 0, 1);

    final num result = vector.magnitude();

    expect(result, expectedResult);
  });
  test('Computing the magnitude of vector(1, 2, 3)', () {
    final num expectedResult = sqrt(14);
    final Vector vector = Vector(1, 2, 3);

    final num result = vector.magnitude();

    expect(result, expectedResult);
  });
  test('Computing the magnitude of vector(-1, -2, -3)', () {
    final num expectedResult = sqrt(14);
    final Vector vector = Vector(-1, -2, -3);

    final num result = vector.magnitude();

    expect(result, expectedResult);
  });
  test('Normalizing vector(4, 0, 0) gives (1, 0, 0)', () {
    final Vector vector = Vector(4, 0, 0);
    final Tuple result = vector.normalize();

    expect(result.equalTo(Vector(1, 0, 0)), true);
  });
  test('Normalizing vector(1, 2, 3)', () {
    const num x = 1;
    const num y = 2;
    const num z = 3;
    final Vector vector = Vector(x, y, z);
    final num magnitudeVal = vector.magnitude();
    final Vector result = vector.normalize();

    // Approximately
    expect(
      result.equalTo(
          Vector(x / magnitudeVal, y / magnitudeVal, z / magnitudeVal)),
      true,
    );
  });
  test('The magnitude of a normalized vector', () {
    final Vector vector = Vector(1, 2, 3);
    final Vector result = vector.normalize();
    final num resultMagnitudeVal = result.magnitude();

    // Approximately
    expect(resultMagnitudeVal == 1, true);
  });
  test('The dot product of two vectors', () {
    final Vector vectorA = Vector(1, 2, 3);
    final Vector vectorB = Vector(2, 3, 4);

    final num result = vectorA * vectorB;

    expect(result, 20);
  });
  test('The cross product of two vectors', () {
    final Vector vectorA = Vector(1, 2, 3);
    final Vector vectorB = Vector(2, 3, 4);

    final Vector vectorACrossToVectorB = Vector.cross(vectorA, vectorB);
    final Vector vectorBCrossToVectorA = Vector.cross(vectorB, vectorA);

    expect(vectorACrossToVectorB.equalTo(Vector(-1, 2, -1)), true);
    expect(vectorBCrossToVectorA.equalTo(Vector(1, -2, 1)), true);
  });
}
