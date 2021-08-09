//
//  ContentView.swift
//  WeSplit
//
//  Created by Ryan Matsuo on 8/4/21.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = 0
    @State private var tipAmount = 2
    
    let tipPercentage = [10, 15, 20, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage[tipAmount])
        let orderAmount = Double(checkAmount) ?? 0
        
        let tipValue = orderAmount / 100 * tipSelection
        let grandTotal = orderAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var totalPlusTip: Double {
        let totalWithOutTip = Double(checkAmount) ?? 0
        let selectedTip = Double(tipPercentage[tipAmount])
        
        let tipValue = totalWithOutTip / 100 * selectedTip
        let totalWithTip = totalWithOutTip + tipValue
        
        return totalWithTip
    }
    
    var body: some View {
        NavigationView{
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip Percentage", selection: $tipAmount) {
                        ForEach(0 ..< tipPercentage.count) {
                            Text("\(self.tipPercentage[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total With Tip")) {
                    Text("$\(totalPlusTip, specifier: "%.2f")")
                }
                
                Section(header: Text("Amount Per Person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationTitle("WeSplit")
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
