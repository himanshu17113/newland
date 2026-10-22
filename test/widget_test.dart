import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:newlandscanner/newland_scan_result.dart';

void main() {
  group('NewlandScanResult', () {
    test('constructor assigns all fields correctly', () {
      final bytes = Uint8List.fromList([1, 2, 3]);
      const result = NewlandScanResult(
        'CODE-123',
        'CODE128',
        true,
        barcodeBytes: null,
        secondaryBarcodeData: 'SEC-456',
      );

      expect(result.barcodeData, 'CODE-123');
      expect(result.barcodeType, 'CODE128');
      expect(result.barcodeSuccess, isTrue);
      expect(result.secondaryBarcodeData, 'SEC-456');

      final withBytes = NewlandScanResult(
        'CODE-123',
        'CODE128',
        true,
        barcodeBytes: bytes,
      );
      expect(withBytes.barcodeBytes, bytes);
    });

    test('fromNative parses valid map with Uint8List bytes', () {
      final bytes = Uint8List.fromList([10, 20, 30]);
      final result = NewlandScanResult.fromNative({
        'barcodeData': '123456',
        'barcodeType': 'EAN13',
        'barcodeSuccess': true,
        'barcodeBytes': bytes,
        'secondaryBarcodeData': '987654',
      });

      expect(result.barcodeData, '123456');
      expect(result.barcodeType, 'EAN13');
      expect(result.barcodeSuccess, isTrue);
      expect(result.barcodeBytes, bytes);
      expect(result.secondaryBarcodeData, '987654');
    });

    test('fromNative converts List<int> to Uint8List for barcodeBytes', () {
      final result = NewlandScanResult.fromNative({
        'barcodeData': '123456',
        'barcodeType': 'QRCODE',
        'barcodeSuccess': true,
        'barcodeBytes': <int>[1, 2, 3],
      });

      expect(result.barcodeBytes, isA<Uint8List>());
      expect(result.barcodeBytes, Uint8List.fromList([1, 2, 3]));
    });

    test('fromNative handles missing and null keys with default fallbacks', () {
      final result = NewlandScanResult.fromNative({});

      expect(result.barcodeData, '');
      expect(result.barcodeType, 'UNKNOWN');
      expect(result.barcodeSuccess, isFalse);
      expect(result.barcodeBytes, isNull);
      expect(result.secondaryBarcodeData, isNull);
    });
  });
}
