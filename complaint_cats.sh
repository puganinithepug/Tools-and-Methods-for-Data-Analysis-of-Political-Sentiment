#!/bin/bash
touch complaint_type_analysis.md
echo "Most frequent complaint in Jan-Feb:" >> complaint_type_analysis.md
cut -d, -f6 jan_feb_2024.csv | tail -n +2 | sort | uniq -c | sort -nr  | head -n 1 >> complaint_type_analysis.md
echo "Most frequent complaint in June-July:" >> complaint_type_analysis.md
cut -d, -f6 june_july_2024.csv | tail -n +2 | sort | uniq -c | sort -nr | head -n 1 >> complaint_type_analysis.md

echo "See frequency in June-July for most frequent complaint in Jan-Feb:" >> complaint_type_analysis.md
top_jan_feb=$(head -n 1 count_complaints_jan_feb.csv | awk '{$1=""; sub(/^ /,""); print}')
grep -F "$top_jan_feb" count_complaints_june_july.csv >> complaint_type_analysis.md

echo "See frequency in Jan-Feb of most frequent complaint in June-July:" >> complaint_type_analysis.md
top_june_july=$(head -n 1 count_complaints_june_july.csv | awk '{$1=""; sub(/^ /,""); print}')
grep -F "$top_june_july" count_complaints_jan_feb.csv >> complaint_type_analysis.md

