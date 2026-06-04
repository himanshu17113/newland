class NewlandScanResult {
  ///contains the scanned barcode value or an empty string
  final String barcodeData;
  ///contains the scanned barcode type (for supported barcode list check this file: https://www.newland-id.com/sites/default/files/documents/2021-02/newland_android_pda_barcode_scanning_sdk_handbook_v1.2.pdf"
  final String barcodeType;
  ///true if the barcode scan was successful false otherwise
  final bool barcodeSuccess;

  NewlandScanResult(this.barcodeData, this.barcodeType, this.barcodeSuccess);

  factory NewlandScanResult.fromNative(Map data) {
    return NewlandScanResult(
      data['barcodeData'] ?? '',
      data['barcodeType'] ?? 'UNKNOWN',
      data['barcodeSuccess'] ?? false,
    );
  }
}
