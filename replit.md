# Ludis - Athletic Recruiting Platform

## Overview
Ludis is an athletic recruiting platform that connects athletes with coaches and institutions. Built with Next.js, TypeScript, Tailwind CSS, and PostgreSQL.

## Project Structure
```
/
├── pages/              # Next.js pages
│   ├── api/            # API routes
│   ├── _app.tsx        # App wrapper
│   └── index.tsx       # Homepage
├── src/
│   └── lib/
│       └── db.ts       # Database connection
├── styles/
│   └── globals.css     # Global styles with Tailwind
├── schema.sql          # Database schema
└── package.json        # Dependencies
```

## Tech Stack
- **Framework**: Next.js 14
- **Language**: TypeScript
- **Styling**: Tailwind CSS
- **Database**: PostgreSQL
- **Authentication**: bcrypt for password hashing

## Database Schema
- **users**: Core user accounts (athlete/coach/institution roles)
- **institutions**: Verified schools and organizations
- **athletes**: Athlete profiles with stats
- **coaches**: Coach profiles linked to institutions
- **athlete_videos**: Video uploads for athletes
- **contact_requests**: Communication between coaches and athletes

## Running Locally
```bash
npm install
npm run dev
```

The app runs on port 5000.

## Environment Variables
- `DATABASE_URL`: PostgreSQL connection string

## Recent Changes
- January 31, 2026: Initial Replit setup with Next.js, Tailwind CSS, and PostgreSQL database
