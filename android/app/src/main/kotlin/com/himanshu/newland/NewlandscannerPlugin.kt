package com.himanshu.newland

import androidx.annotation.NonNull
import com.himanshu.newland.receiver.BarcodeScanReceiver

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel

class NewlandscannerPlugin : FlutterPlugin {
    private lateinit var eventChannel: EventChannel

    private var scanReceiver: BarcodeScanReceiver? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "newland_listenToScanner")

        eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                scanReceiver = BarcodeScanReceiver(events)
                flutterPluginBinding.applicationContext.registerReceiver(
                    scanReceiver,
                    BarcodeScanReceiver.filter
                )
            }

            override fun onCancel(arguments: Any?) {
                scanReceiver?.let {
                    flutterPluginBinding.applicationContext.unregisterReceiver(it)
                    scanReceiver = null
                }
            }
        })
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        scanReceiver?.let {
            binding.applicationContext.unregisterReceiver(it)
            scanReceiver = null
        }
        eventChannel.setStreamHandler(null)
    }
}
