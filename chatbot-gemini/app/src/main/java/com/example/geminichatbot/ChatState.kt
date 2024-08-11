package com.example.geminichatbot

import android.graphics.Bitmap
import com.example.geminichatbot.data.Chat

data class ChatState(
    val chatList: List<Chat> = emptyList(),
    val prompt: String = "",
    val bitmap: Bitmap? = null
)

