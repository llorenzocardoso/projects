package com.example.movieappas.data.di

import com.example.movieappas.data.datasources.MoviesDataSource
import com.example.movieappas.data.network.MoviesApi
import com.example.movieappas.data.repositories.MoviesRepository
import dagger.Module
import dagger.Provides
import dagger.hilt.InstallIn
import dagger.hilt.components.SingletonComponent
import javax.inject.Singleton

@Module
@InstallIn(SingletonComponent::class)
object DataSourceModule {
    @Provides
    @Singleton

    fun providesDataSourceModule(
        api: MoviesApi
    ) : MoviesDataSource {
        return MoviesDataSource(api)
    }
}