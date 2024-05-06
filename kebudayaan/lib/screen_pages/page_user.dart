import 'package:flutter/material.dart';
import 'package:kebudayaan/screen_pages/page_edit_user.dart';
import 'package:kebudayaan/screen_pages/page_login.dart';
import 'package:kebudayaan/utils/cek_session.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PageUser extends StatefulWidget {
  const PageUser({Key? key}) : super(key: key);

  @override
  State<PageUser> createState() => _PageUserState();
}

class _PageUserState extends State<PageUser> {
  String? id_user, username, nama, nohp, email;

  @override
  void initState() {
    super.initState();
    getSession();
  }

  @override
  void didUpdateWidget(PageUser oldWidget) {
    super.didUpdateWidget(oldWidget);
    getSession();
  }

  Future<void> getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id_user = pref.getString("id_user");
      username = pref.getString("username");
      nama = pref.getString("nama");
      nohp = pref.getString("nohp");
      email = pref.getString("email");
      print(id_user);
      print(username);
      print(nama);
      print(nohp);
      print(email);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
              ),
              Text(
                'PROFILE',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40,),
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(
                    'gambar/pulu.png'), // Ganti dengan gambar avatar pengguna
              ),
              SizedBox(height: 20),
              Text(
                '$username', //$username
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                '$email',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PageEditProfile()),
                      );
                      if (result != null) {
                        if (result['newUsername'] != null) {
                          // Data username berhasil diupdate, perbarui data profil
                          session.updateUsername(result['newUsername']);
                          getSession(); // Perbarui data profil di halaman ProfilScreen
                        }

                        if (result['newEmail'] != null) {
                          // Data email berhasil diupdate, perbarui data profil
                          session.updateEmail(result['newEmail']);
                          getSession(); // Perbarui data profil di halaman ProfilScreen
                        }
                      }
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: Text(
                      'Edit Profile',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        session.clearSession();
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PageLogin()),
                            (route) => false);
                      });
                    },
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text(
                      'Logout',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
