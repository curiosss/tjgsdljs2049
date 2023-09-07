class KError {
  final String message;
  KError(this.message);
}

class NoInternet extends KError {
  NoInternet({String? message})
      : super(message ?? 'The application requires access to the network');
}

class ServerError extends KError {
  dynamic err;
  ServerError({
    String? message,
    this.err,
  }) : super(message ?? '');
}
