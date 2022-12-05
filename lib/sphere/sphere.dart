import 'package:dart_ray_tracer/material/material.dart';
import 'package:dart_ray_tracer/matrices/matrices.dart';
import 'package:dart_ray_tracer/point/point.dart';
import 'package:dart_ray_tracer/vector/vector.dart';
import 'package:uuid/uuid.dart';

class Sphere {
  final Uuid uuid;

  Matrices transform = Matrices.identityMatrix;
  Material material = Material();

  Sphere() : uuid = Uuid();

  Point get origin => Point(0, 0, 0);

  static Vector normalAt(Sphere sphere, Point worldPoint) {
    final Point objectPoint =
        Point.fromList((sphere.transform.inverse() * worldPoint).toList());
    final Vector objectNormal = objectPoint - Point(0, 0, 0);
    final Vector worldNormal = Vector.fromList(
        (sphere.transform.inverse().transpose() * objectNormal).toList());

    return worldNormal.normalize();
  }

  @override
  bool operator ==(Object other) {
    if (other is! Sphere) {
      return false;
    }

    return uuid == other.uuid;
  }

  @override
  int get hashCode {
    return uuid.hashCode;
  }
}
