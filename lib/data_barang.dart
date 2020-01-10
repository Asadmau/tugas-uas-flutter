import 'package:flutter/material.dart';
import 'package:uasflutter/detail.dart';
import 'package:uasflutter/edit.dart';
import 'package:uasflutter/service.dart';
import 'package:uasflutter/shop.dart';
import 'package:uasflutter/tambah_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBarang extends StatefulWidget {
  DataBarang();
  @override
  _DataBarangState createState() => _DataBarangState();
}

class _DataBarangState extends State<DataBarang> {
  List<DocumentSnapshot> dtShop = List();
  bool loading = false;

  AmbilDataMhs() async {
    setState(() {
      loading = true;
    });

    dtShop = await ServiceData.service.GetShoping();

    setState(() {
      loading = false;
    });
  }

  HapusData(String id) {
    setState(() {
      loading = true;
    });

    ServiceData.service.HapusData(id).then((_) {});
  }

  // Data(int indek) async {
  //   final sop = dtShop[indek];
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => DetailData(
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

  @override
  void initState() {
    super.initState();
    AmbilDataMhs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text("Refresh"),
        actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: (){
                AmbilDataMhs();
              },
            )
          ],
      ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => AddData(AmbilDataMhs)));
          },
        ),
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            //   : GridView.builder(
            //       itemCount: dtShop.length,
            // gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: (orientation == Orientation.portrait) ? 2 : 3),
            // itemBuilder: (BuildContext context, int index) {
            //   final item = dtShop[index];
            //   return new Card(
            //     child: new GridTile(
            //       footer: new Text(item.data[index]['nama']),
            //         child: new Text(item.data[index]['nama']), //just for testing, will fill with image later
            //     ),
            //   );
            // },
            : GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 8.0 / 10.0,
                children: List.generate(dtShop.length, (int index) {
                  final item = dtShop[index];
                  return InkWell(
                    child: Card(
                      elevation: 10.0,
                      // color: Colors.transparent,
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          // Image.network(item.data['img'], fit: BoxFit.contain,),
                          Container(
                            margin: EdgeInsets.all(5.0),
                            child: Image.network(
                              item.data['img'],
                              height: 140.0,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ListTile(
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      item.data["judul"],
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                          fontStyle: FontStyle.normal),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.all(2.0),
                                    ),
                                    Text(item.data["author"],
                                        style: TextStyle(fontSize: 12)),
                                    Text(item.data["harga"],
                                        style: TextStyle(
                                          fontSize: 12,
                                        )),
                                  ],
                                ),
                              ),

                              // // SizedBox(height: 10.0),
                              // Text('Secondary Text'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailData(item.data["img"],item.data["judul"],item.data["author"],item.data["harga"],item.data["descripsi"],item.documentID)),
                      );
                      // Data(index);
                    },
                  );
                  // return Container(
                  //   child: Card(
                  //     elevation: 10.0,
                  //     child: new Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: <Widget>[
                  //         Image.network(
                  //           item.data['img'],
                  //           height: 150.0,
                  //           width: MediaQuery.of(context).size.width,
                  //           fit: BoxFit.cover,
                  //         ),
                  //         Text(item.data[index]['nama'])
                  //         // SizedBox(
                  //         //   height: 5.0,
                  //         // ),
                  //         // Text(item.data[index]['nama']),
                  //       ],
                  //     ),
                  //   ),
                  // );
                  // return Card(
                  //   color: Colors.transparent,
                  //   clipBehavior: Clip.antiAlias,
                  //   child: Column(
                  //     crossAxisAlignment: CrossAxisAlignment.start,
                  //     children: <Widget>[
                  //       // Image.network(item.data['img'], fit: BoxFit.contain,),
                  //       AspectRatio(
                  //         aspectRatio: 17.0 / 18.0,
                  //         child: Image.network(item.data['img']),
                  //       ),
                  //       Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: <Widget>[
                  //           ListTile(
                  //             title: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: <Widget>[
                  //                 Text(
                  //                   item.data["nama"],
                  //                   style: TextStyle(
                  //                       fontSize: 20,
                  //                       fontWeight: FontWeight.bold,
                  //                       fontStyle: FontStyle.italic),
                  //                 ),
                  //                 Text(item.data["nama"]),
                  //                 Text(item.data["nama"]),
                  //               ],
                  //             ),
                  //             subtitle: Text(item.data['nim']),
                  //           ),

                  //           // // SizedBox(height: 10.0),
                  //           // Text('Secondary Text'),
                  //         ],
                  //       ),
                  //     ],
                  //   ),
                  // );
                }))

        // : ListView.builder(
        //     itemCount: dtShop.length,
        //     itemBuilder: (context, index) {
        //       final item = dtShop[index];

        // return ListTile(
        //   title: Text(item.data["nama"]),
        //   subtitle: Row(
        //     children: <Widget>[
        //       CircleAvatar(
        //         backgroundImage: NetworkImage(item.data['img']),
        //       ),
        //       Expanded(child: Text(item.data['nim'])),
        //       IconButton(
        //           tooltip: "Edit Data",
        //           icon: Icon(Icons.edit),
        //           color: Colors.green,
        //           iconSize: 20,
        //           onPressed: () {
        //             Navigator.push(
        //                 context,
        //                 MaterialPageRoute(
        //                     builder: (context) => EditData(
        //                         reload: AmbilDataMhs,
        //                         id: item.documentID,
        //                         nim: item.data["nim"],
        //                         nama: item.data["nama"],
        //                         jenis: item.data["jk"],
        //                         tempat: item.data["tmp_lahir"],
        //                         tanggal: item.data["tgl_lahir"])));
        //           }),
              // IconButton(
              //   tooltip: "Hapus Data",
              //   icon: Icon(Icons.delete),
              //   color: Colors.red,
              //   iconSize: 20,
              //   onPressed: () {
              //     showDialog(
              //         context: context,
              //         builder: (_) {
              //           return AlertDialog(
              //             title: Text("Konfirmasi"),
              //             content: Text("Yakin Ingin Menghapus Data"),
              //             actions: <Widget>[
              //               OutlineButton(
              //                 child: Text("Iya"),
              //                 textColor: Colors.green,
              //                 onPressed: () {
              //                   HapusData(item.documentID);
              //                   Navigator.pop(context);
              //                 },
              //               ),
              //               OutlineButton(
              //                 child: Text("Tidak"),
              //                 onPressed: () {
              //                   Navigator.pop(context);
              //                 },
              //               )
              //             ],
              //           );
              //         });
              //   },
              // )
        //     ],
        //   ),
        // );
        //   },
        // ),
        );
  }
}
