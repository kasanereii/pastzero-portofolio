-- Run in Supabase SQL Editor. Do not expose your service_role key to the browser.
create table if not exists public.portfolio_admins (
  user_id uuid primary key references auth.users(id) on delete cascade
);
create table if not exists public.projects (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  category text not null,
  description text not null,
  tech text[] not null default '{}',
  image_url text,
  project_url text,
  created_at timestamptz not null default now()
);
alter table public.portfolio_admins enable row level security;
alter table public.projects enable row level security;
create policy "Public can view projects" on public.projects for select to anon, authenticated using (true);
create policy "Admins can add projects" on public.projects for insert to authenticated with check (exists(select 1 from public.portfolio_admins where user_id=(select auth.uid())));
create policy "Admins can edit projects" on public.projects for update to authenticated using (exists(select 1 from public.portfolio_admins where user_id=(select auth.uid()))) with check (exists(select 1 from public.portfolio_admins where user_id=(select auth.uid())));
create policy "Admins can delete projects" on public.projects for delete to authenticated using (exists(select 1 from public.portfolio_admins where user_id=(select auth.uid())));
insert into storage.buckets (id,name,public,file_size_limit,allowed_mime_types) values ('project-images','project-images',true,5242880,array['image/jpeg','image/png','image/webp','image/gif']) on conflict(id) do nothing;
create policy "Anyone can view portfolio images" on storage.objects for select to public using(bucket_id='project-images');
create policy "Admins can upload portfolio images" on storage.objects for insert to authenticated with check(bucket_id='project-images' and exists(select 1 from public.portfolio_admins where user_id=(select auth.uid())));
-- After creating your admin in Authentication > Users, run:
-- insert into public.portfolio_admins(user_id) values ('YOUR-ADMIN-USER-UUID');
