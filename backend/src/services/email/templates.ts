import { EmailTemplate } from './types';

export const getVerificationEmailTemplate = (token: string): EmailTemplate => ({
  subject: 'Verify your CVHere account',
  html: `
    <h2>Welcome to CVHere!</h2>
    <p>Please verify your email address by clicking the link below:</p>
    <a href="${process.env.FRONTEND_URL}/verify-email?token=${token}" 
       style="background: #007bff; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">
      Verify Email
    </a>
    <p>If the button doesn't work, copy and paste this link:</p>
    <p>${process.env.FRONTEND_URL}/verify-email?token=${token}</p>
    <p>This link expires in 24 hours.</p>
  `,
  text: `
    Welcome to CVHere!
    
    Please verify your email address by visiting:
    ${process.env.FRONTEND_URL}/verify-email?token=${token}
    
    This link expires in 24 hours.
  `
});

export const getPasswordResetEmailTemplate = (token: string): EmailTemplate => ({
  subject: 'Reset your CVHere password',
  html: `
    <h2>Password Reset Request</h2>
    <p>You requested to reset your password. Click the link below to set a new password:</p>
    <a href="${process.env.FRONTEND_URL}/reset-password?token=${token}"
       style="background: #dc3545; color: white; padding: 10px 20px; text-decoration: none; border-radius: 5px;">
      Reset Password
    </a>
    <p>If the button doesn't work, copy and paste this link:</p>
    <p>${process.env.FRONTEND_URL}/reset-password?token=${token}</p>
    <p>This link expires in 1 hour.</p>
    <p>If you didn't request this, please ignore this email.</p>
  `,
  text: `
    Password Reset Request
    
    You requested to reset your password. Visit this link to set a new password:
    ${process.env.FRONTEND_URL}/reset-password?token=${token}
    
    This link expires in 1 hour.
    If you didn't request this, please ignore this email.
  `
});