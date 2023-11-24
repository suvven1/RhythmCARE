package com.example.dna

object Debug {
    const val USE_ALGORITHM = false
    const val MEASUREMENT_FEATURE = true
    const val ALGORITHM_CONTINUOUS_MEASUREMENT_FEATURE = true
    const val SAVE_CSV_FILES = false
    const val DEVICE_INFO = "LANE2"
    const val WELLNESS_CARE = "WellnessCare"
    const val LANE2 = "LANE2"
    const val LEVEL1 = 0
    const val LEVEL2 = 1
    const val LEVEL3 = 2
    const val LEVEL4 = 3
    const val LEVEL5 = 4
    var LogLevel = LEVEL5
    const val TAG = "RhythmCare"
    fun print(bytes: ByteArray): String {
        val sb = StringBuilder()
        sb.append("[ ")
        for (b in bytes) {
            sb.append(String.format("0x%02X ", b))
        }
        sb.append("]")
        return sb.toString()
    }
}