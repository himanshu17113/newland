# newlandscanner

Capture SDK of [Newland Barcode Android devices](https://www.newland-id.com/de) for Flutter using native Intent broadcast receiver.

## Installation

Add this to your package's pubspec.yaml file:

```
dependencies:
  newlandscanner: ^0.0.1
```

### iOS

not supported

### Android

Make sure the device scan output mode is set to "Output via API".

## Usage

```dart
Newlandscanner.listenForBarcodes.listen((event) {
	log('BarcodeScanned: ${event.barcodeData}')
});
```

## Author

- [Mateusz Maziec](https://www.nexaion.de/)