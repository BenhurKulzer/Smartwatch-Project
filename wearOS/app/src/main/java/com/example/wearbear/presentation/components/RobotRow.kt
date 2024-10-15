package com.example.wearbear.presentation.components

import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.runtime.Composable
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
    Chip(
        modifier = Modifier
            .fillMaxWidth()
            .padding(vertical = 4.dp),
        label = {
            Row(modifier = Modifier.fillMaxWidth()) {
                Text(
                    text = robot.name,
                    color = Color.White,
                    fontSize = 15.sp,
                    modifier = Modifier.weight(1f),
                )

                Text(
                    text = "${robot.battery}%",
                    fontSize = 15.sp,
                    fontWeight = FontWeight.Normal,
                    color = Color.White,
                )
            }
        },
        onClick = onClick,
        colors = ChipDefaults.primaryChipColors(
            backgroundColor = Color.DarkGray
        ),
        shape = RoundedCornerShape(12.dp),
        icon = {
            Box(
                modifier = Modifier
                    .size(11.dp)
                    .background(Color.Green, shape = CircleShape)
            )
        }
    )
}
