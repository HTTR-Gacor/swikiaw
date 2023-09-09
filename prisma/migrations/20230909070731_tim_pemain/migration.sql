-- CreateTable
CREATE TABLE "Tim" (
    "nama" TEXT NOT NULL,
    "universitas" TEXT NOT NULL,
    "username_manajer" TEXT NOT NULL,

    CONSTRAINT "Tim_pkey" PRIMARY KEY ("nama")
);

-- CreateTable
CREATE TABLE "Pemain" (
    "username" TEXT NOT NULL,
    "nama_tim" TEXT,

    CONSTRAINT "Pemain_pkey" PRIMARY KEY ("username")
);

-- CreateIndex
CREATE UNIQUE INDEX "Tim_username_manajer_key" ON "Tim"("username_manajer");

-- CreateIndex
CREATE UNIQUE INDEX "Pemain_nama_tim_key" ON "Pemain"("nama_tim");

-- AddForeignKey
ALTER TABLE "Tim" ADD CONSTRAINT "Tim_username_manajer_fkey" FOREIGN KEY ("username_manajer") REFERENCES "User"("username") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pemain" ADD CONSTRAINT "Pemain_username_fkey" FOREIGN KEY ("username") REFERENCES "User"("username") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Pemain" ADD CONSTRAINT "Pemain_nama_tim_fkey" FOREIGN KEY ("nama_tim") REFERENCES "Tim"("nama") ON DELETE SET NULL ON UPDATE CASCADE;
