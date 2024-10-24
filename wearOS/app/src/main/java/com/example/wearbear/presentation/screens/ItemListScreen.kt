package com.example.wearbear.presentation.screens

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Check
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

import androidx.lifecycle.viewmodel.compose.viewModel

import androidx.wear.compose.material.PositionIndicator
import androidx.wear.compose.material.Scaffold
import androidx.wear.compose.material3.Text
import androidx.wear.compose.material.TimeText
import androidx.wear.compose.material3.Button
import androidx.wear.compose.material3.ButtonDefaults
import androidx.wear.compose.material3.Icon
import androidx.wear.compose.material3.SwipeToDismissBox

import com.example.wearbear.presentation.components.ItemRow
import com.example.wearbear.presentation.components.LoadingIndicator
import com.example.wearbear.viewmodel.LocationViewModel
import com.example.wearbear.ui.theme.CustomTheme

import com.google.accompanist.swiperefresh.SwipeRefresh
import com.google.accompanist.swiperefresh.SwipeRefreshIndicator
import com.google.accompanist.swiperefresh.rememberSwipeRefreshState

import kotlinx.coroutines.delay
import kotlinx.coroutines.launch

@Composable
fun ItemListScreen(
    locationViewModel: LocationViewModel = viewModel(),
    onLocationClick: (String, Int) -> Unit
) {
    val locations by locationViewModel.locations.collectAsState()
    val robots by locationViewModel.robots.collectAsState()

    val isLoading = locations.isEmpty()
    var isRefreshing by remember { mutableStateOf(false) }

    val listState = rememberLazyListState()
    val scope = rememberCoroutineScope()

    LaunchedEffect(Unit) {
        locationViewModel.reloadData()
    }

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
            if (isLoading && !isRefreshing) {
                LoadingIndicator()
            } else {
                SwipeRefresh(
                    state = rememberSwipeRefreshState(isRefreshing),
                    onRefresh = {
                        isRefreshing = true
                        scope.launch {
                            locationViewModel.reloadData()
                            delay(1000)
                            isRefreshing = false
                        }
                    },
                    indicator = { state, trigger ->
                        SwipeRefreshIndicator(
                            state = state,
                            refreshTriggerDistance = trigger,
                            scale = true
                        )
                    }
                ) {
                    LazyColumn(
                        state = listState,
                        modifier = Modifier.fillMaxSize()
                    ) {
                        item {
                            Text(
                                text = "Locations",
                                fontSize = 22.sp,
                                textAlign = TextAlign.Center,
                                modifier = Modifier
                                    .fillMaxWidth()
                                    .padding(12.dp)
                                    .padding(top = 8.dp)
                            )
                        }
                        items(locations) { location ->
                            val robotCount = robots[location.id] ?: 0

                            if (robotCount > 0) {
                                SwipeToDismissBox(
                                    onDismissed = { }
                                ) { isBackground ->
                                    if (isBackground) {
                                        Button(
                                            onClick = { },
                                            shape = RoundedCornerShape(12.dp),
                                            colors = ButtonDefaults.buttonColors(
                                                containerColor = CustomTheme.colors.reject
                                            ),
                                            modifier = Modifier.fillMaxWidth()
                                        ) {
                                            Icon(
                                                imageVector = Icons.Default.Check,
                                                contentDescription = "Confirm Button",
                                                tint = Color.White,
                                                modifier = Modifier.size(22.dp)
                                            )

                                            Spacer(modifier = Modifier.width(8.dp))

                                            Text(
                                                text = "Cancel Robot",
                                                color = Color.White,
                                                textAlign = TextAlign.Center,
                                                fontSize = 16.sp,
                                                modifier = Modifier.padding(top = 12.dp, bottom = 8.dp)
                                            )
                                        }
                                    } else {
                                        ItemRow(
                                            location = location,
                                            counter = robotCount,
                                            onClick = { onLocationClick(location.name, location.id) },
                                        )
                                    }
                                }
                            } else {
                                ItemRow(
                                    location = location,
                                    counter = robotCount,
                                    onClick = { onLocationClick(location.name, location.id) },
                                )
                            }
                        }
                    }
                }
            }
        }
    }
}