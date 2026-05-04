# Muhib's Den ☕️

**Muhib's Den** is a modern, premium social communication platform built to provide a clean, secure, and vibrant environment for community conversations. Designed with simplicity and professional host-guest interaction in mind, the Den offers a seamless real-time chat experience for close-knit groups.

## 🚀 Key Features

*   **Real-time Group Chat**: Experience fluid, instant messaging powered by Firestore.
*   **Secure Authentication**: Robust Sign-Up and Sign-In flows using Firebase Authentication.
*   **Personalized Profiles**: Manage your identity, update your nickname, and keep your contact details secure.
*   **Modern Aesthetic**: A UI inspired by glassmorphism and Material Design 3, providing a warm, inviting, and professional atmosphere.
*   **Cross-Platform Ready**: Built with Flutter for a consistent experience across mobile and web.

## 🛠 Tech Stack

*   **Framework**: [Flutter](https://flutter.dev/)
*   **Backend**: [Firebase Authentication](https://firebase.google.com/docs/auth)
*   **Database**: [Cloud Firestore](https://firebase.google.com/docs/firestore)
*   **Design/UI**: Custom implementation with Material Symbols and responsive layouts.

## 📱 Getting Started

### Prerequisites

*   Flutter SDK (^3.11.5)
*   Firebase project configured with Email/Password Auth and Firestore enabled.
*   `google-services.json` (Android) and `GoogleService-Info.plist` (iOS) files.

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/muhibsden.git
    cd muhibsden
    ```

2.  **Install dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Run the application**:
    ```bash
    flutter run
    ```

## 🔐 Security & Data Management

Muhib's Den prioritizes user privacy. User information (Full Name, Nickname, Phone) is stored securely in Firestore, linked to their unique Firebase `uid`. Access is restricted via Firestore Security Rules.

## 🎨 UI/UX Philosophy

The app is built around the "Den" metaphor—a professional yet warm space. 
*   **Palette**: Indigo and Teal gradients for an energetic and modern feel.
*   **Typography**: *Plus Jakarta Sans* for headings (authority) and *Be Vietnam Pro* for readable message text.
*   **Interaction**: Glassmorphism effects and smooth navigation transitions ensure a premium user feel.

---

*Built with passion. Living the dream at Muhib's Den.* ☕️
