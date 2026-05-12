#!/bin/bash
# Download all images and park maps used by index.html
# Run this once from the project folder: bash download-images.sh
# Re-run anytime to refresh files (curl -o overwrites existing).

set -e
mkdir -p img
cd img

echo "Downloading hero image (Mormon Row, Tetons behind)..."
curl -fsSL -o hero-tetons.jpg \
  "https://images.unsplash.com/photo-1695331942059-6bf9226ccb2b?fm=jpg&q=75&w=2400&auto=format&fit=crop"

echo "Downloading Day 1 photo (Tetons — arrival view)..."
curl -fsSL -o day1-arrival.jpg \
  "https://images.unsplash.com/photo-1651076473973-270bce695321?fm=jpg&q=75&w=1600&auto=format&fit=crop"

echo "Downloading Day 2 photo (Jenny Lake)..."
curl -fsSL -o day2-jenny-lake.jpg \
  "https://images.unsplash.com/photo-1688275346864-0e9a9b595112?fm=jpg&q=75&w=1600&auto=format&fit=crop"

echo "Downloading Day 3 photo (Hidden Falls, GTNP)..."
curl -fsSL -o day3-hidden-falls.jpg \
  "https://images.unsplash.com/photo-1531247318752-1e5712f633b1?fm=jpg&q=75&w=1600&auto=format&fit=crop"

echo "Downloading Day 4 photo (Tetons flex day — using Mormon Row scene)..."
curl -fsSL -o day4-tetons-flex.jpg \
  "https://images.unsplash.com/photo-1695331942059-6bf9226ccb2b?fm=jpg&q=75&w=1600&auto=format&fit=crop"

echo "Downloading Day 5 photo (West Thumb / Yellowstone Lake)..."
curl -fsSL -o day5-west-thumb.jpg \
  "https://images.unsplash.com/photo-1754956042889-b23e3c0673ab?fm=jpg&q=75&w=1600&auto=format&fit=crop"

echo "Downloading Day 6 photo (Old Faithful)..."
curl -fsSL -o day6-old-faithful.jpg \
  "https://images.unsplash.com/photo-1754878302051-6087c8d632bf?fm=jpg&q=75&w=1600&auto=format&fit=crop"

echo "Downloading Day 7 photo (Lower Yellowstone Falls)..."
curl -fsSL -o day7-lower-falls.jpg \
  "https://images.unsplash.com/photo-1721243017987-2e4677ecb248?fm=jpg&q=75&w=1600&auto=format&fit=crop"

echo "Downloading Day 8 photo (Bison — Yellowstone)..."
curl -fsSL -o day8-bison.jpg \
  "https://images.unsplash.com/photo-1645208966050-3ee80004a719?fm=jpg&q=75&w=1600&auto=format&fit=crop"

echo "Downloading Grand Teton NPS brochure map..."
curl -fsSL -o nps-grand-teton.jpg \
  "https://npmaps.com/wp-content/uploads/grand-teton-national-park-map.jpg"

echo "Downloading Yellowstone NPS brochure map..."
curl -fsSL -o nps-yellowstone.jpg \
  "https://npmaps.com/wp-content/uploads/yellowstone-national-park-map-1.jpg"

echo ""
echo "Done. Files saved to img/:"
ls -lh
