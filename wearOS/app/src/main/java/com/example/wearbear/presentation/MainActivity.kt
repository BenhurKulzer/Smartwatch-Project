package com.example.wearbear.presentation

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableIntStateOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color

import com.example.wearbear.presentation.screens.ItemListScreen
import com.example.wearbear.presentation.screens.RobotListScreen
import com.example.wearbear.presentation.screens.SummaryScreen
import com.example.wearbear.presentation.screens.VoiceCommandScreen
import com.example.wearbear.viewmodel.LocationViewModel
import com.example.wearbear.viewmodel.VoiceCommandViewModel

class MainActivity : ComponentActivity() {
    private val locationViewModel: LocationViewModel by viewModels()
    private val voiceCommandViewModel: VoiceCommandViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            var selectedLocation by remember { mutableStateOf<String?>(null) }
            var selectedLocationId by remember { mutableStateOf<Int?>(null) }
            var numberOfBears by remember { mutableIntStateOf(1) }
            var showVoiceCommandScreen by remember { mutableStateOf(false) }
            var showSummaryScreen by remember { mutableStateOf(false) }

            intent?.data?.let { uri ->
                val locationName = uri.getQueryParameter("location") ?: ""
                if (locationName.isNotEmpty()) {
                    println("Location name: $locationName")
                    voiceCommandViewModel.getLocationIdByName(locationName) { locationId ->
                        locationId?.let {
                            selectedLocation = locationName
                            selectedLocationId = it
                            showVoiceCommandScreen = true
                        }
                    }
                }
            }

            Box(modifier = Modifier.fillMaxSize().background(Color.Black)) {
                if (showVoiceCommandScreen) {
                    VoiceCommandScreen(command = "Send a robot to $selectedLocation") {
                        selectedLocation = null
                        selectedLocationId = null
                        showVoiceCommandScreen = false
                    }
                } else if (showSummaryScreen) {
                    SummaryScreen(
                        locationId = selectedLocationId ?: 0,
                        locationName = selectedLocation ?: "",
                        numberOfBears = numberOfBears,
                        onClose = {
                            showSummaryScreen = false
                        }
                    )
                } else if (selectedLocation == null || selectedLocationId == null) {
                    ItemListScreen(locationViewModel) { locationName, locationId ->
                        selectedLocation = locationName
                        selectedLocationId = locationId
                        showSummaryScreen = true
                    }
                } else {
                    RobotListScreen(
                        locationName = selectedLocation!!,
                        locationId = selectedLocationId!!,
                        numberOfBears = numberOfBears,
                        onNumberOfBearsChange = { newNumberOfBears ->
                            numberOfBears = newNumberOfBears
                        },
                        onBackPress = {
                            selectedLocation = null
                            selectedLocationId = null
                            numberOfBears = 1
                        },
                        onConfirmPress = {
                            showSummaryScreen = true
                        },
                    )
                }
            }
        }
    }
}
