import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:product/screens/home_screen.dart';

class ProdukService{
  final DatabaseReference _database = FirebaseDatabase.instance.ref().child('produk-db');

  Stream<Map<String, String>> getProdukList() {
    return _database.onValue.map((event) {
      final Map<String, String> items = {};
      DataSnapshot snapshot = event.snapshot;
      if(snapshot.value != null) {
        Map<dynamic, dynamic> values = snapshot.value as Map<dynamic, dynamic>;
        values.forEach((key, value) {
          items[key] =
              'Kode Produk\t\t\t\t: ${value['product_code']} \nNama Produk\t: ${value['product_name']}';
        });
      }
      return items;
    });
  }

  void addProduk(String itemName1, itemName2, BuildContext context) {
    if (itemName1.isEmpty || itemName2 == null) {
      const warning = SnackBar(content: Text("Data harus diisi"));
    } else {
      _database.push().set({'product_code' : itemName1,'product_name' : itemName2});
      Navigator.of(context).pushReplacement(
         MaterialPageRoute(builder : (context) => const HomeScreen()));
    }
  }

  Future <void> removeProduk(String key) async {
    await _database.child(key).remove();
  }
}