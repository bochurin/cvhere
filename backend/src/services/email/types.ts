export interface EmailService {
  sendVerificationEmail(to: string, token: string): Promise<void>;
  sendPasswordResetEmail(to: string, token: string): Promise<void>;
}

export interface EmailTemplate {
  subject: string;
  html: string;
  text: string;
}