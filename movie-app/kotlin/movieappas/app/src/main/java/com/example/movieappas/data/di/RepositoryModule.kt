package com.example.movieappas.data.di

import com.example.movieappas.data.datasources.MoviesDataSource
import com.example.movieappas.data.repositories.MoviesRepository
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object RepositoryModule {
    @Provides
    @Singleton

    fun providesMoviesRepository(
        moviesDataSource: MoviesDataSource
    ) : MoviesRepository {
        return MoviesRepository(moviesDataSource)
    }
}