# Nemo - AI-Powered Conversational Assistant

## 📌 Overview

Nemo is a **Flutter** application that integrates **Google Gemini AI, Speech-to-Text, and Text-to-Speech (TTS)** to provide a seamless conversational experience. This app allows users to communicate with an AI assistant via text and voice input, receive responses with voice output, and store chat history using **Hive**.

## 🚀 Features

- **AI-Powered Conversations** - Uses Google's **Gemini AI** for generating responses.
- **Speech-to-Text (STT)** - Converts voice input into text using the `speech_to_text` package.
- **Text-to-Speech (TTS)** - Reads responses aloud with adjustable speech rate, pitch, and volume.
- **Chat History Persistence** - Stores chat history using **Hive database**.
- **Toggle Voice Response** - Option to enable or disable AI voice responses.
- **Scroll to Latest Message** - Automatically scrolls down to show the latest message.

## 📸 Screenshots

### Web

<img src="https://drive.google.com/uc?export=view&id=1s4pVgG05XJy7rvy9XxS_YYXlouxP915z" width="600"/>

### App

<img src="https://drive.google.com/uc?export=view&id=15EZ_Qks-4pBNxTk2ttVp9mWk5I0Ugs_I" width="300"/>

## 🛠️ Tech Stack

- **Flutter** (Cross-platform mobile development)
- **Google Gemini AI** (Natural language processing)
- **Hive** (Local database for storing chat history)
- **GetX** (State management)
- **Speech-to-Text API** (Voice input processing)
- **Flutter TTS** (Voice output for AI responses)

## 🔧 Installation

1. **Clone the Repository**
   ```sh
   git clone https://github.com/CodeBySubin/Ai-Chatbot
   cd Nemo
   ```
2. **Install Dependencies**
   ```sh
   flutter pub get
   ```
3. **Run the App**
   ```sh
   flutter run
   ```

## 📝 Usage

1. **Type or Speak** - Enter text in the chatbox or use the microphone for voice input.
2. **AI Response** - The chatbot processes the input and responds in text & voice.
3. **View History** - Previous messages are saved using Hive and can be accessed anytime.
4. **Toggle Voice** - Enable or disable AI voice output using the toggle button.

## 🔑 API Configuration

- Replace your **Google Gemini API Key** in `ChatController`:
  ```dart
  model = GenerativeModel(
     model: 'gemini-pro',
     apiKey: "YOUR_GOOGLE_API_KEY",
  );
  ```

## 📂 Project Structure

```
├── lib
│   ├── controllers
│   │   ├── chat_controller.dart
│   ├── models
│   │   ├── chat_model.dart
│   ├── utils
│   │   ├── utils.dart
│   ├── views
│   │   ├── chat_screen.dart
│   ├── main.dart
│   ├── pubspec.yaml
```

## 🛠️ Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  google_generative_ai: ^latest_version
  speech_to_text: ^latest_version
  flutter_tts: ^latest_version
  get: ^latest_version
  hive: ^latest_version
  hive_flutter: ^latest_version
```

## 🌐 Try the Web App

🔗 **[Live Demo](https://chatbot-7af1b.web.app/)**

## 📩 Contact

For any queries or suggestions, feel free to reach out:
📧 Email: subin.c.mail@gmail.com
