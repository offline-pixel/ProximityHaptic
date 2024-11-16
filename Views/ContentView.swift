import SwiftUI
import CoreHaptics

struct ContentView: View {
    @State private var dotPosition = CGPoint(x: 200, y: 400)
    @State private var touchLocation: CGPoint? = nil
    @State private var hapticEngine: CHHapticEngine?
    @State private var isVibrating = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white.edgesIgnoringSafeArea(.all)

                Circle()
                    .fill(Color.red)
                    .frame(width: 40, height: 40)
                    .position(dotPosition)

                Color.clear
                    .contentShape(Rectangle())
                    .gesture(
                        DragGesture(minimumDistance: 0)
                            .onChanged { gesture in
                                self.touchLocation = gesture.location
                                self.handleProximity(to: geometry.size)
                            }
                            .onEnded { _ in
                                self.touchLocation = nil
                                self.stopVibration()
                            }
                    )
            }
        }
        .onAppear {
            self.prepareHaptics()
        }
    }

    private func handleProximity(to screenSize: CGSize) {
        guard let touchLocation = touchLocation else { return }

        let distance = hypot(touchLocation.x - dotPosition.x, touchLocation.y - dotPosition.y)
        let maxDistance: CGFloat = 200

        if distance <= maxDistance {
            let proximity = max(0, 1 - distance / maxDistance)

            if !isVibrating {
                startVibration()
            }

            if distance < 20 {
                stopVibration()
                triggerHapticClick()
                randomizeDotPosition(in: screenSize)
            }
        }
    }

    private func randomizeDotPosition(in screenSize: CGSize) {
        let dotSize: CGFloat = 40
        let x = CGFloat.random(in: dotSize...(screenSize.width - dotSize))
        let y = CGFloat.random(in: dotSize...(screenSize.height - dotSize))
        self.dotPosition = CGPoint(x: x, y: y)
    }

    private func prepareHaptics() {
        do {
            hapticEngine = try CHHapticEngine()
            try hapticEngine?.start()
        } catch {
            print("Haptic engine failed to start: \(error.localizedDescription)")
        }
    }
    private func startVibration() {
        isVibrating = true
        let generator = UIImpactFeedbackGenerator(style: .medium)
        DispatchQueue.global(qos: .background).async {
            while self.isVibrating {
                generator.impactOccurred()
                usleep(100_000)
            }
        }
    }

    private func stopVibration() {
        isVibrating = false
    }

    private func triggerHapticClick() {
        guard let engine = hapticEngine else { return }

        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 0)
        do {
            let pattern = try CHHapticPattern(events: [event], parameters: [])
            let player = try engine.makePlayer(with: pattern)
            try player.start(atTime: 0)
        } catch {
            print("Failed to play haptic click: \(error.localizedDescription)")
        }
    }
}
