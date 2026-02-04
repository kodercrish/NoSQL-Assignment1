#!/bin/bash

# Usage check
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 output.txt expected_output.txt"
    exit 1
fi

output="$1"
expected="$2"

# File existence check
if [ ! -f "$output" ] || [ ! -f "$expected" ]; then
    echo "Error: One or both files do not exist."
    exit 1
fi

# Total lines in expected output
total_lines=$(wc -l < "$expected")

# Count differing lines
diff_lines=$(diff -y --suppress-common-lines "$output" "$expected" | wc -l)

# Matching lines
correct_lines=$((total_lines - diff_lines))

# Accuracy calculation
if [ "$total_lines" -eq 0 ]; then
    accuracy=100
else
    accuracy=$(awk "BEGIN { printf \"%.2f\", ($correct_lines/$total_lines)*100 }")
fi

# Report
echo "----------------------------"
echo "Total lines        : $total_lines"
echo "Correct lines      : $correct_lines"
echo "Incorrect lines    : $diff_lines"
echo "Accuracy           : $accuracy %"
echo "----------------------------"

# Show differences
if [ "$diff_lines" -ne 0 ]; then
    echo
    echo "Differences:"
    diff -y "$output" "$expected"
fi
