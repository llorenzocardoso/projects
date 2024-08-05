package com.example.movieappas.data.repositories

import com.example.movieappas.data.Movie
import com.example.movieappas.data.datasources.MoviesDataSource
import com.example.movieappas.data.network.responses.toModel
import javax.inject.Inject

class MoviesRepository @Inject constructor(
    private val moviesDataSource: MoviesDataSource
) {
    suspend fun fetchTrendingMovies(): List<Movie> {
        return moviesDataSource
            .fetchTrendingMovies()
            .movieResult.map { item -> item.toModel() }
    }

    suspend fun fetchTopRatedMovies(): List<Movie> {
        return moviesDataSource
            .fetchTopRatedMovies()
            .movieResult.map { item -> item.toModel() }
    }

    suspend fun fetchUpcomingMovies(): List<Movie> {
        return moviesDataSource
            .fetchUpcomingMovies()
            .movieResult.map { item -> item.toModel() }
    }
}
