# Project Instructions

## Tech Stack
- **Next.js 15** with App Router
- **tRPC v11** for type-safe API
- **Prisma** ORM with PostgreSQL
- **NextAuth.js** for authentication
- **Tailwind CSS** + **shadcn/ui**

## Commands
```bash
npm run dev          # Development server
npm run build        # Production build
npm test             # Run tests
npm run db:push      # Push schema changes
npm run db:generate  # Generate migration
```

## Architecture
```
src/
├── app/              # Next.js pages
├── server/api/       # tRPC routers
├── server/auth/      # Auth config
├── components/       # React components
└── lib/              # Utilities
```

## Conventions
- TypeScript strict mode
- Zod validation for all inputs
- Conventional commits
- 80% test coverage target
