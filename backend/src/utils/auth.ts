import bcrypt from 'bcrypt';
import { sign, verify, SignOptions } from 'jsonwebtoken';
import { StringValue } from 'ms';
import crypto from 'crypto';
import { configService } from '../services/config';

export const hashPassword = async (password: string): Promise<string> => {
  return bcrypt.hash(password, 12);
};

export const comparePassword = async (password: string, hash: string): Promise<boolean> => {
  return bcrypt.compare(password, hash);
};

export const generateJWT = (userId: string): string => {
  const config = configService.getConfig();
  const options: SignOptions = {
    expiresIn: config.api.jwtExpiresIn as StringValue
  };
  return sign(
    { userId },
    process.env.JWT_SECRET!,
    options
  );
};

export const verifyJWT = (token: string): { userId: string } => {
  return verify(token, process.env.JWT_SECRET!) as { userId: string };
};

export const generateToken = (): string => {
  return crypto.randomBytes(32).toString('hex');
};