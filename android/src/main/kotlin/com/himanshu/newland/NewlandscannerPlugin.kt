package com.himanshu.newland

import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.Build
import androidx.annotation.NonNull
import com.himanshu.newland.receiver.BarcodeScanReceiver

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class NewlandscannerPlugin : FlutterPlugin, MethodChannel.MethodCallHandler {
    private lateinit var eventChannel: EventChannel
    private lateinit var methodChannel: MethodChannel
    private var applicationContext: Context? = null
    private var scanReceiver: BarcodeScanReceiver? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = flutterPluginBinding.applicationContext

        // Setup MethodChannel
        methodChannel = MethodChannel(flutterPluginBinding.binaryMessenger, "newland_scanner_methods")
        methodChannel.setMethodCallHandler(this)

        // Setup EventChannel
        eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "newland_listenToScanner")
        eventChannel.setStreamHandler(object : EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                unregisterScanReceiver()

                val action = (arguments as? String) ?: "nlscan.action.SCANNER_RESULT"
                val receiver = BarcodeScanReceiver(events)
                scanReceiver = receiver
                val context = applicationContext ?: flutterPluginBinding.applicationContext
                val filter = IntentFilter(action)

                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
                    context.registerReceiver(
                        receiver,
                        filter,
                        Context.RECEIVER_EXPORTED
                    )
                } else {
                    context.registerReceiver(
                        receiver,
                        filter
                    )
                }
            }

            override fun onCancel(arguments: Any?) {
                unregisterScanReceiver()
            }
        })
    }

    private fun unregisterScanReceiver() {
        scanReceiver?.let { receiver ->
            try {
                applicationContext?.unregisterReceiver(receiver)
            } catch (e: Exception) {
                // Ignore if receiver was not registered or already unregistered
            }
            scanReceiver = null
        }
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        when (call.method) {
            "startScan" -> {
                applicationContext?.let { context ->
                    val intent = Intent("nlscan.action.SCANNER_TRIG")
                    context.sendBroadcast(intent)
                    result.success(null)
                } ?: result.error("NO_CONTEXT", "Application context is null", null)
            }
            "stopScan" -> {
                applicationContext?.let { context ->
                    val intent = Intent("nlscan.action.STOP_SCAN")
                    context.sendBroadcast(intent)
                    result.success(null)
                } ?: result.error("NO_CONTEXT", "Application context is null", null)
            }
            "isScannerAvailable" -> {
                val isNewland = Build.MANUFACTURER.contains("Newland", ignoreCase = true) ||
                                Build.BRAND.contains("Newland", ignoreCase = true) ||
                                Build.MANUFACTURER.contains("nlscan", ignoreCase = true) ||
                                Build.BRAND.contains("nlscan", ignoreCase = true)
                result.success(isNewland)
            }
            else -> result.notImplemented()
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        unregisterScanReceiver()
        eventChannel.setStreamHandler(null)
        methodChannel.setMethodCallHandler(null)
        applicationContext = null
    }
}
