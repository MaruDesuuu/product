import 'package:flutter/material.dart';
import 'package:product/services/produk_service.dart';

class addProductScreen extends StatefulWidget {
  const addProductScreen({super.key});

  @override
  State<addProductScreen> createState() => _addProductScreenState();
}

class _addProductScreenState extends State<addProductScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final ProdukService _produkService = ProdukService();
  final bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
