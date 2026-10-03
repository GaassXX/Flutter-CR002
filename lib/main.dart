import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarangBelanja {
  final String nama;
  final int jumlah;
  final String kategori;
  bool sudahDibeli;

  BarangBelanja({
    required this.nama,
    required this.jumlah,
    required this.kategori,
    this.sudahDibeli = false,
  });
}

class BelanjaModel extends ChangeNotifier {
  final List<BarangBelanja> _barang = [];

  List<BarangBelanja> get barang => List.unmodifiable(_barang);

  int get jumlahBelumDibeli {
    return _barang.where((item) => !item.sudahDibeli).length;
  }

  void tambahBarang({
    required String nama,
    required int jumlah,
    required String kategori,
  }) {
    _barang.add(
      BarangBelanja(
        nama: nama,
        jumlah: jumlah,
        kategori: kategori,
      ),
    );

    notifyListeners();
  }

  void ubahStatus(int index) {
    _barang[index].sudahDibeli = !_barang[index].sudahDibeli;

    notifyListeners();
  }

  void hapusBarang(int index) {
    _barang.removeAt(index);
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => BelanjaModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Belanja',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const DaftarBelanjaPage(),
    );
  }
}

class DaftarBelanjaPage extends StatelessWidget {
  const DaftarBelanjaPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<BelanjaModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Belanja (${model.jumlahBelumDibeli} belum dibeli)',
        ),
      ),
      body: model.barang.isEmpty
          ? const Center(
              child: Text(
                'Belum ada barang',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              itemCount: model.barang.length,
              itemBuilder: (context, index) {
                final item = model.barang[index];

                return ListTile(
                  leading: Checkbox(
                    value: item.sudahDibeli,
                    onChanged: (_) {
                      context.read<BelanjaModel>().ubahStatus(index);
                    },
                  ),
                  title: Text(
                    item.nama,
                    style: TextStyle(
                      decoration: item.sudahDibeli
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(
                    '${item.kategori} • Jumlah: ${item.jumlah}',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<BelanjaModel>().hapusBarang(index);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const TambahBelanjaPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TambahBelanjaPage extends StatefulWidget {
  const TambahBelanjaPage({super.key});

  @override
  State<TambahBelanjaPage> createState() => _TambahBelanjaPageState();
}

class _TambahBelanjaPageState extends State<TambahBelanjaPage> {
  final _formKey = GlobalKey<FormState>();

  final _namaController = TextEditingController();
  final _jumlahController = TextEditingController();

  String? _kategori;

  final List<String> _kategoriList = [
    'Makanan',
    'Minuman',
    'Kebutuhan Rumah',
    'Elektronik',
    'Lainnya',
  ];

  @override
  void dispose() {
    _namaController.dispose();
    _jumlahController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<BelanjaModel>().tambahBarang(
          nama: _namaController.text.trim(),
          jumlah: int.parse(_jumlahController.text),
          kategori: _kategori!,
        );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Belanja'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama barang',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Nama barang wajib diisi';
                }

                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _jumlahController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Jumlah',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Jumlah wajib diisi';
                }

                final jumlah = int.tryParse(value);

                if (jumlah == null) {
                  return 'Jumlah harus berupa angka';
                }

                if (jumlah <= 0) {
                  return 'Jumlah harus lebih dari 0';
                }

                return null;
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _kategori,
              decoration: const InputDecoration(
                labelText: 'Kategori',
                border: OutlineInputBorder(),
              ),
              items: _kategoriList.map((kategori) {
                return DropdownMenuItem(
                  value: kategori,
                  child: Text(kategori),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _kategori = value;
                });
              },
              validator: (value) {
                if (value == null) {
                  return 'Kategori wajib dipilih';
                }

                return null;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _simpan,
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}
