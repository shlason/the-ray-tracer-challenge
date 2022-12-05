import 'package:dart_ray_tracer/point/point.dart';
import 'package:dart_ray_tracer/tuple/tuple.dart';
import 'package:dart_ray_tracer/vector/vector.dart';

int calculate() {
  return 6 * 7;
}

Map tick(env, proj) {
  final position = proj['position'] + proj['velocity'];
  final velocity = proj['velocity'] + env['gravity'] + env['wind'];

  return {
    'position': position,
    'velocity': velocity,
  };
}

Map projectile(position, velocity) {
  return {
    'position': position,
    'velocity': velocity,
  };
}

Map enviroment(gravity, wind) {
  return {
    'gravity': gravity,
    'wind': wind,
  };
}
