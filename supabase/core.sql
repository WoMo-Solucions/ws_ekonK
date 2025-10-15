create extension if not exists "uuid-ossp";

create table if not exists public.profiles (
  id uuid primary key default uuid_generate_v4(),
  user_id uuid unique not null references auth.users(id) on delete cascade,
  full_name text,
  role text default 'user',
  created_at timestamptz default now()
);

create table if not exists public.items (
  id uuid primary key default uuid_generate_v4(),
  owner uuid not null,
  name text not null,
  amount numeric(14,2) default 0,
  created_at timestamptz default now()
);

alter table public.profiles enable row level security;
alter table public.items enable row level security;

create policy "select_own_profile"
  on public.profiles for select using (auth.uid() = user_id);
create policy "update_own_profile"
  on public.profiles for update using (auth.uid() = user_id);

create policy "crud_own_items"
  on public.items for all
  using (owner = auth.uid())
  with check (owner = auth.uid());