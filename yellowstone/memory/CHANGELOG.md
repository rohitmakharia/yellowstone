# Yellowstone — Changelog

Session-by-session log of what shipped. Newest at top. Keep entries terse — one or two lines per change, with the *why* when it isn't obvious.

---

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
