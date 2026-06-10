package com.himanshu.newland.model

import kotlin.collections.HashMap

data class NewlandScanResult(
    val barcodeData: String,
    val barcodeType: String,
    val barcodeSuccess: Boolean
) {
    fun toMap(): HashMap<String, Any> {
        return hashMapOf(
            "barcodeData" to barcodeData,
            "barcodeType" to barcodeType,
            "barcodeSuccess" to barcodeSuccess
        )
    }
}
