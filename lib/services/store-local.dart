import 'package:simple_flutter_auth_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StoreLocal {
    Future<void> storeUserLocal(User user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storeUser = userToJson(user);
    await prefs.setString('user', storeUser);
  }

  Future<User> getUserLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //print("I am here" + (prefs.getString('user')).toString()  );
    if (prefs.getString('user') != null) {
      User user = userFromJson(prefs.getString('user'));
      //print('USER: $user');
      return user;
    } else {
      return null;
    }
  }

  Future<void> deleteUserLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      prefs.remove('user');
    } 
  }

}