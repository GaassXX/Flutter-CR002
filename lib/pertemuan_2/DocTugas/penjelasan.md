# Doc Tugas - Pertemuan 2: Layout, ListView, dan Navigasi

Disusun oleh: Rizqi Bagas Wicaksono  
NIM: 20240801187

## Perintah Flutter (Terminal)

- `flutter create praktikum_2` : membuat proyek baru untuk materi layout dan navigasi
- `flutter run` : menjalankan aplikasi di emulator atau perangkat
- `flutter analyze` : mengecek error dan warning pada kode
- `dart format lib` : memformat kode Dart agar lebih rapi

## Fungsi & Class Dasar

- `main()` : titik masuk aplikasi
- `runApp()` : menjalankan widget utama
- `MyApp` : widget root aplikasi
- `MenuPage` : halaman yang menampilkan daftar menu
- `DetailPage` : halaman yang menampilkan detail sebuah item
- `build(BuildContext context)` : fungsi yang membangun tampilan widget
- `Navigator.push()` : berpindah ke halaman baru dan menambah stack halaman
- `Navigator.pop()` : menutup halaman saat ini dan kembali ke layar sebelumnya

## Konsep Layout

- `Container` : wadah untuk margin, padding, warna, dan border
- `Padding` : memberi jarak antar elemen
- `Row` : menyusun elemen secara horizontal
- `Column` : menyusun elemen secara vertikal
- `Expanded` : membuat widget mengisi ruang yang tersisa
- `CircleAvatar` : menampilkan avatar berbentuk lingkaran
- `ListTile` : komponen standar untuk item daftar dengan judul, subjudul, dan ikon

## Model Data

```dart
class Makanan {
  final String nama;
  final int harga;
  final String deskripsi;

  const Makanan(this.nama, this.harga, this.deskripsi);
}
```

- `Makanan` berfungsi sebagai model data untuk menyimpan informasi menu.
- `nama`, `harga`, dan `deskripsi` adalah properti objek.
- `const` digunakan agar objek bisa dibuat tetap dan lebih efisien.

## Data List

```dart
const daftarMenu = [
  Makanan('Nasi Goreng', 15000, 'Nasi goreng spesial dengan telur dan sayuran.'),
  Makanan('Mie Ayam', 12000, 'Mie ayam dengan potongan ayam dan sayuran.'),
];
```

- `daftarMenu` adalah list data yang berisi beberapa objek `Makanan`.
- List ini akan ditampilkan di layar menggunakan `ListView.builder`.

## ListView Builder

```dart
ListView.builder(
  itemCount: daftarMenu.length,
  itemBuilder: (context, index) {
    final item = daftarMenu[index];
    return ListTile(
      title: Text(item.nama),
      subtitle: Text(formatHarga(item.harga)),
    );
  },
);
```

- `itemCount` menentukan jumlah item yang akan ditampilkan.
- `itemBuilder` membangun widget untuk setiap item secara dinamis.
- `ListTile` menampilkan informasi singkat dari item menu.

## Navigasi Antar Halaman

```dart
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (_) => DetailPage(makanan: item),
    ),
  );
},
```

- `Navigator.push` membuka halaman baru.
- `MaterialPageRoute` mengarahkan ke halaman tujuan.
- `makanan: item` mengirim data item yang dipilih ke halaman detail.

## Fungsi Format Harga

```dart
String formatHarga(int harga) {
  return 'Rp ${harga.toString().replaceAllMapped(
    RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
    (match) => '${match.group(1)}.',
  )}';
}
```

- Fungsi ini mengubah angka menjadi format rupiah.
- Contoh: `15000` menjadi `Rp 15.000`.
- Regex dipakai untuk menambahkan titik sebagai pemisah ribuan.

## Penjelasan Program Profil

Pada layout kartu profil, digunakan `Container` untuk membungkus isi, lalu `Row` untuk menempatkan `CircleAvatar` di sebelah kiri dan teks data di sebelah kanan. `Padding` dan `SizedBox` digunakan untuk memberi ruang agar layout terlihat rapi.

## Jawaban Refleksi

- **ListView.builder** dipakai karena lebih efisien untuk daftar data yang panjang dibanding ListView biasa.
- **Navigator.push** memungkinkan berpindah halaman tanpa menghilangkan halaman sebelumnya.
- **Model data** sangat penting agar data mudah dikelola dan digunakan di banyak widget.
- **Layout** yang rapi membuat aplikasi lebih nyaman dilihat dan lebih profesional.

## Kesimpulan

Pertemuan 2 menekankan pada layout, daftar data, dan navigasi. Mahasiswa belajar menyusun tampilan yang rapi, menampilkan data dinamis menggunakan `ListView.builder`, serta mengirim data antar halaman menggunakan `Navigator`.
