package com.example.wearbear.presentation.screens

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.ArrowBack
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.wear.compose.material.*
import androidx.wear.compose.material3.IconButton
import com.example.wearbear.presentation.components.LoadingIndicator
import com.example.wearbear.presentation.components.RobotRow
import com.example.wearbear.viewmodel.RobotViewModel
import com.example.wearbear.model.Robot

@Composable
fun RobotListScreen(
    locationName: String,
    robotViewModel: RobotViewModel = viewModel(),
    onBackPress: () -> Unit
) {
    val robots by robotViewModel.robots.collectAsState()
    val isLoading = robots.isEmpty()

    val listState = rememberLazyListState()

    var selectedRobot by remember { mutableStateOf<Robot?>(null) }

    Scaffold(
        timeText = { TimeText() },
        positionIndicator = {
            PositionIndicator(
                lazyListState = listState
            )
        }
    ) {
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(8.dp),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Column(
                modifier = Modifier.fillMaxWidth(),
                horizontalAlignment = Alignment.CenterHorizontally
            ) {
                IconButton(
                    onClick = onBackPress,
                    modifier = Modifier.padding(vertical = 2.dp).padding(top = 8.dp).size(26.dp),
                    shape = RoundedCornerShape(18.dp),
                ) {
                    Icon(
                        imageVector = Icons.Default.ArrowBack,
                        contentDescription = "Back",
                        modifier = Modifier.size(16.dp)
                    )
                }
            }

            if (isLoading) {
                LoadingIndicator()
            } else {
                LazyColumn(
                    modifier = Modifier.fillMaxSize(),
                    state = listState,
                ) {
                    item {
                        Text(
                            text = locationName,
                            textAlign = TextAlign.Center,
                            fontSize = 16.sp,
                            modifier = Modifier.fillMaxWidth().padding(vertical = 0.dp).padding(bottom = 6.dp)
                        )
                    }

                    items(robots) { robot ->
                        RobotRow(robot = robot) {
                            selectedRobot = robot
                        }
                    }
                }
            }
        }
    }
}
