# AI Integration Setup

This app now includes AI-powered note summarization using Google's Gemini API.

## Setup Instructions

### 1. Get a Gemini API Key

1. Go to [Google AI Studio](https://aistudio.google.com/)
2. Sign in with your Google account
3. Create a new API key
4. Copy the API key

### 2. Configure the API Key

You have several options to set the API key:

#### Option A: Environment Variable (Recommended for production)
```bash
export GEMINI_API_KEY="your-api-key-here"
flutter run
```

#### Option B: Dart Define (Recommended for development)
```bash
flutter run --dart-define=GEMINI_API_KEY=your-api-key-here
```

#### Option C: IDE Configuration
In your IDE (VS Code, Android Studio), add the environment variable:
- Variable: `GEMINI_API_KEY`
- Value: `your-api-key-here`

#### Option D: Direct Configuration (Development only)
Edit `lib/config/app_config.dart` and uncomment the line:
```dart
static const String geminiApiKey = 'your-api-key-here';
```

### 3. Features

- **Note Summarization**: Click the "Summarize" button on any note detail screen to generate an AI summary
- **Loading States**: The UI shows loading indicators while the AI processes your request
- **Error Handling**: Clear error messages if the API call fails
- **Retry Functionality**: Easy retry button if summarization fails

### 4. Usage

1. Open the notes app
2. Tap on any note to view its details
3. Scroll down to the "AI Summary" section
4. Click the "Summarize" button
5. Wait for the AI to generate a summary
6. The summary will appear in a green box below the button

### 5. Troubleshooting

- **"GEMINI_API_KEY environment variable is required"**: Make sure you've set the API key using one of the methods above
- **"Failed to summarize"**: Check your internet connection and API key validity
- **Empty summary**: The note content might be too short or the API might be temporarily unavailable

### 6. Security Notes

- Never commit your API key to version control
- Use environment variables for production deployments
- Consider implementing API key rotation for production use
