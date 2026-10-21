# MedSoftware — EHR Selection Workbench

## Stack
- Repo: github.com/papajo/ehr-selection-workbenc (branch `main`).
- Single self-contained HTML page (`ehr-workbench.html`), vanilla JS, no build.
- Only external script: SheetJS 0.18.5 from cdnjs (fee-schedule file parsing, in-browser).
- State in `localStorage` key `ehr-workbench-v1`; Save/load tab moves it as JSON.
- Published as claude.ai artifact (same URL each release); mirrored to project doc `claude/ehr-workbench.html`.

## Layout
- Script 1 = engine (pure functions, no DOM; `module.exports` for Node tests): CRITERIA, PRESETS, chplParse, fitScore, knockouts, tco, feeRevenue, savings, costScores, rank, simulate, openQuestions, sampleState.
- Script 2 = UI: one `view*()` per tab, delegated `change`/`click` handlers keyed on `data-*` attributes, `changed()` saves + re-renders.

## Commands
- Engine test: extract script 1 → `node -e` with `new Function("module", src)`; check CRITERIA ids referenced by PRESETS and sample `S`.
- UI smoke test: jsdom, strip the SheetJS `<script src>`, click every `[data-tab]`, assert no `error` events.
- Publish: Artifact publish same file → then `project_write` to `claude/ehr-workbench.html`.

## Formulas
- Fit = Σ(prio weight × score) / Σ(prio weight × 5) × 100; unrated = 2.5, zero confidence.
- Knockout: Must item scored ≤ 2 (with evidence) → ineligible.
- TCO PV = upfront + go-live loss + Σ annual0·(1+esc)^(t−1)/(1+r)^t + exit/(1+r)^Y.
- Savings/yr = Σ tasks × times/day × working days × (min now − min vendor) ÷ 60 × hourly cost.
- Payback = (upfront + go-live) ÷ monthly(savings + current system cost − new recurring).

## Conventions
- New criterion: add to CRITERIA (id, g, prio, name, hint, ask, optional cite) + sample `S` row for 3 vendors; bump `sampleState().v` so stale examples refresh.
- New state field: default it in `migrate()` and `blankState()`.
- Presets replace `state.prio` wholesale; ids must exist in CRITERIA.
- CHPL number format: Edition.ATL.ACB.Developer(4).Product(4).Version(2).ICS(2).AddlSW(0/1).CertDate(YYMMDD). Format check only; no CHPL API (needs a key).
- Example data must be fictional and labelled; no real vendor names or CHPL numbers.

## Landing site + leads
- `site/index.html`: static page, Vercel project `ehr-selection-workbench` (personal account papajo) → https://ehr-selection-workbench.vercel.app
- Deploy: Vercel `create_deployment`, target production, files inline, framework null.
- Sign-ups: Supabase project `ehr-workbench` (hbxqvqqjdxtqjvjvjeur, us-east-1), table `public.leads` (email, providers, interest, source). RLS on; anon has column INSERT only, no SELECT. Page uses the publishable key. `?src=<tag>` on links records the source.
- Read leads: Supabase dashboard › Table editor › leads, or `select * from leads order by created_at desc`.

## Version log
- v3: Savings tab. v4: EHI export criterion (§170.315(b)(10)), 7 specialty presets, CHPL number field + validation.
- v7: `aiprov` requirement (AI model provenance and validation, High); contract AI clause extended; sample v5. Landing copy updated to 44 requirements and new example figures (57% / 43%, 78% evidence, 14 open questions).
- v6: Onboarding. Welcome dialog on first visit (localStorage `ehr-workbench-onboarded`) creates the evaluation from name, providers, specialty, vendor names; "Getting started" checklist on Decision derives 7 steps from state (`obSteps()`), hideable via `state.obHidden`; corrupt saves fall back to the example.
- v5: Report tab (download as HTML → print to PDF; `downloads` capability). Leader = most simulated wins; verdict notes when the deterministic score disagrees.
