Map<int, String> daysOfWeek = {
  1 : "Lundi",
  2 : "Mardi",
  3 : "Mercrédi",
  4 : "Jeudi",
  5 : "Vendrédi",
  6 : "Samedi",
  7 : "Dimanche",
};
String getMonthName(int monthNumber) {
  List<String> months = [
    "Janvier",
    "Fevrier",
    "Mars",
    "Avril",
    "May",
    "Juin",
    "Juillet",
    "Août",
    "Septembre",
    "Octobre",
    "Novembre",
    "Decembre"
  ];
  return months[monthNumber - 1];
}