import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:kebudayaan/main.dart';
import 'package:kebudayaan/model/model_insert_sejarahwan.dart';
import 'package:kebudayaan/utils/ip.dart';

class PageInsertSejarahwan extends StatefulWidget {
  const PageInsertSejarahwan({super.key});

  @override
  State<PageInsertSejarahwan> createState() => _PageInsertSejarahwanState();
}

class _PageInsertSejarahwanState extends State<PageInsertSejarahwan> {
  TextEditingController namaSejarah = TextEditingController();
  TextEditingController fotoSejarah = TextEditingController();
  DateTime? tanggalLahir;
  TextEditingController asal = TextEditingController();
  TextEditingController jenisKelamin = TextEditingController();
  TextEditingController deskripsi = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;

  Future<ModelInsertSejarahwan?> insertSejarahwan() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res = await http
          .post(Uri.parse('$ip/db_uts_mobile/insertSejarahwan.php'), body: {
        "nama_sejarah": namaSejarah.text,
        "foto_sejarah": fotoSejarah.text,
        "tanggal_lahir": tanggalLahir.toString(),
        "asal": asal.text,
        "jenis_kelamin": jenisKelamin.text,
        "deskripsi": deskripsi.text,
      });
      ModelInsertSejarahwan data = modelInsertSejarahwanFromJson(res.body);
      if (data.isSuccess == true) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
        });

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => MyHomePage()),
            (route) => false);
      } else if (data.isSuccess == false) {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
        });
      } else {
        setState(() {
          isLoading = false;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('${data.message}')));
        });
      }
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambah Sejarahwan",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Form(
              key: keyForm,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: namaSejarah,
                    validator: (val) {
                      return val!.isEmpty ? "tidak boleh kosong" : null;
                    },
                    decoration: InputDecoration(
                        hintText: "Nama Sejarahwan",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blue)),
                        filled: true,
                        fillColor: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: fotoSejarah,
                    validator: (val) {
                      return val!.isEmpty ? "tidak boleh kosong" : null;
                    },
                    decoration: InputDecoration(
                        hintText: "Foto Sejarhawan",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.amber)),
                        filled: true,
                        fillColor: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: tanggalLahir ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null && pickedDate != tanggalLahir) {
                      setState(() {
                        tanggalLahir = pickedDate;
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: TextEditingController(
                          text: tanggalLahir != null
                              ? DateFormat('yyyy-MM-dd').format(tanggalLahir!)
                              : ""),
                      decoration: InputDecoration(
                        labelText: "Tanggal Lahir",
                        hintText: "Pilih Tanggal",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: asal,
                    validator: (val) {
                      return val!.isEmpty ? "tidak boleh kosong" : null;
                    },
                    decoration: InputDecoration(
                        hintText: "Asal",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blue)),
                        filled: true,
                        fillColor: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: jenisKelamin,
                    validator: (val) {
                      return val!.isEmpty ? "tidak boleh kosong" : null;
                    },
                    decoration: InputDecoration(
                        hintText: "Jenis Kelamin",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blue)),
                        filled: true,
                        fillColor: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: deskripsi,
                    validator: (val) {
                      return val!.isEmpty ? "tidak boleh kosong" : null;
                    },
                    decoration: InputDecoration(
                        hintText: "Deskripsi",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.blue)),
                        filled: true,
                        fillColor: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  isLoading
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: double.infinity,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () {
                              if (keyForm.currentState!.validate()) {
                                insertSejarahwan();
                              }
                            },
                            color: Colors.blue,
                            textColor: Colors.white,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "submit",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          ),
                        )
                ],
              )),
        ),
      ),
    );
  }
}
