package com.example.movieappas

import android.os.Bundle
import android.view.View
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.recyclerview.widget.LinearLayoutManager
import com.example.movieappas.commons.Resultado
import com.example.movieappas.databinding.ActivityMainBinding
import com.example.movieappas.ui.MoviesViewModel
import com.example.movieappas.ui.adapters.MovieAdapter
import dagger.hilt.android.AndroidEntryPoint

@AndroidEntryPoint
class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding
    private lateinit var trendingMoviesAdapter: MovieAdapter
    private lateinit var topRatedMoviesAdapter: MovieAdapter
    private lateinit var upcomingMoviesAdapter: MovieAdapter
    private val moviesViewModel: MoviesViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        configureRecyclers()
        observeMovies()
    }

    private fun configureRecyclers() {
        trendingMoviesAdapter = MovieAdapter()
        topRatedMoviesAdapter = MovieAdapter()
        upcomingMoviesAdapter = MovieAdapter()

        binding.trendingMoviesRecyclerView.apply {
            layoutManager = LinearLayoutManager(context, LinearLayoutManager.HORIZONTAL, false)
            adapter = trendingMoviesAdapter
        }

        binding.topRatedMoviesRecyclerView.apply {
            layoutManager = LinearLayoutManager(context, LinearLayoutManager.HORIZONTAL, false)
            adapter = topRatedMoviesAdapter
        }

        binding.upcomingMoviesRecyclerView.apply {
            layoutManager = LinearLayoutManager(context, LinearLayoutManager.HORIZONTAL, false)
            adapter = upcomingMoviesAdapter
        }
    }

    private fun observeMovies() {

        moviesViewModel.fetchTrendingMovies().observe(this) { trendingMovies ->

            when(trendingMovies){
                is Resultado.Loading -> {
                    binding.progressBar.visibility = View.VISIBLE
                }

                is Resultado.Success -> {
                    binding.progressBar.visibility = View.GONE
                    trendingMoviesAdapter.setUpMovies(trendingMovies.data)
                }

                is Resultado.Error -> {
                    binding.progressBar.visibility = View.GONE
                }
            }
        }

        moviesViewModel.fetchTopRatedMovies().observe(this) { topRatedMovies ->

            when(topRatedMovies){
                is Resultado.Loading -> {
                    binding.progressBar.visibility = View.VISIBLE
                }

                is Resultado.Success -> {
                    binding.progressBar.visibility = View.GONE
                    topRatedMoviesAdapter.setUpMovies(topRatedMovies.data)
                }

                is Resultado.Error -> {
                    binding.progressBar.visibility = View.GONE
                }
            }
        }

        moviesViewModel.fetchUpcomingMovies().observe(this) { upcomingMovies ->

            when(upcomingMovies){
                is Resultado.Loading -> {
                    binding.progressBar.visibility = View.VISIBLE
                }

                is Resultado.Success -> {
                    binding.progressBar.visibility = View.GONE
                    upcomingMoviesAdapter.setUpMovies(upcomingMovies.data)
                }

                is Resultado.Error -> {
                    binding.progressBar.visibility = View.GONE
                }
            }
        }
    }
}
