//
//  BiometricsScreen.swift
//  Onboarding
//
//  Created by Janice C on 9/16/25.
//

import SwiftUI

struct BiometricsScreen: View {
    @Binding var currentScreen: Int
    @Binding var userData: UserData
    
    @State private var step: Int = 0
    
    private let steps: [BioStep] = [
        BioStep(
            title: "How old are you?",
            subtitle: "This helps us personalize your nutrition plan",
            field: .age,
            placeholder: "25",
            type: .number,
            icon: "🎂",
            gradient: [Color(hex: "#4ade80"), Color(hex: "#3b82f6")]
        ),
        BioStep(
            title: "What's your height?",
            subtitle: "We'll use this to calculate your nutritional needs",
            field: .height,
            placeholder: "5'8\" or 173 cm",
            type: .text,
            icon: "📏",
            gradient: [Color(hex: "#a855f7"), Color(hex: "#ec4899")]
        ),
        BioStep(
            title: "What's your current weight?",
            subtitle: "This helps us track your progress",
            field: .weight,
            placeholder: "150 lbs or 68 kg",
            type: .text,
            icon: "⚖️",
            gradient: [Color(hex: "#facc15"), Color(hex: "#f97316")]
        )
    ]
    
    var body: some View {
        let stepData = steps[step]
        let value = getValue(for: stepData.field)
        
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: stepData.gradient),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 24) {
                // Progress dots
                HStack(spacing: 8) {
                    ForEach(0..<steps.count, id: \.self) { i in
                        Circle()
                            .fill(i <= step ? Color.white : Color.white.opacity(0.3))
                            .frame(width: 8, height: 8)
                    }
                }
                .padding(.bottom, 24)
                
                // Icon
                Text(stepData.icon)
                    .font(.system(size: 56))
                    .padding(.bottom, 12)
                
                // Title + subtitle
                VStack(spacing: 8) {
                    Text(stepData.title)
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Text(stepData.subtitle)
                        .font(.system(size: 16))
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal, 16)
                
                // Input + button
                VStack(spacing: 20) {
                    TextField(stepData.placeholder, text: binding(for: stepData.field))
                        .textFieldStyle(BiometricsTextFieldStyle())
                        .keyboardType(stepData.type == .number ? .numberPad : .default)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 18))
                        .padding(.vertical, 4)
                    
                    Button {
                        handleNext()
                    } label: {
                        Text(step < steps.count - 1 ? "Continue" : "Next")
                            .font(.system(size: 20, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 16)
                            .foregroundColor(.gray.opacity(0.9))
                            .background(Color.white)
                            .clipShape(Capsule())
                            .shadow(color: .black.opacity(0.25), radius: 6, x: 0, y: 3)
                    }
                    .disabled(value.trimmingCharacters(in: .whitespaces).isEmpty)
                    .opacity(value.trimmingCharacters(in: .whitespaces).isEmpty ? 0.5 : 1)
                }
                .padding(.top, 12)
                
                // Skip option
                Button(action: { handleNext() }) {
                    Text("Skip for now")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.7))
                        .underline()
                }
                .padding(.top, 12)
            }
            .frame(maxWidth: 360)
            .padding(.horizontal, 24)
        }
    }
    
    // MARK: Logic
    
    private func handleNext() {
        if step < steps.count - 1 {
            step += 1
        } else {
            withAnimation(.easeInOut) { currentScreen += 1 }
        }
    }
    
    private func binding(for field: BioField) -> Binding<String> {
        switch field {
        case .age: return $userData.age
        case .height: return $userData.height
        case .weight: return $userData.weight
        }
    }
    
    private func getValue(for field: BioField) -> String {
        switch field {
        case .age: return userData.age
        case .height: return userData.height
        case .weight: return userData.weight
        }
    }
}

// MARK: - Step Model

struct BioStep {
    var title: String
    var subtitle: String
    var field: BioField
    var placeholder: String
    var type: FieldType
    var icon: String
    var gradient: [Color]
}

enum BioField { case age, height, weight }
enum FieldType { case text, number }

// MARK: - TextFieldStyle

struct BiometricsTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<_Label>) -> some View {
        configuration
            .padding(.vertical, 14)
            .padding(.horizontal, 12)
            .background(Color.white.opacity(0.1))
            .foregroundColor(.white)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.white.opacity(0.2), lineWidth: 1)
            )
            .accentColor(.white)
            .shadow(color: .black.opacity(0.1), radius: 1, x: 0, y: 1)
    }
}

#Preview {
    BiometricsScreen(
        currentScreen: .constant(2),
        userData: .constant(UserData())
    )
}
