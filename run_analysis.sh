!/bin/bash

# Install dependencies
pip install -r requirements.txt

# Run the analysis notebook
jupyter nbconvert --execute --to notebook --inplace analysis.ipynb

# Convert notebook to HTML for viewing
jupyter nbconvert --to html analysis.ipynb

# Rename outputs for clarity
mv analysis.html report.html
mv analysis_files/ report_files/

echo "✅ Report generated: report.html"
