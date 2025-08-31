import { EmailService } from './types';
import { SESEmailService } from './sesService';

// Factory function for email service - easily replaceable
export const createEmailService = (): EmailService => {
  const provider = process.env.EMAIL_PROVIDER || 'ses';
  
  switch (provider) {
    case 'ses':
      return new SESEmailService();
    // Easy to add other providers:
    // case 'sendgrid':
    //   return new SendGridEmailService();
    // case 'mailgun':
    //   return new MailgunEmailService();
    default:
      return new SESEmailService();
  }
};

export * from './types';