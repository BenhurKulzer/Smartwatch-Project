package com.example.wearbear.presentation.screens

import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.runtime.*

import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.viewmodel.compose.viewModel

import androidx.wear.compose.material.Button
import androidx.wear.compose.material.CircularProgressIndicator
import androidx.wear.compose.material.MaterialTheme
import androidx.wear.compose.material.Text
import com.example.wearbear.viewmodel.SummaryViewModel

import kotlinx.coroutines.delay

@Composable
fun SummaryScreen(
    locationId: Int,
    locationName: String,
    numberOfBears: Int,
    summaryViewModel: SummaryViewModel = viewModel(),
    onClose: () -> Unit
) {
    var progress by remember { mutableFloatStateOf(0f) }

    val animatedProgress by animateFloatAsState(
        targetValue = progress,
        animationSpec = androidx.compose.animation.core.tween(durationMillis = 5000), label = "",
        finishedListener = { onClose() }
    )

    LaunchedEffect(key1 = true) {
        summaryViewModel.callRobot(locationId)
        delay(1000)
        progress = 1f
    }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.SpaceBetween
    ) {
        CircularProgressIndicator(progress = animatedProgress)

        Spacer(modifier = Modifier.height(18.dp))

        Text(
            text = "Sending $numberOfBears bear(s) to $locationName",
            fontSize = 18.sp,
            textAlign = TextAlign.Center,
            modifier = Modifier
                .fillMaxWidth(),
            color = MaterialTheme.colors.primaryVariant
        )

        Spacer(modifier = Modifier.height(18.dp))

        Button(
            onClick = { onClose() },
            shape = RoundedCornerShape(12.dp),
            modifier = Modifier
                .fillMaxWidth()
        ) {
            Text(text = "Close")
        }
    }
}
