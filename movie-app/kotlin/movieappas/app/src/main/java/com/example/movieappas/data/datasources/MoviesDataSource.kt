package com.example.movieappas.data.datasources

import com.example.movieappas.data.network.MoviesApi
import com.example.movieappas.data.network.responses.ResultsResponse
import javax.inject.Inject

class MoviesDataSource @Inject constructor(
    private val api: MoviesApi
) {
    suspend fun fetchTrendingMovies(): ResultsResponse {
        return api.fetchTrendingMovies()
    }

    suspend fun fetchTopRatedMovies(): ResultsResponse {
        return api.fetchTopRatedMovies()
    }

    suspend fun fetchUpcomingMovies(): ResultsResponse {
        return api.fetchUpcomingMovies()
    }
}
