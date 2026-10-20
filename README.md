# UTS Sistem Operasi - Backup Otomatis

## Identitas
- Nama  : Ikhsan Hanif
- NIM   : 09011382530178
- Kelas : sku3b

## Deskripsi
`backup.sh` mencari semua file `.txt` (termasuk subdirektori) di `~/data_NIM` dengan `find`,
menyimpan daftarnya ke `daftar_file.txt`, lalu mengarsipkan dan mengompresinya dengan `tar -czvf`
menjadi `backup_NIM_TANGGAL_JAM.tar.gz` di `~/backup_NIM`. Isi arsip ditampilkan dengan
`tar -tzvf`, dan satu baris dicatat ke `backup.log` (`>>`) berformat
`tanggal jam | nama arsip | jumlah file | ukuran`.

`backup_loop.sh` menjalankan `backup.sh` berulang dengan `while true` dan `sleep $INTERVAL`
(bawaan 60 detik). `alias.sh` berisi alias `bk178` untuk menjalankan backup.

## Cara menjalankan
```bash
cd ~/uts-so-09011382530178
chmod +x script/*.sh
./script/backup.sh              # backup sekali
./script/backup_loop.sh &       # backup berulang di background
INTERVAL=10 ./script/backup_loop.sh &   # ubah jeda jadi 10 detik
kill %1                         # hentikan loop
source script/alias.sh && bk178 # pakai alias
```

## Fitur pengembangan
1. **Parameter ekstensi**: `./script/backup.sh pdf` mengarsipkan file `.pdf` (bawaan `txt`).
2. **Rotasi arsip**: hanya 5 arsip terbaru disimpan; jalankan backup lebih dari 5 kali lalu cek `ls ~/backup_09011382530178`.

## Bukti job control
Tempel keluaran terminal ASLI Anda di sini (teks, bukan gambar):

```
$ ./script/backup_loop.sh &
(tempel)
$ jobs -l
(tempel)
$ fg
(tempel, lalu tekan Ctrl+Z)
$ bg
(tempel)
$ ps x
(tempel)
$ kill %1
(tempel)
```

## Kendala
- (Tulis error yang Anda alami dan cara mengatasinya.)
