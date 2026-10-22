import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:newlandscanner/newland_scan_result.dart';

void main() {
  test('NewlandScanResult.fromNative parses valid map with bytes and secondary barcode', () {
    final result = NewlandScanResult.fromNative({
      'barcodeData': '123456',
      'barcodeType': 'EAN13',
      'barcodeSuccess': true,
      'barcodeBytes': Uint8List.fromList([1, 2, 3]),
      'secondaryBarcodeData': '987654',
    });
    expect(result.barcodeData, '123456');
    expect(result.barcodeType, 'EAN13');
    expect(result.barcodeSuccess, true);
    expect(result.barcodeBytes, Uint8List.fromList([1, 2, 3]));
    expect(result.secondaryBarcodeData, '987654');
  });

  test('NewlandScanResult.fromNative handles missing keys', () {
    final result = NewlandScanResult.fromNative({});
    expect(result.barcodeData, '');
    expect(result.barcodeType, 'UNKNOWN');
    expect(result.barcodeSuccess, false);
    expect(result.barcodeBytes, isNull);
    expect(result.secondaryBarcodeData, isNull);
  });
}
