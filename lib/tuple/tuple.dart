class Tuple {
  num x = 0.0;
  num y = 0.0;
  num z = 0.0;
  num w = 0.0;

  Tuple(this.x, this.y, this.z, this.w);

  static Tuple fromList(List<num> list) {
    return Tuple(list[0], list[1], list[2], list[3]);
  }

  bool isPoint() {
    return w == 1.0;
  }

  bool isVector() {
    return w == 0.0;
  }

  bool equalTo(Tuple tuple) {
    const num currentSmallestNumToCompareEqualityUse = 0.00000000000001;

    bool getIsEqual(num a, num b) =>
        (a - b).abs() < currentSmallestNumToCompareEqualityUse;

    return getIsEqual(x, tuple.x) &&
        getIsEqual(y, tuple.y) &&
        getIsEqual(z, tuple.z) &&
        getIsEqual(w, tuple.w);
  }

  Tuple operator +(Tuple other) =>
      Tuple(x + other.x, y + other.y, z + other.z, w + other.w);

  dynamic operator -(Tuple other) =>
      Tuple(x - other.x, y - other.y, z - other.z, w - other.w);

  dynamic operator *(Object other) {
    if (other is num) {
      return Tuple(x * other, y * other, z * other, w * other);
    }
    if (other is Tuple) {
      return Tuple(x * other.x, y * other.y, z * other.z, w * other.w);
    }
    throw 'Operand type error';
  }

  Tuple operator /(Object other) {
    if (other is Tuple) {
      return Tuple(x / other.x, y / other.y, z / other.z, w / other.w);
    }
    if (other is num) {
      return Tuple(x / other, y / other, z / other, w / other);
    }
    throw 'Operand type error';
  }

  Tuple negate() {
    x = 0 - x;
    y = 0 - y;
    z = 0 - z;
    w = 0 - w;

    return this;
  }

  List<num> toList() {
    return [x, y, z, w];
  }
}
