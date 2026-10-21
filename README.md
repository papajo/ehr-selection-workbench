# EHR Selection Workbench

A free, buyer-side tool that helps independent medical practices (1–10 providers) choose an EHR on evidence instead of vendor claims, and see the true 7-year cost before they sign. No vendor money, no patient data.

Live site: https://ehr-selection-workbench.vercel.app

## What's here

| Path | What it is |
| --- | --- |
| `ehr-workbench.html` | The workbench: a single self-contained page (vanilla JS). Published as a claude.ai artifact. |
| `site/index.html` | Landing page, deployed to Vercel. Sign-up form posts to Supabase. |
| `supabase/migrations/` | Schema for the `leads` table (insert-only for the public). |
| `EHR_Workbench_Go_To_Market.xlsx` | Positioning, target segments, pricing scenario, 30-day plan. |
| `CLAUDE.md` | Stack, commands, conventions and version log. |

## Workbench features

- 44 requirements in 5 groups, each with a "show me" demo request; 7 specialty presets.
- Ratings carry evidence (demo, reference, vendor claim, unchecked); a Monte Carlo simulation turns them into a win rate per vendor.
- 7-year total cost of ownership: escalators, go-live revenue dip, exit fees, discounting.
- Medicare fee-schedule check, staff-time savings and payback.
- CHPL product-number check, demo scripts, contract checklist, downloadable decision report.
- Onboarding: welcome dialog and a getting-started checklist.

## Run locally

Open `ehr-workbench.html` or `site/index.html` in a browser. No build step.

Data stays in the browser's localStorage. Nothing in this repo stores or needs patient information.

## Disclaimer

A decision aid, not legal or financial advice.
