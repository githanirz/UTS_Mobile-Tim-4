import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kebudayaan/model/model_sejarahwan.dart';
import 'package:kebudayaan/utils/ip.dart';

class PageDetailSejarahwan extends StatelessWidget {
  //konstruktor penampung data
  final Datum? data;
  const PageDetailSejarahwan(this.data, {Key? key}) : super(key: key);

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
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                data!.fotoSejarah,
                width: 200, // atur lebar gambar
                height: 300, // atur tinggi gambar
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: CircleAvatar(
              radius:
                  70, // Atur radius lingkaran sesuai kebutuhan untuk membuatnya lebih besar
              backgroundColor: Colors.blue.shade200,
              child: ClipOval(
                // Gunakan ClipOval untuk membuat gambar memiliki radius circular
                child: Image.network(
                  data!.fotoSejarah,
                  width: 200, // atur lebar gambar
                  height: 200, // atur tinggi gambar
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          ListTile(
            title: Center(
              child: Text(
                data?.namaSejarah ?? "",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            subtitle: Text(
              "Asal: ${data?.asal ?? ""}",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          ListTile(
            title: Text("Tanggal Lahir: ${data?.tanggalLahir ?? ""}",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
            subtitle: Text("Jenis Kelamin: ${data?.jenisKelamin ?? ""}",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.blue.shade200, // Warna latar belakang biru
                borderRadius:
                    BorderRadius.circular(10), // Sudut yang dibulatkan
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      data?.deskripsi ?? "",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
