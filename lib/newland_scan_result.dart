import 'dart:typed_data';

class NewlandScanResult {
  ///contains the scanned barcode value or an empty string
  final String barcodeData;
  ///contains the scanned barcode type (for supported barcode list check this file: https://www.newland-id.com/sites/default/files/documents/2021-02/newland_android_pda_barcode_scanning_sdk_handbook_v1.2.pdf"
  final String barcodeType;
  ///true if the barcode scan was successful false otherwise
  final bool barcodeSuccess;
  ///raw bytes of the scanned barcode
  final Uint8List? barcodeBytes;
  ///contains secondary barcode value if dual barcode scanning is enabled
  final String? secondaryBarcodeData;

  NewlandScanResult(
    this.barcodeData,
    this.barcodeType,
    this.barcodeSuccess, {
    this.barcodeBytes,
    this.secondaryBarcodeData,
  });

  factory NewlandScanResult.fromNative(Map data) {
    final bytes = data['barcodeBytes'];
    return NewlandScanResult(
      data['barcodeData'] ?? '',
      data['barcodeType'] ?? 'UNKNOWN',
      data['barcodeSuccess'] ?? false,
      barcodeBytes: bytes is Uint8List
          ? bytes
          : (bytes is List<int> ? Uint8List.fromList(bytes) : null),
      secondaryBarcodeData: data['secondaryBarcodeData'],
    );
  }
}
