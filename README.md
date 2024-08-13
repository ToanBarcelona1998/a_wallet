# AWallet Application

## Overview

- This mobile application is a specific Blockchain wallet for Aura Network chain, that allows users to securely manage their cryptocurrencies. The app is built using Flutter framework and follows Uncle Bob's Clean Architecture principles, ensuring a scalable and maintainable codebase.
- See more about [Aura Network](https://docs.aura.network/)

## Features

- Create , import or create by social network
- Wallet information (Balances, NFTs)
- Manage tokens
- Transaction history
- Send transaction (Native and erc20)
- Transfer NFT
- Manage wallets
- In app browser

## Future showcase
- Staking
- Swap (Coming soon)

## Getting Started

To run the application locally on your development machine, follow these steps:

1. Clone the repository: `git clone https://github.com/ToanBarcelona1998/a_wallet.git`

2. Install dependencies: `flutter pub get`

3. Generate sub files: `dart run build_runner build --delete-conflicting-outputs` or `flutter pub run build_runner build --delete-conflicting-outputs`

4. Run the app: `flutter run`

## Technology Stack

- Flutter: A cross-platform framework for building mobile applications.

- Clean Architecture: A software design pattern that separates concerns and enforces separation of concerns.

- Trust Wallet Core : Trust Wallet Core is an open-source, cross-platform, mobile-focused library implementing low-level cryptographic wallet functionality for a high number of blockchains. It is a core part of the popular [Trust Wallet](https://trustwallet.com/), and some other projects. Most of the code is C++ with a set of strict C interfaces, and idiomatic interfaces for supported languages: Swift for iOS and Java (Kotlin) for Android.

- Web3 dart : A dart library that connects to interact with the Ethereum blockchain. It connects to an Ethereum node to send transactions, interact with smart contracts and much more! [Web3 dart](https://pub.dev/packages/web3dart)
  

## License

This project is licensed under the [MIT License](./LICENSE). Feel free to customize and modify the project according to your needs.
