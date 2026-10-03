import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daftar Kontak',
      home: const ContactPage(),
    );
  }
}

class Kontak {
  final String nama;
  final String nomor;
  final String email;

  const Kontak(
    this.nama,
    this.nomor,
    this.email,
  );
}

const daftarKontak = [
  Kontak(
    'Rizqi Bagas',
    '081234567890',
    'rizqi@gmail.com',
  ),
  Kontak(
    'Fadhil',
    '081234567891',
    'fadhil@gmail.com',
  ),
  Kontak(
    'Luqman',
    '081234567892',
    'luqman@gmail.com',
  ),
  Kontak(
    'Angga',
    '081234567893',
    'angga@gmail.com',
  ),
  Kontak(
    'Dimas',
    '081234567894',
    'dimas@gmail.com',
  ),
  Kontak(
    'Sigmaboy',
    '081234567895',
    'sigmaboy@gmail.com',
  ),
];

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kontak'),
      ),
      body: ListView.builder(
        itemCount: daftarKontak.length,
        itemBuilder: (context, index) {
          final kontak = daftarKontak[index];

          return Card(
            margin: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            child: ListTile(
              leading: CircleAvatar(
                child: Text(
                  kontak.nama[0],
                ),
              ),
              title: Text(
                kontak.nama,
              ),
              subtitle: Text(
                kontak.nomor,
              ),
              trailing: const Icon(
                Icons.chevron_right,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailPage(
                      kontak: kontak,
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
  final Kontak kontak;

  const DetailPage({
    super.key,
    required this.kontak,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(kontak.nama),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Text(
                kontak.nama[0],
                style: const TextStyle(
                  fontSize: 36,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              kontak.nama,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              kontak.nomor,
            ),
            const SizedBox(height: 8),
            Text(
              kontak.email,
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
    );
  }
}