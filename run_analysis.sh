#!/bin/bash

# Austin Traffic Report - Downloads Folder Edition
set -e  # Exit immediately if any command fails

echo "🚀 Setting up analysis environment..."

# 1. Set working directory to Downloads
cd ~/Downloads || {
    echo "❌ Error: Could not access Downloads folder"
    exit 1
}

# 2. Create project directory if it doesn't exist
PROJECT_DIR="austin_traffic_analysis"
mkdir -p "$PROJECT_DIR" || {
    echo "❌ Error: Failed to create project directory"
    exit 1
}
cd "$PROJECT_DIR" || exit 1

# 3. Install Python dependencies
echo "📦 Installing Python packages..."
pip install -r requirements.txt || {
    echo "❌ Error: Failed to install dependencies"
    exit 1
}

# 4. Verify notebook exists
NOTEBOOK="traffic_report.ipynb"
if [ ! -f "$NOTEBOOK" ]; then
    echo "❌ Error: Notebook $NOTEBOOK not found in $PWD"
    exit 1
fi

# 5. Create output directory
OUTPUT_DIR="output"
mkdir -p "$OUTPUT_DIR" || {
    echo "❌ Error: Failed to create output directory"
    exit 1
}

# 6. Execute and convert notebook
echo "📊 Running analysis..."
jupyter nbconvert --execute --to html \
    --output-dir="$OUTPUT_DIR" \
    --output="traffic_report" \
    "$NOTEBOOK" || {
    echo "❌ Error: Notebook execution failed"
    exit 1
}

# 7. Verify output
REPORT_PATH="$OUTPUT_DIR/traffic_report.html"
if [ -f "$REPORT_PATH" ]; then
    echo -e "\n✅ Success! Report generated at:"
    echo "   $(pwd)/$REPORT_PATH"
    echo -e "\nTo open the report:"
    echo "   - Linux: xdg-open '$REPORT_PATH'"
    echo "   - Mac: open '$REPORT_PATH'"
    echo "   - Windows (Git Bash): start '$REPORT_PATH'"
else
    echo "❌ Error: Final report not found at expected path"
    exit 1
fi
