import 'package:dart_ray_tracer/tuple/tuple.dart';

class Color extends Tuple {
  num red = 0.0;
  num green = 0.0;
  num blue = 0.0;

  Color(
    this.red,
    this.green,
    this.blue,
  ) : super(red, green, blue, 0.0);

  @override
  Color operator +(Tuple other) {
    final result = super + other;

    return Color(result.x, result.y, result.z);
  }

  @override
  dynamic operator -(Tuple other) {
    final result = super - other;

    return Color(result.x, result.y, result.z);
  }

  @override
  dynamic operator *(Object other) {
    final result = super * other;

    return Color(result.x, result.y, result.z);
  }

  String toPlainString(maximumColorValue) {
    num getValidColorValue(colorValue) {
      final num result = (colorValue * maximumColorValue).round();
      if (result > maximumColorValue) {
        return maximumColorValue;
      }
      if (result < 0) {
        return 0;
      }
      return result;
    }

    final String redStr = getValidColorValue(red).toString();
    final String greenStr = getValidColorValue(green).toString();
    final String blueStr = getValidColorValue(blue).toString();

    return '$redStr $greenStr $blueStr';
  }
}
