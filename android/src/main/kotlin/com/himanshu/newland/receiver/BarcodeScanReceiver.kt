package com.himanshu.newland.receiver

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.himanshu.newland.model.NewlandBarcodeType
import com.himanshu.newland.model.NewlandScanResult
import io.flutter.plugin.common.EventChannel

class BarcodeScanReceiver(private val sink: EventChannel.EventSink?) : BroadcastReceiver() {

    override fun onReceive(context: Context?, intent: Intent?) {
        val barcodeData = intent?.getStringExtra("SCAN_BARCODE1") ?: ""
        val secondaryBarcodeData = intent?.getStringExtra("SCAN_BARCODE2") ?: ""
        val barcodeType = intent?.getIntExtra("SCAN_BARCODE_TYPE", -1) ?: -1
        val barcodeSuccess = intent?.getStringExtra("SCAN_STATE") == "ok"
        val barcodeBytes = intent?.getByteArrayExtra("scan_result_one_bytes")

        val result = NewlandScanResult(
            barcodeData = barcodeData,
            barcodeType = NewlandBarcodeType.getType(barcodeType),
            barcodeSuccess = barcodeSuccess,
            barcodeBytes = barcodeBytes,
            secondaryBarcodeData = secondaryBarcodeData
        )

        try {
            sink?.success(result.toMap())
        } catch (e: Exception) {
            // Ignore if event sink is cancelled or closed
        }
    }
}
