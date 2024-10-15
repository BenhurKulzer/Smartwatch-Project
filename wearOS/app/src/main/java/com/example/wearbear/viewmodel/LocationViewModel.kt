package com.example.wearbear.viewmodel

import android.util.Log
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.launch
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import retrofit2.http.GET

data class Location(val id: Int, val name: String)

interface ApiService {
    @GET("api/locations")
    suspend fun getLocations(): List<Location>
}

class LocationViewModel : ViewModel() {
    private val _locations = MutableStateFlow<List<Location>>(emptyList())
    val locations = _locations.asStateFlow()

    private val apiService: ApiService by lazy {
        Retrofit.Builder()
            .baseUrl("http://192.168.1.8:3000/")
            .addConverterFactory(GsonConverterFactory.create())
            .build()
            .create(ApiService::class.java)
    }

    init {
        fetchLocations()
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
}
