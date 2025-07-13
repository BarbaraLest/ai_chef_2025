enum ViewStateEnum {
  idle,
  loading,
  success,
  error;

  bool get isLoading => this == loading;
  bool get isIdle => this == idle;
  bool get isSuccess => this == success;
  bool get isError => this == error;
}
