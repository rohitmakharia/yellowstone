# Yellowstone — Source Artifact Inventory

Chain-of-custody log for every photo, screenshot, and PDF Rohit shared during the project. For each artifact: where it lives (or "LOST" if the raw is gone), what data was extracted from it, and where that data now sits in the codebase.

**Rule (effective 2026-05-20):** every raw upload is copied to `Source Data/` *before* data is extracted. Filename convention: `YYYY-MM-DD_short-slug.ext`.

---

## Preserved — raw files in `Source Data/`

| File | Source date | What it documents |
|---|---|---|
| `PHOTO-2026-05-11-18-18-40.jpg` | 2026-05-11 | Delta inbound leg 1 — DL 0935 DTW→SLC Aug 22, 9 pax, 12:15 PM → 2:06 PM, Boeing 737-900 |
| `PHOTO-2026-05-11-18-18-40 2.jpg` | 2026-05-11 | Delta inbound leg 2 — DL 0417 SLC→JAC Aug 22, 9 pax, 3:52 PM → 4:57 PM, Airbus A319, total 6h 42m DTW→JAC |
| `PHOTO-2026-05-11-18-18-40 3.jpg` | 2026-05-11 | Detroit return — DL 0364 BZN→DTW Aug 29, 4 pax, 3:38 PM → 8:54 PM, Airbus A319 |
| `PHOTO-2026-05-19-11-38-53.jpg` | 2026-05-19 | UA 2472 SFO→JAC Aug 22, 1:26 PM → 4:39 PM, Airbus A320, 2h 13m, seats 34D/E/F · conf **HTXHKY** (Agarwal inbound) |
| `PHOTO-2026-05-19-11-25-48.jpg` | 2026-05-19 | UA 1702 BZN→SFO Aug 29, 4:25 PM → 6:01 PM, Boeing 737 MAX 8, 2h 36m, 5 seats 34A/B/C, 35B/C · conf **HVFBCM** (non-refundable, Detroit-onward party) |
| `PHOTO-2026-05-19-11-37-51.jpg` | 2026-05-19 | UA 1702 BZN→SFO Aug 29, same flight, 3 seats 35D/E/F · conf **HVZD9X** (refundable, Agarwal return) |
| `PHOTO-2026-05-20-09-51-32.jpg` | 2026-05-20 | Van 1 reservation — Costco **C491501172** · Enterprise **2112908075** · driver RITESH KUMAR MAKHARIA · booking email ri\*\*\*\*ia@gmail.com · booked May 20, 2026 |
| `PHOTO-2026-05-20-09-53-14.jpg` | 2026-05-20 | Van 2 reservation — Costco **C491501176** · Enterprise **2112908572** · driver PARUL RITESH KUMAR MAKHARIA · booking email pa\*\*\*\*ia@gmail.com · booked May 20, 2026 |
| `Confirmation.pdf` | 2026-05-20 | Vrbo Yellowstone Luxury Cabin Retreat — reservation **ORB17812924**, property 9746176ha, Aug 26-29, $6,030.90 charged + $1,500 deposit at property |
| `Order Confirmation #112575 \| Rendezvous Mountain Rentals.pdf` | 2026-05-20 | Hal'e Teton — order **#112575**, Rendezvous Mountain Rentals, Aug 22-26, $11,626.72 total ($5,813.36 paid, $5,813.36 due 2026-07-23) |
| `0B9B77CB-...jpeg`, `A223BED6-...jpeg`, `A5667687-...jpeg` | 2026-05-11 | Legacy planning photos from initial conversation — not referenced by site |

## Preserved elsewhere

| File | Location | What it documents |
|---|---|---|
| `2026-08-24_barker-ewing-confirmation.pdf` | `memory/` | Barker-Ewing private float — Aug 24 noon, conf 8L5Q8N9T7K3V2H7F, $1,200 paid, 72-hr cancellation policy |
| `yellowstone-tetons-chat-transcript.pdf` | project root | Prior planning chat from May 9-11 (v1-v6 build cycle) |

---

## Pending — re-attached in chat but did not land on disk

| Expected filename | What it documents | Data already preserved in |
|---|---|---|
| `2026-05-20_vrbo-cancellation-policy.png` (or .jpg) | Vrbo cancellation policy — 100% refund by Jul 27, 50% (minus service fee) by Aug 12, no refund after Aug 12, cancel by 11:59 PM property local time | `yellowstone-deadlines.ics` (2 events) + Print page cancellation table + CHANGELOG 2026-05-20 |

---

## Closed — no longer tracked

| Item | Why dropped |
|---|---|
| Mobile thumb-nav floating bug screenshot | Per Rohit 2026-05-20: "don't worry about the Safari scroll for now." Not load-bearing — was a bug-report image; fix is in `index.html` + CHANGELOG. |
| Group-chat conf-numbers screenshot (variously called Telegram/iMessage/WhatsApp) | Per Rohit 2026-05-20: "Forget about the WhatsApp messages. It's not important. It's already captured in the index.html." Data preserved in `index.html` flight cards + the 3 standalone UA ticket photos in Source Data/. |

---

## How to read this file

If a booking value gets questioned later, the source-of-truth chain is: extracted data in `index.html` / `.ics` / `.xlsx` → entry in this file → either the named file in `Source Data/` (verifiable, second-source audit possible) or the pending/closed tables above.

For new uploads going forward: save to `Source Data/` with filename `YYYY-MM-DD_short-slug.ext`, then add a row to the preserved table above with the same information schema. If the upload didn't land in the uploads directory, ask Rohit to drop the file in directly via Finder — don't fabricate the content from chat context.
