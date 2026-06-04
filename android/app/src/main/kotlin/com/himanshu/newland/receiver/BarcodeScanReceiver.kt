package com.himanshu.newland.receiver

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import com.himanshu.newland.model.NewlandBarcodeType
import com.himanshu.newland.model.NewlandScanResult
import io.flutter.plugin.common.EventChannel

class BarcodeScanReceiver(private val sink: EventChannel.EventSink?) : BroadcastReceiver() {

    companion object {
        val filter = IntentFilter("nlscan.action.SCANNER_RESULT")
    }

    override fun onReceive(context: Context?, intent: Intent?) {
        val barcodeData = intent?.getStringExtra("SCAN_BARCODE1") ?: ""
        val barcodeType = intent?.getIntExtra("SCAN_BARCODE_TYPE", -1) ?: -1
        val barcodeSuccess = intent?.getStringExtra("SCAN_STATE") == "ok"

        val result =
            NewlandScanResult(barcodeData, NewlandBarcodeType.getType(barcodeType), barcodeSuccess)

        sink?.success(result.toMap())
    }
}