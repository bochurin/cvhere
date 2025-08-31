export interface AppConfig {
  email: {
    providers: ('ses' | 'sendgrid')[];
    limits: {
      ses: {
        dailyLimit: number;
        monthlyLimit: number;
      };
      sendgrid: {
        dailyLimit: number;
        monthlyLimit: number;
      };
    };
    fromEmail: string;
  };
  api: {
    rateLimitPerMinute: number;
    jwtExpiresIn: string | number;
  };
  features: {
    emailVerificationRequired: boolean;
    passwordResetEnabled: boolean;
  };
  updatedAt: string;
  version: string;
}