# User Test Instructions: PostgreSQL 16 Environment

Instruksi berikut ini menggunakan PostgreSQL 16 dengan dataset yang telah disediakan: `backup-dvdrental-202410100947.sql`.

## Tujuan:
1. **Tampilkan List Tabel Film Berdasarkan Jumlah Sewa Terbanyak:**
   Buatlah query untuk menampilkan daftar film yang diurutkan berdasarkan jumlah penyewaan terbanyak.

2. **Hitung Rata-Rata Lama Penyewaan Film:**
   Buatlah query yang menghitung rata-rata lama penyewaan setiap film dalam satuan hari.

## Penjelasasan Jawaban 1 - Daftar Film Berdasarkan Jumlah Penyewaan Terbanyak

file: `dvdrental-frequent-rent.sql`

```sql
SELECT f.film_id, f.title, COUNT(r.rental_id) AS rental_count
```

**Memilih ID film, judul film, dan jumlah penyewaan untuk setiap film**: Kolom `film_id` merupakan _unique identifier_ untuk setiap film, `title` sebagai judul film, dan `COUNT(r.rental_id)` untuk menghitung total sewa yang dilakukan pada film tersebut.

```sql
FROM film f
JOIN inventory i ON f.film_id = i.film_id
JOIN rental r ON i.inventory_id = r.inventory_id
```

**Menggabungkan tabel film, inventory, dan rental**: Tabel film dihubungkan dengan tabel inventory berdasarkan kolom `film_id`, lalu tabel `inventory` dihubungkan dengan tabel rental berdasarkan kolom `inventory_id`. Dengan cara ini, kita bisa mendapatkan data sewa untuk setiap film.

```sql
GROUP BY f.film_id, f.title
```

**Mengelompokkan hasil berdasarkan ID film dan judul film**: Query ini mengelompokkan data berdasarkan `film_id` dan `title` agar setiap film hanya muncul sekali dengan jumlah sewa yang sesuai.

```sql
ORDER BY rental_count DESC;
```

**Mengurutkan hasil berdasarkan jumlah penyewaan dalam urutan menurun**: Hasil query diurutkan berdasarkan jumlah penyewaan `(rental_count)`, dari yang paling sering disewa hingga yang paling sedikit.

## Penjelasasan Jawaban 2 - rata-rata lama sewa setiap film dalam satuan hari.

file: `dvdrental-average-rent.sql`

```sql
SELECT f.film_id, f.title, ROUND(AVG(DATE_PART('day', r.return_date - r.rental_date))) AS average_rental_duration_days
```

**Memilih ID film, judul film, dan menghitung rata-rata lama penyewaan (dalam hari)**: Menggunakan DATE_PART untuk mendapatkan hari saja dari interval durasi sewa, lalu menghitung rata-rata dan membulatkannya.

```sql
FROM film f JOIN inventory i ON f.film_id = i.film_id JOIN rental r ON i.inventory_id = r.inventory_id
```

**Menggabungkan tabel film, inventory, dan rental untuk mendapatkan data penyewaan:**: Sama seperti query pertama, tabel film dihubungkan dengan tabel inventory berdasarkan kolom `film_id`, dan tabel `inventory` dihubungkan dengan tabel `rental` berdasarkan kolom `inventory_id` untuk mendapatkan data penyewaan.

```sql
WHERE r.return_date IS NOT NULL
```

**Memfilter hasil untuk memastikan hanya menghitung sewa dvd yang sudah dikembalikan saja**: Filter ini memastikan hanya penyewaan yang sudah dikembalikan yang dihitung durasi sewanya, karena penyewaan yang belum dikembalikan tidak memiliki tanggal pengembalian `(return_date)`.

```sql
GROUP BY f.film_id, f.title
```

**Mengelompokkan hasil berdasarkan ID film dan judul film**: Query ini mengelompokkan data berdasarkan film_id dan title agar setiap film hanya muncul sekali dengan rata-rata durasi sewa yang sesuai.

```sql
ORDER BY average_rental_duration_days DESC
```

**Mengurutkan hasil berdasarkan rata-rata durasi sewa dalam urutan menurun**: Hasil query diurutkan dari film dengan rata-rata lama penyewaan tertinggi hingga terendah.