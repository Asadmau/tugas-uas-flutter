import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uasflutter/service.dart';
import 'package:uasflutter/shop.dart';


// import link whatshapp
import 'package:url_launcher/url_launcher.dart';
// import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';

// import 'package:flutter_launch/flutter_launch.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'dart:io';
// import 'package:flutter_launch/flutter_launch.dart';

class DetailShop extends StatefulWidget {
  DetailShop(this.img, this.judul, this.author, this.harga, this.descripsi,
      this.index);

  final img;
  final judul;
  final author;
  final harga;
  final descripsi;
  final index;
  @override
  _DetailShopState createState() => _DetailShopState();
}

class _DetailShopState extends State<DetailShop> {

  List<DocumentSnapshot> dtShop = List();
  bool loading = false;

  

  HapusData(String id) {
    setState(() {
      loading = true;
    });

    ServiceData.service.HapusData(id).then((_) {});
    Navigator.pop(context);
  }

// Future<bool> canLaunch(String url) async {
//   if (url == null) {
//     return false;
//   }
//   return await UrlLauncherPlatform.instance.canLaunch(url);
// }

  void _lauchWhatsapp(String url) async {
    if(await canLaunch(url)){
      await launch(url);
    }else {
      throw 'cloud not open url $url';
    }
  }
//   Future<bool> canLaunch(String url) async {
//   if (url == null) {
//     return false;
//   }
//   return await UrlLauncherPlatform.instance.canLaunch(url);
// }

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
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                        // _lauchInBrowser(_whatshappUrl);
                        _lauchWhatsapp('https://api.whatsapp.com/send?phone=6282216733679');
                      },
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.message),
                          Text(
                            "Chat Whatsapp",
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
