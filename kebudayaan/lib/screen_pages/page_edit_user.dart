import 'package:flutter/material.dart';
import 'package:kebudayaan/main.dart';
import 'package:kebudayaan/model/model_edit_user.dart';
import 'package:kebudayaan/utils/ip.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class PageEditProfile extends StatefulWidget {
  const PageEditProfile({Key? key}) : super(key: key);

  @override
  State<PageEditProfile> createState() => _PageEditProfileState();
}

class _PageEditProfileState extends State<PageEditProfile> {
  TextEditingController txtUsername = TextEditingController();
  TextEditingController txtNama = TextEditingController();
  TextEditingController txtNohp = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;
  String? id_user, username, nama, nohp, email;

  @override
  void initState() {
    super.initState();
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
      txtUsername.text = username ?? '';
      txtNama.text = nama ?? '';
      txtNohp.text = nohp ?? '';
      txtEmail.text = email ?? '';
    });
  }

  Future<void> updateProfile(String newUsername, String newNama, String newNohp,
      String newEmail) async {
    try {
      setState(() {
        isLoading = true;
      });

      final response = await http.post(
        Uri.parse('$ip/db_uts_mobile/updateUser.php'),
        body: {
          "id_user": id_user!,
          "username": newUsername,
          "nama": newNama,
          "nohp": newNohp,
          "email": newEmail,
        },
      );

      ModelEditUser data = modelEditUserFromJson(response.body);

      if (data.isSuccess == true) {
        // Perbarui nilai controller dan tampilkan pesan sukses
        txtUsername.text = newUsername;
        txtNama.text = newNama;
        txtNohp.text = newNohp;
        txtEmail.text = newEmail;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${data.message}'),
        ));

        // Perbarui nilai SharedPreferences dengan data yang baru
        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString("username", newUsername);
        pref.setString("nama", newNama);
        pref.setString("nohp", newNohp);
        pref.setString("email", newEmail);

        // Navigasi kembali ke halaman profil
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
            (route) => false);
      } else if (data.isSuccess == false) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${data.message}'),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Form(
            key: keyForm,
            child: Column(
              children: [
                Text(
                  'Edit Profile',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
                TextFormField(
                  controller: txtUsername,
                  validator: (val) {
                    return val!.isEmpty ? "Tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                    labelText: "Username",
                    hintText: "Masukkan username baru",
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Colors.blue.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: txtNama,
                  validator: (val) {
                    return val!.isEmpty ? "Tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                    labelText: "Nama",
                    hintText: "Masukkan username baru",
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Colors.blue.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: txtNohp,
                  validator: (val) {
                    return val!.isEmpty ? "Tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                    labelText: "No. HP",
                    hintText: "Masukkan nomor telepon baru",
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Colors.blue.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: txtEmail,
                  validator: (val) {
                    return val!.isEmpty ? "Tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Masukkan email baru",
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 1, color: Colors.blue.shade300),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Container(
                  width: 500,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: MaterialButton(
                    onPressed: () {
                      if (keyForm.currentState?.validate() == true) {
                        final newUsername = txtUsername.text.trim();
                        final newNama = txtNama.text.trim();
                        final newNohp = txtNohp.text.trim();
                        final newEmail = txtEmail.text.trim();
                        updateProfile(newUsername, newNama, newNohp, newEmail);
                      } else {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Silakan isi data terlebih dahulu"),
                        ));
                      }
                    },
                    child: const Text(
                      "UPDATE",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Color(0xffFFFFFF),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
