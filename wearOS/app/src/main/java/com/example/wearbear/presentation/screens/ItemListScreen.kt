package com.example.wearbear.presentation.screens

import androidx.compose.foundation.layout.*
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.rememberLazyListState
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.text.style.TextAlign
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp

import androidx.lifecycle.viewmodel.compose.viewModel

import androidx.wear.compose.material.PositionIndicator
import androidx.wear.compose.material.Scaffold
import androidx.wear.compose.material3.Text
import androidx.wear.compose.material.TimeText

import com.example.wearbear.presentation.components.ItemRow
import com.example.wearbear.presentation.components.LoadingIndicator
import com.example.wearbear.viewmodel.LocationViewModel

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