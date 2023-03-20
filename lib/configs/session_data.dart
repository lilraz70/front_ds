import 'package:get_storage/get_storage.dart';

class SessionData {

  static GetStorage box = GetStorage();

  static bool isFirstLaunch() {
    bool status = box.read('firstLaunch') ?? false;
    // log("GetLaunchStatus ==> $status");
    return status;
  }

  static setLaunchStatus(bool status) {
    box.write('firstLaunch', status);
    // log("SetLaunchStatus ==> ${box.read('firstLaunch')}");
  }

  static bool isLoggedIn() {
    bool status = box.read('isLoggedIn') ?? false;
   // log("GetLoggedInStatus ==> $status");
    return status;
  }

  static setLoggedInStatus(bool status) {
    box.write('isLoggedIn', status);
  }
  static saveToken(data) {return box.write("token", data);}
  static getToken() {return box.read("token");}
  static saveUser(Map user) {return box.write("user", user);}
  static Map getUser() {return box.read("user");}

  static saveSousGroupe(Map sousGroupe) {return box.write("sousGroupe", sousGroupe);}
  static Map getSousGroupe() {return box.read("sousGroupe");}

  static saveGroupe(Map groupe) {return box.write("groupe", groupe);}
  static Map getGroupe() {return box.read("groupe");}


  static deleteAll() {
    box.remove("token");
    box.remove("user");
    box.remove("firstLaunch");
    box.remove("isLoggedIn");
    box.remove("Sousgroupe");
    box.remove("groupe");
    box.remove('cart');
  }


}