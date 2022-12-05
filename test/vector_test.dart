import 'dart:math';

import 'package:test/test.dart';

import 'package:dart_ray_tracer/tuple/tuple.dart';
import 'package:dart_ray_tracer/vector/vector.dart';

void main() {
  test('Vector() creates tuples with w = 0.0', () {
    const num x = 4.3;
    const num y = -4.2;
    const num z = 3.1;
    const num w = 0.0;

    final Vector vector = Vector(x, y, z);
    final Tuple tuple = Tuple(x, y, z, w);

    expect(vector.w, w);
    expect(vector.x, tuple.x);
    expect(vector.y, tuple.y);
    expect(vector.z, tuple.z);
    expect(vector.w, tuple.w);
  });
  test('Reflecting a vector approaching at 45 degree', () {
    final Vector v = Vector(1, -1, 0);
    final Vector n = Vector(0, 1, 0);
    final Vector r = v.reflect(n);

    expect(r.equalTo(Vector(1, 1, 0)), true);
  });
  test('Reflecting a vector off a slanted surface', () {
    final Vector v = Vector(0, -1, 0);
    final Vector n = Vector(sqrt(2) / 2, sqrt(2) / 2, 0);
    final Vector r = v.reflect(n);

    expect(r.equalTo(Vector(1, 0, 0)), true);
  });
}
