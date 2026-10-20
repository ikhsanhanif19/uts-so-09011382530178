#!/bin/bash
# Nama  : Ikhsan Hanif
# NIM   : 09011382530178
# Kelas : sku3b
#
# Menjalankan backup.sh berulang di background.
# Jalankan : ./backup_loop.sh &
# Hentikan : kill %1   (atau kill PID)

# ---------- Variabel ----------
INTERVAL="${INTERVAL:-60}"                       # jeda antar backup (detik)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_SCRIPT="$SCRIPT_DIR/backup.sh"

echo "Loop backup dimulai (PID $$), jeda ${INTERVAL} detik."

# ---------- Perulangan tanpa henti ----------
while true; do
    "$BACKUP_SCRIPT"
    sleep "$INTERVAL"
done
