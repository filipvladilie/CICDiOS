//
//  ContentView.swift
//  RetirementCalculator
//
//  Created by Vlad Filip on 12.02.2023.
//

import SwiftUI
import AppCenterCrashes
import AppCenterAnalytics

struct ContentView: View {
  
  @State private var monthlyInvestments: String = ""
  @State private var currentAge: String = ""
  @State private var retirementAge: String = ""
  @State private var interestRate: String = ""
  @State private var currentSavings: String = ""
  @State private var result: Double = 0
  @State private var showingAlert = false
  
  var body: some View {
    VStack(spacing: 10) {
      TextField("Monthly investments", text: $monthlyInvestments)
        .padding(4)
        .overlay(
          RoundedRectangle(cornerRadius: 5)
            .stroke(Color.green, lineWidth: 2)
        )
      TextField("Your current age", text: $currentAge)
        .padding(4)
        .overlay(
          RoundedRectangle(cornerRadius: 5)
            .stroke(Color.green, lineWidth: 2)
        )
      TextField("Retirement age", text: $retirementAge)
        .padding(4)
        .overlay(
          RoundedRectangle(cornerRadius: 5)
            .stroke(Color.green, lineWidth: 2)
        )
      TextField("Average interests rate", text: $interestRate)
        .padding(4)
        .overlay(
          RoundedRectangle(cornerRadius: 5)
            .stroke(Color.green, lineWidth: 2)
        )
      TextField("Current savings", text: $currentSavings)
        .padding(4)
        .overlay(
          RoundedRectangle(cornerRadius: 5)
            .stroke(Color.green, lineWidth: 2)
        )
      HStack {
        Spacer()
        Text("Result is: \(result)")
        Spacer()
      }
      Spacer()
      Button(action: {
        calculateAction()
      }, label: {
        HStack {
          Spacer()
          Text("Calculate retirement amount")
          Spacer()
        }
        .frame(height: 50)
        .background(.blue)
        .foregroundColor(.white)
        .cornerRadius(8)
      })
    }
    .onAppear {
      if Crashes.hasCrashedInLastSession {
        showingAlert = true
      }
      Analytics.trackEvent("navigated_to_calculator")
    }
    .alert("Oops", isPresented: $showingAlert) {
      Button("OK", role: .cancel) { }
    }
    .padding()
  }
  
  private func calculateAction(){
    //Crashes.generateTestCrash()
    
    let current_age: Int? = Int(self.currentAge)
    let planned_retirement_age: Int? = Int(self.retirementAge)
    let monthly_investment: Float? = Float(self.monthlyInvestments)
    let average_rate: Float? = Float(self.interestRate)
    let savings: Float? = Float(self.currentSavings)
    
    if let current_age,let planned_retirement_age,let monthly_investment,let average_rate,let savings {
    
      let months_until_retirement = (planned_retirement_age - current_age) * 12
      
      var retirement_amount = Double(savings) * pow(Double(1 + average_rate / 100), Double(months_until_retirement))
      
      for i in 1...months_until_retirement {
        let monthly_rate = average_rate / 100 / 12
        retirement_amount += Double(monthly_investment) * pow(Double(1 + monthly_rate), Double(i))
      }
      
      result = retirement_amount
      
    }
    
    let properties = ["current_age": String(current_age ?? 0), "planned_retirement_age": String(planned_retirement_age ?? 100)]
    
    Analytics.trackEvent("calculate_retirement_amount", withProperties: properties)
  }
  
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
