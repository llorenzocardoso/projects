package com.example.movieappas.ui

import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import androidx.lifecycle.viewModelScope
import com.example.movieappas.commons.Resultado
import com.example.movieappas.data.Movie
import com.example.movieappas.data.repositories.MoviesRepository
import dagger.hilt.android.lifecycle.HiltViewModel
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import javax.inject.Inject

@HiltViewModel
class MoviesViewModel @Inject constructor(
    private val moviesRepository: MoviesRepository
) : ViewModel() {

    fun fetchTrendingMovies(): LiveData<Resultado<List<Movie>>> {
        val liveData = MutableLiveData<Resultado<List<Movie>>>()

        liveData.postValue(Resultado.Loading)

        viewModelScope.launch(Dispatchers.IO) {
            try {
                val result = moviesRepository.fetchTrendingMovies()
                liveData.postValue(Resultado.Success(result))
            } catch (e: Exception){
                liveData.postValue(Resultado.Error(e))
            }

        }
        return liveData
    }

    fun fetchTopRatedMovies(): LiveData<Resultado<List<Movie>>> {
        val liveData = MutableLiveData<Resultado<List<Movie>>>()

        liveData.postValue(Resultado.Loading)

        viewModelScope.launch(Dispatchers.IO) {

            try {
                val result = moviesRepository.fetchTopRatedMovies()
                liveData.postValue(Resultado.Success(result))
            } catch (e: Exception){
                liveData.postValue(Resultado.Error(e))
            }

        }
        return liveData
    }

    fun fetchUpcomingMovies(): LiveData<Resultado<List<Movie>>> {
        val liveData = MutableLiveData<Resultado<List<Movie>>>()

        liveData.postValue(Resultado.Loading)

        viewModelScope.launch(Dispatchers.IO) {
            try {
                val result = moviesRepository.fetchUpcomingMovies()
                liveData.postValue(Resultado.Success(result))
            } catch (e: Exception){
                liveData.postValue(Resultado.Error(e))
            }

        }
        return liveData
    }
}
