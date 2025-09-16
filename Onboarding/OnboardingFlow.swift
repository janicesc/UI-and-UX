//
//  OnboardingFlow.swift
//  Onboarding
//
//  Created by Janice C on 9/16/25.
//

import SwiftUI

struct OnboardingFlow: View {
    @State private var currentScreen: Int = 0
    @State private var userData: UserData = UserData()
    
    var body: some View {
        ZStack {
            switch currentScreen {
            case 0:
                IntroScreen(currentScreen: $currentScreen)
            case 1:
                SignUpScreen(currentScreen: $currentScreen, userData: $userData)
            case 2:
                BiometricsScreen(currentScreen: $currentScreen, userData: $userData)
            case 3:
                GoalSettingScreen(currentScreen: $currentScreen, userData: $userData)
            case 4:
                FoodPreferencesScreen(currentScreen: $currentScreen, userData: $userData)
            case 5:
                NotificationsScreen(currentScreen: $currentScreen, userData: $userData)
            default:
                HomeScreen(userData: userData) // 👈 Landing screen after onboarding
            }
        }
        .animation(.easeInOut, value: currentScreen)
        .transition(.slide)
    }
}

#Preview {
    OnboardingFlow()
}
