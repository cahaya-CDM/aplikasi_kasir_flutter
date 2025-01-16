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
  String _jeniProduk = 'Jenis Produk Tidak Diketahui';
  bool _isDrawerOpen = false;
  final supabase = Supabase.instance.client;
  final TextEditingController _namaBarangController = TextEditingController();
  final TextEditingController _hargaBarangController = TextEditingController();
  TextInputFormatter currencyFormatter = FilteringTextInputFormatter.digitsOnly;
  List<Map<String, dynamic>> barang = [];

  Future<void> _tambahBarang(String jenisProduk) async {
    await supabase.from('barang').insert({
      'nama_barang': _namaBarangController.text,
      'harga_barang': _hargaBarangController.text,
      'jenis': jenisProduk
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

  void _tombolPilihJenisProduk(String item) async {
    setState(() {
      _jeniProduk =
          (_jeniProduk == item) ? 'Jenis Produk Tidak Diketahui' : item;
    });
    // await _tambahBarang(_jeniProduk);
  }

  Future<void> _editProduk(Map<String, dynamic> item) async {
    final nameController = TextEditingController(text: item['nama_barang']);
    final priceController =
        TextEditingController(text: item['harga_barang'].toString());
    String jenisProduk =
        item['jenis']; // Jenis produk awal (Makanan atau Minuman)

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Produk'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Nama Barang'),
            ),
            TextField(
              controller: priceController,
              inputFormatters: [currencyFormatter],
              decoration: const InputDecoration(labelText: 'Harga Barang'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: jenisProduk == 'Makanan',
                  onChanged: (value) {
                    if (value == true) {
                      setState(() {
                        jenisProduk = 'Makanan';
                      });
                    }
                  },
                ),
                const Text('Makanan'),
                Checkbox(
                  value: jenisProduk == 'Minuman',
                  onChanged: (value) {
                    if (value == true) {
                      setState(() {
                        jenisProduk = 'Minuman';
                      });
                    }
                  },
                ),
                const Text('Minuman'),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);

              final updatedName = nameController.text;
              final updatedPrice =
                  int.tryParse(priceController.text) ?? item['harga_barang'];

              // Perbarui data di Supabase
              await supabase
                  .from('barang')
                  .update({
                    'nama_barang': updatedName,
                    'harga_barang': updatedPrice,
                    'jenis': jenisProduk,
                  })
                  .eq('id', item['id'])
                  .then((value) {
                    // Update data di List barang lokal
                    setState(() {
                      final index =
                          barang.indexWhere((b) => b['id'] == item['id']);
                      if (index != -1) {
                        barang[index]['nama_barang'] = updatedName;
                        barang[index]['harga_barang'] = updatedPrice;
                        barang[index]['jenis'] = jenisProduk;
                      }
                    });
                  });
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _hapusProduk(int id) async {
    try {
      await supabase.from('barang').delete().eq('id', id);
      tampilBarang();
    } catch (e) {
      print('gagal');
    }
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
                      barang.isEmpty
                          ? Padding(
                              padding: const EdgeInsets.only(top: 250),
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                  itemCount: barang.length,
                                  itemBuilder: (context, index) {
                                    IconData iconProduk = Icons.help;
                                    if (barang[index]['jenis'] == 'Makanan') {
                                      iconProduk = Icons.fastfood;
                                    } else if (barang[index]['jenis'] ==
                                        'Minuman') {
                                      iconProduk = Icons.local_drink;
                                    }
                                    return ListTile(
                                      leading: Icon(iconProduk),
                                      title: Text(barang[index]['nama_barang']),
                                      subtitle: Text(
                                          '${barang[index]['harga_barang']}'),
                                      trailing: SizedBox(
                                        width: 85,
                                        child: Row(
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  _hapusProduk(barang[index]['id']);
                                                },
                                                icon: Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                )),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            IconButton(
                                                onPressed: () {
                                                  _editProduk(barang[index]);
                                                },
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: Colors.blue,
                                                ))
                                          ],
                                        ),
                                      ),
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
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Checkbox(
                                      value: _jeniProduk == 'Makanan',
                                      onChanged: (bool? value) {
                                        _tombolPilihJenisProduk('Makanan');
                                      },
                                    ),
                                    Text('Makanan'),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Checkbox(
                                      value: _jeniProduk == 'Minuman',
                                      onChanged: (bool? value) {
                                        _tombolPilihJenisProduk('Minuman');
                                      },
                                    ),
                                    Text('Minuman')
                                  ],
                                ),
                                SizedBox(height: 20),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.only(
                                          left: 80, right: 80),
                                      side: BorderSide(
                                          color: Colors.black, width: 1),
                                      backgroundColor: Colors.green),
                                  onPressed: () {
                                    setState(() {
                                      _tambahBarang;
                                      _isDrawerOpen = false;
                                    });
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
