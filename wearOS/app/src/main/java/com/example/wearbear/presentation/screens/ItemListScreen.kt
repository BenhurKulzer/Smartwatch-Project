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
import androidx.wear.compose.material.*
import com.example.wearbear.presentation.components.ItemRow
import com.example.wearbear.viewmodel.LocationViewModel
import com.example.wearbear.presentation.components.LoadingIndicator

@Composable
fun ItemListScreen(
    locationViewModel: LocationViewModel = viewModel(),
    onLocationClick: (String) -> Unit
) {
    val locations by locationViewModel.locations.collectAsState()
    val isLoading = locations.isEmpty()

    val listState = rememberLazyListState()

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
            if (isLoading) {
                LoadingIndicator()
            } else {
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
                                .padding(vertical = 14.dp, horizontal = 12.dp)
                                .padding(top = 18.dp)
                        )
                    }
                    items(locations) { location ->
                        ItemRow(
                            location = location,
                            onClick = { onLocationClick(location.name) },
                        )
                    }
                }
            }
        }
    }
}
