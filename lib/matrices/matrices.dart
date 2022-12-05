import 'package:dart_ray_tracer/tuple/tuple.dart';

class Matrices {
  final List<List<num>> _matrices;

  const Matrices(List<List<num>> matrices) : _matrices = matrices;

  static Matrices get identityMatrix => const Matrices([
        [1, 0, 0, 0],
        [0, 1, 0, 0],
        [0, 0, 1, 0],
        [0, 0, 0, 1]
      ]);
  int get rowLength => _matrices.length;
  int get colLength => _matrices[0].length;

  num get determinatnat {
    const int fixedRowIndex = 0;

    if (rowLength > 2 && colLength > 2) {
      final List<num> currentRow = getRowByIndex(fixedRowIndex);
      num sum = 0;

      for (int colIndex = 0; colIndex < currentRow.length; colIndex++) {
        sum += _matrices[fixedRowIndex][colIndex] *
            cofactor(row: fixedRowIndex, col: colIndex);
      }

      return sum;
    }

    return _matrices[0][0] * _matrices[1][1] -
        _matrices[0][1] * _matrices[1][0];
  }

  List<num> operator [](int index) => _matrices[index];

  Matrices create({required int row, required int col}) {
    return Matrices(
        List<List<num>>.generate(row, (_) => List<num>.filled(col, 0)));
  }

  Matrices getSubmatrix({required int row, required int col}) {
    final List<List<num>> resultList = deepCloneList(_matrices);

    resultList.removeAt(row);

    for (List<num> row in resultList) {
      row.removeAt(col);
    }

    return Matrices(resultList);
  }

  Matrices transpose() {
    final Matrices resultMatrix = create(row: colLength, col: rowLength);

    for (int row = 0; row < resultMatrix.rowLength; row++) {
      for (int col = 0; col < resultMatrix.colLength; col++) {
        resultMatrix.set(_matrices[row][col], row: col, col: row);
      }
    }

    return resultMatrix;
  }

  num minor({required int row, required int col}) {
    return getSubmatrix(row: row, col: col).determinatnat;
  }

  num cofactor({required int row, required int col}) {
    bool isNegate = (row + col).isOdd;
    final num minorVal = minor(row: row, col: col);

    return isNegate ? -minorVal : minorVal;
  }

  Matrices inverse() {
    final Matrices matrix = Matrices(deepCloneList(_matrices));
    final num determinantVal = matrix.determinatnat;

    if (determinatnat == 0) {
      throw 'The matrix is not invertible.';
    }

    for (int row = 0; row < matrix.rowLength; row++) {
      for (int col = 0; col < matrix.colLength; col++) {
        matrix.set(
          cofactor(row: row, col: col) / determinantVal,
          // For accomplish transpose operation to improve performance instead of using method
          row: col,
          col: row,
        );
      }
    }

    return matrix;
  }

  dynamic operator *(Object other) {
    if (other is Matrices) {
      if (colLength != other.rowLength) {
        throw "Left hand's columns must equal right hand's rows";
      }

      final Matrices resultMatrix =
          create(row: rowLength, col: other.colLength);

      for (int row = 0; row < resultMatrix.rowLength; row++) {
        for (int col = 0; col < resultMatrix.colLength; col++) {
          resultMatrix.set(
            multiplyList(getRowByIndex(row), other.getColByIndex(col)),
            row: row,
            col: col,
          );
        }
      }

      return resultMatrix;
    }
    if (other is Tuple) {
      final List<num> listFromTuple = other.toList();
      final List<num> tupleList = [];

      for (int row = 0; row < rowLength; row++) {
        tupleList.add(multiplyList(getRowByIndex(row), listFromTuple));
      }

      return Tuple.fromList(tupleList);
    }

    throw 'Operand type error';
  }

  @override
  bool operator ==(Object other) {
    if (other is! Matrices) {
      return false;
    }

    if (rowLength != other.rowLength || colLength != other.colLength) {
      return false;
    }

    bool isEqual = true;

    for (int row = 0; row < rowLength; row++) {
      for (int col = 0; col < colLength; col++) {
        const num currentSmallestNumToCompareEqualityUse = 0.00000000000001;
        final result = _matrices[row][col] - other[row][col];
        if (result.abs() > currentSmallestNumToCompareEqualityUse) {
          isEqual = false;
          break;
        }
      }
      if (!isEqual) {
        break;
      }
    }

    return isEqual;
  }

  @override
  int get hashCode {
    return _matrices.hashCode;
  }

  void set(num value, {required int row, required int col}) {
    _matrices[row][col] = value;
  }

  List<num> getRowByIndex(int index) {
    return _matrices[index];
  }

  List<num> getColByIndex(int index) {
    return _matrices.map((row) => row[index]).toList();
  }
}

num multiplyList(List<num> listA, List<num> listB) {
  num sum = 0;

  for (int i = 0; i < listA.length; i++) {
    sum += listA[i] * listB[i];
  }

  return sum;
}

List<List<num>> deepCloneList(List<List<num>> list) {
  return list.fold(<List<num>>[], (prevVal, element) {
    prevVal.add([...element]);
    return prevVal;
  });
}
