// Theme.kt
package com.example.wearbear.ui.theme

import androidx.wear.compose.material.Colors
import androidx.compose.runtime.Composable
import androidx.wear.compose.material.MaterialTheme
import androidx.compose.ui.graphics.Color

private val DarkColorPalette = Colors(
    primary = Color(0xFF6200EE),
    primaryVariant = Color(0xFF3700B3),
    secondary = Color(0xFF03DAC6),
    background = Color.Black,
    surface = Color.DarkGray,
    onPrimary = Color.White,
    onSecondary = Color.Black,
    onBackground = Color.White,
    onSurface = Color.White
)

@Composable
fun WearBearTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colors = DarkColorPalette,
        content = content
    )
}
