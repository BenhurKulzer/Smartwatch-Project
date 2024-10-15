package com.example.wearbear.presentation

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.viewModels
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import com.example.wearbear.presentation.screens.ItemListScreen
import com.example.wearbear.presentation.screens.RobotListScreen
import com.example.wearbear.viewmodel.LocationViewModel
import com.example.wearbear.viewmodel.RobotViewModel

class MainActivity : ComponentActivity() {
    private val locationViewModel: LocationViewModel by viewModels()
    private val robotViewModel: RobotViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContent {
            var selectedLocation by remember { mutableStateOf<String?>(null) }

            Box(modifier = Modifier.fillMaxSize().background(Color.Black)) {
                if (selectedLocation == null) {
                    ItemListScreen(locationViewModel) { locationName ->
                        selectedLocation = locationName
                    }
                } else {
                    RobotListScreen(
                        locationName = selectedLocation!!,
                        robotViewModel = robotViewModel,
                        onBackPress = { selectedLocation = null }
                    )
                }
            }
        }
    }
}
