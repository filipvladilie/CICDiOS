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
    AppCenter.start(withAppSecret: "444fbd8b-d062-4306-ac37-36593e623d0f", services: [Analytics.self, Crashes.self])
  }
  
  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
