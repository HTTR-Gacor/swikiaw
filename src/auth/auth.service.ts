import { Injectable } from '@nestjs/common';
import { PrismaService } from 'src/prisma.service';

@Injectable()
export class AuthService {
  constructor(private prisma: PrismaService) {}

  getHello() {
    return this.prisma.stadium.findMany();
  }

  async create(nama: string, alamat: string, kapasitas: number) {
    const stadium = await this.prisma.stadium.create({
      data: {
        nama,
        alamat,
        kapasitas,
      },
    });
    return stadium;
  }
}
