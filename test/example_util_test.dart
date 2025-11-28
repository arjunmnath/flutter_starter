import 'package:flutter_starter_template/utils/example_util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('ellipsize trims long strings', () {
    const input = 'abcdefghijklmnopqrstuvwxyz';
    expect(ellipsize(input, maxLength: 5), 'abcde…');
  });
}
