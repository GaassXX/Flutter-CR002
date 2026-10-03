# Doc Tugas - Pertemuan 1: Pengenalan Flutter

Disusun oleh: Rizqi Bagas Wicaksono  
NIM: 20240801187

## Perintah Flutter (Terminal)

- `flutter doctor` : mengecek instalasi Flutter, Android toolchain, dan editor
- `flutter doctor --android-licenses` : menerima lisensi Android SDK
- `flutter create <nama_project>` : membuat proyek Flutter baru
- `flutter run` : menjalankan aplikasi di emulator atau perangkat
- `flutter devices` : melihat daftar emulator/perangkat yang terdeteksi
- **Hot Reload** : perubahan kode langsung tampil tanpa restart aplikasi

## Fungsi & Class Dasar

- `main()` : titik masuk aplikasi, dijalankan pertama kali saat program dimulai
- `runApp()` : menjalankan widget root aplikasi
- `MyApp` : class root aplikasi yang mengembalikan `MaterialApp`
- `build(BuildContext context)` : fungsi yang menghasilkan tampilan widget
- `BuildContext` : konteks posisi widget di dalam tree widget
- `@override` : menandai method yang mengganti method dari class induk
- `const` : membuat widget konstan agar lebih efisien
- `super.key` : meneruskan key ke class induk

## Jenis Widget

- `StatelessWidget` : widget yang tampilannya tidak berubah
- `StatefulWidget` : widget yang tampilannya dapat berubah
- `State` : tempat data yang berubah disimpan
- `createState()` : membuat objek state untuk StatefulWidget
- `setState()` : memberi tahu Flutter bahwa data berubah dan UI harus dibangun ulang

## Widget Struktur

- `MaterialApp` : pembungkus aplikasi dengan style Material Design
- `Scaffold` : kerangka halaman berisi `AppBar`, `body`, dan tombol aksi
- `AppBar` : bagian judul atas aplikasi
- `FloatingActionButton` : tombol melayang untuk aksi cepat

## Widget Isi & Layout

- `Text` : menampilkan teks
- `TextStyle` : menata tampilan teks seperti ukuran, warna, dan ketebalan
- `Icon` : menampilkan ikon dari library Material Icons
- `Center` : meletakkan isi di tengah layar
- `Column` : menyusun widget secara vertikal
- `Row` : menyusun widget secara horizontal
- `children` : daftar child widget di dalam layout
- `mainAxisAlignment` : pengaturan posisi child sepanjang sumbu utama
- `SizedBox` : memberi jarak spasi antar widget

## Properti Umum

- `title` : judul aplikasi atau halaman
- `home` : halaman yang pertama kali ditampilkan
- `body` : area utama di `Scaffold`
- `child` : satu widget child yang ditempatkan di dalam widget lain
- `backgroundColor` : warna latar belakang widget
- `foregroundColor` : warna teks/ikon di dalam widget
- `onPressed` : fungsi yang dipanggil saat tombol ditekan
- `Colors` : warna bawaan Flutter seperti `Colors.blue`

## Struktur Folder

- `lib/main.dart` : file utama aplikasi
- `pubspec.yaml` : konfigurasi proyek dan dependency
- `android/` dan `ios/` : kode native untuk platform mobile
- `test/` : folder untuk file uji

## Widget Tree Praktikum

```dart
MaterialApp
  -> Scaffold
      -> AppBar
      -> Center
          -> Column
              -> Text
              -> SizedBox
              -> Row
                  -> FloatingActionButton
```

## Penjelasan Program Counter

Program ini membuat aplikasi counter sederhana. Saat tombol tambah ditekan, nilai variabel `_count` bertambah. Saat tombol kurang ditekan, nilai berkurang, dan saat tombol reset ditekan nilai kembali ke 0.

```dart
class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}
```

- `StatefulWidget` dipakai karena tampilan berubah saat tombol ditekan.
- `setState()` digunakan agar Flutter menggambar ulang UI sesuai data terbaru.

```dart
void _tambah() {
  setState(() {
    _count++;
  });
}
```

- Fungsi `_tambah()` menambah angka di variabel `_count`.
- Fungsi `_kurang()` mengurangi angka jika nilai masih lebih dari 0.
- Fungsi `_reset()` mengembalikan nilai counter ke 0.

## Jawaban Refleksi

- **Stateless vs Stateful**: Stateless untuk widget statis, Stateful untuk widget yang data atau tampilannya berubah.
- **Kenapa pakai `setState()`**: karena Flutter perlu tahu ada perubahan data agar UI diperbarui.
- **Keuntungan hot reload**: perubahan kode langsung terlihat tanpa restart aplikasi, sehingga proses debugging lebih cepat.

## Kesimpulan

Pertemuan 1 memperkenalkan Flutter sebagai framework UI modern, Dart sebagai bahasa pemrograman, serta konsep widget dasar. Mahasiswa belajar cara membuat aplikasi pertama, mengatur layout, dan memahami cara kerja state dalam aplikasi.
