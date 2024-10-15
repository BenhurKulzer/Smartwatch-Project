package com.example.wearbear.viewmodel

import android.util.Log
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.wearbear.model.Robot
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.http.GET

interface ApiRobotsService {
    @GET("api/robots")
    suspend fun getRobots(): List<Robot>
}

class RobotViewModel : ViewModel() {
    private val _robots = MutableStateFlow<List<Robot>>(emptyList())
    val robots = _robots.asStateFlow()

    private val apiService: ApiRobotsService by lazy {
        Retrofit.Builder()
            .baseUrl("http://192.168.1.8:3000/")
            .addConverterFactory(GsonConverterFactory.create())
            .build()
            .create(ApiRobotsService::class.java)
    }

    init {
        fetchRobots()
    }

    private fun fetchRobots() {
        viewModelScope.launch {
            try {
                val response = apiService.getRobots()
                _robots.value = response
            } catch (e: Exception) {
                Log.e("RobotViewModel", "Error fetching locations: ${e.message}")
            }
        }
    }
}
