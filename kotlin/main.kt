import kotlin.math.PI
import kotlin.math.sin
import kotlin.system.exitProcess

const val EXIT_FAILURE: Int = 1

const val COLOR_RESET: String = "\u001B[0m"

const val FREQ: Double = 0.1

data class RGB(val r: Int, val g: Int, val b: Int) {
    val escapeSequence: String
        get() = "\u001B[38;2;$r;$g;${b}m"

    companion object {
        fun rainbow(frequency: Double, i: Int): RGB {
            return RGB(
                (sin(frequency * i) * 127 + 128).toInt(),
                (sin(frequency * i + 2 * PI / 3) * 127 + 128).toInt(),
                (sin(frequency * i + 4 * PI / 3) * 127 + 128).toInt()
            )
        }
    }
}

fun putcWithRgb(c: Char, color: RGB) {
    print("${color.escapeSequence}$c$COLOR_RESET")
}

fun main(args: Array<String>) {
    // Check if at least one command line argument was provided
    // Note that there is no 0th argument with the executable name so check if there are any
    if (args.isNotEmpty()) {
        val input = args.first()

        for ((index, char) in input.withIndex()) {
            putcWithRgb(char, RGB.rainbow(FREQ, index))
        }
    } else {
        exitProcess(EXIT_FAILURE)
    }
}