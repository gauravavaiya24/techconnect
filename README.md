# techconnect

TechConnect is a cross-platform mobile application built with Flutter. It is designed to help users discover and engage with tech-focused events like hackathons, startup expos, coding meetups, and workshops — all in one place.

## Getting Started

<!-- This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference. -->


## Setup Guide

    1.Prerequisites

        Flutter SDK = 3.32.0
        Dart SDK = 3.8.0
        Android Studio / VS Code with Flutter & Dart plugins
        Firebase project (for authentication & Firestore)

    2. Clone the Repository

        git clone https://github.com/gauravavaiya24/techconnect.git
        cd techconnect

    3. Install Dependencies
        flutter pub get

    4. Run the App
        flutter run

    5. Build for Release
        flutter build apk --release


## Theme Rationale: Tech & Startup

    TechConnect aligns with the Tech & Startup community theme — it promotes innovation and collaboration through events like:
        Hackathons
        Tech meetups
        Startup pitching sessions
        Developer workshops

    This app helps students, developers, and startup founders discover events, RSVP, and network in real time.
    Design principles:
        Real-time interactions for community engagement
        Support for rapid event discovery and RSVPs


 ## Team Roles and Contributions
 
    1. Gaurav Jayesbhai Avaiya:	Project Lead - Set up the Flutter project structure, developed event listing & routing, contributed to authentication logic, and co-authored setup documentation.

    2. Malay: Firebase - Integrated Firebase Auth and Firestore, built RSVP and comment APIs, contributed to API documentation and Firebase setup.

    3. Het: UI/UX Designer - Designed UI/UX using Figma, implemented login/register/profile screens, contributed to frontend components and UI documentation.

    4. Digvijay: Full Stack Contributor - Wrote event detail and commenting modules, implemented form validation, performed app testing (unit & manual), and led README, APA citations, and API documentation.


## API Documentation (Firebase-based)

    Authentication
        POST /register: Register using email/password
        POST /login: Log in user
        GET /logout: Log out current session

    Events Collection (/events)
        GET /events: Retrieve all upcoming tech events
        POST /events: Create a new event (admin)
        GET /events/:id: Get specific event details

    RSVPs
        POST /rsvp: RSVP to an event (requires auth)
        GET /rsvps/:uid: Fetch all RSVPs by user

    Comments Collection (/comments)
        GET /event/:id/comments: Load real-time comments
        POST /event/:id/comments: Post a new comment

    User Profiles
        GET /users/:uid: Get user profile data
        PATCH /users/:uid: Update profile

## References

    Google. (n.d.). Flutter. https://flutter.dev
    Firebase. (n.d.). Firebase Authentication Documentation. https://firebase.google.com/docs/auth
    Firebase. (n.d.). Cloud Firestore Documentation. https://firebase.google.com/docs/firestore
    Material Design. (n.d.). Material Design Guidelines. https://m3.material.io/
    GitHub, Inc. (n.d.). GitHub. https://github.com
    Stack Overflow. (n.d.). Flutter community Q&A. https://stackoverflow.com/questions/tagged/flutter