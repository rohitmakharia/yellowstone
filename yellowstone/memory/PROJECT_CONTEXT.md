# Yellowstone — Project Context

**2026 Makharia Family Reunion · Yellowstone & The Tetons**
August 22–29, 2026 · 12 travelers, 3 generations · Anchor: Dadu's 75th birthday

---

## 1. Trip identity

A seven-night, eight-day family reunion built around two anchor moments:

- **Aug 23 — Dadu's 75th birthday dinner** at Glorietta (private dining room, Jackson)
- **Aug 28 — Rakhi celebration** at the West Yellowstone rental

Twelve travelers, three generations: 8 adults, 2 teens, 2 ten-year-olds. Two parties converge in Jackson on Aug 22 — 9 from Detroit (DTW), 3 from California (TBD). Split on Aug 29 from Bozeman (BZN) — 4 back to Detroit, 8 onward to California.

Two vacation rental bases, no in-park lodging. One transit day (Aug 26) connects them. JAC in, BZN out — one-way south-to-north arc, no backtracking.

---

## 2. What the site is for

A single-file Progressive Web App (`index.html`) that serves as the family's shared trip reference. It is **phase-aware** — the home page changes shape depending on how close to the trip the viewer is:

- **Pre-trip:** countdown + a checklist card sized to "how soon is the trip" (planning → T-60 → T-30 → T-14 → T-7 → T-3 → T-1)
- **During trip:** today's plan, tomorrow's preview, the evening pivot (tonight's dinner with tap-to-call), Jackson clock pill for non-traveling viewers in other timezones
- **Post-trip:** "In the books" card; everything else stays browsable

**Who it serves:** travelers (Detroit + California parties) and non-traveling family who want to follow along. Designed for the audience extremes: 10-year-olds and 75-year-olds. Tap targets and font floors are tuned for both.

**Success looks like:** every family member can answer "what's tonight?" or "where do I show up tomorrow?" by opening one URL on their phone, regardless of who they are or what timezone they're in.

---

## 3. Ownership and how we work

- **Rohit owns the project.** No co-editors. Zero coding background.
- **Claude makes all code edits** via Cowork mode against this folder. Rohit reviews visually, says what to change, Claude implements.
- **Decision cadence:** session-by-session. No fixed sprint. Sessions happen when Rohit has time and something to change.
- **House style for working together** is in `~/Documents/Claude/Projects/Automated Workflows/CLAUDE.md` — verify before claiming, surface assumptions explicitly, plain English, ask before unilateral design choices, smaller steps over fewer steps.

---

## 4. Files in this folder

```
yellowstone/
├── index.html                                            # The site. 2,435 lines / 175,543 bytes (2026-05-20 EOD, post Tier-1 cleanup).
├── manifest.webmanifest                                  # PWA manifest (installable to home screen)
├── favicon.svg                                           # App icon / brand mark
├── yellowstone-deadlines.ics                             # 8-event iCalendar with 7-day-prior reminders (2026-05-20)
├── yellowstone-expenses.xlsx                             # 3-sheet expense tracker with SUMIF settlement (2026-05-20)
├── Source Data/                                          # Raw uploads, preserved (folder added 2026-05-20)
│   ├── PHOTO-2026-05-11-18-18-40.jpg                       # DL 0935 DTW→SLC ticket
│   ├── PHOTO-2026-05-11-18-18-40 2.jpg                     # DL 0417 SLC→JAC ticket
│   ├── PHOTO-2026-05-11-18-18-40 3.jpg                     # DL 0364 BZN→DTW return ticket
│   ├── PHOTO-2026-05-19-11-25-48.jpg                       # UA 1702 HVFBCM (5 seats, non-refundable)
│   ├── PHOTO-2026-05-19-11-37-51.jpg                       # UA 1702 HVZD9X (3 seats, Agarwal refundable)
│   ├── PHOTO-2026-05-19-11-38-53.jpg                       # UA 2472 HTXHKY (Agarwal inbound)
│   ├── PHOTO-2026-05-20-09-51-32.jpg                       # Van 1 Costco C491501172 (Ritesh)
│   ├── PHOTO-2026-05-20-09-53-14.jpg                       # Van 2 Costco C491501176 (Parul)
│   ├── Confirmation.pdf                                    # Vrbo Yellowstone Luxury (ORB17812924)
│   ├── Order Confirmation #112575 | Rendezvous Mountain Rentals.pdf  # Hal'e Teton
│   ├── yellowstone-tetons-chat-transcript.pdf              # Prior planning chat (May 9–11) — moved here in Tier-1 cleanup
│   └── 0B9B77CB-..., A223BED6-..., A5667687-...jpeg        # Legacy May-11 originals
├── img/                                                  # Hero + 8 day photos + 2 NPS brochure maps
│   ├── hero-tetons.jpg
│   ├── day1-arrival.jpg ... day8-bison.jpg
│   ├── nps-grand-teton.jpg
│   └── nps-yellowstone.jpg
└── memory/
    ├── PROJECT_CONTEXT.md                                # ← you are here
    ├── CHANGELOG.md                                      # Session-by-session log of what shipped
    ├── SOURCE_ARTIFACTS.md                               # Chain-of-custody manifest for Source Data/
    └── 2026-08-24_barker-ewing-confirmation.pdf          # Float trip booking PDF
```

**`Source Data/` is the canonical home for every raw upload Rohit provides.** Rule effective 2026-05-20: any photo, screenshot, PDF, document, audio, or video gets saved here with filename `YYYY-MM-DD_short-slug.ext` before any data extraction. See `memory/SOURCE_ARTIFACTS.md` for the full chain-of-custody manifest.

**Source-artifact pending list: empty as of 2026-05-21.** Vrbo cancellation policy + group-chat conf-numbers were both found preserved on disk in the 2026-05-21 resume sweep (as `Screenshot 2026-05-20 at 12.45.{11,59} PM.png`). Mobile thumb-nav bug screenshot remains closed (not load-bearing, never saved). See `SOURCE_ARTIFACTS.md`.

---

## 5. Trip details (canonical)

### Dates and arc

| Day | Date | Title | Where you sleep |
|---|---|---|---|
| D01 | Sat Aug 22 | Arrive Jackson | Jackson rental (Stay 1) |
| D02 | Sun Aug 23 | Jenny Lake + Dadu's 75th | Jackson |
| D03 | Mon Aug 24 | Tetons signature day (Snake River float) | Jackson |
| D04 | Tue Aug 25 | Tetons flex day (Tram, optional whitewater) | Jackson |
| D05 | Wed Aug 26 | Transit to West Yellowstone (via West Thumb) | W. Yellowstone (Stay 2) |
| D06 | Thu Aug 27 | Canyon & Hayden Valley | W. Yellowstone |
| D07 | Fri Aug 28 | Geyser day + Rakhi | W. Yellowstone |
| D08 | Sat Aug 29 | Drive to Bozeman, fly out | — |

### Lodging

Two large vacation rentals, no in-park stays, no hotels. Both bases need to fit 12 sleeping + common space for multi-gen pacing.

- **Stay 1 — Hal'e Teton, Teton Village (BOOKED 2026-05-20).** 6,600 sf · 5 BR / 5.5 BA · sleeps up to 22 · Aug 22 → Aug 26 (4 nights) · 10 adults + 2 children · **order #112575** · Rendezvous Mountain Rentals · 307-739-9050 · **$11,626.72 total** ($5,813.36 paid, balance due 2026-07-23) · trip insurance included · cancellation 30+ days out = 6% forfeit, inside 30 days = no refund. PDF at `Source Data/Order Confirmation #112575 | Rendezvous Mountain Rentals.pdf`.
- **Stay 2 — Yellowstone Luxury Cabin Retreat, Hebgen Lake area (BOOKED 2026-05-20).** 5,000 sf · 5 BR / 5 BA · 10 adults + 2 children · Wed Aug 26 → Sat Aug 29 (3 nights) · check-in 4 PM / check-out 10 AM · **Vrbo reservation ORB17812924** · property `9746176ha` · **$6,030.90 charged in full** ($1,395/nt × 3 + host fees $609 + service fee $657 + tax $579.90) · **+ $1,500 refundable deposit at property** · 10/10 across 68 Vrbo reviews · 8 min to West Yellowstone town / 10 min to West Entrance. PDF at `Source Data/Confirmation.pdf`.

### Flights

- **Inbound Aug 22 from Detroit (confirmed):** DL 0935 (DTW→SLC, 12:15 PM → 2:06 PM) + DL 0417 (SLC→JAC, 3:52 PM → 4:57 PM). 9 pax.
- **Inbound Aug 22 from California (confirmed 2026-05-19):** UA 2472 · SFO → JAC · 1:26 PM → 4:39 PM · 2h 13m · Airbus A320 · United Economy (W) · seats 34D / 34E / 34F · **conf HTXHKY** (Agarwal family). 3 pax. Arrives 18 min before the Detroit party — one airport pickup sweep handles both.
- **Return Aug 29 to Detroit (confirmed):** DL 0364 (BZN→DTW, 3:38 PM → 8:54 PM). 4 of 9.
- **Onward Aug 29 to California (confirmed 2026-05-19):** UA 1702 · BZN → SFO · 4:25 PM → 6:01 PM · 2h 36m · Boeing 737 MAX 8 · United Economy (W). 8 pax (5 of 9 Detroit + 3 California). Two PNRs: **HVFBCM** — 5 seats non-refundable (34A/B/C, 35B/C, Detroit-onward party); **HVZD9X** — 3 seats refundable (35D/E/F, Agarwal family). 4:25 PM departure clears the 12:30 PM BZN floor with margin.

### Key bookings (Aug 23 anchors)

- **Glorietta · Aug 23 · 5:30 PM · 307-733-3888.** Private dining room for Dadu's 75th. Table of 12. **The single most important reservation in the trip — book first.** *Note (2026-05-13):* Rohit considering switching to Snake River Grill — sees Glorietta's private room as not upscale enough for the milestone. Awaiting SRG private-dining info. Decision pending. See CHANGELOG.md.

**Dietary split across the party of 12** (canonical, applies to every group meal):
- ~6 vegetarian: no meat, no poultry, no fish. Cheese is fine. Eggs are OK only as ingredients in noodles or desserts — not as a standalone egg dish.
- ~6 omnivores: eat everything.
- Implication for venue choice: chophouses and steakhouses are out. Look for kitchens that build vegetarian entrées at celebration tier (not afterthought salads). Italian, French farm-to-table, and modern American with serious seasonal cooking all qualify.
- **Snake River scenic float · Aug 24 · 12:00 PM · Barker-Ewing · 307-733-1800.** Booked 2026-05-13. Private raft for 12, $1,200 paid. Conf #8L5Q8N9T7K3V2H7F. Pickup at Float Trip Parking lot, Moose Village (1 Teton Park Rd).
- **Day 3 (Aug 24) stop sequence — Option A (decided 2026-05-13):** Easy morning at rental. 12:00 PM Barker-Ewing float (ends ~3 PM at Moose). 3:30 PM Oxbow Bend. 4:00 PM Signal Mountain Summit (call carry-out order in from here — reliable cell signal). 6:00 PM Schwabacher Landing for golden hour (~7:30 PM) / sunset (~8:15 PM); leave by 7:45 PM. Pickup 7:45–8:15 PM. Eat at rental. Both carry-out options close 9 PM Monday.
- **Whitewater raft · Aug 25 PM · Dave Hansen · 307-201-4639.** Optional, active subgroup.
- **Two Enterprise mini vans · JAC → BZN · Aug 22 → 29 (BOOKED 2026-05-20).** Both booked by Ritesh via Costco Travel; both paid by Ritesh. Together they seat the full party of 12. **Cancellation: refundable through Aug 20** (2 days before pickup).
  - **Van 1:** Costco C491501172 · Enterprise 2112908075 · driver RITESH KUMAR MAKHARIA.
  - **Van 2:** Costco C491501176 · Enterprise 2112908572 · driver PARUL RITESH KUMAR MAKHARIA.
  - Pickup requirements: Costco card required at counter; one additional driver fee waived for Costco members; additional drivers must be present.
  - Help: 1-866-328-1385 (before trip) · 1-866-317-4711 (during/after).

### Other dining (one sit-down dinner per night)

Aug 22 Hand Fire Pizza (arrival night) · Aug 23 **Glorietta** · Aug 24 **Carry-out at the rental** (Pinky G's 307-734-7465 or Teton Tiger 307-733-4111 — pizza vs. Pan-Asian incl. Indian curries; both close 9 PM Mon; order ahead from rental morning or Signal Mountain summit ~5 PM where signal is reliable; pickup 7:45–8:15 PM on the drive back from Schwabacher) · Aug 25 Snake River Grill · Aug 26 Madison Crossing Lounge · Aug 27 Bar N Ranch / Embers (406-646-0300) · Aug 28 Rakhi at rental (or Wild West Pizzeria pickup).

**General Jackson carry-out fallbacks (not tied to a specific night):** Teton Tiger (165 Center St · 307-733-4111 · Pan-Asian, strong veg) and Merry Piglets (160 N Cache St · 307-733-2966 · Tex-Mex, veg-friendly, 5% to-go fee). Listed on the dining page as backup options for anyone who wants different food during the trip.

### Lunch pickup

Jackson: Persephone Bakery, Creekside Market & Deli, Picnic. West Yellowstone: **Ernie's Bakery & Deli (order by 7 PM previous night)**, Mountain Mama's.

### Grocery stops

Two total. Jackson: Albertsons or Jackson Whole Grocer (Sat night or Sun morning). West Yellowstone: Market Place Foods (Wed afternoon on arrival).

---

## 6. Site architecture

### Pages (hash router)

`#home` · `#trip` (map + day-by-day timeline) · `#nps` (NPS brochure overlays) · `#dining` · `#lodging` · `#flights` · `#vehicles` (Rental Car, added 2026-05-20) · `#bookings` · `#prep` · `#print`

### The trip state machine — the load-bearing logic

One source of truth in JS (lines ~2125–2323 of `index.html`). Three derived values drive CSS visibility and JS rendering:

1. **`tripPhase`** — `"pre"`, `"during"`, or `"post"`
2. **`preBucket`** (only when phase=pre) — `"planning"` (>60d) · `"t60"` (31–60d) · `"t30"` (15–30d) · `"t14"` (8–14d) · `"t7"` (4–7d) · `"t3"` (2–3d) · `"t1"` (≤1d)
3. **`timeOfDay`** — `"morning"` · `"afternoon"` · `"evening"` · `"night"` (controls during-trip pivot)

Body data-attrs (`data-trip-phase`, `data-pre-bucket`, `data-time-of-day`, `data-trip-day`) are set every 60 seconds and gate which context cards show via CSS.

### Timezone anchoring (refactored 2026-05-12)

`TRIP_START_LOCAL = new Date(2026,7,22)` and `TRIP_END_LOCAL = new Date(2026,7,30)` — both anchored to the **viewer's local calendar**, not Mountain Time. Rationale: "tomorrow we fly" should mean tomorrow for whoever is reading the page, regardless of timezone. During the trip itself, everyone is in MT so local matches trip-time.

### Jackson clock pill

For non-traveling viewers in other timezones during the trip. `viewerSharesJacksonClock()` compares wall-clock to MT within 30 minutes; if they differ, a small "In Jackson · 4:23 PM" pill appears above the during-trip context card. Constant: `JACKSON_TZ = 'America/Denver'`.

### STATUS flag system (added 2026-05-12)

Seven booleans in a `STATUS` object (grep `^const STATUS=` for current line — line numbers shift). When `true`, the matching checklist item gets `class="done"`, which strikes it through and dims it. The flags are referenced from multiple pre-trip cards via `data-status-key` attributes — flip once, every card updates.

| Flag | What it tracks |
|---|---|
| `rentalJacksonBooked` | Jackson rental (Hal'e Teton, Aug 22-26) — split from `rentalsBooked` on 2026-05-20 |
| `rentalWyBooked` | W. Yellowstone rental (Aug 26-29) — split from `rentalsBooked` on 2026-05-20 |
| `gloriettaConfirmed` | Aug 23 private room locked |
| `floatBooked` | Snake River float (Aug 24 · 12:00 PM, Barker-Ewing) |
| `raftBooked` | Whitewater raft (Aug 25 PM, Dave Hansen) |
| `flightsCaInbound` | CA → JAC tickets purchased |
| `flightsCaReturn` | BZN → CA tickets purchased |

**Current state (after 2026-05-20 PM updates): 6 of 7 flipped. Both rentals + Glorietta + float + both CA flights confirmed. Only `raftBooked` remains open.**

### Other notable pieces

- **Leaflet map** with OpenStreetMap tiles. Day filter pills. Lodging anchors point at actual booked properties (Hal'e Teton, Yellowstone Luxury Cabin Retreat).
- **NPS brochure overlays** (`#nps`) — itinerary stops on top of the official Grand Teton and Yellowstone brochure maps.
- **Print one-pager** (`#print`) — single-sheet table layout for offline reference.
- **Mobile thumb nav** (Home/Trip/Dining/Bookings) — appears <760px viewport. Note: Vehicles/Rental Car page (added 2026-05-20) is NOT in thumb nav — reachable only via top nav + hamburger menu. Intentional: thumb nav holds the 4 highest-traffic pages.
- **PWA manifest** — installable to home screen, standalone display, portrait-primary, dark theme color (`#0E1A14`).

---

## 7. Current state (as of 2026-05-20 end-of-day)

- **Countdown:** ~94 days to Jackson (today is May 20, trip starts Aug 22).
- **Phase:** `pre` · `preBucket = "planning"` (>60d out).
- **STATUS flags: 6 of 7 flipped.** Both rentals (Hal'e Teton + Yellowstone Luxury Cabin Retreat), Glorietta, the Barker-Ewing float, and both CA flights (UA 2472 inbound + UA 1702 return) are all confirmed. **Only `raftBooked` remains `false`** — whitewater rafting Aug 25 PM via Dave Hansen (307-201-4639). The flag schema was split on 2026-05-20: the old `rentalsBooked` became `rentalJacksonBooked` + `rentalWyBooked` (so the schema went from 6 → 7 flags).
- **Two new artifacts shipped 2026-05-20:** `yellowstone-deadlines.ics` (8 events, OS-level notifications via .ics import) and `yellowstone-expenses.xlsx` (3-sheet pre/during/settlement tracker, SUMIF cross-sheet formulas).
- **New Rental Car page (#vehicles) added 2026-05-20 PM.** PAGES array grew to 10 entries. Both Enterprise mini vans (Ritesh + Parul drivers, both paid by Ritesh) fully wired.
- **Deployment: GitHub → Vercel (confirmed live as of 2026-05-13).** Rohit pushes commits manually; Vercel auto-redeploys. Vercel "Root Directory" set to `yellowstone`. No `vercel.json` needed. PWA manifest uses relative paths.

---

## 8. Open booking items (the seven STATUS flags as a checklist)

This is the actionable list. Flip the flag in `index.html` once each is confirmed.

- [x] **`rentalJacksonBooked`** — **Booked 2026-05-20.** Hal'e Teton · Teton Village · 5 BR / 5.5 BA · Aug 22 → 26 · order #112575 · Rendezvous Mountain Rentals · 307-739-9050 · $11,626.72 total ($5,813.36 paid, $5,813.36 due 2026-07-23) · trip insurance included.
- [x] **`rentalWyBooked`** — **Booked 2026-05-20.** Yellowstone Luxury Cabin Retreat · Hebgen Lake area · 5 BR / 5 BA · 5,000 sf · Aug 26 → 29 · Vrbo reservation `ORB17812924` · property `9746176ha` · $6,030.90 charged + $1,500 refundable deposit at property · check-in 4 PM / check-out 10 AM.
- [x] **`gloriettaConfirmed`** — **Booked 2026-05-12.** Aug 23 · 5:30 PM · private dining room · party of 12. 10-day cancellation policy. Temporary menu selected; finalize ~2 weeks out. 307-733-3888.
- [x] **`floatBooked`** — **Booked 2026-05-13.** Aug 24 · 12:00 PM check-in · Barker-Ewing 10-Mile Scenic Float · 1 private raft (PDF says "up to 10" capacity; Lisa at Barker-Ewing confirmed by phone that the raft accommodates 12 because 2 of the 12 are children) · $1,200 paid · Cancellation: full $1,200 refund if cancelled ≥72 hours before trip; $1,200 forfeit inside 72-hour window. Confirmed by phone with Lisa at Barker-Ewing. · pickup at Float Trip Parking lot, Moose Village, 1 Teton Park Rd · conf #8L5Q8N9T7K3V2H7F · 307-733-1800.
- [ ] **`raftBooked`** — Aug 25 PM whitewater. Dave Hansen. 307-201-4639.
- [x] **`flightsCaInbound`** — **Booked 2026-05-19.** UA 2472 · SFO → JAC · 1:26 PM → 4:39 PM · Sat Aug 22, 2026 · Airbus A320 · 2h 13m · United Economy (W) · 3 pax · seats 34D / 34E / 34F · conf HTXHKY.
- [x] **`flightsCaReturn`** — **Booked 2026-05-19.** UA 1702 · BZN → SFO · 4:25 PM → 6:01 PM · Sat Aug 29, 2026 · Boeing 737 MAX 8 · 2h 36m · United Economy (W) · 8 pax across two PNRs: **HVFBCM** — 5 non-refundable (34A/B/C, 35B/C); **HVZD9X** — 3 refundable (35D/E/F, Agarwal family).

**Other to-dos that don't have flags yet (could be added later if Rohit wants):**

- Buy bear spray on Aug 22 in Jackson (4 cans, 2 per vehicle — can't fly with it).
- Confirm walk-in dinner plans for Hand Fire (Aug 22), Madison Crossing (Aug 26), Bar N Ranch / Embers (Aug 27).
- Carry-out coordination Aug 24 (Pinky G's or Teton Tiger) — call order from rental morning or Signal Mountain summit.

---

## 9. Deferred / declined / out of scope

- **Custom Yellowstone SVG map** — declined during the 2026-05-12 session. The earlier transcript shows a v3 build that used a custom hand-drawn SVG map; current site uses Leaflet + OSM tiles, and Rohit chose not to revisit the custom SVG idea.
- **In-park lodging** (Old Faithful Inn, Canyon Lodge, Mammoth Hot Springs Hotel) — considered early in planning, dropped in favor of two large vacation rentals.
- **Lamar Valley + Mammoth Hot Springs** — were on an earlier 4-base itinerary, dropped when the trip consolidated to 2 bases. The current arc skips both.
- **Post-trip photo gallery** — not built. Post-trip mode currently shows only the "In the books" card. Could be added later but no commitment.
- **Real-terrain map** (Esri World Topographic, satellite layer toggle) — attempted in a prior version, didn't work, reverted to plain OSM.

These belong in `memory/CHANGELOG.md` only if they get reopened.

---

## 10. Operational footguns

- **Timezone consistency.** The viewer-local anchoring is deliberate. Don't switch `TRIP_START_LOCAL` to a UTC or MT-pinned date without thinking through what happens when (e.g.) someone in CA opens the site at 11:30 PM PT on Aug 21 — they should not see "Day 1: Arrive Jackson" yet, because for them it's still "tomorrow."
- **Lodging coords.** `LODGING_JACKSON` and `LODGING_WY` (re-grep `const LODGING_` for current line numbers — they shift). LODGING_JACKSON points at Teton Village base area (43.5870, -110.8290). LODGING_WY points at West Yellowstone town centroid (44.6618, -111.1041) since Vrbo doesn't reveal the exact Hebgen Lake address until host accepts — refine post-arrival if needed.
- **All phone numbers verified May 2026** per the dining-card note. If a number gets revised, re-check before flipping STATUS flags.
- **Bear spray cannot fly.** The trip plan depends on buying it in Jackson on Aug 22. Don't try to optimize this away.
- **BZN departure floor: 12:30 PM.** Earlier flights are dangerously tight on the Gallatin Canyon drive (2.5 hrs from West Yellowstone). If a CA return ticket gets booked for, say, 11 AM, the whole departure morning breaks.
- **Audience extremes.** Site is designed for 10-year-olds and 75-year-olds. Don't shrink mono labels below 12px on mobile (grep `@media (max-width:480px)` for the enforcing blocks — line numbers shift session to session). Don't shrink tap targets below 48px.
- **~2,435-line single file (as of 2026-05-20 EOD; was 2,474 before audit fixes, 2,447 before Tier-1 cleanup).** Edits are line-anchored. Any structural refactor needs to keep the JS state machine, the `DAYS` array, the `STATUS` flag object, the `DEADLINES` array, and the CSS visibility rules in sync. Line numbers shift session to session; re-grep before quoting line refs. After any size change, re-grep memory files for the old size string and update.

---

## Surfacing assumptions

I'm assuming the following — flag any that are wrong:

1. **The three top-level `.jpeg` files are inert** (original uploads, not referenced by the site). Verified via grep that they aren't linked from `index.html`.
2. **Deployment is live on Vercel** (per CHANGELOG 2026-05-13). Updated from earlier "no deployment exists yet" assumption.
3. **Both rentals are now booked.** Hal'e Teton (Jackson) and Yellowstone Luxury Cabin Retreat (West Yellowstone) are confirmed; the shortlist headers on the Lodging page were retitled "(reference)" 2026-05-20 PM.
4. **The post-trip card content** is intentionally minimal — Rohit explicitly deferred any post-trip photo gallery; will handle photo sharing via other apps.
5. **"Audience: ages 10–75"** per `project_yellowstone_audience.md` — real design driver, enforced by CSS font/tap-target floors.
6. **Park Maps page stays.** Rohit explicit: "dont kill this. i like this page." Was on the Tier 1 kill list; now off.
7. **Tier 1/2/3 cleanup is gated on pre-summary check-in.** No silent execution, even when content-stability trigger fires.
