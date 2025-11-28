/// Simple helper demonstrating how shared utilities can live in this package.
String ellipsize(String value, {int maxLength = 40}) {
  if (value.length <= maxLength) {
    return value;
  }
  return '${value.substring(0, maxLength)}…';
}
