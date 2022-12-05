import 'package:dart_ray_tracer/tuple/tuple.dart';
import 'package:dart_ray_tracer/vector/vector.dart';

class Point extends Tuple {
  Point(
    num x,
    num y,
    num z,
  ) : super(x, y, z, 1.0);

  static Point fromList(List<num> list) {
    return Point(list[0], list[1], list[2]);
  }

  @override
  dynamic operator -(Object other) {
    if (other is Point) {
      return Vector(x - other.x, y - other.y, z - other.z);
    }
    if (other is Vector) {
      return Point(x - other.x, y - other.y, z - other.z);
    }
    throw 'Operand type error';
  }
}
