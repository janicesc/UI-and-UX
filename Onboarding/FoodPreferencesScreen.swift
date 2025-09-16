//
//  FoodPreferencesScreen.swift
//  Onboarding
//
//  Created by Janice C on 9/16/25.
//

import SwiftUI

struct FoodPreferencesScreen: View {
    @Binding var currentScreen: Int
    @Binding var userData: UserData
    
    @State private var selected: [String] = []
    
    private let dietaryPreferences: [FoodOption] = [
        .init(id: "vegetarian", name: "Vegetarian", icon: "🌱"),
        .init(id: "high-protein", name: "High Protein", icon: "💪"),
        .init(id: "low-carb", name: "Low Carb", icon: "🥗"),
        .init(id: "keto", name: "Keto", icon: "🥑"),
        .init(id: "mediterranean", name: "Mediterranean", icon: "🫒"),
        .init(id: "gluten-free", name: "Gluten Free", icon: "🌾")
    ]
    
    private let foodCategories: [FoodOption] = [
        .init(id: "fruits", name: "Fruits", icon: "🍎"),
        .init(id: "veggies", name: "Veggies", icon: "🥦"),
        .init(id: "chicken", name: "Chicken", icon: "🍗"),
        .init(id: "beef", name: "Beef", icon: "🥩"),
        .init(id: "pork", name: "Pork", icon: "🥓"),
        .init(id: "fish", name: "Fish", icon: "🐟"),
        .init(id: "dairy", name: "Dairy", icon: "🧀"),
        .init(id: "dessert", name: "Dessert", icon: "🍰"),
        .init(id: "grains", name: "Grains", icon: "🍚"),
        .init(id: "nuts", name: "Nuts", icon: "🥜"),
        .init(id: "eggs", name: "Eggs", icon: "🥚"),
        .init(id: "pasta", name: "Pasta", icon: "🍝")
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(hex: "#34d399"), // emerald-400
                    Color(hex: "#14b8a6"), // teal-500
                    Color(hex: "#06b6d4")  // cyan-600
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Text("What foods do you enjoy?")
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                        Text("Select your dietary preferences and favorite foods")
                            .font(.system(size: 16))
                            .foregroundColor(.white.opacity(0.8))
                            .multilineTextAlignment(.center)
                    }
                    
                    // Dietary Preferences
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Dietary Preferences")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                            ForEach(dietaryPreferences) { pref in
                                PreferenceButton(option: pref, isSelected: selected.contains(pref.id)) {
                                    toggle(pref.id)
                                }
                            }
                        }
                    }
                    
                    // Food Categories
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Food Categories")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 4), spacing: 8) {
                            ForEach(foodCategories) { food in
                                PreferenceButton(option: food, isSelected: selected.contains(food.id), compact: true) {
                                    toggle(food.id)
                                }
                            }
                        }
                    }
                    
                    // Continue button
                    Button {
                        userData.foodPreferences = selected
                        withAnimation { currentScreen += 1 }
                    } label: {
                        Text("Continue (\(selected.count) selected)")
                            .font(.system(size: 20, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .foregroundColor(Color.teal)
                            .background(Color.white)
                            .clipShape(Capsule())
                            .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 4)
                    }
                    
                    // Skip
                    Button {
                        withAnimation { currentScreen += 1 }
                    } label: {
                        Text("Skip for now")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.7))
                            .underline()
                    }
                }
                .frame(maxWidth: 360)
                .padding(24)
            }
        }
        .onAppear {
            selected = userData.foodPreferences
        }
    }
    
    private func toggle(_ id: String) {
        if selected.contains(id) {
            selected.removeAll { $0 == id }
        } else {
            selected.append(id)
        }
    }
}

// MARK: - Option Model
struct FoodOption: Identifiable {
    var id: String
    var name: String
    var icon: String
}

// MARK: - Button View
struct PreferenceButton: View {
    let option: FoodOption
    let isSelected: Bool
    var compact: Bool = false
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: compact ? 2 : 4) {
                Text(option.icon)
                    .font(.system(size: compact ? 20 : 28))
                Text(option.name)
                    .font(.system(size: compact ? 11 : 14, weight: .medium))
                    .foregroundColor(.white)
                    .lineLimit(1)
            }
            .frame(maxWidth: .infinity)
            .padding(compact ? 6 : 12)
            .background(isSelected ? Color.white.opacity(0.2) : Color.white.opacity(0.1))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.white : Color.white.opacity(0.2), lineWidth: 2)
            )
            .cornerRadius(12)
        }
    }
}

// MARK: - Preview
#Preview {
    FoodPreferencesScreen(
        currentScreen: .constant(4),
        userData: .constant(UserData())
    )
}
