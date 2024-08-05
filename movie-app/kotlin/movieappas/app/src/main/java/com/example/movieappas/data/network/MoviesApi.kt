package com.example.movieappas.data.network

import com.example.movieappas.data.network.responses.ResultsResponse
import retrofit2.http.GET

interface MoviesApi {
    @GET("trending/movie/week")
    suspend fun fetchTrendingMovies(): ResultsResponse

    @GET("movie/top_rated")
    suspend fun fetchTopRatedMovies(): ResultsResponse

    @GET("movie/upcoming")
    suspend fun fetchUpcomingMovies(): ResultsResponse
}
