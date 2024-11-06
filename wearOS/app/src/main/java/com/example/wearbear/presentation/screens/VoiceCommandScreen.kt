package com.example.wearbear.presentation.screens

import androidx.compose.animation.core.animateFloatAsState
import androidx.compose.foundation.layout.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.wear.compose.material.CircularProgressIndicator
import androidx.wear.compose.material3.Text
import com.example.wearbear.viewmodel.VoiceCommandViewModel

@Composable
fun VoiceCommandScreen(
    command: String,
    voiceCommandViewModel: VoiceCommandViewModel = viewModel(),
    onClose: () -> Unit
) {
    var locationId by remember { mutableStateOf<Int?>(null) }
    val processedCommand = voiceCommandViewModel.processVoiceCommand(command)

    var progress by remember { mutableFloatStateOf(0f) }

    val animatedProgress by animateFloatAsState(
        targetValue = progress,
        animationSpec = androidx.compose.animation.core.tween(durationMillis = 5000), label = "",
        finishedListener = { onClose() }
    )

    LaunchedEffect(processedCommand) {
        voiceCommandViewModel.getLocationIdByName(processedCommand) { id ->
            locationId = id
            id?.let {
                voiceCommandViewModel.callRobot(it)
                progress = 1f
            } ?: run {
                println("Error: Location not found.")
                onClose()
            }
        }
    }

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        CircularProgressIndicator(progress = animatedProgress)

        Spacer(modifier = Modifier.height(16.dp))

        Text(
            text = "Command: $processedCommand",
            fontSize = 18.sp,
            textAlign = TextAlign.Center,
            modifier = Modifier.fillMaxWidth()
        )

        Spacer(modifier = Modifier.height(16.dp))

        Text(
            text = "Location ID: ${locationId ?: "Not Found"}",
            fontSize = 18.sp,
            textAlign = TextAlign.Center,
            modifier = Modifier.fillMaxWidth()
        )
    }
}
