package com.example.dna

import android.content.Context
import android.widget.Toast

class MyToast {
    fun showToast(context : Context,text: String?) : Boolean? {
        Toast.makeText(context, text, Toast.LENGTH_SHORT).show();
        return false;
    }
}