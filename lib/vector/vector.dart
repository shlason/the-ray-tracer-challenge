import 'dart:math';

import 'package:dart_ray_tracer/tuple/tuple.dart';

class Vector extends Tuple {
  Vector(
    num x,
    num y,
    num z,
  ) : super(x, y, z, 0.0);

  static Vector cross(Vector v1, Vector v2) {
    return Vector(
      v1.y * v2.z - v1.z * v2.y,
      v1.z * v2.x - v1.x * v2.z,
      v1.x * v2.y - v1.y * v2.x,
    );
  }

  static Vector fromList(List<num> list) {
    return Vector(list[0], list[1], list[2]);
  }

  @override
  dynamic operator -(Object other) {
    if (other is Vector) {
      return Vector(x - other.x, y - other.y, z - other.z);
    }
    throw 'Operand type error';
  }

  @override
  dynamic operator *(Object other) {
    if (other is Vector) {
      // Dot product
      return x * other.x + y * other.y + z * other.z + w * other.w;
    }
    if (other is num) {
      return Vector(x * other, y * other, z * other);
    }
    throw 'Operand type error';
  }

  num magnitude() {
    num getSquare(num base) {
      return pow(base, 2);
    }

    return sqrt(getSquare(x) + getSquare(y) + getSquare(z) + getSquare(w));
  }

  Vector normalize() {
    final num magnitudeVal = magnitude();

    x /= magnitudeVal;
    y /= magnitudeVal;
    z /= magnitudeVal;
    w /= magnitudeVal;

    return this;
  }

  Vector reflect(Vector vector) {
    return this - vector * 2 * (this * vector);
  }
}
