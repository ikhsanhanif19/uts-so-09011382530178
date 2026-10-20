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

```
$ INTERVAL=10 ./backup_loop.sh > /dev/null &
[1] 5298
$ jobs -l
[1]+  5298 Running                 INTERVAL=10 ./backup_loop.sh > /dev/null &
$ fg
INTERVAL=10 ./backup_loop.sh > /dev/null
^Z
[1]+  Stopped                 INTERVAL=10 ./backup_loop.sh > /dev/null
$ bg
[1]+ INTERVAL=10 ./backup_loop.sh > /dev/null &
$ ps x | grep backup_loop
 5298 pts/0    S      0:00 /bin/bash ./backup_loop.sh
 5425 pts/0    S+     0:00 grep --color=auto backup_loop
$ sleep 25
$ ls ~/backup_09011382530178
backup_09011382530178_20261020_134135.tar.gz
backup_09011382530178_20261020_134145.tar.gz
backup_09011382530178_20261020_134155.tar.gz
backup_09011382530178_20261020_134205.tar.gz
backup_09011382530178_20261020_134215.tar.gz
backup.log
daftar_file.txt
$ kill %1
$ jobs -l
[1]+  5298 Terminated              INTERVAL=10 ./backup_loop.sh > /dev/null
```

Keterangan: loop berjalan di background (`&`), dipindah ke foreground (`fg`), dihentikan sementara (Ctrl+Z), dilanjutkan di background (`bg`), lalu dihentikan (`kill %1`). Arsip terbentuk tiap 10 detik dan rotasi menyisakan 5 arsip terbaru.

## Kendala

- Salah mengetik `github,com` dengan koma sehingga `git clone` gagal; diperbaiki dengan `github.com`.
- Pesan commit tidak ditutup tanda kutip sehingga terminal menunggu input; diperbaiki dengan Ctrl+C lalu mengetik ulang.
- `timedatectl` tidak ada di Ubuntu 18.04; waktu sudah benar dari perintah `date`.
- Nama repositori sempat berhuruf kapital; diubah menjadi huruf kecil lewat Settings GitHub.
## Bukti job control

```
$ INTERVAL=10 ./backup_loop.sh > /dev/null &
[1] 5298
$ jobs -l
[1]+  5298 Running                 INTERVAL=10 ./backup_loop.sh > /dev/null &
$ fg
INTERVAL=10 ./backup_loop.sh > /dev/null
^Z
[1]+  Stopped                 INTERVAL=10 ./backup_loop.sh > /dev/null
$ bg
[1]+ INTERVAL=10 ./backup_loop.sh > /dev/null &
$ ps x | grep backup_loop
 5298 pts/0    S      0:00 /bin/bash ./backup_loop.sh
 5425 pts/0    S+     0:00 grep --color=auto backup_loop
$ sleep 25
$ ls ~/backup_09011382530178
backup_09011382530178_20261020_134135.tar.gz
backup_09011382530178_20261020_134145.tar.gz
backup_09011382530178_20261020_134155.tar.gz
backup_09011382530178_20261020_134205.tar.gz
backup_09011382530178_20261020_134215.tar.gz
backup.log
daftar_file.txt
$ kill %1
$ jobs -l
[1]+  5298 Terminated              INTERVAL=10 ./backup_loop.sh > /dev/null
```

Keterangan: loop berjalan di background (`&`), dipindah ke foreground (`fg`), dihentikan sementara (Ctrl+Z), dilanjutkan di background (`bg`), lalu dihentikan (`kill %1`). Arsip terbentuk tiap 10 detik dan rotasi menyisakan 5 arsip terbaru.

## Kendala

- Salah mengetik `github,com` dengan koma sehingga `git clone` gagal; diperbaiki dengan `github.com`.
- Pesan commit tidak ditutup tanda kutip sehingga terminal menunggu input; diperbaiki dengan Ctrl+C lalu mengetik ulang.
- `timedatectl` tidak ada di Ubuntu 18.04; waktu sudah benar dari perintah `date`.
- Nama repositori sempat berhuruf kapital; diubah menjadi huruf kecil lewat Settings GitHub.
