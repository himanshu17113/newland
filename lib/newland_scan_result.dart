import 'dart:typed_data';

class NewlandScanResult {
  /// Contains the scanned barcode value or an empty string.
  final String barcodeData;

  /// Contains the scanned barcode type.
  final String barcodeType;

  /// True if the barcode scan was successful, false otherwise.
  final bool barcodeSuccess;

  /// Raw bytes of the scanned barcode.
  final Uint8List? barcodeBytes;

  /// Contains secondary barcode value if dual barcode scanning is enabled.
  final String? secondaryBarcodeData;

  const NewlandScanResult(
    this.barcodeData,
    this.barcodeType,
    this.barcodeSuccess, {
    this.barcodeBytes,
    this.secondaryBarcodeData,
  });

  factory NewlandScanResult.fromNative(Map<dynamic, dynamic> data) {
    final dynamic bytes = data['barcodeBytes'];
    return NewlandScanResult(
      (data['barcodeData'] as String?) ?? '',
      (data['barcodeType'] as String?) ?? 'UNKNOWN',
      (data['barcodeSuccess'] as bool?) ?? false,
      barcodeBytes: bytes is Uint8List
          ? bytes
          : (bytes is List<int> ? Uint8List.fromList(bytes) : null),
      secondaryBarcodeData: data['secondaryBarcodeData'] as String?,
    );
  }
}
