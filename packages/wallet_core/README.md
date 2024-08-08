# Android
Add 
```
class MainActivity: FlutterActivity() {
    init {
        System.loadLibrary("TrustWalletCore")
    }
}
 ```
in your android project MainActivity.kt file

minSdk require >=23

# iOS

min ios platform support >=13.0


# dart part
before use wallet_core, call below function once.
```
 WalletCore.init();
```

Then you are ready to run.
