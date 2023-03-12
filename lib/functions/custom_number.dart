
String customNumber(int id) {

  String a = id.toString();

  if(id < 10) {
    return "000$a";
  } else if(id < 100) {
    return "00$a";
  } else if(id < 1000) {
    return "0$a";
  } else {
    return a;
  }

}