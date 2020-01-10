import 'package:flutter/material.dart';
import 'package:uasflutter/beranda.dart';
import 'package:uasflutter/data_barang.dart';
import 'package:uasflutter/service.dart';
import 'package:uasflutter/shop.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int index = 0;
  bool loading = false;
  List<DocumentSnapshot> dtShop = List();

  PilihMenu(int ind, String title) {
    setState(() {
      widget.title = title;
      index = ind;
    });
    Navigator.pop(context);
  }

  AmbilDataMhs() async {

    dtShop = await ServiceData.service.GetShoping();

    setState(() {
      loading = false;
    });
  }

  GetContent() {
    if (index == 0) {
      return Beranda();
    } else if (index == 1)
      return DataBarang();
      else if (index == 2 ){
        return Shoping();
      }
    else {
      return Text("Coming Soon");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        
        preferredSize: Size.fromHeight(100),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.amber,
          title: Text('Book Shopping'),
          centerTitle: true,
        ),
      ),
      drawer: Drawer(
          child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.amber),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              backgroundImage: NetworkImage(
                  'http://www.vsolutionindia.com/wp-content/uploads/2019/08/AccountIcon2.png'),
            ),
            accountName: Text("ADMIN"),
            accountEmail: Text("Admin"),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Beranda"),
            selected: index == 0,
            onTap: () {
              PilihMenu(0, "Beranda");
            },
          ),
          ListTile(
            leading: Icon(Icons.people_outline),
            title: Text("Data Barang"),
            selected: index == 1,
            onTap: () {
              PilihMenu(1, "Data Barang");
            },
          ),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text("Shopping"),
            selected: index == 2,
            onTap: () {
              PilihMenu(2, "Shopping");
            },
          ),
        ],
      )),
      body: GetContent(),
    );
  }
}
