package com.example.movieappas.data.network.responses

import com.example.movieappas.data.Movie
import com.google.gson.annotations.SerializedName

data class MoviesResponse(
    @SerializedName("title")
    val title : String,
    @SerializedName("original_title")
    val originalTitle : String,
    @SerializedName("overview")
    val overview : String,
    @SerializedName("poster_path")
    val posterPath : String,
    @SerializedName("backdrop_path")
    val backdropPath : String,
    @SerializedName("release_date")
    val releaseDate : String,
    @SerializedName("vote_average")
    val voteAverage : Double,
)

fun MoviesResponse.toModel() = Movie(
    title = this.title,
    originalTitle = this.originalTitle,
    overview = this.overview,
    posterPath = this.posterPath,
    backdropPath = this.backdropPath,
    releaseDate = this.releaseDate,
    voteAverage = this.voteAverage
)
