import 'package:flutter/material.dart';
import 'dart:async';

import 'package:newlandscanner/newland_scan_result.dart';
import 'package:newlandscanner/newlandscanner.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late Stream<NewlandScanResult> _stream;

  @override
  void initState() {
    super.initState();

    _stream = Newlandscanner.listenForBarcodes;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: StreamBuilder<NewlandScanResult>(
            stream: _stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!;

                return Text('Scanned barcode: ${data.barcodeData}');
              }

              return const Text('Waiting for Data');
            }
          ),
        ),
      ),
    );
  }
}
