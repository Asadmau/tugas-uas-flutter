import 'package:cloud_firestore/cloud_firestore.dart';

//coba gambar
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:path/path.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceData{
  static ServiceData service = ServiceData();

  static Firestore db = Firestore.instance;
  CollectionReference ref = db.collection("shoping");
  Future<List<DocumentSnapshot>> GetShoping() async {
    QuerySnapshot hasil = await ref.getDocuments();
    return hasil.documents;
  }

  Future<String> TambahData(Map dtShop)async{
    DocumentReference shop = await ref.add(dtShop);
    return shop.documentID;
  }

    Future UpdateData(String idDokumen, Map<String, dynamic> dtShop)async{
    await ref.document(idDokumen).updateData(dtShop);
  }

  Future HapusData(String idDokumen)async{
    // await ref.document(idDokumen).delete();
    db.collection("shoping").document(idDokumen).delete();
  }

 
  

}

