import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pl1_kasir/menu/drawer_menu.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDrawerOpen = false;
  final supabase = Supabase.instance.client;
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _hargaBarangController = TextEditingController();
  TextInputFormatter currencyFormatter = FilteringTextInputFormatter.digitsOnly;
  List<Map<String, dynamic>> barang = [];

  Future<void> _tambahBarang() async {
    await supabase.from('barang').insert({
      'nama_barang': _namaBarangController.text,
      'harga_barang': _hargaBarangController.text
    }).then((value) {
      setState(() {
        _isDrawerOpen = false;
      });
    });
  }

  Future<void> tampilBarang() async {
    final response = await supabase.from('barang').select();

    setState(() {
      barang = List<Map<String, dynamic>>.from(response);
    });
  }

  void _tampiTabBaru() {
    setState(() {
      _isDrawerOpen = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Home'),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home), text: 'Home'),
                Tab(icon: Icon(Icons.shopping_cart), text: 'Kasir'),
                Tab(icon: Icon(Icons.account_circle), text: 'Profil'),
              ],
            ),
            actions: [
              IconButton(
                  onPressed: tampilBarang, icon: Icon(Icons.import_contacts))
            ],
          ),
          drawer: DrawerMenu(),
          body: TabBarView(
            children: [
              Stack(
                children: [
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment,
                    children: [
                      barang.isEmpty ? Center(child: CircularProgressIndicator(),)
                      :
                      Expanded(
                        child: ListView.builder(
                          itemCount: barang.length,
                          itemBuilder: (context, index){
                          return ListTile(
                            title: Text(barang[index]['nama_barang']),
                            subtitle: Text('${barang[index]['harga_barang']}'),
                          );
                        }),
                      )
                    ],
                  ),
                  if (_isDrawerOpen)
                    Center(
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.lightGreenAccent,
                            borderRadius: BorderRadius.circular(10)),
                        child: SizedBox(
                          width: 350,
                          height: 300,
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 30, left: 8, right: 8),
                            child: Column(
                              children: [
                                TextField(
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  controller: _namaBarangController,
                                  decoration: const InputDecoration(
                                      hintText: 'Nama Barang',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: Colors.teal, width: 2.0))),
                                ),
                                SizedBox(height: 20),
                                TextField(
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [currencyFormatter],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  controller: _hargaBarangController,
                                  decoration: const InputDecoration(
                                      hintText: 'Harga',
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                          borderSide: BorderSide(
                                              color: Colors.teal, width: 2.0))),
                                ),
                                SizedBox(height: 50),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.only(
                                          left: 80, right: 80),
                                      side: BorderSide(
                                          color: Colors.black, width: 1),
                                      backgroundColor: Colors.green),
                                  onPressed: () {
                                    _tambahBarang();
                                  },
                                  child: const Text('Simpan',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Roboto',
                                          fontSize: 20)),
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      side: BorderSide(
                                          color: Colors.black, width: 1),
                                      backgroundColor: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      _isDrawerOpen = false;
                                    });
                                  },
                                  child: const Text('Cancel',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Roboto',
                                          fontSize: 20)),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              Center(child: Text('Kasir')),
              Center(child: Text('Profil')),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _tampiTabBaru();
            },
            child: const Icon(Icons.add),
          ),
        ));
  }
}
