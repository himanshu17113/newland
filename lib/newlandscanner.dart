import 'dart:async';

import 'package:flutter/services.dart';
import 'package:newland/newland_scan_result.dart';

class Newlandscanner {
  static const EventChannel _eventChannel = EventChannel('newland_listenToScanner');

  static final Stream<NewlandScanResult> _stream = _eventChannel
      .receiveBroadcastStream()
      .map((event) => event is Map ? event : <dynamic, dynamic>{})
      .map((event) => NewlandScanResult.fromNative(event));

  static Stream<NewlandScanResult> get listenForBarcodes {
    return _stream;
  }
}
