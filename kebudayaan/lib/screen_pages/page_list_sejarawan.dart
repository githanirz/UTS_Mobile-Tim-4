import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:kebudayaan/model/model_dlt_sejarahwan.dart';
import 'package:kebudayaan/model/model_sejarahwan.dart';
import 'package:kebudayaan/screen_pages/page_detail_sejarahwan.dart';
import 'package:kebudayaan/screen_pages/page_edit_sejarahwan.dart';
import 'package:kebudayaan/screen_pages/page_insert_sejarahwan.dart';
import 'package:kebudayaan/utils/ip.dart';

class PageListSejarahwan extends StatefulWidget {
  final Datum? data;
  const PageListSejarahwan({this.data, super.key});

  @override
  State<PageListSejarahwan> createState() => _PageListSejarahwanState();
}

class _PageListSejarahwanState extends State<PageListSejarahwan> {
  TextEditingController txtsearch = TextEditingController();
  bool isSearch = false;
  bool isLoading = false;
  late List<Datum> _getSejarahwan = [];
  late List<Datum> _searchResult = [];

  @override
  void initState() {
    // TODO: implement initState
    getSejarahwan();
    super.initState();
  }

  Future<void> getSejarahwan() async {
    try {
      setState(() {
        isLoading = true;
      });
      http.Response res =
          await http.get(Uri.parse('$ip/db_uts_mobile/listSejarahwan.php'));
      if (res.statusCode == 200) {
        // Parsing respon dari JSON ke objek ModelListMahasiswa
        ModelSejarahwan data = modelSejarahwanFromJson(res.body);

        setState(() {
          _getSejarahwan = data.data ?? [];
          _searchResult = _getSejarahwan;
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      print(e);
    }
  }

  Future<void> deleteSejarahwan(int id) async {
    // var iduser = id;
    try {
      setState(() {
        isLoading = false;
      });
      http.Response res = await http.post(
          Uri.parse('$ip/db_uts_mobile/deleteSejarahwan.php'),
          body: {"id": id.toString()});
      if (res.statusCode == 200) {
        // Parsing respon dari JSON ke objek ModelDeleteMahasiswa
        ModelDltSejarahwan data = modelDltSejarahwanFromJson(res.body);

        if (data.status == "success") {
          setState(() {
            // Hapus Mahasiswa dari _searchResult berdasarkan ID
            _searchResult
                .removeWhere((Sejarahwan) => Sejarahwan.id == id.toString());
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${data.message}')),
            );
          });

          // Panggil kembali _filterBerita untuk memperbarui tampilan berdasarkan pencarian yang saat ini ada
          _filterSejarahwan(txtsearch.text);
          setState(() {
            getSejarahwan();
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('${data.message}')),
          );
          print(data.message);
        }
      } else {
        // Menampilkan pesan kesalahan jika permintaan tidak berhasil
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menghapus Sejarahwan')),
        );
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
      print(e);
    }
  }

  void _filterSejarahwan(String query) {
    List<Datum> filteredSejarah = _getSejarahwan
        .where((sejarahwan) =>
            sejarahwan.namaSejarah!.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      _searchResult = filteredSejarah;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        backgroundColor: Colors.blue.shade300,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PageInsertSejarahwan()));
        },
        tooltip: "tambah Sejarahwan",
        child: Icon(
          Icons.add,
          size: 25,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    width: 480,
                    height: 220,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF3957ED),
                          Color.fromARGB(255, 112, 181, 238)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20, left: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Text "Mulai Belajar"
                              Text(
                                'Welcome, \nmany Sejarahwan \nfrom Indonesian!',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              // Spacer untuk memberikan jarak antara teks dan gambar
                              SizedBox(width: 20),
                              // Gambar
                              Image.asset(
                                'gambar/p1.png', // Sesuaikan dengan path gambar Anda
                                width: 120, // Sesuaikan lebar gambar
                                height: 120, // Sesuaikan tinggi gambar
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: TextFormField(
                              onChanged: _filterSejarahwan,
                              controller: txtsearch,
                              decoration: InputDecoration(
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Icon(Icons.search),
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide.none),
                                fillColor: Colors.white,
                                filled: true,
                                hintText: "Search...",
                                hintStyle:
                                    TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'List Sejarahwan',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _searchResult.length,
                    itemBuilder: (context, index) {
                      Datum data = _searchResult[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PageDetailSejarahwan(data),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 2),
                          child: Card(
                            child: ListTile(
                              minLeadingWidth: 15,
                              leading: CircleAvatar(
                                radius:
                                    25, // Atur radius lingkaran sesuai kebutuhan
                                backgroundColor: Colors.blue.shade200,
                                child: ClipOval(
                                  // Gunakan ClipOval untuk membuat gambar memiliki radius circular
                                  child: Image.network(
                                    data!.fotoSejarah,
                                    width: 100, // atur lebar gambar
                                    height: 100, // atur tinggi gambar
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    tooltip: "hapus data",
                                    onPressed: () {
                                      String idToDelete =
                                          _searchResult[index].id;
                                      // Periksa apakah idToDelete merupakan angka
                                      if (int.tryParse(idToDelete) != null) {
                                        // Jika idToDelete dapat diubah menjadi int, panggil deleteMahasiswa
                                        deleteSejarahwan(int.parse(idToDelete));
                                      } else {
                                        // Jika idToDelete tidak dapat diubah menjadi int, tampilkan pesan kesalahan
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                              content: Text('ID tidak valid')),
                                        );
                                      }
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 20,
                                    ),
                                  ),
                                  IconButton(
                                    tooltip: "edit data",
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PageUpdateSejarahwan(
                                                    data: data,
                                                  )));
                                    },
                                    icon: Icon(
                                      Icons.edit,
                                      color: Colors.blue.shade800,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              title: Text(
                                "${data.namaSejarah}",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                              subtitle: Text(
                                "Lihat Detail",
                                style: TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
