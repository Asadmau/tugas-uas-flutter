import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uasflutter/edit.dart';
import 'package:uasflutter/service.dart';
import 'package:uasflutter/shop.dart';

class DetailData extends StatefulWidget {
  DetailData(this.img,this.judul,this.author,this.harga,this.descripsi,this.index);

  final img;
  final judul;
  final author;
  final harga;
  final descripsi;
  final index;
  @override
  _DetailDataState createState() => _DetailDataState();
}

class _DetailDataState extends State<DetailData> {
  List<DocumentSnapshot> dtShop = List();
  bool loading = false;

  // AmbilDataMhs() async {
  //   setState(() {
  //     loading = true;
  //   });

  //   dtShop = await ServiceData.service.GetShoping();

  //   setState(() {
  //     loading = false;
  //   });
  // }

  // Edit(int indek) async {
  //   final sop = dtShop[indek];
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => EditData(
  //                 img: sop['img'],
  //                 judul: sop['judul'],
  //                 author: sop['author'],
  //                 harga: sop['harga'],
  //                 descripsi: sop['descripsi'],
  //                 // jk: sop['jk'],
  //                 // jenis: sop['jenis'],
  //                 // agama: sop['agama']
  //               )));
  //   setState(() {});
  // }

  HapusData(String id) {
    setState(() {
      loading = true;
    });

    ServiceData.service.HapusData(id).then((_) {});
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    // AmbilDataMhs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Barang"),
        centerTitle: true,
      ),
      body: ListView(
        // itemCount: dtShop.length,
        // itemBuilder: (context, index) {
        //   final item = dtShop[index];
            children: <Widget>[
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
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.judul,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.all(5.0),
                    ),
                    Text(widget.author,
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                    ),
                    Text(
                      widget.harga,
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      child: Divider(
                        color: Colors.black,
                        thickness: 1,
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Text(widget.descripsi, textAlign: TextAlign.left)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          onPressed: () {
                          // EditData(widget.judul,widget.harga,widget.author,widget.descripsi,widget.img);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => EditData(widget.judul,widget.harga,widget.author,widget.descripsi,widget.img,widget.index)));
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.edit),
                              Text(
                                "Edit",
                                style: TextStyle(),
                              ),
                            ],
                          ),
                          color: Colors.purple,
                          textColor: Colors.white,
                          highlightColor: Colors.red,
                          splashColor: Colors.blue[100],
                        ),
                        RaisedButton(
                           onPressed: () {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text("Konfirmasi"),
                          content: Text("Yakin Ingin Menghapus Data"),
                          actions: <Widget>[
                            OutlineButton(
                              child: Text("Iya"),
                              textColor: Colors.green,
                              onPressed: () {
                                HapusData(widget.index);
                              },
                            ),
                            OutlineButton(
                              child: Text("Tidak"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        );
                      });
                },
                          child: Row(
                            children: <Widget>[
                              Icon(Icons.delete),
                              Text(
                                "Hapus",
                                style: TextStyle(),
                              ),
                            ],
                          ),
                          color: Colors.green,
                          textColor: Colors.white,
                          highlightColor: Colors.red,
                          splashColor: Colors.blue[100],
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          
        
      ),
    );
  }
}

// class DetailData extends StatelessWidget {
//   final String img;
//   final String id;
//   final String judul;
//   final String author;
//   final String harga;
//   final String descripsi;
//   // final String jk;
//   DetailData({
//     this.id,
//     this.img,
//     this.judul,
//     this.author,
//     this.harga,
//     this.descripsi,
//   });

//   @override

//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Detail Barang"),
//         centerTitle: true,
//       ),
//       body: ListView(
//         children: <Widget>[
//           Container(
//             margin: EdgeInsets.all(10),
//             width: MediaQuery.of(context).size.width,
//             height: 400.0,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 image: DecorationImage(
//                   image: NetworkImage(img),
//                   fit: BoxFit.cover,
//                 )),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text(
//                   judul,
//                   style: TextStyle(
//                       color: Colors.blue,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.all(5.0),
//                 ),
//                 Text(author,
//                     style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                     textAlign: TextAlign.left),
//                 Padding(
//                   padding: EdgeInsets.all(10.0),
//                 ),
//                 Text(
//                   harga,
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                   textAlign: TextAlign.center,
//                 ),
//                 Container(
//                   child: Divider(
//                     color: Colors.black,
//                     thickness: 1,
//                   ),
//                 ),
//                 Column(
//                   children: <Widget>[
//                     Text(descripsi, textAlign: TextAlign.left)
//                     ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     RaisedButton(
//                       onPressed: () {
//                         print("click");
//                       },
//                       child: Row(
//                         children: <Widget>[
//                           Icon(Icons.shopping_cart),
//                           Text(
//                             "Buy",
//                             style: TextStyle(),
//                           ),
//                         ],
//                       ),
//                       color: Colors.purple,
//                       textColor: Colors.white,
//                       highlightColor: Colors.red,
//                       splashColor: Colors.blue[100],
//                     ),
//                     RaisedButton(
//                       onPressed: () {
//                         Navigator.push(context, MaterialPageRoute(
//                           builder: (context) => Shoping()
//                         ));
//                         // print("click");
//                       },
//                       child: Row(
//                         children: <Widget>[
//                           Icon(Icons.shopping_cart),
//                           Text(
//                             "Pesan Whatsapp",
//                             style: TextStyle(),
//                           ),
//                         ],
//                       ),
//                       color: Colors.green,
//                       textColor: Colors.white,
//                       highlightColor: Colors.red,
//                       splashColor: Colors.blue[100],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           )
//         ],
//       ),
//       // body: Column(
//       //     crossAxisAlignment: CrossAxisAlignment.start,
//       //     children: <Widget>[
//       //       Container(
//       //         margin: EdgeInsets.all(8.0),
//       //         height: 450.0,
//       //         width: MediaQuery.of(context).size.width,
//       //         decoration: BoxDecoration(
//       //           image: DecorationImage(
//       //             image: NetworkImage(img),fit: BoxFit.cover
//       //           )
//       //         ),
//       //         ),
//       //       Text("Nim: " + nim),
//       //       Text("Nama : " + nama),
//       //       Text("Alamat: " + tmplahir),
//       //       // Text(tmp_lahir),
//       //       Text("Tanggal lahir: " + tgllahir),
//       //       Text("Jenis Kelamin: " + jk),

//       //     ],
//       // ),
//     );
//   }
// }
