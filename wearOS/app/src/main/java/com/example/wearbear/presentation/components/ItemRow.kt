package com.example.wearbear.presentation.components

import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.LocationOn
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.wear.compose.material.Chip
import androidx.wear.compose.material.ChipDefaults
import androidx.wear.compose.material.Icon
import androidx.wear.compose.material.Text

import com.example.wearbear.viewmodel.Location

@Composable
fun ItemRow(location: Location, onClick: () -> Unit) {
    Chip(
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 2.dp),
        shape = RoundedCornerShape(12.dp),
        label = {
            Text(text = location.name, color = Color.White, fontSize = 15.sp, fontWeight = FontWeight.W400,)
        },
        onClick = { onClick() },
        colors = ChipDefaults.primaryChipColors(
            backgroundColor = Color.DarkGray
        ),
        icon = {
            Icon(
                imageVector = Icons.Filled.LocationOn,
                contentDescription = "Location",
                tint = Color.White,
                modifier = Modifier.size(20.dp)
            )
        }
    )
}
