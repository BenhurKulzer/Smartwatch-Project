package com.example.wearbear.viewmodel

import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope

import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

import org.json.JSONObject

import java.io.OutputStreamWriter
import java.net.HttpURLConnection
import java.net.URL

class SummaryViewModel : ViewModel() {
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
                        println("Success: $responseCode")
                    } else {
                        println("Error: $responseCode")
                    }

                    connection.disconnect()
                }
            } catch (e: Exception) {
                println("Error: ${e.message}")
                e.printStackTrace()
            }
        }
    }
}
