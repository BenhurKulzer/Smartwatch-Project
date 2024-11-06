package com.example.wearbear.presentation.screens

import androidx.compose.foundation.layout.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.wear.compose.material3.Text
import com.example.wearbear.viewmodel.VoiceCommandViewModel

@Composable
fun VoiceCommandScreen(
    command: String,
    voiceCommandViewModel: VoiceCommandViewModel = viewModel(),
    onClose: () -> Unit
) {
    val processedCommand = voiceCommandViewModel.processVoiceCommand(command)

    Column(
        modifier = Modifier
            .fillMaxSize()
            .padding(16.dp),
        horizontalAlignment = Alignment.CenterHorizontally,
        verticalArrangement = Arrangement.Center
    ) {
        Text(
            text = "Command: $processedCommand",
            fontSize = 18.sp,
            textAlign = TextAlign.Center,
            modifier = Modifier.fillMaxWidth()
        )
    }
}
