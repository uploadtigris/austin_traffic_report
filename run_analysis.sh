#!/bin/bash

# Austin Traffic Report - Run Analysis Script
set -e  # Exit immediately if any command fails

echo "🚀 Setting up analysis environment..."

# 1. Install Python dependencies
echo "📦 Installing Python packages..."
pip install -r requirements.txt || {
    echo "❌ Error: Failed to install dependencies"
    exit 1
}

# 2. Verify notebook exists
NOTEBOOK="traffic_report.ipynb"
if [ ! -f "$NOTEBOOK" ]; then
    echo "❌ Error: Notebook $NOTEBOOK not found"
    exit 1
fi

# 3. Execute and convert notebook
echo "📊 Running analysis..."
jupyter nbconvert --execute --to html --output-dir=. --output=report "$NOTEBOOK" || {
    echo "❌ Error: Notebook execution failed"
    exit 1
}

# 4. Verify output
if [ -f "report.html" ]; then
    echo -e "\n✅ Success! Report generated:"
    echo "   - report.html (open in browser)"
    echo "   - Data files in output/"
else
    echo "❌ Error: Report generation failed"
    exit 1
fi
