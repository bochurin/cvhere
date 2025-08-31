import fs from 'fs';
import path from 'path';
import YAML from 'yaml';
import { AppConfig } from './types';

class ConfigService {
  private config: AppConfig;
  private configPath: string;
  private watcher?: fs.FSWatcher;

  constructor() {
    this.configPath = path.join(process.cwd(), 'config', 'app-config.yaml');
    this.config = this.loadConfig();
    this.startWatching();
  }

  private loadConfig(): AppConfig {
    try {
      const configData = fs.readFileSync(this.configPath, 'utf8');
      return YAML.parse(configData);
    } catch (error) {
      console.error('Failed to load config file:', error);
      return this.getDefaultConfig();
    }
  }

  private getDefaultConfig(): AppConfig {
    return {
      email: {
        providers: ['ses', 'sendgrid'],
        limits: {
          ses: {
            dailyLimit: 200,
            monthlyLimit: 62000
          },
          sendgrid: {
            dailyLimit: 100,
            monthlyLimit: 3000
          }
        },
        fromEmail: process.env.FROM_EMAIL || 'noreply@cvhere.net'
      },
      api: {
        rateLimitPerMinute: 100,
        jwtExpiresIn: '7d'
      },
      features: {
        emailVerificationRequired: true,
        passwordResetEnabled: true
      },
      updatedAt: new Date().toISOString(),
      version: '1.0.0'
    };
  }

  private startWatching(): void {
    this.watcher = fs.watch(this.configPath, (eventType) => {
      if (eventType === 'change') {
        console.log('Config file changed, reloading...');
        this.config = this.loadConfig();
      }
    });
  }

  public getConfig(): AppConfig {
    return { ...this.config };
  }

  public updateConfig(updates: Partial<AppConfig>): void {
    this.config = { ...this.config, ...updates, updatedAt: new Date().toISOString() };
    fs.writeFileSync(this.configPath, YAML.stringify(this.config));
  }

  public destroy(): void {
    if (this.watcher) {
      this.watcher.close();
    }
  }
}

export const configService = new ConfigService();