import 'package:dart_ray_tracer/matrices/matrices.dart';
import 'package:dart_ray_tracer/point/point.dart';
import 'package:dart_ray_tracer/vector/vector.dart';

class Ray {
  final Point origin;
  final Vector direction;

  Ray(this.origin, this.direction);

  static Point position(Ray ray, num time) {
    return Point.fromList((ray.origin + ray.direction * time).toList());
  }

  static Ray transform(Ray r, Matrices t) {
    return Ray(
      Point.fromList((t * r.origin).toList()),
      Vector.fromList((t * r.direction).toList()),
    );
  }
}
