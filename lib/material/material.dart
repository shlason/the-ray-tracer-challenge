import 'package:dart_ray_tracer/color/color.dart';

class Material {
  Color color = Color(1, 1, 1);
  num ambient = 0.1;
  num diffuse = 0.9;
  num specular = 0.9;
  num shininess = 200.0;

  Material();

  @override
  bool operator ==(Object other) {
    if (other is! Material) {
      return false;
    }

    return color.equalTo(other.color) &&
        ambient == other.ambient &&
        diffuse == other.diffuse &&
        specular == other.specular &&
        shininess == other.shininess;
  }

  @override
  int get hashCode {
    return color.hashCode;
  }
}
