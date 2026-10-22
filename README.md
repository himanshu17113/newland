# newlandscanner

A Flutter plugin for Newland Android PDA barcode scanners (e.g., MT90, MT65, PT60, and other Newland Android hardware scanners).

## Features

- **Barcode Event Stream**: Listen to barcode scans broadcasted by the Newland scanner service.
- **Android 14+ Ready**: Fully compatible with Android 13/14+ (API 33/34+) requirements for `RECEIVER_EXPORTED`.
- **Custom Intent Action Support**: Specify custom intent actions or use the default `nlscan.action.SCANNER_RESULT`.
- **Full Barcode Metadata**: Provides barcode data string, barcode symbology type (e.g., Code 128, EAN-13, QR Code), raw byte array, and secondary barcode data (for dual-barcode scanning).
- **Programmatic Scan Triggers**: Start and stop scans programmatically.
- **Device Availability Detection**: Check whether the current device is a Newland PDA scanner.

---

## Installation

Add `newlandscanner` to your `pubspec.yaml`:

```yaml
dependencies:
  newlandscanner: ^1.0.1
```

Or reference via git:

```yaml
dependencies:
  newlandscanner:
    git:
      url: https://github.com/himanshu17113/newland.git
      ref: main
```

---

## Usage

### 1. Listen for Barcodes

```dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:newlandscanner/newlandscanner.dart';
import 'package:newlandscanner/newland_scan_result.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({super.key});

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  StreamSubscription<NewlandScanResult>? _subscription;
  String _lastScannedBarcode = '';

  @override
  void initState() {
    super.initState();
    _subscription = Newlandscanner.listenForBarcodes.listen((scanResult) {
      if (scanResult.barcodeSuccess && scanResult.barcodeData.isNotEmpty) {
        setState(() {
          _lastScannedBarcode = scanResult.barcodeData;
        });
      }
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Newland Scanner')),
      body: Center(
        child: Text(
          _lastScannedBarcode.isEmpty
              ? 'Scan a barcode...'
              : 'Scanned: $_lastScannedBarcode',
        ),
      ),
    );
  }
}
```

### 2. Custom Intent Action

If your Newland QuickSetting or scanner app broadcasts on a custom intent action:

```dart
final stream = Newlandscanner.listenForBarcodesWithAction(
  intentAction: 'your.custom.scanner.ACTION',
);
```

### 3. Programmatic Trigger

```dart
// Trigger scanner beam
await Newlandscanner.startScan();

// Stop active beam
await Newlandscanner.stopScan();
```

### 4. Scanner Hardware Check

```dart
final isAvailable = await Newlandscanner.isScannerAvailable();
if (isAvailable) {
  // Device is a Newland scanner
}
```

---

## License

MIT
