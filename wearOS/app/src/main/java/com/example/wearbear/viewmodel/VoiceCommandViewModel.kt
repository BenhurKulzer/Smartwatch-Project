package com.example.wearbear.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import org.json.JSONArray
import org.json.JSONObject
import java.io.OutputStreamWriter
import java.net.HttpURLConnection
import java.net.URL

class VoiceCommandViewModel : ViewModel() {
    fun getLocationIdByName(locationName: String, callback: (Int?) -> Unit) {
        viewModelScope.launch {
            try {
                withContext(Dispatchers.IO) {
                    val url = URL("https://smartwatch-project.onrender.com/api/locations")
                    val connection = (url.openConnection() as HttpURLConnection).apply {
                        requestMethod = "GET"
                        setRequestProperty("Content-Type", "application/json")
                    }

                    val responseCode = connection.responseCode
                    if (responseCode == HttpURLConnection.HTTP_OK) {
                        val responseText = connection.inputStream.bufferedReader().readText()
                        val locationsArray = JSONArray(responseText)

                        var locationId: Int? = null
                        for (i in 0 until locationsArray.length()) {
                            val location = locationsArray.getJSONObject(i)
                            if (location.getString("name").equals(locationName, ignoreCase = true)) {
                                locationId = location.getInt("id")
                                break
                            }
                        }

                        withContext(Dispatchers.Main) {
                            callback(locationId)
                        }
                    } else {
                        withContext(Dispatchers.Main) {
                            callback(null)
                        }
                    }

                    connection.disconnect()
                }
            } catch (e: Exception) {
                println("Error fetching locations: ${e.message}")
                e.printStackTrace()
                withContext(Dispatchers.Main) {
                    callback(null)
                }
            }
        }
    }

    fun callRobot(locationId: Int) {
        viewModelScope.launch {
            try {
                withContext(Dispatchers.IO) {
                    val url = URL("https://smartwatch-project.onrender.com/api/robots/call")
                    val connection = (url.openConnection() as HttpURLConnection).apply {
                        requestMethod = "POST"
                        setRequestProperty("Content-Type", "application/json")
                        doOutput = true
                    }

                    val jsonParam = JSONObject().apply {
                        put("locationId", locationId)
                    }

                    OutputStreamWriter(connection.outputStream).use { writer ->
                        writer.write(jsonParam.toString())
                        writer.flush()
                    }

                    val responseCode = connection.responseCode
                    if (responseCode == HttpURLConnection.HTTP_OK) {
                        println("Robot successfully called: $responseCode")
                    } else {
                        println("Error calling robot: $responseCode")
                    }

                    connection.disconnect()
                }
            } catch (e: Exception) {
                println("Error calling robot: ${e.message}")
                e.printStackTrace()
            }
        }
    }

    fun processVoiceCommand(command: String): String {
        return extractLocationFromCommand(command) ?: "Location not found"
    }

    private fun extractLocationFromCommand(command: String): String? {
        return when {
            command.contains("kitchen", ignoreCase = true) -> "Kitchen"
            command.contains("standby", ignoreCase = true) -> "StandBy"
            command.contains("table one", ignoreCase = true) -> "T 1"
            command.contains("table two", ignoreCase = true) -> "T 2"
            command.contains("table three", ignoreCase = true) -> "T 3"
            command.contains("table four", ignoreCase = true) -> "T 4"
            command.contains("table five", ignoreCase = true) -> "T 5"
            command.contains("table six", ignoreCase = true) -> "T 6"
            command.contains("table seven", ignoreCase = true) -> "T 7"
            command.contains("table eight", ignoreCase = true) -> "T 8"
            command.contains("table nine", ignoreCase = true) -> "T 9"
            command.contains("warehouse", ignoreCase = true) -> "Warehouse"
            else -> null
        }
    }
}
