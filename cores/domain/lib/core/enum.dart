enum TokenType{
  native,
  erc20,
}

enum AppNetworkType implements Comparable<AppNetworkType> {
  evm(type: 'evm'),
  other(type: 'other');

  const AppNetworkType({
    required this.type,
  });

  final String type;

  @override
  int compareTo(AppNetworkType other) => type.length - other.type.length;
}

enum AccountCreateType {
  normal,
  social,
  import,
}

enum AccountType {
  normal,
  abstraction,
}

enum ControllerKeyType {
  passPhrase,
  privateKey,
}

enum Web3AuthLoginProvider {
  google,
  facebook,
  reddit,
  discord,
  twitch,
  github,
  apple,
  linkedin,
  twitter,
  line,
  kakao,
  email_passwordless,
  jwt,
  sms_passwordless,
  farcaster,
}
