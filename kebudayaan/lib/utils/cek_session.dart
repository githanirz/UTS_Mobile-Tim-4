import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  int? value;
  String? id_user, userName, newNama, newNohp, newEmail;

  Future<void> saveSession(int val, String id_user, String userName,
      String nama, String nohp, String email) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setInt("value", val);
    pref.setString("id_user", id_user);
    pref.setString("username", userName);
    pref.setString("nama", nama);
    pref.setString("nohp", nohp);
    pref.setString("email", email);
  }

  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getInt("value");
    pref.getString("id_user");
    pref.getString("username");
    pref.getString("nama");
    pref.getString("nohp");
    pref.getString("email");
    return value;
  }

  Future getSesiIdUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getString("id_user");
    return id_user;
  }

  Future<void> updateUsername(
    String newUsername,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("username", newUsername);
  }

  Future<void> updateNama(
    String newNama,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("nama", newNama);
  }

  Future<void> updateNohp(
    String newNohp,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("nohp", newNohp);
  }

  Future<void> updateEmail(
    String newEmail,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("email", newEmail);
  }

  //clear session --> logout
  Future clearSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}

SessionManager session = SessionManager();
