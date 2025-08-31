import { SESClient, SendEmailCommand } from '@aws-sdk/client-ses';
import { EmailService } from './types';
import { getVerificationEmailTemplate, getPasswordResetEmailTemplate } from './templates';

export class SESEmailService implements EmailService {
  private sesClient: SESClient;
  private fromEmail: string;

  constructor() {
    this.sesClient = new SESClient({
      region: process.env.AWS_REGION || 'us-east-1',
      credentials: {
        accessKeyId: process.env.AWS_ACCESS_KEY_ID!,
        secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY!,
      },
    });
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
    const command = new SendEmailCommand({
      Source: this.fromEmail,
      Destination: {
        ToAddresses: [to],
      },
      Message: {
        Subject: {
          Data: subject,
          Charset: 'UTF-8',
        },
        Body: {
          Html: {
            Data: html,
            Charset: 'UTF-8',
          },
          Text: {
            Data: text,
            Charset: 'UTF-8',
          },
        },
      },
    });

    await this.sesClient.send(command);
  }
}