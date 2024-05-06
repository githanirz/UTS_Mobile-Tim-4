import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kebudayaan/model/model_berita.dart';
import 'package:kebudayaan/utils/ip.dart';

class PageGalleryFoto extends StatefulWidget {
  const PageGalleryFoto({Key? key}) : super(key: key);

  @override
  State<PageGalleryFoto> createState() => _PageGalleryFotoState();
}

class _PageGalleryFotoState extends State<PageGalleryFoto> {
  String? id, username;

  @override
  void initState() {
    super.initState();
    getBerita();
  }

  Future<List<Datum>?> getBerita() async {
    try {
      http.Response res =
          await http.get(Uri.parse("$ip/db_uts_mobile/listBerita.php"));
      return modelBeritaFromJson(res.body).data;
    } catch (e) {
      setState(() {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
    return null;
  }

  // Fungsi untuk menampilkan dialog pop-up dengan gambar
  Future<void> _showImageDialog(String imageUrl, Datum data) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Image.network(
            imageUrl,
            fit: BoxFit.cover,
          ),
          title: Text('${data?.judul}'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getBerita(),
        builder: (BuildContext context, AsyncSnapshot<List<Datum>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(color: Colors.blue),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text("No data available"),
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt_rounded),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Gallery Photo",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue.shade400,
                            ),
                          ),
                        ],
                      ),
                    )),
                Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Jumlah kolom
                      crossAxisSpacing: 10, // Jarak antar kolom
                      mainAxisSpacing: 10, // Jarak antar baris
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Datum data = snapshot.data![index];
                      return GestureDetector(
                        onTap: () {
                          _showImageDialog(
                              "$ip/db_uts_mobile/gambar/${data.gambar}", data);
                          // _showImageDialog(imageUrl, data)
                        },
                        child: Card(
                          color: Colors.blue.shade100,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(20),
                                  child: ClipRRect(
                                    // borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      "$ip/db_uts_mobile/gambar/${data.gambar}",
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
