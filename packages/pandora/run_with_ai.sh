#!/bin/bash

# Example script to run the app with Gemini API key
# Replace 'your-api-key-here' with your actual Gemini API key

echo "Starting Notes App with AI integration..."
echo "Make sure you have set your GEMINI_API_KEY environment variable"
echo "Or run with: flutter run --dart-define=GEMINI_API_KEY=your-key-here"

# Check if API key is set
if [ -z "$GEMINI_API_KEY" ]; then
    echo "Warning: GEMINI_API_KEY environment variable is not set"
    echo "The app will show an error when trying to use AI features"
    echo "Set it with: export GEMINI_API_KEY=your-key-here"
fi

# Run the app
flutter run --dart-define=GEMINI_API_KEY=${GEMINI_API_KEY:-"your-api-key-here"}
