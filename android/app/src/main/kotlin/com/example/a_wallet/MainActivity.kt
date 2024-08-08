package com.example.a_wallet

import io.flutter.embedding.android.FlutterActivity

class MainActivity: FlutterActivity(){
    init {
        System.loadLibrary("TrustWalletCore")
    }
}
