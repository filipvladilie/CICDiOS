//
//  RetirementCalculatorApp.swift
//  RetirementCalculator
//
//  Created by Vlad Filip on 12.02.2023.
//

import SwiftUI
import AppCenter
import AppCenterCrashes
import AppCenterAnalytics

@main
struct RetirementCalculatorApp: App {
  
  init() {
    AppCenter.start(withAppSecret: "ca9fb3b6-cace-45d5-b669-993a7d459823", services: [Analytics.self, Crashes.self])
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
