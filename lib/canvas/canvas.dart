import 'package:dart_ray_tracer/color/color.dart';

class Canvas {
  static Color get defaultPixel => Color(0, 0, 0);

  final int width;
  final int height;
  final List<List<Color>> pixels;

  Canvas(this.width, this.height)
      : pixels = List<List<Color>>.generate(
          height,
          (_) => List<Color>.filled(width, defaultPixel),
          growable: false,
        );

  void printPixels() {
    print(pixels);
  }

  Color getPixelAt(int x, int y) {
    return pixels[y][x];
  }

  void writePixel(num x, num y, Color color) {
    pixels[y.round()][x.round()] = color;
  }

  String toPPM() {
    const int maximumColorValue = 255;
    const int maximumLengthPerRow = 70;
    final String ppmHeader = 'P3\n$width $height\n$maximumColorValue\n';

    num currentLength = 0;
    String pixelData = '';
    List<String> eachColorList = [];
    List<String> tempColorList = [];

    void reset() {
      currentLength = 0;
      tempColorList.clear();
    }

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        tempColorList.add(pixels[y][x].toPlainString(maximumColorValue));
      }

      eachColorList = tempColorList.join(' ').split(' ');

      for (int i = 0; i < eachColorList.length; i++) {
        if (i > 0) {
          currentLength += 1;
        }
        currentLength += eachColorList[i].length;
        if (currentLength > maximumLengthPerRow) {
          eachColorList[i] = '\n${eachColorList[i]}';
          currentLength = 0;
        }
      }

      pixelData =
          '$pixelData${eachColorList.join(' ').replaceAll(' \n', '\n')}\n';
      reset();
    }

    return '$ppmHeader$pixelData';
  }
}
