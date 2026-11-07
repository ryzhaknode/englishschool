-- Таблиця прогресу для «Школи англійської».
-- Запусти один раз у Supabase: SQL Editor → New query → встав цей текст → Run.

create table if not exists public.progress (
  user_id    uuid        not null default auth.uid() references auth.users(id) on delete cascade,
  day        date        not null,
  blocks     boolean[]   not null default '{false,false,false,false}', -- слова, вхід, мовлення, швидкість
  min        boolean     not null default false,                       -- 5-хвилинний мінімум
  updated_at timestamptz not null default now(),
  primary key (user_id, day)
);

-- Row Level Security: кожен бачить і змінює лише свої рядки.
alter table public.progress enable row level security;

-- Supabase більше не відкриває нові таблиці для Data API автоматично: без цього рядка буде помилка 42501.
grant select, insert, update, delete on public.progress to authenticated;

drop policy if exists "progress: read own"   on public.progress;
drop policy if exists "progress: insert own" on public.progress;
drop policy if exists "progress: update own" on public.progress;
drop policy if exists "progress: delete own" on public.progress;

create policy "progress: read own"   on public.progress for select using (auth.uid() = user_id);
create policy "progress: insert own" on public.progress for insert with check (auth.uid() = user_id);
create policy "progress: update own" on public.progress for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "progress: delete own" on public.progress for delete using (auth.uid() = user_id);

-- Корисний запит для перевірки (після перших позначок у застосунку):
-- select day, blocks, min from public.progress order by day desc;
