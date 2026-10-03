# Doc Tugas - Pertemuan 3: Form Input dan State Management

Disusun oleh: Rizqi Bagas Wicaksono  
NIM: 20240801187

## Perintah Flutter (Terminal)

- `flutter create praktikum_3` : membuat proyek baru untuk form dan state management
- `flutter pub add provider` : menambahkan dependency `provider`
- `flutter run` : menjalankan aplikasi di emulator atau perangkat
- `flutter analyze` : memeriksa error dan warning kode

## Fungsi & Class Dasar

- `main()` : titik masuk aplikasi
- `runApp()` : menjalankan aplikasi Flutter
- `FormPage` : halaman form pendaftaran
- `TextEditingController` : menangkap input user dari `TextField`/`TextFormField`
- `GlobalKey<FormState>` : mengontrol state form dan validasi form
- `ChangeNotifier` : class yang menyimpan state dan memberi sinyal saat data berubah
- `Provider` : alat untuk membagikan state di banyak widget/halaman
- `context.watch<T>()` : membaca state dan me-rebuild widget saat data berubah
- `context.read<T>()` : membaca state tanpa perlu rebuild UI
- `notifyListeners()` : memanggil semua listener saat state berubah

## Form Input dan Validasi

```dart
final _formKey = GlobalKey<FormState>();
final _nama = TextEditingController();
```

- `_formKey` digunakan untuk validasi seluruh form.
- `_nama` digunakan untuk menyimpan input teks nama user.

```dart
TextFormField(
  controller: _nama,
  validator: (value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nama wajib diisi';
    }
    return null;
  },
)
```

- `validator` mengecek apakah input kosong atau tidak valid.
- Jika hasil validasi `null`, artinya data valid.
- Jika ada error, Flutter menampilkan pesan sesuai validator.

## Dropdown dan Checkbox

```dart
DropdownButtonFormField<String>(
  items: const [
    DropdownMenuItem(value: 'TI', child: Text('Teknik Informatika')),
    DropdownMenuItem(value: 'SI', child: Text('Sistem Informasi')),
  ],
  onChanged: (value) {
    setState(() {
      _jurusan = value;
    });
  },
)
```

- `DropdownButtonFormField` menampilkan pilihan dengan daftar yang sudah ditentukan.
- `onChanged` menangkap pilihan yang dipilih user.
- `setState()` dipanggil agar UI update sesuai pilihan baru.

```dart
CheckboxListTile(
  value: _setuju,
  onChanged: (value) {
    setState(() {
      _setuju = value ?? false;
    });
  },
)
```

- `CheckboxListTile` digunakan untuk meminta persetujuan user.
- Data persetujuan disimpan di variabel `_setuju`.

## State Management dengan Provider

```dart
class BelanjaModel extends ChangeNotifier {
  final List<BarangBelanja> _barang = [];

  List<BarangBelanja> get barang => List.unmodifiable(_barang);

  void tambahBarang({
    required String nama,
    required int jumlah,
    required String kategori,
  }) {
    _barang.add(BarangBelanja(
      nama: nama,
      jumlah: jumlah,
      kategori: kategori,
    ));
    notifyListeners();
  }
}
```

- `BelanjaModel` adalah class state yang menyimpan daftar belanja.
- `notifyListeners()` memberi sinyal ke semua widget yang memakai data ini untuk update UI.
- Dalam aplikasi, state ini dibagikan dengan `ChangeNotifierProvider`.

## Context Watch dan Context Read

```dart
final model = context.watch<BelanjaModel>();
```

- `context.watch<T>()` dipakai saat widget harus mendengar perubahan data dan membangun ulang UI.

```dart
context.read<BelanjaModel>().tambahBarang(...);
```

- `context.read<T>()` dipakai saat fungsi hanya membutuhkan data satu kali tanpa perlu mendengar perubahan.

## Fungsi Utama Form

```dart
void _kirim() {
  if (_formKey.currentState!.validate()) {
    final jurusan = _jurusan ?? '-';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Terdaftar: ${_nama.text} ($jurusan)')),
    );
  }
}
```

- `_kirim()` mengecek validasi form terlebih dahulu.
- Jika berhasil valid, aplikasi menampilkan `SnackBar` sebagai notifikasi.
- Nilai dari input nama dan jurusan ditampilkan ke user.

## Jawaban Refleksi

- **TextField** digunakan untuk input satu field, sementara **Form** berguna jika ada beberapa field yang harus divalidasi sekaligus.
- **State management** dibutuhkan ketika data dipakai di banyak widget atau halaman.
- **Provider** membuat state lebih mudah dikelola dan dipakai ulang.
- **context.watch** dan **context.read** dibutuhkan untuk membedakan antara widget yang ikut rebuild dan widget yang hanya membaca data sekali.

## Kesimpulan

Pertemuan 3 membahas bagaimana aplikasi menerima input, memvalidasi data, dan mengelola state. Mahasiswa belajar membangun form interaktif, mengubah data pada state, serta menggunakan Provider agar aplikasi lebih terstruktur dan mudah dikembangkan.
