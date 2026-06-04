import 'package:flutter_test/flutter_test.dart';
import 'package:newlandscanner/newland_scan_result.dart';

void main() {
  test('NewlandScanResult.fromNative parses valid map', () {
    final result = NewlandScanResult.fromNative({
      'barcodeData': '123456',
      'barcodeType': 'EAN13',
      'barcodeSuccess': true,
    });
    expect(result.barcodeData, '123456');
    expect(result.barcodeType, 'EAN13');
    expect(result.barcodeSuccess, true);
  });

  test('NewlandScanResult.fromNative handles missing keys', () {
    final result = NewlandScanResult.fromNative({});
    expect(result.barcodeData, '');
    expect(result.barcodeType, 'UNKNOWN');
    expect(result.barcodeSuccess, false);
  });
}
