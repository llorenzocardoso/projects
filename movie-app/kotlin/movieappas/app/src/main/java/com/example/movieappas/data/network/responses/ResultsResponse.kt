package com.example.movieappas.data.network.responses

import com.google.gson.annotations.SerializedName

data class ResultsResponse(
    @SerializedName("results")
    val movieResult: List<MoviesResponse>
)
