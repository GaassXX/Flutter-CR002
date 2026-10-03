import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class Makanan {
  final String nama;
  final int harga;
  final String deskripsi;

  const Makanan(
    this.nama,
    this.harga,
    this.deskripsi,
  );
}

const daftarMenu = [
  Makanan(
    'Nasi Goreng',
    15000,
    'Nasi goreng spesial dengan telur dan sayuran.',
  ),
  Makanan(
    'Mie Ayam',
    12000,
    'Mie ayam dengan potongan ayam dan sayuran.',
  ),
  Makanan(
    'Es Teh',
    4000,
    'Minuman teh manis yang menyegarkan.',
  ),
  Makanan(
    'Ayam Bakar',
    20000,
    'Ayam bakar dengan bumbu khas dan nasi.',
  ),
  Makanan(
    'Soto Ayam',
    15000,
    'Soto ayam dengan kuah gurih dan suwiran ayam.',
  ),
  Makanan(
    'Bakso',
    13000,
    'Bakso sapi dengan kuah gurih dan mie.',
  ),
  Makanan(
    'Nasi Ayam',
    18000,
    'Nasi dengan ayam goreng dan sambal.',
  ),
  Makanan(
    'Kwetiau Goreng',
    17000,
    'Kwetiau goreng dengan telur dan sayuran.',
  ),
  Makanan(
    'Seblak',
    14000,
    'Seblak pedas dengan kerupuk dan telur.',
  ),
  Makanan(
    'Sate Ayam',
    22000,
    'Sate ayam dengan bumbu kacang.',
  ),
  Makanan(
    'Bakmi Goreng',
    16000,
    'Bakmi goreng dengan ayam dan sayuran.',
  ),
  Makanan(
    'Gado-Gado',
    12000,
    'Sayuran dengan tahu, tempe, dan saus kacang.',
  ),
];

String formatHarga(int harga) {
  return 'Rp ${harga.toString().replaceAllMapped(
        RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
        (match) => '${match.group(1)}.',
      )}';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Praktikum 2',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const MenuPage(),
    );
  }
}

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Menu'),
      ),
      body: ListView.builder(
        itemCount: daftarMenu.length,
        itemBuilder: (context, index) {
          final item = daftarMenu[index];

          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              leading: const Icon(
                Icons.restaurant,
                size: 32,
              ),
              title: Text(
                item.nama,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                formatHarga(item.harga),
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailPage(
                      makanan: item,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class DetailPage extends StatelessWidget {
  final Makanan makanan;

  const DetailPage({
    super.key,
    required this.makanan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(makanan.nama),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.restaurant_menu,
                size: 80,
              ),
              const SizedBox(height: 20),
              Text(
                makanan.nama,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                formatHarga(makanan.harga),
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Deskripsi',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                makanan.deskripsi,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Kembali'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
