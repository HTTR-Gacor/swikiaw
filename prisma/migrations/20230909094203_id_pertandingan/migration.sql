-- AddForeignKey
ALTER TABLE "Wasit_Pertandingan" ADD CONSTRAINT "Wasit_Pertandingan_id_pertandingan_fkey" FOREIGN KEY ("id_pertandingan") REFERENCES "Pertandingan"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
