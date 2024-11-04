package com.example.wearbear.viewmodel

import android.util.Log
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.Dispatchers

import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch

import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.http.Body
import retrofit2.http.GET
import retrofit2.http.POST

data class CancelRequest(val locationId: Int)
data class Location(val id: Int, val name: String)
data class LocationQueue(val robotId: Int, val locationId: Int, val status: String)

interface ApiService {
    @GET("api/locations")
    suspend fun getLocations(): List<Location>

    @GET("api/queue")
    suspend fun getQueue(): List<LocationQueue>

    @POST("api/robots/cancel")
    suspend fun cancelRobotRequest(@Body cancelRequest: CancelRequest): Unit
}

class LocationViewModel : ViewModel() {
    private val _locations = MutableStateFlow<List<Location>>(emptyList())
    val locations = _locations.asStateFlow()

    private val _queueRequests = MutableStateFlow<Set<Int>>(emptySet())
    val queue = _queueRequests.asStateFlow()

    private val _robotCounts = MutableStateFlow<Map<Int, Int>>(emptyMap())
    val robots = _robotCounts.asStateFlow()

    private val apiService: ApiService by lazy {
        Retrofit.Builder()
            .baseUrl("https://smartwatch-project.onrender.com/")
            .addConverterFactory(GsonConverterFactory.create())
            .build()
            .create(ApiService::class.java)
    }

    init {
        fetchLocations()
        fetchLocationQueue()
    }

    fun reloadData() {
        fetchLocations()
        fetchLocationQueue()
    }

    private fun fetchLocations() {
        viewModelScope.launch {
            try {
                val response = apiService.getLocations()
                _locations.value = response
            } catch (e: Exception) {
                Log.e("LocationViewModel", "Error fetching locations: ${e.message}")
            }
        }
    }

    private fun fetchLocationQueue() {
        viewModelScope.launch {
            try {
                val queueItems = apiService.getQueue()

                _queueRequests.value = queueItems.map { it.locationId }.toSet()

                calculateRobotCounts(queueItems)
            } catch (e: Exception) {
                Log.e("QueueViewModel", "Error fetching queue requests: ${e.message}")
            }
        }
    }

    private fun calculateRobotCounts(queueItems: List<LocationQueue>) {
        val counts = mutableMapOf<Int, Int>()

        for (item in queueItems) {
            counts[item.locationId] = (counts[item.locationId] ?: 0) + 1
        }

        _robotCounts.value = counts
    }

    fun cancelRobotRequest(locationId: Int) {
        viewModelScope.launch(Dispatchers.IO) {
            try {
                apiService.cancelRobotRequest(CancelRequest(locationId))
                Log.d("LocationViewModel", "Robot request cancelled successfully")

                fetchLocationQueue()
            } catch (e: Exception) {
                Log.e("LocationViewModel", "Error cancelling robot request: ${e.message}")
            }
        }
    }
}
