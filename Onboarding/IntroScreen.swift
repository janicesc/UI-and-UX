//
//  IntroScreen.swift
//  Onboarding
//
//  Created by Janice C on 9/16/25.
//

import SwiftUI

// MARK: - IntroScreen

struct IntroScreen: View {
    @Binding var currentScreen: Int

    var body: some View {
        ZStack {
            backgroundGradient
            content
        }
    }

    // MARK: Background
    private var backgroundGradient: some View {
        LinearGradient(
            gradient: Gradient(colors: Self.bgColors),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }

    // MARK: Content
    private var content: some View {
        VStack(spacing: 32) {
            avatarImage
            titleSection
            actionSection
        }
        .padding(.horizontal, 24)
        .padding(.vertical, 20)
    }

    private var avatarImage: some View {
        Image("healthy-avatar")
            .resizable()
            .scaledToFit()
            .frame(width: 192, height: 192)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .shadow(radius: 10)       // Tailwind w-48 h-48
            .shadow(color: .black.opacity(0.15),   // drop-shadow-2xl approx
                    radius: 25, x: 0, y: 25)
    }

    private var titleSection: some View {
        VStack(spacing: 16) {
            Text("Ready to look your best?")
                .font(.system(size: 28, weight: .bold))   // text-3xl font-bold
                .foregroundStyle(.white)
                .multilineTextAlignment(.center)
                .shadow(color: .black.opacity(0.6), radius: 6, x: 0, y: 2) // drop-shadow-lg

            Text("Meet your cheerful nutrition companion that makes healthy eating fun, easy, and rewarding!")
                .font(.system(size: 18))                  // text-lg
                .foregroundStyle(Color.white.opacity(0.9))
                .multilineTextAlignment(.center)
                .shadow(color: .black.opacity(0.5), radius: 4, x: 0, y: 2) // drop-shadow-md
                .padding(.horizontal, 8)
        }
        .frame(maxWidth: 520) // ~max-w-sm
    }

    private var actionSection: some View {
        VStack(spacing: 16) {
            Button {
                withAnimation(.easeInOut) { currentScreen = 1 }
            } label: {
                Text("Let's start this journey! 🚀")
                    .font(.system(size: 20, weight: .semibold)) // text-lg font-semibold
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)                      // py-4
                    .foregroundStyle(.white)
                    .background(buttonGradient)
                    .clipShape(Capsule())                        // rounded-full
                    .shadow(color: .black.opacity(0.4), radius: 12, x: 0, y: 6) // shadow-xl
            }
            .buttonStyle(PressScaleButtonStyle()) // simple, compiler-friendly press effect
            .padding(.horizontal, 8)

            Text("Join thousands who've transformed their lives with joy")
                .font(.system(size: 14))                        // text-sm
                .foregroundStyle(Color.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .shadow(color: .black.opacity(0.4), radius: 2, x: 0, y: 1) // drop-shadow-sm
        }
        .padding(.top, 8)
        .frame(maxWidth: 520)
    }

    private var buttonGradient: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(hex: "#0891b2"), // cyan-600
                Color(hex: "#0d9488")  // teal-600
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    // Tailwind gradient colors (top→bottom) from the v0 snippet
    private static let bgColors: [Color] = [
        Color(hex: "#0f172a"), // slate-900
        Color(hex: "#1e293b"), // slate-800
        Color(hex: "#0f4c75"),
        Color(hex: "#3730a3"), // indigo-800
        Color(hex: "#1e40af"), // blue-800
        Color(hex: "#0891b2"), // cyan-600
        Color(hex: "#0d9488"), // teal-600
        Color(hex: "#059669")  // emerald-600
    ]
}

// MARK: - Helpers

/// Simple press-to-scale button style (lighter than custom gestures)
struct PressScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.05 : 1.0)
            .animation(.easeInOut(duration: 0.18), value: configuration.isPressed)
    }
}

#Preview {
    IntroScreen(currentScreen: .constant(0))
}
