package com.example.movieappas.data

import android.util.Log

data class Movie(
    val title: String,
    val originalTitle: String,
    val overview: String,
    val posterPath: String,
    val backdropPath: String,
    val releaseDate: String,
    val voteAverage: Double,
)
