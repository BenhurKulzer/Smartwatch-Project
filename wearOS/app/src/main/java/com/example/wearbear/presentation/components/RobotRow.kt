package com.example.wearbear.presentation.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.wear.compose.material.Chip
import androidx.wear.compose.material.ChipDefaults
import androidx.wear.compose.material.Text
import com.example.wearbear.model.Robot

@Composable
fun RobotRow(robot: Robot, onClick: () -> Unit) {
    val statusColor = when (robot.status) {
        "Running" -> Color.Green
        "Idle" -> Color.Blue
        "Charging" -> Color.Yellow
        "Offline" -> Color.Gray
        else -> Color.Gray
    }

    Chip(
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 4.dp),
        label = {
            Row(
                modifier = Modifier.fillMaxWidth(),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = robot.name,
                    color = Color.White,
                    fontSize = 15.sp,
                    fontWeight = FontWeight.Bold,
                    modifier = Modifier.weight(1f),
                )

                Spacer(modifier = Modifier.width(8.dp))

                Text(
                    text = "${robot.battery}%",
                    fontSize = 16.sp,
                    fontWeight = FontWeight.Normal,
                    color = Color.White,
                    modifier = Modifier.padding(end = 8.dp)
                )

                Box(
                    modifier = Modifier
                        .size(12.dp)
                        .background(statusColor, CircleShape)
                )
            }
        },
        onClick = onClick,
        colors = ChipDefaults.primaryChipColors(
            backgroundColor = Color.DarkGray
        ),
        shape = RoundedCornerShape(12.dp)
    )
}
