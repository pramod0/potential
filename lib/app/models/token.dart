class Token {
  late String token;
  static final Token _instance = Token._internal();

  factory Token(String s) {
    _instance.token = s;
    return _instance;
  }

  Token._internal();

  static Token get instance => _instance;
}
