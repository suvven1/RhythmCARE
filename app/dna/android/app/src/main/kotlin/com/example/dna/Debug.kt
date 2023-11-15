package com.example.dna

class Debug {
    val USE_ALGORITHM = false
    val MEASUREMENT_FEATURE = true
    val ALGORITHM_CONTINUOUS_MEASUREMENT_FEATURE = true
    val SAVE_CSV_FILES = false

    val DEVICE_INFO = "LANE2"

    val WELLNESS_CARE = "WellnessCare"
    val LANE2 = "LANE2"

    val LEVEL1 = 0
    val LEVEL2 = 1
    val LEVEL3 = 2
    val LEVEL4 = 3
    val LEVEL5 = 4

    var LogLevel = LEVEL5
    val TAG = "Lifeband"
    fun print(bytes: ByteArray): String? {
        val sb = StringBuilder()
        sb.append("[ ")
        for (b in bytes) {
            sb.append(String.format("0x%02X ", b))
        }
        sb.append("]")
        return sb.toString()
    }
}