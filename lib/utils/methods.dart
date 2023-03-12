
import 'package:shared_preferences/shared_preferences.dart';

class Methods {


    static  Future<String> getToken() async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        return preferences.getString('token') ?? '';
      }

      static  Future<String> getUserName() async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        return preferences.getString('username') ?? '';
      }

      static  Future<String> getUserAccess() async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        return preferences.getString('user_access') ?? '';
      }

      static  Future<int> getUserID() async{
        SharedPreferences preferences = await SharedPreferences.getInstance();
        return preferences.getInt('id') ?? 0;
      }


}
