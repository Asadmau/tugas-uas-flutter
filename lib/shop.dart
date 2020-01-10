import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uasflutter/detailshop.dart';
import 'package:uasflutter/service.dart';

class Shoping extends StatefulWidget {
  Shoping();
  @override
  _ShopingState createState() => _ShopingState();
}

class _ShopingState extends State<Shoping> {
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

  

  @override
  void initState() {
    super.initState();
    AmbilDataMhs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
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
                            ],
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => DetailShop(item.data["img"],item.data["judul"],item.data["author"],item.data["harga"],item.data["descripsi"],item.documentID)),
                      );
                    },
                  );
                })));
  }
}
