import 'package:dart_ray_tracer/ray/ray.dart';
import 'package:dart_ray_tracer/transform/transform.dart';
import 'package:dart_ray_tracer/vector/vector.dart';
import 'package:test/test.dart';

import 'package:dart_ray_tracer/point/point.dart';

void main() {
  test('Creating and querying a ray', () {
    final Point origin = Point(1, 2, 3);
    final Vector direction = Vector(4, 5, 6);
    final Ray ray = Ray(origin, direction);

    expect(origin.equalTo(ray.origin), true);
    expect(direction.equalTo(ray.direction), true);
  });
  test('Computing a point from a distance', () {
    final Point origin = Point(2, 3, 4);
    final Vector direction = Vector(1, 0, 0);
    final Ray ray = Ray(origin, direction);

    expect(Point(2, 3, 4).equalTo(Ray.position(ray, 0)), true);
    expect(Point(3, 3, 4).equalTo(Ray.position(ray, 1)), true);
    expect(Point(1.0, 3, 4).equalTo(Ray.position(ray, -1)), true);
    expect(Point(4.5, 3, 4).equalTo(Ray.position(ray, 2.5)), true);
  });
  test('Translating a ray', () {
    final Ray ray = Ray(Point(1, 2, 3), Vector(0, 1, 0));
    final Translation translation = Translation(3, 4, 5);
    final Ray ray2 = Ray.transform(ray, translation);

    expect(ray2.origin.equalTo(Point(4, 6, 8)), true);
    expect(ray2.direction.equalTo(Vector(0, 1, 0)), true);
  });
  test('Scaling a ray', () {
    final Ray ray = Ray(Point(1, 2, 3), Vector(0, 1, 0));
    final Scale scale = Scale(2, 3, 4);
    final Ray ray2 = Ray.transform(ray, scale);

    expect(ray2.origin.equalTo(Point(2, 6, 12)), true);
    expect(ray2.direction.equalTo(Vector(0, 3, 0)), true);
  });
}
