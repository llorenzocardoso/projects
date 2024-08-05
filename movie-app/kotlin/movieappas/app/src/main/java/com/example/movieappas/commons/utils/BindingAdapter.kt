package com.example.movieappas.commons.utils

import android.widget.ImageView
import androidx.databinding.BindingAdapter
import com.bumptech.glide.Glide

object BindingAdapter {
    private const val BASE_URL = "https://image.tmdb.org/t/p/w500"

    @BindingAdapter("loadImage")
    @JvmStatic
    fun ImageView.loadImage(posterPath: String?) {
        posterPath?.let {
            val url = BASE_URL + it
            Glide.with(this.context)
                .load(url)
                .into(this)
        }
    }
}
