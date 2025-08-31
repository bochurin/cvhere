import { EmailService } from './types';
import { SESEmailService } from './sesService';
import { SendGridEmailService } from './sendgridService';

interface EmailLimits {
  dailyLimit: number;
  dailyCount: number;
  lastResetDate: string;
}

export class FailoverEmailService implements EmailService {
  private primaryService: EmailService;
  private secondaryService: EmailService;
  private limits: EmailLimits;

  constructor() {
    this.primaryService = new SESEmailService();
    this.secondaryService = new SendGridEmailService();
    this.limits = {
      dailyLimit: parseInt(process.env.SES_DAILY_LIMIT || '200'), // AWS SES default limit
      dailyCount: 0,
      lastResetDate: new Date().toDateString()
    };
  }

  async sendVerificationEmail(to: string, token: string): Promise<void> {
    await this.sendWithFailover(
      () => this.primaryService.sendVerificationEmail(to, token),
      () => this.secondaryService.sendVerificationEmail(to, token)
    );
  }

  async sendPasswordResetEmail(to: string, token: string): Promise<void> {
    await this.sendWithFailover(
      () => this.primaryService.sendPasswordResetEmail(to, token),
      () => this.secondaryService.sendPasswordResetEmail(to, token)
    );
  }

  private async sendWithFailover(
    primaryAction: () => Promise<void>,
    secondaryAction: () => Promise<void>
  ): Promise<void> {
    this.resetDailyCountIfNeeded();

    // Check if primary service is available and within limits
    if (this.canUsePrimary()) {
      try {
        await primaryAction();
        this.incrementDailyCount();
        return;
      } catch (error) {
        console.warn('Primary email service failed, trying secondary:', error);
      }
    }

    // Use secondary service
    try {
      await secondaryAction();
    } catch (error) {
      console.error('Both email services failed:', error);
      throw new Error('Email delivery failed');
    }
  }

  private canUsePrimary(): boolean {
    return this.limits.dailyCount < this.limits.dailyLimit;
  }

  private incrementDailyCount(): void {
    this.limits.dailyCount++;
  }

  private resetDailyCountIfNeeded(): void {
    const today = new Date().toDateString();
    if (this.limits.lastResetDate !== today) {
      this.limits.dailyCount = 0;
      this.limits.lastResetDate = today;
    }
  }
}