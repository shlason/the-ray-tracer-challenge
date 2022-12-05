import 'package:test/test.dart';

import 'package:dart_ray_tracer/tuple/tuple.dart';
import 'package:dart_ray_tracer/matrices/matrices.dart';

void main() {
  test('Constructing and inspecting a 4x4 matrix', () {
    final Matrices matrix = Matrices([
      [1, 2, 3, 4],
      [5.5, 6.5, 7.5, 8.5],
      [9, 10, 11, 12],
      [13.5, 14.5, 15.5, 16.5]
    ]);

    expect(matrix[0][0], 1);
    expect(matrix[0][3], 4);
    expect(matrix[1][0], 5.5);
    expect(matrix[1][2], 7.5);
    expect(matrix[2][2], 11);
    expect(matrix[3][0], 13.5);
    expect(matrix[3][2], 15.5);
  });
  test('Constructing and inspecting a 4x4 matrix', () {
    final Matrices matrix = Matrices([
      [-3, 5],
      [1, -2]
    ]);

    expect(matrix[0][0], -3);
    expect(matrix[0][1], 5);
    expect(matrix[1][0], 1);
    expect(matrix[1][1], -2);
  });
  test('Constructing and inspecting a 4x4 matrix', () {
    final Matrices matrix = Matrices([
      [-3, 5, 0],
      [1, -2, -7],
      [0, 1, 1]
    ]);

    expect(matrix[0][0], -3);
    expect(matrix[1][1], -2);
    expect(matrix[2][2], 1);
  });
  test('Matrix equality with identical matrices', () {
    final Matrices matrixA = Matrices([
      [1, 2, 3, 4],
      [5, 6, 7, 8],
      [9, 8, 7, 6],
      [5, 4, 3, 2],
    ]);
    final Matrices matrixB = Matrices([
      [1, 2, 3, 4],
      [5, 6, 7, 8],
      [9, 8, 7, 6],
      [5, 4, 3, 2],
    ]);

    expect(matrixA == matrixB, true);
  });
  test('Matrix equality with different matrices', () {
    final Matrices matrixA = Matrices([
      [1.1, 2, 3, 4],
      [5, 6, 7, 8],
      [9, 8, 7, 6],
      [5, 4, 3, 2],
    ]);
    final Matrices matrixB = Matrices([
      [2, 3, 4, 5],
      [6, 7, 8, 9],
      [8, 7, 6, 5],
      [4, 3, 2, 1],
    ]);
    final Matrices matrixC = Matrices([
      [1.01, 2, 3, 4],
      [5, 6, 7, 8],
      [9, 8, 7, 6],
      [5, 4, 3, 2],
    ]);

    expect(matrixA == matrixB, false);
    expect(matrixA == matrixC, false);
  });
  test('Multiplying two matrices', () {
    final Matrices matrixA = Matrices([
      [1, 2, 3, 4],
      [5, 6, 7, 8],
      [9, 8, 7, 6],
      [5, 4, 3, 2],
    ]);
    final Matrices matrixB = Matrices([
      [-2, 1, 2, 3],
      [3, 2, 1, -1],
      [4, 3, 6, 5],
      [1, 2, 7, 8],
    ]);
    final Matrices resultMatrix = matrixA * matrixB;
    final Matrices expectedMatrix = Matrices([
      [20, 22, 50, 48],
      [44, 54, 114, 108],
      [40, 58, 110, 102],
      [16, 26, 46, 42],
    ]);

    expect(resultMatrix == expectedMatrix, true);
  });
  test('A matrix multiplied by a tuple', () {
    final Matrices matrixA = Matrices([
      [1, 2, 3, 4],
      [2, 4, 4, 2],
      [8, 6, 4, 1],
      [0, 0, 0, 1]
    ]);
    final Tuple tuple = Tuple(1, 2, 3, 1);
    final Tuple resultTuple = matrixA * tuple;
    final Tuple expectedTuple = Tuple(18, 24, 33, 1);

    expect(expectedTuple.equalTo(resultTuple), true);
  });
  test('Multiplying a matrix by the identity matrix', () {
    final Matrices matrix = Matrices([
      [0, 1, 2, 4],
      [1, 2, 4, 8],
      [2, 4, 8, 16],
      [4, 8, 16, 32]
    ]);
    final Matrices resultMatrix = matrix * Matrices.identityMatrix;

    expect(resultMatrix == matrix, true);
  });
  test('Multiplying the identity matrix by a tuple', () {
    final Tuple tuple = Tuple(1, 2, 3, 4);
    final Tuple resultTuple = Matrices.identityMatrix * tuple;

    expect(resultTuple.equalTo(tuple), true);
  });
  test('Transposing a matrix', () {
    final Matrices matrix = Matrices([
      [0, 9, 3, 0],
      [9, 8, 0, 8],
      [1, 8, 5, 3],
      [0, 0, 5, 8]
    ]);
    final expectedMatrix = Matrices([
      [0, 9, 1, 0],
      [9, 8, 8, 0],
      [3, 0, 5, 5],
      [0, 8, 3, 8]
    ]);
    final Matrices transposedMatrix = matrix.transpose();

    expect(transposedMatrix == expectedMatrix, true);
  });
  test('Transposing the identity matrix', () {
    expect(
      Matrices.identityMatrix.transpose() == Matrices.identityMatrix,
      true,
    );
  });
  test('Calculating the determinant of a 2x2 matrix', () {
    final Matrices matrix = Matrices([
      [1, 5],
      [-3, 2]
    ]);

    expect(matrix.determinatnat, 17);
  });
  test('A submatrix of 3x3 matrix is a 2x2 matrix', () {
    final Matrices matrix = Matrices([
      [1, 5, 0],
      [-3, 2, 7],
      [0, 6, -3]
    ]);
    final Matrices submatrix = matrix.getSubmatrix(row: 0, col: 2);
    final Matrices expectedMatrix = Matrices([
      [-3, 2],
      [0, 6],
    ]);

    expect(submatrix == expectedMatrix, true);
  });
  test('A submatrix of 4x4 matrix is a 3x3 matrix', () {
    final Matrices matrix = Matrices([
      [-6, 1, 1, 6],
      [-8, 5, 8, 6],
      [-1, 0, 8, 2],
      [-7, 1, -1, 1]
    ]);
    final Matrices submatrix = matrix.getSubmatrix(row: 2, col: 1);
    final Matrices expectedMatrix = Matrices([
      [-6, 1, 6],
      [-8, 8, 6],
      [-7, -1, 1]
    ]);

    expect(submatrix == expectedMatrix, true);
  });
  test('Calculating a minor of a 3x3 matrix', () {
    const int row = 1;
    const int col = 0;

    final Matrices matrix = Matrices([
      [3, 5, 0],
      [2, -1, -7],
      [6, -1, 5]
    ]);
    final Matrices submatrix = matrix.getSubmatrix(row: row, col: col);

    expect(submatrix.determinatnat == matrix.minor(row: row, col: col), true);
  });
  test('Calculating the determinant of a 3x3 matrix', () {
    final Matrices matrix = Matrices([
      [1, 2, 6],
      [-5, 8, -4],
      [2, 6, 4]
    ]);

    expect(matrix.cofactor(row: 0, col: 0) == 56, true);
    expect(matrix.cofactor(row: 0, col: 1) == 12, true);
    expect(matrix.cofactor(row: 0, col: 2) == -46, true);
    expect(matrix.determinatnat == -196, true);
  });
  test('Calculating the determinant of a 4x4 matrix', () {
    final Matrices matrix = Matrices([
      [-2, -8, 3, 5],
      [-3, 1, 7, 3],
      [1, 2, -9, 6],
      [-6, 7, 7, -9]
    ]);

    expect(matrix.cofactor(row: 0, col: 0) == 690, true);
    expect(matrix.cofactor(row: 0, col: 1) == 447, true);
    expect(matrix.cofactor(row: 0, col: 2) == 210, true);
    expect(matrix.cofactor(row: 0, col: 3) == 51, true);
    expect(matrix.determinatnat == -4071, true);
  });
  test('Testing an invertible matrix for invertibility', () {
    final Matrices matrix = Matrices([
      [6, 4, 4, 4],
      [5, 5, 7, 6],
      [4, -9, 3, -7],
      [9, 1, 7, -6]
    ]);

    // The matrix is invertible
    expect(matrix.determinatnat == -2120, true);
  });
  test('Testing an noninvertible matrix for invertibility', () {
    final Matrices matrix = Matrices([
      [-4, 2, -2, -3],
      [9, 6, 2, 6],
      [0, -5, 1, -5],
      [0, 0, 0, 0]
    ]);

    // The matrix is not invertible
    expect(matrix.determinatnat == 0, true);
  });
  test('Calculating the inverse of a matrix', () {
    final Matrices matrix = Matrices([
      [-5, 2, 6, -8],
      [1, -5, 1, 8],
      [7, 7, -6, -7],
      [1, -3, 7, 4]
    ]);

    final Matrices inversedMatrix = matrix.inverse();
    final Matrices expectedMatrix = Matrices([
      [0.21805, 0.45113, 0.24060, -0.04511],
      [-0.80827, -1.45677, -0.44361, 0.52068],
      [-0.07895, -0.22368, -0.05263, 0.19737],
      [-0.52256, -0.81391, -0.30075, 0.30639]
    ]);
    // Actual inversed result
    // [0.21804511278195488, 0.45112781954887216, 0.24060150375939848, -0.045112781954887216]
    // [-0.8082706766917294, -1.4567669172932332, -0.44360902255639095, 0.5206766917293233]
    // [-0.07894736842105263, -0.2236842105263158, -0.05263157894736842, 0.19736842105263158]
    // [-0.5225563909774437, -0.8139097744360902, -0.3007518796992481, 0.30639097744360905]

    // For fixed decimal point
    for (int row = 0; row < inversedMatrix.colLength; row++) {
      for (int col = 0; col < inversedMatrix[row].length; col++) {
        inversedMatrix.set(
          num.parse((inversedMatrix[row][col]).toStringAsFixed(5)),
          row: row,
          col: col,
        );
      }
    }

    expect(inversedMatrix == expectedMatrix, true);
  });
  test('Calculating the inverse of another matrix', () {
    final Matrices matrix = Matrices([
      [8, -5, 9, 2],
      [7, 5, 6, 1],
      [-6, 0, 9, 6],
      [-3, 0, -9, -4]
    ]);

    final Matrices inversedMatrix = matrix.inverse();
    final Matrices expectedMatrix = Matrices([
      [-0.15385, -0.15385, -0.28205, -0.53846],
      [-0.07692, 0.12308, 0.02564, 0.03077],
      [0.35897, 0.35897, 0.43590, 0.92308],
      [-0.69231, -0.69231, -0.76923, -1.92308]
    ]);

    // For fixed decimal point
    for (int row = 0; row < inversedMatrix.colLength; row++) {
      for (int col = 0; col < inversedMatrix[row].length; col++) {
        inversedMatrix.set(
          converNumToSpecificFixedNum(inversedMatrix[row][col], 5),
          row: row,
          col: col,
        );
      }
    }

    expect(inversedMatrix == expectedMatrix, true);
  });
  test('Calculating the inverse of third matrix', () {
    final Matrices matrix = Matrices([
      [9, 3, 0, 9],
      [-5, -2, -6, -3],
      [-4, 9, 6, 4],
      [-7, 6, 6, 2]
    ]);

    final Matrices inversedMatrix = matrix.inverse();
    final Matrices expectedMatrix = Matrices([
      [-0.04074, -0.07778, 0.14444, -0.22222],
      [-0.07778, 0.03333, 0.36667, -0.33333],
      [-0.02901, -0.14630, -0.10926, 0.12963],
      [0.17778, 0.06667, -0.26667, 0.33333]
    ]);

    // For fixed decimal point
    for (int row = 0; row < inversedMatrix.colLength; row++) {
      for (int col = 0; col < inversedMatrix[row].length; col++) {
        inversedMatrix.set(
          converNumToSpecificFixedNum(inversedMatrix[row][col], 5),
          row: row,
          col: col,
        );
      }
    }

    expect(inversedMatrix == expectedMatrix, true);
  });
  test('Multiplying a product by its inverse', () {
    final Matrices matrixA = Matrices([
      [3, -9, 7, 3],
      [3, -8, 2, -9],
      [-4, 4, 4, 1],
      [-6, 5, -1, 1]
    ]);
    final Matrices matrixB = Matrices([
      [8, 2, 2, 2],
      [3, -1, 7, 0],
      [7, 0, 5, 4],
      [6, -2, 0, 5]
    ]);

    final Matrices multipledMatrixC = matrixA * matrixB;
    final Matrices inversedMatrixB = matrixB.inverse();

    expect((multipledMatrixC * inversedMatrixB) == matrixA, true);
  });
}

num converNumToSpecificFixedNum(num n, int fixedPoint) {
  return num.parse(n.toStringAsFixed(fixedPoint));
}
