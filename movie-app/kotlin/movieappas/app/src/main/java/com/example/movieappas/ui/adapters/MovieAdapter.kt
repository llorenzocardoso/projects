package com.example.movieappas.ui.adapters

import android.content.Context
import android.view.LayoutInflater
import android.view.ViewGroup
import androidx.recyclerview.widget.RecyclerView
import com.example.movieappas.data.Movie
import com.example.movieappas.databinding.MovieItemBinding

class MovieAdapter : RecyclerView.Adapter<MovieAdapter.ViewHolder>(){

    private lateinit var context: Context
    private var listMovies : List<Movie> = emptyList()
    private lateinit var binding: MovieItemBinding

    fun setUpMovies(movies : List<Movie>){
        this.listMovies = movies
        notifyDataSetChanged()
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        context = parent.context
        binding = MovieItemBinding.inflate(LayoutInflater.from(context), parent, false)

        return ViewHolder(binding)
    }

    override fun getItemCount(): Int = listMovies.size

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        holder.bind(listMovies[position])
        binding.executePendingBindings()
    }

    inner class ViewHolder(private val bindingHolder: MovieItemBinding) : RecyclerView.ViewHolder(bindingHolder.root) {
        fun bind(movie: Movie) {
            bindingHolder.movie = movie
        }
    }
}