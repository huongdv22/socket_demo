bool isBlank(obj) {
  if (obj == null) {
    return true;
  } else if(obj.runtimeType == String && obj == '') {
    return true;
  }
  return false;
}

bool isNotBlank(obj) {
  return !isBlank(obj);
}

extension NullStringExtension<T> on String? {
  /// Will return if the string is null or empty
  bool get isNullOrEmpty => this == null || this?.isEmpty == true;

  /// Will return if the string is not null and not empty
  bool get isNotNullOrEmpty => !isNullOrEmpty;
}

