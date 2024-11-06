package com.example.wearbear.viewmodel

import androidx.lifecycle.ViewModel

class VoiceCommandViewModel : ViewModel() {
    private val locations = mapOf(
        "Kitchen" to 1,
        "T1" to 2,
        "Bedroom" to 3
    )

    fun getLocationIdByName(locationName: String, callback: (Int?) -> Unit) {
        val locationId = locations[locationName]
        callback(locationId)
    }

    fun processVoiceCommand(command: String): String {
        return extractLocationFromCommand(command) ?: "Location not found"
    }

    private fun extractLocationFromCommand(command: String): String? {
        return when {
            command.contains("kitchen", ignoreCase = true) -> "Kitchen"
            command.contains("t1", ignoreCase = true) -> "T 1"
            else -> null
        }
    }
}
