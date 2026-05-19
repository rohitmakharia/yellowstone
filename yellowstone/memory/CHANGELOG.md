# Yellowstone — Changelog

Session-by-session log of what shipped. Newest at top. Keep entries terse — one or two lines per change, with the *why* when it isn't obvious.

---

## 2026-05-19 · California inbound flight booked (UA 2472)

- Rohit booked United for the 3-person California party. Confirmed details from booking screenshot: **UA 2472 · SFO 1:26 PM → JAC 4:39 PM · Sat Aug 22, 2026 · Airbus A320 · 2h 13m · United Economy (W) · Seats 34D / 34E / 34F.**
- `flightsCaInbound` flipped `false → true` in `index.html` STATUS object.
- Flight card on `#flights` page replaced TBD placeholder with full confirmed details. Card class flipped from `return-ca tbd` → `outbound` (same visual style as the confirmed Detroit inbound).
- Both pre-trip checklist `<li>` items (in `planning` and `t60` ctx-cards) updated to reflect the booking and now auto-strike with the flag flip.
- **Print page flight table:** added a new "Inbound CA" row (was missing entirely — the parallel session that added the CA card on May 13 didn't add it to the print table). Also updated "Return CA" row to note "post-12:30 PM required" instead of the old "similar afternoon window" placeholder.
- **Airport pickup logic refined in the flight-note:** CA arrives 4:39 PM, DTW arrives 4:57 PM — only 18 minutes apart. Note now reads: "Arrives 18 minutes before the Detroit party. Both pickups can run on one airport sweep — CA group waits at baggage claim, Detroit group joins ~20 min later."
- Three flags remain open: `rentalsBooked`, `raftBooked`, `flightsCaReturn`.
- File grew: 2,353 → 2,358 lines, 168,828 → 169,296 bytes.

---

## 2026-05-13 · Aug 24 dinner swap + dining-list expansion

- Mon Aug 24 carry-out options: Hand Fire replaced with Teton Tiger (165 Center St · 307-733-4111). Pinky G's stays as option 1. Hand Fire is the Aug 22 arrival-night plan, not Aug 24.
- Aug 24 label shifted from "Pizza carry-out" → "Carry-out" across dining list, D03 itinerary row, dinner reservations table, and DAY_DINNER constant — since one option (Teton Tiger) is Pan-Asian, not pizza. Assumption surfaced rather than left implicit.
- Added Teton Tiger (Pan-Asian incl. Indian curries) and Merry Piglets (Tex-Mex) as general Jackson carry-out entries in the "Pickup for low-key nights" section. Both are veg-friendly — relevant since half the party (6 of 12) is lacto-vegetarian.
- Fixed two day-name errors: "Fri Aug 22" → "Sat Aug 22" in dining list (L1214) and reservations table (L1492). Aug 22, 2026 is a Saturday.
- Aug 24 reminder logic unchanged — order ahead from rental morning or Signal Mountain summit ~5 PM, pickup 7:45–8:15 PM. Both new restaurants close 9 PM Monday.

---

## 2026-05-13 · Day 3 restructure: Option A + pizza carry-out dinner

- Day 3 (Mon Aug 24) restructured to fit confirmed noon float. Oxbow Bend moved to 3:30 PM, Signal Mountain to 4:00 PM (both post-float). Schwabacher Landing entry updated to 6:00 PM golden-hour stop (was 7:30 PM placeholder). Narrative + driving time (`~2 hrs` → `~2.5 hrs local`) rewritten.
- Float stop name/coords corrected: was "Triangle X Ranch area" (43.7645231, -110.5677611) — wrong location; now "Barker-Ewing Float Trip" at Moose Village (43.6582, -110.7140). Reconciled with the booked pickup location at Moose Village Float Trip Parking, 1 Teton Park Rd.
- Bin 22 dinner placeholder replaced with pizza carry-out plan. Two options: Hand Fire Pizza (120 N Cache St · 307-733-7199 · handfirepizza.com) and Pinky G's Pizzeria (50 W Broadway Ave · 307-734-7465 · pinkygs.com). Both close 9 PM Monday.
- Reminder logic added: order pizza in the morning from the rental, or from Signal Mountain summit (~5 PM) where signal is reliable. Pickup 7:45–8:15 PM on the drive back from Schwabacher.
- Fixed "Sun Aug 24" → "Mon Aug 24" in two spots (dining list line, dinner reservations table). Other day-name discrepancies in the file (e.g., "Fri Aug 22" — Aug 22, 2026 is Saturday) left untouched per scope.
- DINNER_BY_DAY (`DAY_DINNER` constant) entry for day 3 updated so the during-trip evening pivot card surfaces the pizza plan instead of Bin 22.
- PROJECT_CONTEXT.md: dining line updated; new bullet added documenting the Day 3 Option A stop sequence.
- Bin 22 retained where it's a legitimate non-Day-3 mention (line 1285 "Other nightly dinners" list).

## 2026-05-13 · Snake River float booked

- Barker-Ewing private raft, Aug 24 at 12:00 PM, $1,200 paid. Confirmation #8L5Q8N9T7K3V2H7F. PDF saved to `memory/2026-08-24_barker-ewing-confirmation.pdf`.
- Raft listed as "up to 10" capacity on the itinerary; Barker-Ewing confirmed by phone it accommodates 12. Used "12" in user-facing copy per Rohit's direction.
  - Lisa at Barker-Ewing confirmed by phone that the raft accommodates 12 because 2 of the 12 are children.
- Cancellation: full $1,200 refund if cancelled ≥72 hours before trip; $1,200 forfeit inside 72-hour window. Confirmed by phone with Lisa at Barker-Ewing.
- Pickup: Float Trip Parking lot, Moose Village (1 Teton Park Rd, Moose, WY). Boatman drives party to Deadman's Bar launch in a Barker-Ewing van.
- `floatBooked` flipped to `true` in `index.html`. Two ctx-list lines + Booking Priority list updated with booking details. Booking Priority `<li>` now carries `data-status-key="floatBooked"` and will auto-strikethrough.
- Time corrections: placeholder `8:30 AM` / `8 AM` / `Aug 24 AM` → actual `12:00 PM` in five spots (DAYS array Aug 24 stop, print itinerary grid, activities table, one-week-out pre-trip task, both ctx-list lines).
- Day-3 narrative still reads "Private Snake River scenic float in the morning" and the Oxbow Bend (1:30 PM) + Signal Mountain (2:30 PM) stops now overlap with the noon–~3 PM float window. Did not unilaterally rewrite — flagging for Rohit to decide.
- Four flags remain open: `rentalsBooked`, `raftBooked`, `flightsCaInbound`, `flightsCaReturn`.

## 2026-05-13 · Audit + deployment fact + Glorietta-replacement research

- **Audit.** Verified file state (2,351 lines / 166,345 bytes) against memory. All previously-shipped features intact. `gloriettaConfirmed: true` confirmed; other 5 STATUS flags still false. No corruption.
- **Deployment fact added to `PROJECT_CONTEXT.md`.** The "Deployment: unconfirmed" line was replaced with the actual fact: GitHub → Vercel, Vercel root directory set to `yellowstone`, no `vercel.json` needed (default static config works).
- **Dietary constraint surfaced.** ~6 of 12 are vegetarian (no meat / poultry / fish; cheese OK; eggs only as ingredients in noodles or desserts). The other ~6 are omnivores. Save this in PROJECT_CONTEXT.md when convenient.
- **Glorietta replacement research initiated.** Rohit raised concern that Glorietta's private room isn't upscale enough for the milestone. Researched alternatives. Snake River Grill (Jackson town) emerged as the strongest candidate after I read the actual menu and chef bios:
  - Two genuinely elevated vegetarian entrées on the standard menu (Forbidden Rice Cake $32, Mushroom Tagliatelle $32) + five vegetable small plates + full dessert program.
  - Kitchen pedigree: Chef Addison Fleming (ex-Alinea/3-star, ex-Entente/1-star), Chef de Cuisine Alejandro Soto (ex-Quince+Cotogna/3-star, ex-Acquerello/1-star), Pastry Chef Kaitlyn Soto (ex-Acquerello/1-star, ex-Michael Mina, ex-Entente/1-star).
  - Purpose-built private dining room: single oval table up to 16, $1,750 F&B minimum, $750 deposit, 4-bottle corkage in private room.
  - 307-733-0557 · https://www.snakerivergrill.com/private-dining/
- **Wild Sage at Rusty Parrot Lodge.** Strong alternative if SRG falls through. Rebuilt 2024 post-fire, Chef Hugo Goodwin (French/Montreal/NYC), Forbes Travel Guide / SLH / Virtuoso rated, only 48 seats total. Vegetarian + private dining setup needs phone-call verification. 307-733-2000.
- **Explicitly rejected this session — do NOT re-propose:**
  - Steadfire Chophouse (Four Seasons) and White Buffalo Club — meat-forward, fail the dietary split.
  - Spur Restaurant & Bar (Teton Mountain Lodge) — Rohit's words: "does not look elevated at all" and the private rooms are "more for events, not for private dining, celebratory kind of options."
  - Corsa at Caldera House — Italian but service reviews flag "erratic and unpolished."
  - Il Villaggio Osteria — Italian and veg-friendly, but same Fine Dining Restaurant Group as Glorietta. Lateral move, not upgrade.
  - Couloir / Piste Mountain Bistro — dinner service closed for 2025-26 season.
  - Westbank Grill (Four Seasons) — closed; replaced by Steadfire.
- **Status:** Rohit reached out to SRG for more info on their private dining. Decision (keep Glorietta vs switch to SRG) is pending their reply. Glorietta's 10-day cancellation window is still wide open.
- **Lesson learned.** Don't recommend restaurants based on search-snippet descriptions. Fetch actual menus. Check chef pedigree. Verify whether "private rooms" are purpose-built dining rooms or conference spaces.

## 2026-05-12 · Glorietta booking confirmed

- Glorietta Trattoria private dining room reserved Aug 23, 5:30 PM, party of 12. 10-day cancellation policy. Temporary menu selected; finalize ~2 weeks out.
- `gloriettaConfirmed` flipped to `true` in `index.html`. Glorietta line in dining list updated with reservation details.
- Five flags remain open: `rentalsBooked`, `floatBooked`, `raftBooked`, `flightsCaInbound`, `flightsCaReturn`.
  - Time corrections: placeholder `7:00 PM` → actual `5:30 PM` in three spots (index.html DAYS array Aug 23 stop, `DINNER_BY_DAY` evening pivot card, and `PROJECT_CONTEXT.md` key-bookings line).
  - Strikethrough wiring: Booking Priority `<li>` for Glorietta now carries `data-status-key="gloriettaConfirmed"`, so it auto-strikes with the flag.
  - Reword: one-week-out pre-trip task changed from "Re-confirm Glorietta reservation (Aug 23, table of 12)" to "Finalize Glorietta menu (~2 weeks out)" — the reservation is locked; the menu deadline is what's left.
  - Added `.logistics-list li.done` CSS rules so Booking Priority list strikes through when flags flip.

## 2026-05-12 · Timezone refactor + STATUS flag system + Jackson clock pill

- **Timezone anchoring rewritten.** `TRIP_START_LOCAL` / `TRIP_END_LOCAL` now use viewer-local calendar (`new Date(2026,7,22)`), not Mountain Time. Phase boundaries flip based on whichever calendar day the viewer is in. *Why:* "tomorrow we fly" should mean tomorrow for whoever is reading the page.
- **STATUS flag system.** New 6-boolean `STATUS` object (`rentalsBooked`, `gloriettaConfirmed`, `floatBooked`, `raftBooked`, `flightsCaInbound`, `flightsCaReturn`). Checklist `<li>` items carry `data-status-key`; `applyStatus()` adds `class="done"` when the flag flips. All six start `false`.
- **Jackson clock pill.** Non-traveling viewers in other timezones now see a small "In Jackson · 4:23 PM" pill above the during-trip card. `viewerSharesJacksonClock()` compares wall-clock within 30 min, hides the pill if they match.
- **Custom Yellowstone SVG map — declined.** Stayed with Leaflet + OSM tiles. The earlier transcript shows a custom hand-drawn SVG version that was used briefly; not revisited.
- **Memory scaffolding created** (this folder). `PROJECT_CONTEXT.md` + this changelog. No prior memory infrastructure existed.

## 2026-05-11 · Build cycle — multiple HTML versions, settled on Leaflet + OSM + comprehensive accommodations

- Six versions in one day (per `yellowstone-tetons-chat-transcript.pdf`). Sequence: v1 (Leaflet, broke) → v2 (rebuilt typography, map still wouldn't load) → v3 (custom SVG map, worked) → v4 (cut off mid-write) → v5 (Leaflet + Esri tiles + accommodations, didn't work) → v6 (back to SVG + booking links). Final state evolved further to current Leaflet + OSM.
- Group size locked: 12 travelers — 8 adults, 2 teens, 2 ten-year-olds.
- Accommodations directory added: shortlists for Jackson (Moose Hideaway, Hal'e Teton) and West Yellowstone (Yellowstone Luxury Cabin Retreat, Bar N Ranch, Under Canvas).
- Vacation rental marketplaces tiered: Ultra Lux / Lux / Mid Market for both Jackson and West Yellowstone.
- Chat transcript PDF generated and saved to the folder.

## 2026-05-09 · Initial trip design

- 12-person, three-generation family reunion scoped: 8 adults, 2 teens, 2 ten-year-olds. Anchor: Dadu's 75th + Rakhi.
- Flight pattern set: JAC in (9 from DTW confirmed via DL 0935 + DL 0417), BZN out (DL 0364 confirmed for 4 of 9). California party TBD on both ends.
- Itinerary settled at 8 days, 2 vacation rental bases (Jackson Aug 22–25, West Yellowstone Aug 26–28). One-way south-to-north arc, no backtracking. Lamar/Mammoth dropped from earlier 4-base version.
- Booking priorities locked: rentals first, Glorietta second, Snake River float third, SUVs, whitewater raft, then everything else.
