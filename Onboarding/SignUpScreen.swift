//
//  SignUpScreen.swift
//  Onboarding
//
//  Created by Janice C on 9/16/25.
//

import SwiftUI

struct SignUpScreen: View {
    @Binding var currentScreen: Int
    @Binding var userData: UserData   // custom model for name/email
    
    @State private var name: String = ""
    @State private var email: String = ""
    @State private var showNameError: Bool = false
    @State private var showEmailError: Bool = false
    @FocusState private var focusedField: Field?
    
    enum Field {
        case name, email
    }
    
    var body: some View {
        ZStack {
            backgroundGradient
            
            VStack(spacing: 24) {
                headerSection
                formSection
                footerSection
            }
            .frame(maxWidth: 360)
            .padding(.horizontal, 24)
        }
        .onAppear {
            name = userData.name
            email = userData.email
        }
    }
    
    // MARK: Background
    private var backgroundGradient: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.blue, Color.purple, Color.indigo
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
    
    // MARK: Header
    private var headerSection: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.white.opacity(0.2))
                    .frame(width: 64, height: 64)
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 32, height: 32)
                    .foregroundColor(.white)
            }
            .padding(.bottom, 12)
            
            Text("Hi there! Let's get started.")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
            
            Text("Tell us a bit about yourself")
                .font(.system(size: 16))
                .foregroundColor(.white.opacity(0.8))
        }
        .multilineTextAlignment(.center)
    }
    
    // MARK: Form
    private var formSection: some View {
        VStack(spacing: 20) {
            // Name Input
            VStack(alignment: .leading, spacing: 6) {
                Text("Name")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white.opacity(0.9))
                
                ZStack(alignment: .leading) {
                    if name.isEmpty {
                        Text("Enter your name")
                            .foregroundColor(.white.opacity(0.6)) // placeholder
                            .padding(.horizontal, 14)
                            .padding(.vertical, 12)
                    }
                    TextField("", text: $name)
                        .focused($focusedField, equals: .name)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 14)
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    showNameError ? Color.red :
                                        (focusedField == .name ? Color.white.opacity(0.4) : Color.white.opacity(0.2)),
                                    lineWidth: 1
                                )
                        )
                }
                
                if showNameError {
                    errorMessage("Please fill out this field.")
                }
            }
            
            // Email Input
            VStack(alignment: .leading, spacing: 6) {
                Text("Email")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white.opacity(0.9))
                
                ZStack(alignment: .leading) {
                    if email.isEmpty {
                        Text("your.email@example.com")
                            .foregroundColor(.white.opacity(0.6)) // placeholder
                            .padding(.horizontal, 14)
                            .padding(.vertical, 12)
                    }
                    TextField("", text: $email)
                        .focused($focusedField, equals: .email)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 14)
                        .foregroundColor(.white)
                        .font(.system(size: 16))
                        .background(Color.white.opacity(0.1))
                        .cornerRadius(8)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    showEmailError ? Color.red :
                                        (focusedField == .email ? Color.white.opacity(0.4) : Color.white.opacity(0.2)),
                                    lineWidth: 1
                                )
                        )
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                }
                
                if showEmailError {
                    errorMessage("Please include a valid email with '@' and domain.\n\"\(email)\" is invalid.")
                }
            }
            
            // Continue Button
            Button {
                validateForm()
            } label: {
                Text("Continue")
                    .font(.system(size: 20, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 16)
                    .foregroundColor(Color.blue.opacity(0.9))
                    .background(Color.white)
                    .clipShape(Capsule())
                    .shadow(color: .black.opacity(0.3), radius: 6, x: 0, y: 4)
            }
            .padding(.top, 24)
        }
    }
    
    // MARK: Footer
    private var footerSection: some View {
        Text("By continuing, you agree to our Terms & Privacy Policy")
            .font(.system(size: 14))
            .foregroundColor(.white.opacity(0.6))
            .multilineTextAlignment(.center)
            .padding(.top, 8)
    }
    
    // MARK: Validation
    private func validateForm() {
        var isValid = true
        
        if name.trimmingCharacters(in: .whitespaces).isEmpty {
            showNameError = true
            isValid = false
        } else {
            showNameError = false
        }
        
        if !isValidEmail(email) {
            showEmailError = true
            isValid = false
        } else {
            showEmailError = false
        }
        
        if isValid {
            userData.name = name
            userData.email = email
            withAnimation(.easeInOut) { currentScreen = 2 }
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    // MARK: Error UI
    private func errorMessage(_ message: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: "exclamationmark.triangle.fill")
                .foregroundColor(.red)
                .font(.system(size: 16))
            Text(message)
                .font(.caption)
                .foregroundColor(.red)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(.top, 4)
    }
}

#Preview {
    SignUpScreen(
        currentScreen: .constant(1),
        userData: .constant(UserData())
    )
}
