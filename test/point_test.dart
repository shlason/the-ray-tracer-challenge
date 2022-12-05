import 'package:test/test.dart';

import 'package:dart_ray_tracer/tuple/tuple.dart';
import 'package:dart_ray_tracer/point/point.dart';

void main() {
  test('Point() creates tuples with w = 1.0', () {
    const num x = 4.3;
    const num y = -4.2;
    const num z = 3.1;
    const num w = 1.0;

    final Point point = Point(x, y, z);
    final Tuple tuple = Tuple(x, y, z, w);

    expect(point.w, w);
    expect(point.x, tuple.x);
    expect(point.y, tuple.y);
    expect(point.z, tuple.z);
    expect(point.w, tuple.w);
  });
}
