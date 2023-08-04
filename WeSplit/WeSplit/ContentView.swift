//
//  ContentView.swift
//  WeSplit
//
//  Created by Лилия Феодотова on 17.07.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPersentage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPersentages = [0, 10, 15, 20, 25]
    
    var grandTotal: Double {
        let tipSelection = Double(tipPersentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var currencyFormatted: FloatingPointFormatStyle<Double>.Currency{
        let currencyCode = Locale.current.currency?.identifier ?? "USD"
        return FloatingPointFormatStyle<Double>.Currency(code: currencyCode)
    }
    
    var body: some View {
        NavigationView {
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: currencyFormatted)
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach (2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section {
                    Picker("Tip persentage", selection: $tipPersentage) {
                        //ForEach(0..<101)
                        ForEach(tipPersentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    //.pickerStyle(.navigationLink)
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section{
                    Text(grandTotal, format: currencyFormatted)
                        .foregroundColor(tipPersentage == 0 ? .red : .black)
                } header: {
                    Text("Grand total")
                }
                
                Section{
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
