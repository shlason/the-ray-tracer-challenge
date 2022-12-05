import 'dart:math';

import 'package:dart_ray_tracer/matrices/matrices.dart';

abstract class Transform extends Matrices {
  const Transform(List<List<num>> matrix) : super(matrix);
}

class Translation extends Transform {
  final num x;
  final num y;
  final num z;

  Translation(this.x, this.y, this.z)
      : super([
          [1, 0, 0, x],
          [0, 1, 0, y],
          [0, 0, 1, z],
          [0, 0, 0, 1]
        ]);
}

class Scale extends Transform {
  final num x;
  final num y;
  final num z;

  Scale(this.x, this.y, this.z)
      : super([
          [x, 0, 0, 0],
          [0, y, 0, 0],
          [0, 0, z, 0],
          [0, 0, 0, 1]
        ]);
}

class RotateX extends Transform {
  final num radians;

  RotateX(this.radians)
      : super([
          [1, 0, 0, 0],
          [0, cos(radians), -sin(radians), 0],
          [0, sin(radians), cos(radians), 0],
          [0, 0, 0, 1]
        ]);
}

class RotateY extends Transform {
  final num radians;

  RotateY(this.radians)
      : super([
          [cos(radians), 0, sin(radians), 0],
          [0, 1, 0, 0],
          [-sin(radians), 0, cos(radians), 0],
          [0, 0, 0, 1]
        ]);
}

class RotateZ extends Transform {
  final num radians;

  RotateZ(this.radians)
      : super([
          [cos(radians), -sin(radians), 0, 0],
          [sin(radians), cos(radians), 0, 0],
          [0, 0, 1, 0],
          [0, 0, 0, 1]
        ]);
}

class Skew extends Transform {
  final num xy;
  final num xz;
  final num yx;
  final num yz;
  final num zx;
  final num zy;

  Skew(
    this.xy,
    this.xz,
    this.yx,
    this.yz,
    this.zx,
    this.zy,
  ) : super([
          [1, xy, xz, 0],
          [yx, 1, yz, 0],
          [zx, zy, 1, 0],
          [0, 0, 0, 1]
        ]);
}
