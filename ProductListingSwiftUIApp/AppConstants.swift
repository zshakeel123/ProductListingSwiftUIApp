//
//  AppConstants.swift
//  ProductSwiftUIApp
//
//  Created by Zeeshan Shakeel on 17/05/2025.
//

import Foundation
import SwiftUI // Import SwiftUI for Color and Font

// MARK: - App Constants (Enum for name spacing)
enum AppConstants {
    // MARK: - API
    enum API {
        // base url
        static let baseURLString = "https://dummyjson.com"
        // API endpoints
        static let productsEndpoint = "/products"
        static let usersEndpoint = "/users"
    }
    
    // MARK: - UI
    enum UI {
        static let defaultPadding: CGFloat = 16.0
        static let animationDuration: TimeInterval = 0.3
    }
    
    enum Colors {
        // Using SwiftUI's Color directly. You can define custom colors here
        // or load them from asset catalog if they are defined there.
        //        static let primary = SwiftUI.Color("PrimaryColor") // Assumes "PrimaryColor" is in Assets.xcassets
        //        static let secondary = SwiftUI.Color("SecondaryColor") ?? .secondary // Fallback to system color
        //        static let accent = SwiftUI.Color("AccentColor") ?? .orange
        //        static let background = SwiftUI.Color("BackgroundColor") ?? .clear // Clear for background
        //        static let cellBackground = SwiftUI.Color("CellBackgroundColor") ?? .white
        
        // Using system colors directly as we don't have custom asset colors
        static let primary = Color.blue
        static let secondary = Color.secondary
        static let accent = Color.orange
        static let background = Color.white
        static let cellBackground = Color.cyan
    }
    
    enum Typography {
        static let title = Font.system(size: 18, weight: .semibold)
        static let price = Font.system(size: 18, weight: .bold)
        // SwiftUI's built-in text styles for dynamic type
         static let body = Font.body
         static let headline = Font.headline
    }
    
    // MARK: - Other
    static let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A"
    static let supportEmail = "support@myapp.com"
}
