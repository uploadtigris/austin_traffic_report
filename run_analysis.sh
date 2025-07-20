#!/bin/bash

# Create output directory
mkdir -p my_images

# Run the notebook and save output
jupyter nbconvert --execute --to html --output-dir=my_images traffic_report.ipynb

echo "✅ Done! Output saved to my_images/"
