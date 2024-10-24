package com.example.wearbear.ui.theme

import androidx.compose.runtime.*
import androidx.compose.ui.graphics.Color

import androidx.wear.compose.material.*

private val DarkColorPalette = Colors(
    primary = Color(0xFF6200EE),
    primaryVariant = Color(0xFF3700B3),
    secondary = Color(0xFF03DAC6),
    background = Color.Black,
    surface = Color.DarkGray,
    onPrimary = Color.White,
    onSecondary = Color.Black,
    onBackground = Color.White,
    onSurface = Color.White,
)

data class CustomColors(
    val accept: Color,
    val reject: Color
)

val LocalCustomColors = staticCompositionLocalOf {
    CustomColors(
        accept = Color(0xFF5CD89F),
        reject = Color(0xFFFF5C3E)
    )
}

@Composable
fun WearBearTheme(content: @Composable () -> Unit) {
    val customColors = CustomColors(
        accept = Color(0xFF5CD89F),
        reject = Color(0xFFFF5C3E)
    )

    CompositionLocalProvider(LocalCustomColors provides customColors) {
        MaterialTheme(
            colors = DarkColorPalette,
            content = content
        )
    }
}

object CustomTheme {
    val colors: CustomColors
        @Composable
        get() = LocalCustomColors.current
}
