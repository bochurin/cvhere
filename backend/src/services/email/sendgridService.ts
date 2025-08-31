import sgMail from '@sendgrid/mail';
import { EmailService } from './types';
import { getVerificationEmailTemplate, getPasswordResetEmailTemplate } from './templates';

export class SendGridEmailService implements EmailService {
  private fromEmail: string;

  constructor() {
    sgMail.setApiKey(process.env.SENDGRID_API_KEY!);
    this.fromEmail = process.env.FROM_EMAIL || 'noreply@cvhere.net';
  }

  async sendVerificationEmail(to: string, token: string): Promise<void> {
    const template = getVerificationEmailTemplate(token);
    await this.sendEmail(to, template.subject, template.html, template.text);
  }

  async sendPasswordResetEmail(to: string, token: string): Promise<void> {
    const template = getPasswordResetEmailTemplate(token);
    await this.sendEmail(to, template.subject, template.html, template.text);
  }

  private async sendEmail(to: string, subject: string, html: string, text: string): Promise<void> {
    await sgMail.send({
      to,
      from: this.fromEmail,
      subject,
      html,
      text,
    });
  }
}