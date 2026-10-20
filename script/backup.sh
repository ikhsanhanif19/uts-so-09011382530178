#!/bin/bash
# Nama  : Ikhsan Hanif
# NIM   : 09011382530178
# Kelas : sku3b
#
# Backup file catatan praktikum: cari -> arsipkan -> verifikasi -> catat log.
# Pemakaian: ./backup.sh [ekstensi]   (bawaan: txt)

# ---------- Variabel (ubah di sini saja) ----------
NIM="09011382530178"
EXT="${1:-txt}"                          # ekstensi file yang dicari
SRC_DIR="$HOME/data_${NIM}"              # direktori sumber
DEST_DIR="$HOME/backup_${NIM}"           # direktori tujuan backup
LOG_FILE="$DEST_DIR/backup.log"          # file log
LIST_FILE="$DEST_DIR/daftar_file.txt"    # daftar hasil find
MAX_ARCHIVE=5                            # jumlah arsip yang disimpan (rotasi)

# ---------- Cek direktori sumber ----------
if [ ! -d "$SRC_DIR" ]; then
    echo "Error: direktori sumber '$SRC_DIR' tidak ditemukan." >&2
    exit 1
fi

# ---------- Buat direktori tujuan jika belum ada ----------
mkdir -p "$DEST_DIR"

# ---------- Cari semua file (termasuk subdirektori) ----------
(cd "$SRC_DIR" && find . -type f -name "*.${EXT}" | sort) > "$LIST_FILE"
JUMLAH=$(wc -l < "$LIST_FILE")

if [ "$JUMLAH" -eq 0 ]; then
    echo "Tidak ada file .${EXT} di '$SRC_DIR'. Backup dibatalkan." >&2
    exit 1
fi
echo "Ditemukan $JUMLAH file .${EXT}:"
cat "$LIST_FILE"

# ---------- Arsipkan dan kompres ----------
WAKTU=$(date +%Y%m%d_%H%M%S)
ARSIP_NAMA="backup_${NIM}_${WAKTU}.tar.gz"
ARSIP="$DEST_DIR/$ARSIP_NAMA"
tar -C "$SRC_DIR" -czvf "$ARSIP" -T "$LIST_FILE"

# ---------- Verifikasi isi arsip (tanpa ekstrak) ----------
echo "Isi arsip $ARSIP_NAMA:"
tar -tzvf "$ARSIP"

# ---------- Catat ke log (tepat satu baris, redirect >>) ----------
UKURAN=$(du -h "$ARSIP" | cut -f1)
echo "$(date '+%Y-%m-%d %H:%M:%S') | $ARSIP_NAMA | $JUMLAH | $UKURAN" >> "$LOG_FILE"

# ---------- Rotasi: simpan hanya $MAX_ARCHIVE arsip terbaru ----------
ls -1t "$DEST_DIR"/backup_"${NIM}"_*.tar.gz 2>/dev/null | tail -n +$((MAX_ARCHIVE + 1)) | while read -r lama; do
    rm -f -- "$lama"
    echo "Rotasi: menghapus arsip lama $(basename "$lama")"
done

echo "Backup selesai: $ARSIP_NAMA"
