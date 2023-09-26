extension NullOr<T> on T {
  R? nullOr<R>(R? Function(T value) mapper) =>
      this == null ? null : mapper(this);
}
