import { EmailService } from './types';
import { SESEmailService } from './sesService';
import { SendGridEmailService } from './sendgridService';
import { FailoverEmailService } from './failoverService';

// Factory function for email service - easily replaceable
export const createEmailService = (): EmailService => {
  const provider = process.env.EMAIL_PROVIDER || 'failover';
  
  switch (provider) {
    case 'ses':
      return new SESEmailService();
    case 'sendgrid':
      return new SendGridEmailService();
    case 'failover':
      return new FailoverEmailService();
    default:
      return new FailoverEmailService();
  }
};

export * from './types';