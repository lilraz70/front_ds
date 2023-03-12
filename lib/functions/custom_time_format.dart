String customTimeFormat(date) {
  return "${DateTime.parse(date).hour}:${DateTime.parse(date).minute}";
}