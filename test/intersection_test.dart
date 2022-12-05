import 'package:dart_ray_tracer/intersection/intersection.dart';
import 'package:dart_ray_tracer/sphere/sphere.dart';
import 'package:test/test.dart';

void main() {
  test('An intersection encapsulates t and object', () {
    final Sphere s = Sphere();
    final Intersection i = Intersection(3.5, s);

    expect(i.t == 3.5, true);
    expect(i.object == s, true);
  });
  test('Aggregating intersections', () {
    final Sphere s = Sphere();
    final Intersection i1 = Intersection(1, s);
    final Intersection i2 = Intersection(2, s);
    final List<Intersection> xs = Intersection.fromList([i1, i2]);

    expect(xs[0].t == 1, true);
    expect(xs[1].t == 2, true);
  });
  test('The hit, when all intersections have positive t', () {
    final Sphere s = Sphere();
    final Intersection i1 = Intersection(1, s);
    final Intersection i2 = Intersection(2, s);
    final List<Intersection> xs = Intersection.fromList([i1, i2]);
    final Intersection? i = hit(xs);

    expect(i?.t, 1);
    expect(i?.object == s, true);
  });
  test('The hit, when some intersections have negative t', () {
    final Sphere s = Sphere();
    final Intersection i1 = Intersection(-1, s);
    final Intersection i2 = Intersection(1, s);
    final List<Intersection> xs = Intersection.fromList([i1, i2]);
    final Intersection? i = hit(xs);

    expect(i?.t, 1);
    expect(i?.object == s, true);
  });
  test('The hit, when all intersections have negative t', () {
    final Sphere s = Sphere();
    final Intersection i1 = Intersection(-2, s);
    final Intersection i2 = Intersection(-1, s);
    final List<Intersection> xs = Intersection.fromList([i1, i2]);
    final Intersection? i = hit(xs);

    expect(i == null, true);
  });
  test('The hit, when all intersections have positive t', () {
    final Sphere s = Sphere();
    final Intersection i1 = Intersection(5, s);
    final Intersection i2 = Intersection(7, s);
    final Intersection i3 = Intersection(-3, s);
    final Intersection i4 = Intersection(2, s);
    final List<Intersection> xs = Intersection.fromList([i1, i2, i3, i4]);
    final Intersection? i = hit(xs);

    expect(i?.t, 2);
    expect(i?.object == s, true);
  });
}
