// import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uasflutter/service.dart';
import 'package:path/path.dart';

// File image;
// String filename;

class EditData extends StatefulWidget {
  // final VoidCallback reload;
  final String id;
  final String judul;
  final String author;
  final String harga;
  final String descripsi;
  final String img;
  // final String tanggal;
  EditData(
      this.judul, this.harga, this.author, this.descripsi, this.img, this.id);
  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {
  TextEditingController txtJudul = TextEditingController();
  TextEditingController txtAuthor = TextEditingController();
  TextEditingController txtHarga = TextEditingController();
  TextEditingController txtDescripsi = TextEditingController();
  // String jenisKelamin;

  bool loading = false;
  Update() async {
    setState(() {
      loading = true;
    });
    Map<String, dynamic> data = {
      'judul': txtJudul.text,
      'author': txtAuthor.text,
      'harga': txtHarga.text,
      'descripsi': txtDescripsi.text,
    };
    await ServiceData.service.UpdateData(widget.id, data);
    setState(() {
      loading = false;
    });
    // ServiceData.service.UpdateData(widget.id, data).then((_){
    //   setState(() {
    //     widget.reload();
    //     loading = false;
    //   });
    //   // Navigator.pop(context);
    // });
  }
  // UbahData() {
  //   setState(() {
  //     loading = true;
  //   });
  //   Map<String, dynamic> data = {
  //     "judul": txtJudul.text,
  //     "author": txtAuthor.text,
  //     "harga": txtHarga.text,
  //     "descripsi": txtDescripsi.text,
  //     // "jk" : jenisKelamin
  //   };
  //   ServiceData.service.UpdateData(widget.id, data).then((_) {
  //     setState(() {
  //       widget.reload();
  //       loading = false;
  //     });
  //     Navigator.pop(context);
  //   });
  // }

  @override
  void initState() {
    super.initState();
    txtJudul = TextEditingController(text: widget.judul);
    txtAuthor = TextEditingController(text: widget.author);
    txtDescripsi = TextEditingController(text: widget.descripsi);
    txtHarga = TextEditingController(text: widget.harga);
    // txtAuthor = widget.author;
    // txtHarga.text = widget.harga;
    // txtDescripsi.text = widget.descripsi;
    // jenisKelamin = widget.jenis;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Data Mahasiswa'),
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              child: ListView(
                children: <Widget>[
                  // Image.network(img),
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
                    decoration: InputDecoration(labelText: "Descripsi"),
                    controller: txtDescripsi,
                  ),

                  Container(
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    height: 400.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        image: DecorationImage(
                          image: NetworkImage(widget.img),
                          fit: BoxFit.cover,
                        )),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      OutlineButton(
                        child: Text("Simpan"),
                        color: Colors.teal,
                        textColor: Colors.teal,
                        onPressed: () {
                          Update();
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
