package com.himanshu.newland.model

data class NewlandScanResult(
    val barcodeData: String,
    val barcodeType: String,
    val barcodeSuccess: Boolean,
    val barcodeBytes: ByteArray?,
    val secondaryBarcodeData: String?
) {
    fun toMap(): HashMap<String, Any?> {
        return hashMapOf(
            "barcodeData" to barcodeData,
            "barcodeType" to barcodeType,
            "barcodeSuccess" to barcodeSuccess,
            "barcodeBytes" to barcodeBytes,
            "secondaryBarcodeData" to secondaryBarcodeData
        )
    }

    override fun equals(other: Any?): Boolean {
        if (this === other) return true
        if (javaClass != other?.javaClass) return false

        other as NewlandScanResult

        if (barcodeData != other.barcodeData) return false
        if (barcodeType != other.barcodeType) return false
        if (barcodeSuccess != other.barcodeSuccess) return false
        if (barcodeBytes != null) {
            if (other.barcodeBytes == null) return false
            if (!barcodeBytes.contentEquals(other.barcodeBytes)) return false
        } else if (other.barcodeBytes != null) return false
        if (secondaryBarcodeData != other.secondaryBarcodeData) return false

        return true
    }

    override fun hashCode(): Int {
        var result = barcodeData.hashCode()
        result = 31 * result + barcodeType.hashCode()
        result = 31 * result + barcodeSuccess.hashCode()
        result = 31 * result + (barcodeBytes?.contentHashCode() ?: 0)
        result = 31 * result + (secondaryBarcodeData?.hashCode() ?: 0)
        return result
    }
}
