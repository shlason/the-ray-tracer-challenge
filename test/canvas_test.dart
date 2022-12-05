import 'package:dart_ray_tracer/color/color.dart';
import 'package:test/test.dart';

import 'package:dart_ray_tracer/canvas/canvas.dart';

void main() {
  test('Creating a canvas', () {
    const int width = 10;
    const int height = 20;
    final Canvas canvas = Canvas(width, height);
    final Color black = Color(0, 0, 0);

    expect(width, canvas.width);
    expect(height, canvas.height);

    for (var x = 0; x < width; x++) {
      for (var y = 0; y < width; y++) {
        expect(canvas.getPixelAt(x, y).equalTo(black), true);
      }
    }
  });
  test('Writing pixels to a canvas', () {
    const int width = 10;
    const int height = 20;
    const int x = 2;
    const int y = 3;

    final Canvas canvas = Canvas(width, height);
    final Color red = Color(1, 0, 0);

    canvas.writePixel(x, y, red);
    expect(canvas.getPixelAt(x, y).equalTo(red), true);
  });
  test('Constructing the PPM plain string', () {
    const int width = 5;
    const int height = 3;
    final Canvas canvas = Canvas(width, height);
    final Color color1 = Color(1.5, 0, 0);
    final Color color2 = Color(0, 0.5, 0);
    final Color color3 = Color(-0.5, 0, 1);
    const String expectedPPM = '''
P3
$width $height
255
255 0 0 0 0 0 0 0 0 0 0 0 0 0 0
0 0 0 0 0 0 0 128 0 0 0 0 0 0 0
0 0 0 0 0 0 0 0 0 0 0 0 0 0 255
''';

    canvas.writePixel(0, 0, color1);
    canvas.writePixel(2, 1, color2);
    canvas.writePixel(4, 2, color3);

    expect(expectedPPM, canvas.toPPM());
  });
  test('Splitting long lines in PPM files', () {
    const int width = 10;
    const int height = 2;
    final Canvas canvas = Canvas(width, height);
    final Color color = Color(1, 0.8, 0.6);
    const String expectedPPM = '''
P3
$width $height
255
255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204
153 255 204 153 255 204 153 255 204 153 255 204 153
255 204 153 255 204 153 255 204 153 255 204 153 255 204 153 255 204
153 255 204 153 255 204 153 255 204 153 255 204 153
''';

    for (var x = 0; x < width; x++) {
      for (var y = 0; y < height; y++) {
        canvas.writePixel(x, y, color);
      }
    }

    expect(expectedPPM, canvas.toPPM());
  });
  test('PPM files are terminated by a newline character', () {
    const int width = 5;
    const int height = 3;
    final Canvas canvas = Canvas(width, height);
    final String ppmFile = canvas.toPPM();

    expect(ppmFile[ppmFile.length - 1], '\n');
  });
}
