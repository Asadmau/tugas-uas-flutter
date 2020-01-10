import 'package:flutter/material.dart';
import 'package:uasflutter/service.dart';

//coba gambar

import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';

File image;
String filename;

class AddData extends StatefulWidget {
  final VoidCallback reload;
  AddData(this.reload);

  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController txtJudul = TextEditingController();
  TextEditingController txtAuthor = TextEditingController();
  TextEditingController txtHarga = TextEditingController();
  TextEditingController txtDescripsi = TextEditingController();
  // String jenisKelamin;

  //coba gambar

  bool loading = false;

  _getImage() async {
    File selectimage = await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = selectimage;
      filename = basename(image.path);
    });
  }

  AddShop() async {
    setState(() {
      loading = true;
    });

    StorageReference ref = FirebaseStorage.instance.ref().child(filename);
    StorageUploadTask uploadTask = ref.putFile(image);

    var downUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    var url = downUrl.toString();
    print("Download Url : $url");

    Map<String, dynamic> data = {
      "judul": txtJudul.text,
      "author": txtAuthor.text,
      "harga": txtHarga.text,
      "descripsi": txtDescripsi.text,
      // "jk": jenisKelamin,
      "img": url
    };

    String hasil = await ServiceData.service.TambahData(data);

    setState(() {
      widget.reload();
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Data Siswa'),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              child: ListView(
                padding: EdgeInsets.all(5.0),
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(labelText: "Judul"),
                    controller: txtJudul,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Author"),
                    controller: txtAuthor,
                  ),
                  TextFormField(
                    decoration: InputDecoration(labelText: "Harga"),
                    controller: txtHarga,
                  ),
                 
                  TextFormField(
                    maxLines: 7,
                    decoration: InputDecoration(labelText: "Descripsi"),
                    controller: txtDescripsi,
                  ),
                  // DropdownButton(
                  //   hint: Text("Pilih Jenis Kelamin"),
                  //   items: [
                  //     DropdownMenuItem(
                  //       child: Text("Laki- Laki"),
                  //       value: "Laki - Laki",
                  //     ),
                  //     DropdownMenuItem(
                  //       child: Text("Perempuan"),
                  //       value: "Perempuan",
                  //     ),
                  //   ],
                  //   value: jenisKelamin,
                  //   onChanged: (selected) {
                  //     setState(() {
                  //       jenisKelamin = selected;
                  //     });
                  //   },
                  // ),
                  //coba gambar

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: image == null
                              ? Text('selected image')
                              : Image.file(image, width: double.infinity),
                        ),
                        // Image.file(image, width: double.infinity),
                        OutlineButton(
                          color: Colors.yellowAccent,
                          textColor: Colors.blue,
                          child: Text('upload'),
                          onPressed: () {
                            _getImage();
                            // uploadImage();
                          },
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      OutlineButton(
                        child: Text("Simpan"),
                        color: Colors.teal,
                        textColor: Colors.teal,
                        onPressed: () {
                          AddShop();
                        },
                      ),
                      OutlineButton(
                        child: Text("Batal"),
                        color: Colors.red,
                        textColor: Colors.red,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}

Widget uploadArea() {
  return Column(
    children: <Widget>[
      Image.file(image, width: double.infinity),
      RaisedButton(
        color: Colors.yellowAccent,
        child: Text('upload'),
        onPressed: () {
          // uploadImage();
        },
      )
    ],
  );
}
