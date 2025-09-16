//
//  HomeScreen.swift
//  Onboarding
//
//  Created by Janice C on 9/16/25.
//

import SwiftUI

// MARK: - HomeScreen

struct HomeScreen: View {
    @State private var loggedMeals: [String] = []
    @State private var streak: Int = 5
    @State private var calories: (current: Int, goal: Int) = (0, 2296)
    @State private var macros: (protein: (Int, Int), carbs: (Int, Int), fats: (Int, Int)) =
        ((0, 120), (0, 258), (0, 77))

    let userData: UserData
    
    private var greeting: String {
        let hour = Calendar.current.component(.hour, from: Date())
        if hour < 12 { return "Good morning" }
        else if hour < 18 { return "Good afternoon" }
        return "Good evening"
    }
    
    // MARK: - Background Gradient
    private let backgroundGradient = LinearGradient(
            gradient: Gradient(stops: [
                .init(color: Color(hex: "#0f172a"), location: 0.0),
                .init(color: Color(hex: "#1e293b"), location: 0.15),
                .init(color: Color(hex: "#0f4c75"), location: 0.30),
                .init(color: Color(hex: "#3730a3"), location: 0.45),
                .init(color: Color(hex: "#1e40af"), location: 0.60),
                .init(color: Color(hex: "#0891b2"), location: 0.75),
                .init(color: Color(hex: "#0d9488"), location: 0.90),
                .init(color: Color(hex: "#059669"), location: 1.0),
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    
    var body: some View {
        ZStack {
            backgroundGradient.ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    VStack(spacing: 6) {
                        Text("\(greeting), \(userData.name)!")
                            .font(.title2).bold()
                            .foregroundColor(.white)
                        Text("Your pet is waiting for some nourishment!")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                    }
                    .padding(.top, 20)
                    
                    // Avatar Card
                    VStack(spacing: 12) {
                        Image("sad-avatar") // 👈 replace with your asset
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120)
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                            .shadow(radius: 10)
                        
                        Text("Your HabitPet")
                            .font(.headline)
                            .foregroundColor(.white)
                        Text("Level 1 • \(loggedMeals.count) meals logged today")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.7))
                        
                        HStack(spacing: 12) {
                            Button(action: {
                                loggedMeals.append("Meal")
                                calories.current += 400
                            }) {
                                Label("Log Food", systemImage: "plus")
                                    .font(.subheadline).bold()
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(
                                        LinearGradient(
                                            colors: [Color(hex: "#06b6d4"), Color(hex: "#3b82f6")],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .foregroundColor(.white)
                                    .cornerRadius(16)
                            }
                            
                            Button(action: {}) {
                                Label("Recipes", systemImage: "book")
                                    .font(.subheadline).bold()
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(Color.white.opacity(0.1))
                                    .foregroundColor(.white)
                                    .cornerRadius(16)
                                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white.opacity(0.3)))
                            }
                        }
                    }
                    .padding()
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(24)
                    .overlay(RoundedRectangle(cornerRadius: 24).stroke(Color.white.opacity(0.2)))
                    
                    // Streak Card
                    Text("🏆 \(streak) Day Streak! 🏆")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            LinearGradient(colors: [Color.green, Color.teal], startPoint: .leading, endPoint: .trailing)
                        )
                        .cornerRadius(16)
                    
                    // Daily Calories
                    VStack(spacing: 12) {
                        HStack {
                            Text("Daily Calories")
                                .font(.headline)
                            Spacer()
                            Text("\(calories.current) / \(calories.goal)")
                                .font(.headline).bold()
                                .foregroundColor(.red)
                        }
                        
                        ProgressView(value: Double(calories.current), total: Double(calories.goal))
                            .progressViewStyle(LinearProgressViewStyle(tint: .red))
                        
                        HStack {
                            Text("\(Int(Double(calories.current) / Double(calories.goal) * 100))% of goal")
                                .font(.caption)
                                .foregroundColor(.gray)
                            Spacer()
                            Text("\(calories.goal - calories.current) remaining")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    
                    // Macronutrients
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Macronutrients")
                            .font(.headline)
                        
                        MacroRow(label: "Protein", current: macros.protein.0, goal: macros.protein.1, color: .orange)
                        MacroRow(label: "Carbs", current: macros.carbs.0, goal: macros.carbs.1, color: .blue)
                        MacroRow(label: "Fats", current: macros.fats.0, goal: macros.fats.1, color: .purple)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 5)
                    
                    // Bottom Nav
                    HStack {
                        Spacer()
                        BottomNavItem(icon: "magnifyingglass", label: "Search")
                        Spacer()
                        BottomNavItem(icon: "book", label: "Recipes")
                        Spacer()
                        BottomNavItem(icon: "chart.bar.fill", label: "Stats")
                        Spacer()
                        BottomNavItem(icon: "gearshape.fill", label: "Settings")
                        Spacer()
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(24, corners: [.topLeft, .topRight])
                }
                .padding()
            }
        }
    }
}

// MARK: - MacroRow
struct MacroRow: View {
    let label: String
    let current: Int
    let goal: Int
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            HStack {
                Text(label)
                Spacer()
                Text("\(current)g / \(goal)g")
                    .foregroundColor(color)
                    .bold()
            }
            ProgressView(value: Double(current), total: Double(goal))
                .progressViewStyle(LinearProgressViewStyle(tint: color))
            Text("\(goal == 0 ? 0 : Int(Double(current) / Double(goal) * 100))% of goal")
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

// MARK: - Bottom Nav
struct BottomNavItem: View {
    let icon: String
    let label: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.gray)
            Text(label)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

// MARK: - Corner Radius Helper
extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

// MARK: - Preview
struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(userData: UserData(name: "Janice", email: "test@example.com"))
    }
}
