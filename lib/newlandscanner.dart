import 'dart:async';

import 'package:flutter/services.dart';
import 'package:newlandscanner/newland_scan_result.dart';

class Newlandscanner {
  static const EventChannel _eventChannel = EventChannel('newland_listenToScanner');
  static const MethodChannel _methodChannel = MethodChannel('newland_scanner_methods');

  /// Listens for barcodes using the default Newland intent action.
  static Stream<NewlandScanResult> get listenForBarcodes {
    return listenForBarcodesWithAction();
  }

  /// Listens for barcodes using a custom intent action.
  static Stream<NewlandScanResult> listenForBarcodesWithAction({
    String intentAction = 'nlscan.action.SCANNER_RESULT',
  }) {
    return _eventChannel
        .receiveBroadcastStream(intentAction)
        .map((event) => event is Map ? event : <dynamic, dynamic>{})
        .map((event) => NewlandScanResult.fromNative(event));
  }

  /// Trigger a barcode scan programmatically.
  static Future<void> startScan() async {
    await _methodChannel.invokeMethod('startScan');
  }

  /// Force stop any active scan programmatically.
  static Future<void> stopScan() async {
    await _methodChannel.invokeMethod('stopScan');
  }

  /// Check if the current device is a Newland scanner PDA.
  static Future<bool> isScannerAvailable() async {
    try {
      final bool? available = await _methodChannel.invokeMethod('isScannerAvailable');
      return available ?? false;
    } catch (_) {
      return false;
    }
  }
}
