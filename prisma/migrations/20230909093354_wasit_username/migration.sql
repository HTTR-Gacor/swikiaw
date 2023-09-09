/*
  Warnings:

  - Added the required column `is_captain` to the `Pemain` table without a default value. This is not possible if the table is not empty.
  - Added the required column `npm` to the `Pemain` table without a default value. This is not possible if the table is not empty.
  - Added the required column `posisi` to the `Pemain` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "Pemain_nama_tim_key";

-- AlterTable
ALTER TABLE "Pemain" ADD COLUMN     "is_captain" BOOLEAN NOT NULL,
ADD COLUMN     "npm" TEXT NOT NULL,
ADD COLUMN     "posisi" TEXT NOT NULL;

-- CreateTable
CREATE TABLE "Wasit" (
    "username" TEXT NOT NULL,
    "lisensi" TEXT NOT NULL,

    CONSTRAINT "Wasit_pkey" PRIMARY KEY ("username")
);

-- CreateTable
CREATE TABLE "Pelatih" (
    "username" TEXT NOT NULL,
    "nama_tim" TEXT,
    "spesialisasi" TEXT NOT NULL,

    CONSTRAINT "Pelatih_pkey" PRIMARY KEY ("username")
);

-- CreateTable
CREATE TABLE "Stadium" (
    "id" UUID NOT NULL,
    "nama" TEXT NOT NULL,
    "alamat" TEXT NOT NULL,
    "kapasitas" INTEGER NOT NULL,

    CONSTRAINT "Stadium_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Pertandingan" (
    "id" UUID NOT NULL,
    "start" TIMESTAMP(3) NOT NULL,
    "end" TIMESTAMP(3) NOT NULL,
    "stadium_id" UUID NOT NULL,

    CONSTRAINT "Pertandingan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Peristiwa" (
    "id_pertandingan" UUID NOT NULL,
    "time" INTEGER NOT NULL,
    "jenis" TEXT NOT NULL,
    "username_pemain" TEXT NOT NULL,

    CONSTRAINT "Peristiwa_pkey" PRIMARY KEY ("id_pertandingan","time","jenis")
);

-- CreateTable
CREATE TABLE "Wasit_Pertandingan" (
    "username_wasit" TEXT NOT NULL,
    "id_pertandingan" UUID NOT NULL,
    "posisi_wasit" TEXT NOT NULL,

    CONSTRAINT "Wasit_Pertandingan_pkey" PRIMARY KEY ("username_wasit","id_pertandingan")
);

-- CreateTable
CREATE TABLE "Pembelian_Tiket" (
    "id_receipt" UUID NOT NULL,
    "username_penonton" TEXT NOT NULL,
    "tanggal_pembelian" TIMESTAMP(3) NOT NULL,
    "jenis_tiket" TEXT NOT NULL,
    "jenis_pembayaran" TEXT NOT NULL,

    CONSTRAINT "Pembelian_Tiket_pkey" PRIMARY KEY ("id_receipt")
);

-- CreateTable
CREATE TABLE "Tim_Pertandigan" (
    "id_pertandingan" UUID NOT NULL,
    "nama_tim" TEXT NOT NULL,
    "skor" INTEGER NOT NULL,

    CONSTRAINT "Tim_Pertandigan_pkey" PRIMARY KEY ("id_pertandingan","nama_tim")
);

-- CreateTable
CREATE TABLE "Peminjaman" (
    "username_manajer" TEXT NOT NULL,
    "start" TIMESTAMP(3) NOT NULL,
    "end" TIMESTAMP(3) NOT NULL,
    "id_stadium" UUID NOT NULL,

    CONSTRAINT "Peminjaman_pkey" PRIMARY KEY ("username_manajer","start")
);

-- CreateTable
CREATE TABLE "Rapat" (
    "username_panitia" TEXT NOT NULL,
    "id_pertandingan" UUID NOT NULL,
    "datetime" TIMESTAMP(3) NOT NULL,
    "manajer_tim_A" TEXT NOT NULL,
    "manajer_tim_B" TEXT NOT NULL,
    "Isi" TEXT NOT NULL,

    CONSTRAINT "Rapat_pkey" PRIMARY KEY ("username_panitia","id_pertandingan","datetime","manajer_tim_A","manajer_tim_B")
);

-- CreateTable
CREATE TABLE "Undangan" (
    "id" UUID NOT NULL,
    "nama_tim" TEXT NOT NULL,
    "username_kandidat" TEXT NOT NULL,
    "status" TEXT NOT NULL,

    CONSTRAINT "Undangan_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Pendaftaran" (
    "id" UUID NOT NULL,
    "nama_tim" TEXT NOT NULL,
    "username_kandidat" TEXT NOT NULL,
    "status" TEXT NOT NULL,

    CONSTRAINT "Pendaftaran_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Ujian" (
    "id" UUID NOT NULL,
    "username_wasit" TEXT NOT NULL,
    "status" BOOLEAN NOT NULL,
    "tanggal" TIMESTAMP(3) NOT NULL,
    "skor" INTEGER NOT NULL,

    CONSTRAINT "Ujian_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "Rapat_id_pertandingan_key" ON "Rapat"("id_pertandingan");

-- AddForeignKey
ALTER TABLE "Wasit" ADD CONSTRAINT "Wasit_username_fkey" FOREIGN KEY ("username") REFERENCES "User"("username") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pelatih" ADD CONSTRAINT "Pelatih_username_fkey" FOREIGN KEY ("username") REFERENCES "User"("username") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pelatih" ADD CONSTRAINT "Pelatih_nama_tim_fkey" FOREIGN KEY ("nama_tim") REFERENCES "Tim"("nama") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pertandingan" ADD CONSTRAINT "Pertandingan_stadium_id_fkey" FOREIGN KEY ("stadium_id") REFERENCES "Stadium"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Peristiwa" ADD CONSTRAINT "Peristiwa_id_pertandingan_fkey" FOREIGN KEY ("id_pertandingan") REFERENCES "Pertandingan"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Peristiwa" ADD CONSTRAINT "Peristiwa_username_pemain_fkey" FOREIGN KEY ("username_pemain") REFERENCES "Pemain"("username") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Wasit_Pertandingan" ADD CONSTRAINT "Wasit_Pertandingan_username_wasit_fkey" FOREIGN KEY ("username_wasit") REFERENCES "Wasit"("username") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pembelian_Tiket" ADD CONSTRAINT "Pembelian_Tiket_username_penonton_fkey" FOREIGN KEY ("username_penonton") REFERENCES "User"("username") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Tim_Pertandigan" ADD CONSTRAINT "Tim_Pertandigan_nama_tim_fkey" FOREIGN KEY ("nama_tim") REFERENCES "Tim"("nama") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Tim_Pertandigan" ADD CONSTRAINT "Tim_Pertandigan_id_pertandingan_fkey" FOREIGN KEY ("id_pertandingan") REFERENCES "Pertandingan"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Peminjaman" ADD CONSTRAINT "Peminjaman_username_manajer_fkey" FOREIGN KEY ("username_manajer") REFERENCES "User"("username") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Peminjaman" ADD CONSTRAINT "Peminjaman_id_stadium_fkey" FOREIGN KEY ("id_stadium") REFERENCES "Stadium"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rapat" ADD CONSTRAINT "Rapat_username_panitia_fkey" FOREIGN KEY ("username_panitia") REFERENCES "User"("username") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rapat" ADD CONSTRAINT "Rapat_id_pertandingan_fkey" FOREIGN KEY ("id_pertandingan") REFERENCES "Pertandingan"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rapat" ADD CONSTRAINT "Rapat_manajer_tim_A_fkey" FOREIGN KEY ("manajer_tim_A") REFERENCES "User"("username") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Rapat" ADD CONSTRAINT "Rapat_manajer_tim_B_fkey" FOREIGN KEY ("manajer_tim_B") REFERENCES "User"("username") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Undangan" ADD CONSTRAINT "Undangan_username_kandidat_fkey" FOREIGN KEY ("username_kandidat") REFERENCES "User"("username") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Undangan" ADD CONSTRAINT "Undangan_nama_tim_fkey" FOREIGN KEY ("nama_tim") REFERENCES "Tim"("nama") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pendaftaran" ADD CONSTRAINT "Pendaftaran_username_kandidat_fkey" FOREIGN KEY ("username_kandidat") REFERENCES "User"("username") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pendaftaran" ADD CONSTRAINT "Pendaftaran_nama_tim_fkey" FOREIGN KEY ("nama_tim") REFERENCES "Tim"("nama") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Ujian" ADD CONSTRAINT "Ujian_username_wasit_fkey" FOREIGN KEY ("username_wasit") REFERENCES "Wasit"("username") ON DELETE RESTRICT ON UPDATE CASCADE;
