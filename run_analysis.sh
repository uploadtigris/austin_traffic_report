#!/bin/bash

# Robust analysis script for Austin Traffic Report
set -e  # Exit immediately if any command fails

echo "🚀 Starting analysis..."

# 1. Install dependencies
pip install -r requirements.txt || {
    echo "❌ Failed to install dependencies";
    exit 1;
}

# 2. Execute notebook
jupyter nbconvert --execute --to notebook --inplace analysis.ipynb || {
    echo "❌ Notebook execution failed";
    exit 1;
}

# 3. Convert to HTML with explicit output handling
OUTPUT_HTML="report.html"
jupyter nbconvert --to html --output-dir=. --output="$OUTPUT_HTML" analysis.ipynb || {
    echo "❌ HTML conversion failed";
    exit 1;
}

# 4. Cleanup and verify
[ -f "$OUTPUT_HTML" ] || {
    echo "❌ Output HTML not found";
    exit 1;
}

echo "✅ Success! Report generated: $OUTPUT_HTML"
echo "🖥️  Open in browser:"
echo "    open $OUTPUT_HTML  # MacOS"
echo "    xdg-open $OUTPUT_HTML  # Linux"
echo "    start $OUTPUT_HTML  # Windows CMD"
