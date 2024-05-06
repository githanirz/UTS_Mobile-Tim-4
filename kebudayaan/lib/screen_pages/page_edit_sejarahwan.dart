import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:kebudayaan/main.dart';
import 'package:kebudayaan/model/model_sejarahwan.dart';
import 'package:kebudayaan/model/model_update_sejarahwan.dart';
import 'package:kebudayaan/utils/ip.dart';

class PageUpdateSejarahwan extends StatefulWidget {
  final Datum? data;
  PageUpdateSejarahwan({this.data, Key? key}) : super(key: key);

  @override
  State<PageUpdateSejarahwan> createState() => _PageUpdateSejarahwanState();
}

class _PageUpdateSejarahwanState extends State<PageUpdateSejarahwan> {
  TextEditingController upNamasejarah = TextEditingController();
  TextEditingController upFotosejarah = TextEditingController();
  DateTime? selectedDate; // Tambahkan variabel untuk menyimpan tanggal lahir
  TextEditingController upAsal = TextEditingController();
  TextEditingController upJeniskelamin = TextEditingController();
  TextEditingController upDeskripsi = TextEditingController();
  GlobalKey<FormState> keyForm = GlobalKey<FormState>();
  bool isLoading = false;
  String? id;

  Future<ModelSejarahwan?> editSejarahwan() async {
    try {
      setState(() {
        isLoading = true;
        print(id);
      });
      http.Response res = await http
          .post(Uri.parse('$ip/db_uts_mobile/updateSejarahwan.php'), body: {
        "id": id,
        "nama_sejarah": upNamasejarah.text,
        "foto_sejarah": upFotosejarah.text,
        "tanggal_lahir": selectedDate.toString(), // Gunakan nilai selectedDate
        "asal": upAsal.text,
        "jenis_kelamin": upJeniskelamin.text,
        "deskripsi": upDeskripsi.text,
      });
      var jsonResponse = json.decode(res.body);
      ModelUpdateSejarahwan data = ModelUpdateSejarahwan.fromJson(jsonResponse);
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
    super.initState();
    id = widget.data?.id;
    upNamasejarah = TextEditingController(text: widget.data?.namaSejarah);
    upFotosejarah = TextEditingController(text: widget.data?.fotoSejarah);
    upAsal = TextEditingController(text: widget.data?.asal);
    upJeniskelamin = TextEditingController(text: widget.data?.jenisKelamin);
    upDeskripsi = TextEditingController(text: widget.data?.deskripsi);
    selectedDate = widget.data?.tanggalLahir;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Sejarahwan",
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
                  controller: upNamasejarah,
                  validator: (val) {
                    return val!.isEmpty ? "tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                      labelText: "Nama Sejarahwan",
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
                  controller: upFotosejarah,
                  validator: (val) {
                    return val!.isEmpty ? "tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                      labelText: "Foto Sejarahwan",
                      hintText: "Foto Sejarahwan",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue)),
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
                      initialDate: selectedDate ?? DateTime.now(),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );
                    if (pickedDate != null && pickedDate != selectedDate) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: TextEditingController(
                          text: selectedDate != null
                              ? DateFormat('yyyy-MM-dd').format(selectedDate!)
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
                  controller: upAsal,
                  validator: (val) {
                    return val!.isEmpty ? "tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                      labelText: "Asal",
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
                  controller: upJeniskelamin,
                  validator: (val) {
                    return val!.isEmpty ? "tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                      labelText: "Jenis Kelamin",
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
                  controller: upDeskripsi,
                  validator: (val) {
                    return val!.isEmpty ? "tidak boleh kosong" : null;
                  },
                  decoration: InputDecoration(
                      labelText: "Deskripsi",
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
                              editSejarahwan();
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
            ),
          ),
        ),
      ),
    );
  }
}
