create table public.leads (
  id bigint generated always as identity primary key,
  created_at timestamptz not null default now(),
  email text not null check (char_length(email) between 5 and 254 and email ~* '^[^@\s]+@[^@\s]+\.[^@\s]+$'),
  providers text check (providers in ('1-3','4-10','10+')),
  interest text check (interest in ('checklist','pro','service')),
  source text check (char_length(source) <= 100)
);
alter table public.leads enable row level security;
revoke all on public.leads from anon, authenticated;
grant insert (email, providers, interest, source) on public.leads to anon;
create policy "anon can submit leads" on public.leads
  for insert to anon with check (true);
comment on table public.leads is 'Landing page sign-ups. Insert-only for the public; read via dashboard or service role.';
