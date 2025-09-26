#!/bin/bash
# Generate line percentages for main ponies from clean_dialog.csv

INPUT="clean_dialog.csv"
OUTPUT="Line_percentages.csv"

# Count total spoken lines (skip header)
total_lines=$(tail -n +2 "$INPUT" | wc -l)

# Write header to CSV
echo "pony_name,total_line_count,percent_all_lines" > "$OUTPUT"

# Loop through main ponies
for pony in "Twilight Sparkle" "Rarity" "Pinkie Pie" "Rainbow Dash" "Fluttershy"
do
    # Count lines spoken by pony
    count=$(grep -F "$pony" "$INPUT" | wc -l)

    # Compute percentage (2 decimal places)
    percent=$(echo "scale=4; ($count/$total_lines)*100" | bc)

    # Append to CSV
    echo "$pony,$count,$percent" >> "$OUTPUT"
done

