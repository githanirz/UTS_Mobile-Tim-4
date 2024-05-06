import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kebudayaan/screen_pages/page_detail_berita.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:uts_mobile_rpl/screen_pages/page_detail_berita.dart';
import 'package:kebudayaan/screen_pages/page_login.dart';
import 'package:kebudayaan/utils/cek_session.dart';
import 'package:kebudayaan/utils/ip.dart';

import 'package:kebudayaan/model/model_berita.dart';

class PageListBerita extends StatefulWidget {
  const PageListBerita({super.key});

  @override
  State<PageListBerita> createState() => _PageListBeritaState();
}

class _PageListBeritaState extends State<PageListBerita> {
  String? id, username;
  List<Datum>? _listBerita;
  List<Datum>? _searchResult;

  // Fungsi untuk mendapatkan daftar berita
  Future<List<Datum>?> getBerita() async {
    try {
      http.Response res =
          await http.get(Uri.parse('$ip/db_uts_mobile/listBerita.php'));
      _listBerita = modelBeritaFromJson(res.body).data;
      return _listBerita;
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getSession();
  }

  Future getSession() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      id = pref.getString("id") ?? '';
      username = pref.getString("username") ?? '';
      print('id $id');
    });
  }

  void _searchBerita(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResult = null;
      });
      return;
    }

    setState(() {
      _searchResult = _listBerita
          ?.where((berita) =>
              berita.judul.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'gambar/p2.png', // Sesuaikan dengan path gambar Anda
                          width: 120, // Sesuaikan lebar gambar
                          height: 120, // Sesuaikan tinggi gambar
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Welcome, \nmany popular ones for you!',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    decoration: InputDecoration(
                      hintText: 'Search ...',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onChanged:
                        _searchBerita, // Memanggil fungsi pencarian saat nilai berubah
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            FutureBuilder(
              future: getBerita(),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
                // Jika snapshot memiliki data
                if (snapshot.hasData) {
                  // Jika hasil pencarian tidak kosong, tampilkan hasil pencarian
                  if (_searchResult != null && _searchResult!.isNotEmpty) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: _searchResult?.length,
                        itemBuilder: (context, index) {
                          Datum? data = _searchResult?[index];
                          return buildBeritaCard(data);
                        },
                      ),
                    );
                  } else {
                    // Jika hasil pencarian kosong atau tidak ada, tampilkan semua berita
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          Datum? data = snapshot.data?[index];
                          return buildBeritaCard(data);
                        },
                      ),
                    );
                  }
                } else if (snapshot.hasError) {
                  // Jika terjadi error
                  return Center(
                    child: Text(snapshot.error.toString()),
                  );
                } else {
                  // Jika tidak ada data
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk membangun tampilan kartu berita
  Widget buildBeritaCard(Datum? data) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PageDetailBerita(data),
            ),
          );
        },
        child: Card(
          color: Colors.blue.shade100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    '$ip/db_uts_mobile/gambar/${data?.gambar}',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10),
                    ListTile(
                      title: Text(
                        '${data?.judul}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        '${data?.konten}',
                        maxLines: 2,
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
