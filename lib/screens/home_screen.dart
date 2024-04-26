import 'package:flutter/material.dart';
import 'package:product/services/produk_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  final ProdukService _produkService = ProdukService();
  final bool _validate = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add Product'),
        ),
        body: Column(
          children: [
            Expanded(child: StreamBuilder<Map<String, String>>(
              stream: _produkService.getProdukList(),
              builder: (context, snapshot) {
                if(snapshot.hasData){
                  Map<String, String> items = snapshot.data!;
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index){
                      final key = items.keys.elementAt(index);
                      final item = items[key];
                      return ListTile(
                        title: Text(item!),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _produkService.removeProduk(key);
                          },
                        ),
                      );
                    },
                  );
                }
                else if (snapshot.hasError) {
                  return Center(child: Text('Error : ${snapshot.error}'),);
                }
                else {
                  return const Center(child: CircularProgressIndicator(),);
                }
              },
            ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: 100,
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: FloatingActionButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const HomeScreen()
                      ));
                    },
                    child: const Text('Tambah Produk'),
                  ),
                ),
              ),
            )
          ],
        )
    );
  }
}
