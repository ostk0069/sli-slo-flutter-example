extension GenericExt<T> on T {
  R let<R>(R Function(T v) transform) => transform(this);

  T? takeIf(bool Function(T v) predicate) {
    return predicate(this) ? this : null;
  }

  R? safeCast<R>() => this is R ? (this as R) : null;
}
