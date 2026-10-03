import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Tugas {
  String judul;
  bool selesai;

  Tugas(this.judul, {this.selesai = false});
}

class TugasModel extends ChangeNotifier {
  final List<Tugas> _tugas = [];

  List<Tugas> get tugas => List.unmodifiable(_tugas);

  void tambahTugas(String judul) {
    _tugas.add(Tugas(judul));
    notifyListeners();
  }

  void ubahStatus(int index) {
    _tugas[index].selesai = !_tugas[index].selesai;
    notifyListeners();
  }

  void hapusSelesai() {
    _tugas.removeWhere((tugas) => tugas.selesai);
    notifyListeners();
  }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TugasModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Latihan Mandiri D',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const LatihanPage(),
    );
  }
}

class LatihanPage extends StatelessWidget {
  const LatihanPage({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TugasModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tugas'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_sweep),
            onPressed: model.tugas.isEmpty
                ? null
                : () {
                    model.hapusSelesai();

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Tugas selesai dihapus'),
                      ),
                    );
                  },
          ),
        ],
      ),
      body: model.tugas.isEmpty
          ? const Center(
              child: Text('Belum ada tugas'),
            )
          : ListView.builder(
              itemCount: model.tugas.length,
              itemBuilder: (context, index) {
                final tugas = model.tugas[index];

                return ListTile(
                  leading: Checkbox(
                    value: tugas.selesai,
                    onChanged: (_) {
                      model.ubahStatus(index);
                    },
                  ),
                  title: Text(
                    tugas.judul,
                    style: TextStyle(
                      decoration: tugas.selesai
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const TambahTugasPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TambahTugasPage extends StatefulWidget {
  const TambahTugasPage({super.key});

  @override
  State<TambahTugasPage> createState() => _TambahTugasPageState();
}

class _TambahTugasPageState extends State<TambahTugasPage> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void simpanTugas() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    context.read<TugasModel>().tambahTugas(
          _controller.text.trim(),
        );

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Tugas ditambahkan'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Tugas'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextFormField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Judul tugas',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().length < 3) {
                    return 'Judul minimal 3 karakter';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: simpanTugas,
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
