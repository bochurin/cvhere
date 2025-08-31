import { EmailService } from './types';
import { SESEmailService } from './sesService';
import { SendGridEmailService } from './sendgridService';
import { FailoverEmailService } from './failoverService';
import { configService } from '../config';

// Factory function for email service - easily replaceable
export const createEmailService = (): EmailService => {
  const providers = configService.getConfig().email.providers;
  
  // If multiple providers, use failover service
  if (providers.length > 1) {
    return new FailoverEmailService();
  }
  
  // Single provider
  const provider = providers[0];
  switch (provider) {
    case 'ses':
      return new SESEmailService();
    case 'sendgrid':
      return new SendGridEmailService();
    default:
      return new FailoverEmailService();
  }
};

export * from './types';