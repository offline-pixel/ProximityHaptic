### Proximity-Based Haptic App
A single-page iOS app that demonstrates proximity-based haptic feedback using SwiftUI. The app places a dot on the screen, and as the user moves their finger closer to the dot, haptic feedback intensity increases. When the dot is touched, a satisfying haptic click is triggered, and the dot moves to a new random location.

### Features
**Proximity-Based Haptic**:
Provides increasing haptic vibration intensity as the user moves closer to the dot.

**Dynamic Dot Placement**:
The dot is placed at random positions on the screen and resets upon successful touch.

**Satisfying Haptic Click**:
A click-like haptic is triggered when the user touches the dot.

**Responsive Design**:
Adapts to different screen sizes and orientations.

### Technologies Used
**SwiftUI**: Declarative UI framework for building modern iOS apps.
**CoreHaptics**: Provides precise control over haptic feedback.
**Swift**: The language powering the app's logic and UI.

### Setup Instructions
1. Clone the Repository
```
    git clone https://github.com/your-username/ProximityHapticApp.git
    cd ProximityHapticApp
```

2. Open in Xcode

Open Xcode on your Mac.

Go to File > Open and navigate to the ProximityHapticApp.xcodeproj file.
Select the project and open it.

3. Run the App

Connect an iOS device (iPhone 8 or later for haptic feedback).

In Xcode, select your device under Product > Destination.

Press Command + R or click the Run button to build and launch the app.
How It Works

A red dot is displayed at a random position on the screen.

The user places their finger on the screen:

Haptic feedback intensity increases as the finger approaches the dot.

Visual feedback changes dynamically (dot opacity adjusts based on proximity).

When the dot is touched:

A satisfying haptic click is triggered.

The dot moves to a new random position.
