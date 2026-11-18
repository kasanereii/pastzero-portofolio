# K/YO Developer Portfolio

React + Vite portfolio with Supabase-backed project management and Vercel deployment.

## Quick start
1. Install Node.js 20+ and Git.
2. Open this project folder in a terminal.
3. Run `npm install`.
4. Copy `.env.example` to `.env` and fill in your Supabase project URL and **publishable / anon** key (never the service_role key).
5. In Supabase SQL Editor, run `supabase/schema.sql` on a new project. If running again, existing policies may require removal first.
6. In Supabase Authentication > Users, create an admin user with email and password. Copy its UUID.
7. Run `insert into public.portfolio_admins(user_id) values ('YOUR-ADMIN-USER-UUID');` in SQL Editor. Do not expose this SQL operation to public visitors.
8. Run `npm run dev` to preview locally.
9. Open `/` and click **Admin** to log in and add projects.

## Publish with GitHub + Vercel
1. Create a new GitHub repository and push the project files. `.env` is ignored.
2. On Vercel choose **Add New > Project**, import the GitHub repository.
3. Framework: Vite; build command: `npm run build`; output directory: `dist`.
4. Set environment variables `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY` in Vercel project settings.
5. Deploy. Each GitHub push triggers a new deployment.

## Notes
- If Supabase is not configured, the site displays sample projects. These are examples, not claims of completed paid work.
- Once real projects are inserted, they replace the sample cards.
- Project image uploads require an allowlisted admin account.
- The Supabase URL and publishable key are intended to be public; RLS protects write access.
- For production, consider CAPTCHA/rate limits on authentication and audit your RLS policies.
- To change your brand, services, or contacts, edit `src/App.jsx`.
