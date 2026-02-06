package com.marekmusial.random_quote_app

// import io.flutter.embedding.android.FlutterActivity

// class MainActivity: FlutterActivity() {
// }
import android.os.Build
import android.os.Bundle
import android.view.View
import android.view.WindowInsets
import android.view.WindowInsetsController
import io.flutter.embedding.android.FlutterActivity
import android.util.Log
import android.graphics.Color

class MainActivity: FlutterActivity() {
    override fun onResume() {
        super.onResume()
        showSystemBars()
    }

    private fun showSystemBars() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            window.setDecorFitsSystemWindows(true)
            // API 30 and above
            window.insetsController?.show(WindowInsets.Type.systemBars())
        } else {
            // Below API 30
            @Suppress("DEPRECATION")
            window.decorView.systemUiVisibility = (
                View.SYSTEM_UI_FLAG_VISIBLE
            )
        }
    }
}