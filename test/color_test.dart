import 'package:test/test.dart';

import 'package:dart_ray_tracer/color/color.dart';

void main() {
  test('Colors are (red, green, blue) tuples', () {
    const num red = -0.5;
    const num green = 0.4;
    const num blue = 1.7;

    final Color color = Color(red, green, blue);

    expect(color.red, red);
    expect(color.green, green);
    expect(color.blue, blue);
  });
  test('Adding colors', () {
    const num redA = 0.9;
    const num greenA = 0.6;
    const num blueA = 0.75;

    const num redB = 0.7;
    const num greenB = 0.1;
    const num blueB = 1.0;

    final Color colorA = Color(redA, greenA, blueA);
    final Color colorB = Color(redB, greenB, blueB);

    final Color result = colorA + colorB;

    expect(
      result.equalTo(Color(redA + redB, greenA + greenB, blueA + blueB)),
      true,
    );
  });
  test('Suctracting colors', () {
    const num redA = 0.9;
    const num greenA = 0.6;
    const num blueA = 0.75;

    const num redB = 0.7;
    const num greenB = 0.1;
    const num blueB = 1.0;

    final Color colorA = Color(redA, greenA, blueA);
    final Color colorB = Color(redB, greenB, blueB);

    final Color result = colorA - colorB;

    expect(
      result.equalTo(Color(redA - redB, greenA - greenB, blueA - blueB)),
      true,
    );
  });
  test('Mutiplying a color by a scalar', () {
    const num scalar = 2.0;
    const num red = 0.2;
    const num green = 0.3;
    const num blue = 0.4;

    final Color colorA = Color(red, green, blue);
    final Color result = colorA * 2;

    expect(
      result.equalTo(Color(red * scalar, green * scalar, blue * scalar)),
      true,
    );
  });
  test('Mutiplying colors', () {
    const num redA = 0.9;
    const num greenA = 0.6;
    const num blueA = 0.75;

    const num redB = 0.7;
    const num greenB = 0.1;
    const num blueB = 1.0;

    final Color colorA = Color(redA, greenA, blueA);
    final Color colorB = Color(redB, greenB, blueB);

    final Color result = colorA * colorB;

    expect(
      result.equalTo(Color(redA * redB, greenA * greenB, blueA * blueB)),
      true,
    );
  });
}
