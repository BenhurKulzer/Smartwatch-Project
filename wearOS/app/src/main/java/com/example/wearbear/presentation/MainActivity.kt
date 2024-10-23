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
import com.example.wearbear.viewmodel.LocationViewModel

class MainActivity : ComponentActivity() {
    private val locationViewModel: LocationViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            var selectedLocation by remember { mutableStateOf<String?>(null) }
            var selectedLocationId by remember { mutableStateOf<Int?>(null) }
            var numberOfBears by remember { mutableIntStateOf(1) }
            var showSummaryScreen by remember { mutableStateOf(false) }

            Box(modifier = Modifier.fillMaxSize().background(Color.Black)) {
                if (selectedLocation == null || selectedLocationId == null) {
                    ItemListScreen(locationViewModel) { locationName, locationId ->
                        selectedLocation = locationName
                        selectedLocationId = locationId
                    }
                } else if (showSummaryScreen) {
                    SummaryScreen(
                        locationId = selectedLocationId!!,
                        locationName = selectedLocation!!,
                        numberOfBears = numberOfBears,
                        onClose = {
                            selectedLocation = null
                            selectedLocationId = null
                            showSummaryScreen = false
                            numberOfBears = 1
                        }
                    )
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
