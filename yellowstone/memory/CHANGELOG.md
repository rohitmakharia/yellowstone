# Yellowstone — Changelog

Session-by-session log of what shipped. Newest at top. Keep entries terse — one or two lines per change, with the *why* when it isn't obvious.

---

## 2026-05-21 · Print stylesheet fix — only print page now prints

**Bug:** Cmd+P or the in-page Print button was printing the entire HTML (all 10 pages + hero + footer + credits), not just the Print one-pager.

**Root cause:** the old `@media print` block at line 637 had `.page{display:block!important}` — which forced every routed page visible during print. Combined with no hide rules for hero/footer/credits/deadline-banner/top-nav-in-print, the printed output was the full SPA dump.

**Fix:** rewrote the `@media print` block. Now:
- Hides every routed page EXCEPT `#page-print` (`.page{display:none!important}` + `#page-print{display:block!important}`).
- Hides global chrome: `.top-nav`, `.hamburger`, `.mobile-menu*`, `.thumb-nav`, `.deadline-banner-host`, `.hero`, `.credits`, `footer`, `.print-btn-wrap`, `#mainMap`, `.leaflet-container`.
- `@page{size:letter;margin:0.55in}` sets sensible paper margins.
- Switches print font to Georgia / Times New Roman serif at 10.5pt with tighter table sizes (9.5pt body, 8.5pt headers) so the one-pager fits in 2–3 pages.
- All print text forced to black (`color:#000!important`), backgrounds to white.
- Links lose color/underline in print (they aren't useful on paper).

**Two older redundant `@media print` rules left in place** (lines 43 + 501) — they hide `.deadline-banner-host`, `.print-btn-wrap`, and reset `.print-sheet` padding. Same effect as the new block, no conflict; consolidation deferred.

**Verification:** JS parses, DOM balanced (472 = 472), 2,458 lines / 177,239 bytes. Selector-coverage check: all 10 hide-targets match at least one element; all 10 page divs except `#page-print` will be hidden. Manual print test = Rohit's job (Cmd+P in Safari to confirm).

**To test:** open the site, navigate anywhere (doesn't matter — Cmd+P from any page should still produce only the print one-pager), hit Cmd+P. Or click the "⎙ Print this page" button on the Print page.

---

## 2026-05-20 · Tier 1 cleanup (8 items)

Pre-summary check-in given before edits; Rohit approved 7 of 9 candidates plus an added 8th (compress footer).

- **T1.2** Deleted `download-images.sh` from project root (script ran once long ago to populate `img/`; now dead).
- **T1.3** Moved `yellowstone-tetons-chat-transcript.pdf` from project root → `Source Data/` for chain-of-custody consistency.
- **T1.4** Dead CSS sweep beyond marketplace: removed `.lodge-targets`, `.lodge-targets-label`, `.lodge-targets-list` (old shortlist machinery), `.flight-card.tbd`, `.flight-tbd`, `.flight-tbd-tag` (TBD flight styling — all flights now confirmed), and `.booking-guide-header h3 em` chain selector. Verified via JS-aware grep that none of these are added by classList/className at runtime. ~8 lines of CSS gone.
- **T1.5** Yellowstone Luxury "Sleeps 14" stat → "Sleeps 12" (trip is 12 people; the 14 was max capacity, misleading).
- **T1.6** Print page Aug 28 Rakhi dinner row: was "Bar N Ranch or pickup at rental, 406-646-0300" → now lists all 3 dining options (Madison Crossing 406-646-7621 · Bar N Ranch 406-646-0300 · Wild West yellowstonepizza.com), per Rohit: "leave the options in there. We don't know what we're going to do."
- **T1.8** NPS Yellowstone section header "Days 05 – 07 · Aug 26 – 28" → "Days 05 – 08 · Aug 26 – 29" (Day 8 / Aug 29 is also Yellowstone-adjacent).
- **T1.9** Removed the fake "Rakhi at the rental" stop from Day 7 in the DAYS array (it had W. Yellowstone town centroid coords, not a real geographic stop). Map header "19 stops" → "18 stops". Rakhi content stays in narrative.
- **T1.10 (added mid-session)** Footer photo credits compressed: was a 6-line block with per-photographer attribution → now a single line ("Photos via Unsplash License · Park brochures © NPS via NPMaps"). Per-photo attribution available at the Unsplash links in dev tools / source HTML if needed.

**Skipped per Rohit:** T1.1 (PWA manifest stays — "we keep it all the way") and T1.7 (date typography normalize — Rohit didn't explicitly approve).

**Verification:** 2,435 lines / 175,543 bytes (was 2,447 / 177,177 — net -12 lines / -1,634 bytes). JS parses. DOM balanced (472 `<div>` opens = 472 closes). All seven verifications re-greppеd clean.

---

## 2026-05-20 · Audit pass 2 + 5 more fixes + global auditor rule

Pass 2 of the audit caught 6 issues missed in pass 1 (46% miss rate on the first sweep). Five fixed in this entry; one (Day 5 vehicleB) restructured per Rohit's direction.

- **A · Bookings raft `<li>` gained `data-status-key="raftBooked"`.** Now both the home ctx card and the Bookings priority list will strike through when raft is booked. Fixed at `index.html:1365`.
- **B · Day 5 vehicleB rewritten.** Was "Leaves 8 AM ... Arrives ~2 PM, starts unpacking" — but check-in is 4 PM. Now: "Leaves Hal'e Teton 10 AM. Quick stops. Arrives Yellowstone Luxury ~4 PM in time for check-in." Per Rohit: "we just assumed we leave at 10 AM in the morning instead."
- **C · Stale line refs in PROJECT_CONTEXT.md sec 10.** "lines 1691-1692" pointed at hamburger-menu code; LODGING_JACKSON/WY are actually at 1752/1755 now. Rewrote the bullet to use a grep instruction instead of a fixed line number.
- **D · Stale "2,474 lines / 180,379 bytes" in three memory locations.** All updated to current "2,447 lines / 177,118 bytes" (PROJECT_CONTEXT.md sec 4, sec 10; auto-memory session_state.md). CHANGELOG line 84 left alone — it documents historical state at the time of that earlier entry.
- **E · Day 4 + Bookings "two rafts" → "one raft".** Per Rohit: 12-person rafts exist; the active subgroup of 8 (6 adults + 2 teens) goes in one boat. Both narratives updated to match.

**Global rule shipped (separate file):** `~/Documents/Claude/Projects/Automated Workflows/CLAUDE.md` gained **§9 Auditor mode** with 10 mandatory audit checks. Origin documented as the 2026-05-20 audit miss rate.

**Verification:** 2,447 lines / JS parses clean / zero `two rafts` refs / zero `8 AM` vehicleB refs / zero stale `2,474` claims outside the historical CHANGELOG entry / zero stale `1691` line refs.

---

## 2026-05-20 · Audit + 13 fixes

Self-audit found 13 inconsistencies. All fixed in this pass.

**Load-bearing errors (4):**
- "Sat Aug 23" → "Sun Aug 23" in dining list + print dinner table (Aug 23 is Sunday, not Saturday). Affected Dadu's birthday row twice.
- "Wed Aug 20" → "Thu Aug 20" in vehicles cancellation card (Aug 20 is Thursday).
- "Bear spray bought on the Aug 23 grocery run" → "Aug 22 arrival-day grocery run" in home t14 ctx card (5 other places already said Aug 22).
- "Suburban or Tahoe" Prep two-vehicle-ops card → rewritten for the two booked Enterprise mini vans, with cross-link to Rental Car page.
- "8 days · 14 stops" map header → "8 days · 19 stops" (matches DAYS array stop count).

**Internal contradiction (1):**
- "12-foot live-edge custom dining table seating all 14" → "seating all 12 of us" (trip has 12 people, not 14).

**Stale references (5):**
- Deleted dead "marketplace browse moved to Bookings page" note on Lodging (target was removed 2026-05-20).
- PROJECT_CONTEXT.md sec 6 "update coords once rentals are booked" → "anchors point at actual booked properties" (both rentals now booked).
- PROJECT_CONTEXT.md sec 8 header "six STATUS flags" → "seven STATUS flags" (post rentalsBooked split).
- PROJECT_CONTEXT.md sec 8 final bullets: removed stale "Two SUVs reserved JAC → BZN", clarified remaining open items.
- PROJECT_CONTEXT.md sec 6 added explicit note that Vehicles/Rental Car page is intentionally NOT in mobile thumb nav.

**Cosmetic / dead code (3):**
- Deleted empty `~$yellowstone-expenses.xlsx` lockfile from project root.
- Removed 26 lines of dead marketplace CSS (`.marketplace-*`, `.booking-grid`, `.booking-tier*`, `.booking-col`, `.booking-area-header`, `.booking-link*`, `.booking-note`). Confirmed via grep that none of these classes are used in HTML. Also cleaned up two `@media`/general rules that referenced these classes.
- DAY_PHOTOS swap (Day 6 ↔ Day 7 file mapping) noted in audit as intentional — left alone.

**Verification:** 2,447 lines / 177,118 bytes (was 2,474 lines before fixes — net 27 lines removed from CSS cleanup). JS parses clean. DOM balanced (472 `<div>` opens = 472 closes). Re-grep confirms zero Suburban/Tahoe refs, zero "Sat Aug 23" refs, zero dead marketplace CSS classes still defined, all booking-page links and references intact.

---

## 2026-05-20 · Source Data folder + chain-of-custody backfill

Rohit created `Source Data/` and dropped 8 previously-LOST source photos into it plus the 5 already-saved files (2 booking PDFs + 3 legacy JPEGs). Eight images recovered:

- 3 Delta flight tickets from 2026-05-11 (DL 0935, DL 0417, DL 0364) — never previously saved as files.
- 3 United flight tickets from 2026-05-19 (UA 1702 HVFBCM, UA 1702 HVZD9X, UA 2472 HTXHKY) — were on the LOST list.
- 2 Costco Travel van reservations from 2026-05-20 (Van 1 Ritesh, Van 2 Parul) — were on the LOST list.

Cross-verified every data point against `index.html` / `yellowstone-deadlines.ics` / `yellowstone-expenses.xlsx`. Seat letters, confirmation numbers, driver names, dates, email masks all match. No corrections needed.

`memory/SOURCE_ARTIFACTS.md` updated — 8 items moved from LOST → preserved. 3 items still LOST: Vrbo cancellation policy screenshot, iMessage conf-numbers screenshot (originally mislabeled "Telegram" — corrected 2026-05-20 PM after Rohit clarified it was iMessage), mobile thumb-nav bug screenshot.

`memory/PROJECT_CONTEXT.md` updated — sec 4 file inventory now shows `Source Data/` as canonical home for raw uploads. Stay 1/Stay 2 PDF refs updated.

**New operating rule (effective 2026-05-20):** every raw upload Rohit provides (photo, PDF, document, anything) gets saved to `Source Data/` with filename `YYYY-MM-DD_short-slug.ext` *before* any data extraction. Rule mirrored to `~/Documents/Claude/Projects/Automated Workflows/CLAUDE.md` as Section 8.

**Correction:** Initial assumption that Rohit "copied" the 5 booking files into Source Data/ was wrong — he MOVED them (verified by md5sum: root files don't exist). yellowstone/ root is already deduplicated.

**Excel update (same session):** DL 0935 + DL 0417 row in `yellowstone-expenses.xlsx` updated with $304.19/ticket × 9 tickets paid by Rohit. Formula `=9*304.19` = $2,737.71. Sheet 1 total $18,857.62 → $21,595.33. Settlement auto-updated: Rohit pre-trip $21,595.33; by-category Flight $2,737.71. 50 formulas, 0 errors.

**Three previously-LOST items reassessed:**
- ~~Group-chat conf-numbers screenshot~~ — CLOSED. Per Rohit: "Forget about the WhatsApp messages. It's not important. It's already captured in the index.html." Standalone UA ticket photos in Source Data/ are the primary source for the PNRs.
- ~~Mobile thumb-nav bug screenshot~~ — CLOSED. Per Rohit: "don't worry about the Safari scroll for now." Not load-bearing.
- **Vrbo cancellation policy screenshot** — still pending. Rohit re-attached in chat 2026-05-20 PM but upload didn't land on disk. Awaiting manual save to `Source Data/2026-05-20_vrbo-cancellation-policy.png`.

---

## 2026-05-20 · Structural fixes + accuracy sweep (per Rohit's review)

**New Rental Car page (#vehicles).** Standalone subpage with full van details. Home nav now promotes "Rental Car" instead of "Bookings"; Bookings demoted to the "Also" line. Top nav and mobile menu both gained a Rental Car link between Flights and Bookings. PAGES array grew to 10. The long vehicles `<li>` on Bookings became a short "see Rental Car page" stub. The Vehicles page itself has six cards: Van 1 (Ritesh), Van 2 (Parul), Pickup/drop, At-the-counter, Phone numbers, Cancellation.

**Day 1 / 5 / 8 narratives updated with lodging context** in the DAYS array:
- Day 1: "drive thirty minutes to **Hal'e Teton in Teton Village** (Stay 1 · order #112575 · 5 BR / 5.5 BA, sleeps the full party)." Driving label changed to "30 min from JAC to Hal'e Teton."
- Day 5: "Check out of Hal'e Teton by 10 AM ... Destination: **Yellowstone Luxury Cabin Retreat (Stay 2)** in the Hebgen Lake area — Vrbo reservation ORB17812924 · check-in 4 PM." Vehicle plays now mention both Hal'e Teton departure and Yellowstone Luxury arrival.
- Day 8: "Check out of **Yellowstone Luxury Cabin Retreat by 10 AM** (Vrbo ORB17812924 — collect the $1,500 refundable deposit confirmation). Drive Gallatin Canyon ... drop both mini vans at BZN. DL 0364 boards 3:38 PM for Detroit; UA 1702 boards 4:25 PM for SFO."

**Lodging page rewritten for booked state.** Stay 1 / Stay 2 overview cards no longer describe shopping criteria — they now describe **Hal'e Teton** (6,600 sf · 5 BR / 5.5 BA · order #112575) and **Yellowstone Luxury Cabin Retreat** (5,000 sf · 5 BR / 5 BA · ORB17812924 · $1,500 deposit reminder) with actual booking details, contacts, and check-in/out times. Page intro text changed from "Both bases need to be locked in this week" → "Both rentals booked. One base in Jackson, one in West Yellowstone — all luggage moves on Aug 26." Shortlist headers retitled "(reference)" with "X was selected · the other(s) were considered" subline. Stay 2 dates fixed from "Aug 26 – 28" to actual "Aug 26 – 29" (3 nights).

**Marketplace section deleted from Bookings.** Both rentals booked, marketplace browse no longer needed. ~67 lines of `<details>` + `<div class="booking-grid">` removed. The `.marketplace-details`, `.booking-grid`, etc. CSS rules remain but are now unused (didn't strip them — minor dead-CSS, can clean later).

**Accuracy sweep results:**
- "two SUVs" → "two mini vans" in 2 places (shortlist-watch line, flight-note line). Now zero SUV references in user-facing copy.
- TBD / pending / "still open" — already zero before sweep (good sign).
- "Mon Aug 25" → "Tue Aug 25" in two places (dining list, print reservations) — Aug 25, 2026 is a Tuesday.
- "Other nightly dinners" item in Bookings updated to reflect current plan: Hand Fire (Aug 22, walk-in), carry-out at the rental (Aug 24 · Pinky G's or Teton Tiger), Snake River Grill (Aug 25), Madison Crossing (Aug 26), Bar N Ranch / Embers (Aug 27). Bin 22 dropped (was outdated placeholder).
- "Afternoon flight from BZN · Aug 29 (12:30 PM floor reminder)" deleted from Bookings priority — both CA and DTW return flights are now booked for the afternoon, advice no longer actionable.

**File: 2,422 → 2,474 lines, 177,484 → 180,379 bytes. JS clean. DOM balanced. 10 pages.**

**Open thread:** marketplace CSS classes are now dead code but not stripped — minor cleanup waiting on the next pre-summary-approved cleanup batch.

---

## 2026-05-20 · Deadline notifications + Excel tracker (cleanup deferred)

**Three new artifacts shipped. Tier 1/2/3 cleanup deliberately not started — Rohit wants a pre-cleanup check-in.**

- **`yellowstone-deadlines.ics`** (4.7 KB at project root). Standard iCalendar file with 8 events covering every cancellation/payment deadline. Each event has a 7-day-prior VALARM. Distribution: Rohit AirDrops/emails the file once, each recipient taps it on their phone, the calendar app imports the 8 events and handles all OS-level notifications from then on.
- **In-app deadline banner system** in `index.html`:
  - New `DEADLINES` array in JS (7 entries — drops the Aug 29 HVZD9X-until-departure since it's noisy to surface as a deadline).
  - New `renderDeadlineBanner()` function: on every page load, checks if today is within 7 days of any deadline. If yes, renders a bright accent-orange banner at the top of every page showing the nearest deadline + "+N more this week" if multiple. Clicking the banner deep-links to the relevant page.
  - `#deadlineBanner` host element placed above the top nav so it's the first thing seen.
  - CSS: `.deadline-banner-host`, pill, body, sub, arrow styling. Includes `body:has(#deadlineBanner:not(:empty))` selector that bumps page-top padding to make room when the banner is showing. Hidden in print.
  - Rendered every 60s by `syncTripState()`.
- **`yellowstone-expenses.xlsx`** (13.8 KB at project root). Three sheets, 49 formulas, zero errors verified via `scripts/recalc.py`:
  - **Sheet 1 — Pre-trip bookings:** 12 rows pre-populated with every confirmed booking (date paid, category, description, paid by, amount, refundable status, cancel deadline, conf #, paid-to, who-benefits, notes). Known amounts hardcoded; unknowns marked $0 with yellow background.
  - **Sheet 2 — During-trip log:** 30 blank rows with column headers (date, day #, category, description, paid by, amount, receipt-kept, notes) for entries during the trip. Auto-sum at the bottom.
  - **Sheet 3 — Settlement:** auto-calculated. Three blocks — by-person totals (SUMIF cross-sheet), by-category totals (SUMIF cross-sheet), and a simple equal-split who-owes-who section with the 12-traveler share calculation.
  - Color coding follows industry standard: blue inputs, black formulas, green cross-sheet references.

**Tasks deleted from queue per Rohit's instruction (do not re-propose without check-in):**
- Kill Park Maps page — Rohit wants it kept.
- Kill PWA manifest — needs Rohit's explicit approval before any cleanup.
- All other Tier 1/2/3 cleanup items still deferred per `project_yellowstone_design_deferred.md`.

**Operating rule going forward:** Any structural cleanup (Tier 1/2/3) requires a pre-summary check-in with Rohit BEFORE making changes. Don't batch with feature work.

**File: 2,422 → 2,477 lines, 177,484 → 181,891 bytes. JS clean, DOM balanced.**

**Open from earlier ask:** if Rohit fills in flight dollar amounts and any unknowns in `yellowstone-expenses.xlsx`, the settlement view auto-updates.

---

## 2026-05-20 · Both vans fully wired + payment attribution finalized

- **Both Enterprise mini van bookings confirmed and complete.** Ritesh forwarded both Costco Travel screenshots.
  - **Van 1:** Costco C491501172 · Enterprise 2112908075 · driver **RITESH KUMAR MAKHARIA** · booking email ri****ia@gmail.com.
  - **Van 2:** Costco C491501176 · Enterprise 2112908572 · driver **PARUL RITESH KUMAR MAKHARIA** · booking email pa****ia@gmail.com.
- **Dates confirmed:** Pickup Sat Aug 22 at JAC · drop Sat Aug 29 at BZN (Rohit confirmed the earlier "27th to 29th" was a typo for "22nd to 29th"). Removed the date-confirmation flag from the Bookings item.
- **Cancellation deadline both vans:** refundable through Aug 20 (2 days before Aug 22 pickup).
- **Both vans paid by Ritesh** (two separate Costco accounts: his and Parul's).
- **Payment attribution now complete** (per Rohit's confirmations):
  - **Rohit paid:** 9 Detroit DL inbound (DL 0935 + DL 0417) + 4 Detroit DL return (DL 0364) + 3 Agarwal UA 2472 inbound (HTXHKY) + Hal'e Teton + Yellowstone Luxury Cabin Retreat + Glorietta (deposit $0 to date) + Barker-Ewing float.
  - **Ritesh paid:** Both Enterprise mini vans + UA 1702 HVFBCM (5 non-refundable return) + UA 1702 HVZD9X (3 refundable return, Agarwal).
- Surfaces updated: Bookings priority item (both vans inline with full details + dates); Print Vehicles table (two complete rows); date-confirmation flag removed.
- **File: 2,422 lines / 177,484 bytes. JS clean, DOM balanced.**

---

## 2026-05-20 · Mobile thumb-nav fix + Print prominence + cancellation schedule + 2nd van

**Thumb-nav floating mid-screen on mobile (iOS Safari fix):**
- Root cause: `viewport-fit=cover` was missing from the viewport meta tag, so iOS Safari wasn't reserving the home-indicator safe area properly. The `position:fixed; bottom:0` then sat against the wrong baseline.
- Fixes applied:
  - Viewport meta: added `viewport-fit=cover`.
  - Thumb-nav padding: rewrote with `max(8px, env(safe-area-inset-bottom))` instead of `calc(8px + env(...))`, plus explicit left/right safe-area padding.
  - Body bottom padding (mobile): `calc(68px + env(safe-area-inset-bottom))` so content clears the nav even on notched devices.
  - Added `will-change:transform` on the thumb-nav for GPU acceleration (helps iOS Safari with fixed-position quirks).
- Flag: if the user's screenshot was actually a "Full Page" iOS screenshot, what they saw might also be a stitching artifact rather than a runtime bug. The CSS hardening above is defensive either way.

**Print one-pager prominence:**
- Added top-nav "⎙ Print" link styled as a pill (gold border, transparent) so it doesn't blend with the other text-style nav items — visible on every page on desktop.
- Added footer "⎙ Open the print one-pager" button — gold border, prominent, on every page (footer is global).
- Footer-meta text rewritten from "Print to PDF for offline reference" to "Save the one-pager as PDF for offline access" (the print page is the source; saving as PDF is the action).

**Cancellation deadlines & payment schedule section added to Print page:**
- New section sits right after "Itinerary at a glance" so deadlines are visible near the top of the printout.
- 8 dated rows in chronological order: Hal'e Teton final payment / cancellation flip (Jul 23), Yellowstone Luxury Cabin Retreat 100% refund window (Jul 27), Glorietta menu finalize (~Aug 9), Yellowstone Luxury 50% refund window (Aug 12), Glorietta cancel (Aug 13), both vans cancel (Aug 20), Barker-Ewing 72-hr (Aug 21 noon), UA 1702 HVZD9X refundable until departure (Aug 29).
- Non-refundable items called out separately below the table: UA 2472 (HTXHKY) + UA 1702 (HVFBCM).

**Second mini van wired into Bookings + Print:**
- Bookings priority item rewritten as "Two Enterprise mini vans · one-way JAC → BZN." Van 1 keeps full details. Van 2 shows "confirmation numbers + driver pending — to be added when Ritesh shares the second booking." Cancellation policy ("refundable until 2 days before pickup") + date assumption flagged.
- Print Vehicles table now has TWO rows: Mini Van #1 (with conf numbers) and Mini Van #2 (pending). Both rows note the refundable-until-2-days-before policy.
- DAYS array Day 1 stop note: "Pick up two SUVs" → "Pick up two Enterprise mini vans."

**Date flag for Rohit to confirm:**
- He said both vans are picked up at JAC and dropped at BZN "from the 27th to the 29th of August" — but the trip needs vehicles from Aug 22 onward (rental check-in Aug 22, transit drive Aug 26, etc.). Reading "27th" as a typo for "22nd"; flagged in the Bookings item explicitly so Rohit can correct.

**Payment attribution learned 2026-05-20 PM:**
- Rohit paid: all 9 Detroit DL flights inbound + return; HTXHKY (UA 2472 inbound Agarwal); Hal'e Teton; Yellowstone Luxury Cabin Retreat; Glorietta (deposit only — $0 to date); Barker-Ewing float.
- Ritesh paid: both Enterprise mini van bookings (via Costco Travel); UA 1702 HVZD9X (refundable Agarwal return).
- Open question: who paid HVFBCM (UA 1702, 5 non-refundable, Detroit-onward to CA)?

**File: 2,396 → 2,422 lines, 174,202 → 177,550 bytes. JS clean, DOM balanced.**

---

## 2026-05-20 · W. Yellowstone (Stay 2) booked — Yellowstone Luxury Cabin Retreat

**`rentalWyBooked` flipped to true. Only `raftBooked` remains open out of 7 STATUS flags.**

- PDF dropped at project root 2026-05-20 14:45 UTC as `Confirmation.pdf` (105 KB, Vrbo confirmation page).
- **Property:** Yellowstone Luxury Cabin Retreat — the Option A pick on the shortlist. Vrbo property `9746176ha`. 5 BR / 5 BA · 5,000 sf · Hebgen Lake area · 8 min to West Yellowstone town · 10 min to West Entrance.
- **Dates:** Wed Aug 26 → Sat Aug 29, 2026 · 3 nights. Matches Stay 2 exactly.
- **Check-in:** 4:00 PM. **Check-out:** 10:00 AM.
- **Guests:** 10 adults + 2 children = 12 (full party).
- **Reservation ID: ORB17812924.** Booked via Vrbo.
- **Charged:** $6,030.90 on May 20 ($1,395/nt × 3 = $4,185 + host fees $609 + service fee $657 + tax $579.90).
- **+ $1,500 refundable deposit** paid at the property (returned post-stay).
- **Total committed: $7,530.90.**
- Property address + access details are in the Vrbo Trip Details inbox once host accepts. Site card directs to Vrbo "Manage on Vrbo" for that.

**Surfaces updated:**
- `#lodging` page: Yellowstone Luxury Cabin Retreat card flipped to "✓ Booked · Stay 2" with full booking details + check-in/out times + deposit reminder. Bar N Ranch and Under Canvas cards marked "Not selected · Yellowstone Luxury Cabin Retreat was booked instead" and visually dimmed via the existing `.shortlist-card.not-selected` style.
- `#bookings` priority list: WY rental `<li>` updated from "still open" to full booked state with Vrbo reservation + property ID + price + check-in/out + deposit.
- Pre-trip ctx-cards: the WY rental checklist line now reads "Yellowstone Luxury Cabin Retreat booked (Aug 26-29, Vrbo ORB17812924)" and auto-strikes via `rentalWyBooked: true`.
- `#print` page Lodging section: Stay 2 row replaced "TBD" with full property + reservation + deposit info.
- Map JS: `LODGING_WY` name updated to "Yellowstone Luxury Cabin Retreat (Stay 2)". Coords left at W. Yellowstone town centroid (~8 min from the actual property per listing; close enough visually).
- Memory: this CHANGELOG entry + PROJECT_CONTEXT.md lodging/STATUS/checklist sections + auto-memory session-state.
- File: 2,394 → **2,396 lines, 173,312 → 174,202 bytes.**

**Open STATUS flag remaining: just `raftBooked` (Dave Hansen Whitewater, Aug 25 PM).**

---

## 2026-05-20 · Hal'e Teton booked + Enterprise Mini Van booked + STATUS flag split

**Two major bookings wired in. STATUS flag schema changed.**

**Hal'e Teton (Jackson rental · Stay 1):**
- Confirmed booking (PDF dropped at project root 2026-05-20 14:29 UTC as `Order Confirmation #112575 | Rendezvous Mountain Rentals.pdf`). PDF stayed at root rather than moving to `memory/` subfolder — different filing pattern from the Barker-Ewing float confirmation; flagging but not relocating.
- **Property:** Hal'e Teton · 5 BR / 5.5 BA · 6,600 sf · Teton Village · sleeps up to 22.
- **Dates:** Sat Aug 22 → Wed Aug 26, 2026 · 4 nights. **Matches Stay 1 exactly.**
- **Guests:** 10 adults + 2 children = 12 (full party).
- **Order #112575** · Rendezvous Rentals LLC · 307-739-9050 · rmrentals.com.
- **Total: $11,626.72** = lodging $8,396 + clean $1,175 + service/hot-tub/wellness fees + tax + trip insurance $901.07.
- **Payment:** $5,813.36 paid today; **$5,813.36 due 2026-07-23**.
- **Cancellation:** 30+ days out = 6% of initial payment forfeit; within 30 days = no refund. Trip insurance purchased — covers non-refundable payments.

**Enterprise Mini Van (vehicle, one-way JAC → BZN):**
- Booked by Ritesh through Costco Travel on 2026-05-20.
- **Costco conf C491501176 · Enterprise conf 2112908572.**
- **Driver:** PARUL RITESH KUMAR MAKHARIA.
- **Pickup requirements:** Driver must present Costco membership card. One additional driver fee waived for Costco members at participating locations. All additional drivers must be present at pickup.
- **Contact:** 1-866-328-1385 (before trip) · 1-866-317-4711 (during/after).
- **Pickup/drop dates and times NOT visible in the screenshots** — assumption is JAC pickup Aug 22 / BZN drop Aug 29 matching the trip. Flag for Rohit to confirm.
- **Assumption surfaced:** standard mini van seats 7-8; the trip needs capacity for 12. A second vehicle is likely needed but not yet seen. Flagged in the Bookings priority `<li>` with an explicit "Assumption to verify."

**STATUS flag schema change — `rentalsBooked` split into two:**
- Removed: `rentalsBooked`.
- Added: `rentalJacksonBooked: true` (Hal'e Teton confirmed) and `rentalWyBooked: false` (W. Yellowstone still open).
- Rationale: one rental confirmed, the other open — a single boolean couldn't represent that cleanly. Splitting lets each line auto-strike independently.
- All `data-status-key="rentalsBooked"` lines replaced with paired entries for Jackson + WY in both ctx-cards (`planning` + `t60`) and the Bookings priority list.

**Site surfaces touched:**
- `#lodging` page: Hal'e Teton shortlist-card flipped to "✓ Booked · Stay 1" with full booking details (order #, total, payment schedule, cancellation, operator); Moose Hideaway card marked "Not selected · Hal'e Teton was booked instead" and dimmed via new `.shortlist-card.not-selected` style. New CSS class `.shortlist-card.booked` adds a forest-green left bar.
- `#bookings` priority list: "Both rentals" item replaced with two items (Jackson booked / WY open); "Two SUVs" item replaced with the Enterprise Mini Van booking + driver + confs + Costco/Enterprise help numbers.
- Pre-trip ctx-cards: rentals checklist lines split into Jackson + WY.
- `#print` page: new "Lodging" and "Vehicles" sections inserted between Flights and Dinners. Day 8 description updated from "drop SUVs" to "drop vehicles."
- Map JS: `LODGING_JACKSON` name changed from "Jackson rental (Stay 1)" to "Hal'e Teton (Stay 1)". Coords left at Teton Village centroid placeholder (within a few hundred meters; accurate enough visually).
- File: 2,362 → **2,394 lines, 170,022 → 173,312 bytes.**

---

## 2026-05-19 · Confirmation numbers wired in (Ritesh forwarded them)

- Ritesh sent three confirmation numbers for the CA-direction tickets. Wired into every relevant surface in the site.
- **HTXHKY** — UA 2472 inbound (SFO → JAC, 3 pax, seats 34D/E/F).
- **HVFBCM** — UA 1702 return, 5 non-refundable seats (34A/B/C, 35B/C).
- **HVZD9X** — UA 1702 return, 3 refundable seats (35D/E/F). Booked under "Agarwal family" — that's the CA-party surname, confirms that the 3 inbound CA travelers and the 3 refundable return tickets belong to the same family.
- Updated 5 surfaces: inbound CA card seat meta-line, return CA card seat meta-line (now lists both PNRs by name and bolds them), pre-trip checklist `<li>` for inbound (planning + t60), pre-trip checklist `<li>` for return, print page Inbound CA row, print page Return CA row. The return card seat-meta line now reads: "Booked as two PNRs: **HVFBCM** — 5 seats non-refundable (34A / 34B / 34C / 35B / 35C); **HVZD9X** — 3 seats refundable, Agarwal family (35D / 35E / 35F)".
- File: 2,362 lines / 170,022 bytes.

---

## 2026-05-19 · California return flight booked (UA 1702 · two PNRs)

- Rohit booked the same flight UA 1702 across two separate PNRs covering all 8 onward-to-CA pax. **UA 1702 · BZN 4:25 PM → SFO 6:01 PM · Sat Aug 29, 2026 · Boeing 737 MAX 8 · 2h 36m · United Economy (W).**
  - **PNR 1 — non-refundable, 5 seats:** 34A, 34B, 34C, 35B, 35C.
  - **PNR 2 — refundable, 3 seats:** 35D, 35E, 35F.
- `flightsCaReturn` flipped `false → true` in STATUS object. **Only 2 STATUS flags remain open now: `rentalsBooked` and `raftBooked`.**
- Onward-to-California card on `#flights` page flipped from `return-ca tbd` → `return-ca` (loses the striped TBD background). One consolidated card for both PNRs per Rohit's direction ("just have one card from Bozeman to SFO, since it's just the same flight").
- **Seat meta-line on the card** notes both PNRs: "Booked as two PNRs: 5 seats non-refundable (34A / 34B / 34C / 35B / 35C) + 3 seats refundable (35D / 35E / 35F)".
- **Confirmation numbers** were not in the screenshots provided. Card does not currently list conf numbers — Rohit said "just reference the confirmation numbers that are refundable or unrefundable," which (after parsing) reads as "note the refundable/non-refundable distinction" rather than literal conf numbers. If actual conf numbers come later, they go in the seat meta-line.
- **Flight-note rewritten:** removed the "When the CA itinerary lands, this card updates" placeholder. New note: "4:25 PM departure clears the 12:30 PM floor comfortably. Leave West Yellowstone by ~11 AM, ~2.5-hr Gallatin Canyon drive to BZN — same drive window as the Detroit group. Both vehicles drop at BZN together; one handles each party's bags through check-in."
- **Print page Return CA row** updated with actual flight + both seat blocks (was still "TBD · post-12:30 PM required").
- Both pre-trip checklist `<li>` items reflect the booking and auto-strike with the flag.
- File: 2,362 lines / 169,839 bytes.

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
