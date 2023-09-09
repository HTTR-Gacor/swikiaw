import { Body, Controller, Get, Post } from '@nestjs/common';
import { AuthService } from './auth.service';

@Controller('auth')
export class AuthController {
  constructor(private authService: AuthService) {}

  @Get('hello')
  async getHello() {
    return this.authService.getHello();
  }

  @Post('create')
  async create(
    @Body('nama') nama: string,
    @Body('alamat') alamat: string,
    @Body('kapasitas') kapasitas: number,
  ) {
    const stadium = await this.authService.create(nama, alamat, kapasitas);
    return stadium;
  }
}
