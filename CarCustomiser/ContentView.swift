//
//  ContentView.swift
//  CarCustomiser
//
//  Created by Fiennes Harris on 12/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var starterCars = StarterCars()
    @State private var selectedCar: Int = 0 {
        didSet {
            if selectedCar >= starterCars.cars.count {
                selectedCar = 0
            }
        }
    }
    
    func resetToggles() {
        if exhaustPackage == true {
            starterCars.cars[selectedCar].topSpeed -= 10
        }
        exhaustPackage = false
        if tiresPackage == true {
            starterCars.cars[selectedCar].handling -= 2
        }
        tiresPackage = false
        if wheelsPackage == true {
            starterCars.cars[selectedCar].acceleration += 0.5
        }
        wheelsPackage = false
        if superPackage == true {
            starterCars.cars[selectedCar].topSpeed -= 5
            starterCars.cars[selectedCar].handling -= 1
            starterCars.cars[selectedCar].acceleration += 0.25
        }
        superPackage = false
        remainingFunds = 1000
    }
    
    @State private var exhaustPackage: Bool = false
    @State private var tiresPackage: Bool = false
    @State private var wheelsPackage: Bool = false
    @State private var superPackage: Bool = false
    @State private var remainingFunds = 1000
    @State private var remainingTime = 30
    @State private var disableAll = false
    
    var exhaustPackageEnabled: Bool {
        return remainingFunds >= 500 ? true : remainingFunds == 0 && exhaustPackage == false ? false : true
    }
    
    var tiresPackageEnabled: Bool {
        return remainingFunds >= 500 ? true : remainingFunds == 0 && tiresPackage == false ? false : true
    }
        
    var wheelsPackageEnabled: Bool {
        return remainingFunds >= 500 ? true : remainingFunds == 0 && wheelsPackage == false ? false : true
    }
    
    var superPackageEnabled: Bool {
        return remainingFunds >= 1000 ? true : remainingFunds == 500 && exhaustPackage == false || remainingFunds == 0 && superPackage == false ? false : true
    }
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        let statDisplay = starterCars.cars[selectedCar].displayStats()
        
        let exhaustPackageBinding = Binding<Bool> (
            get: { self.exhaustPackage },
            set: { newValue in
                self.exhaustPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 10
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 10
                    remainingFunds += 500
                }
            }
        )
        
        let tiresPackageBinding = Binding<Bool> (
            get: { self.tiresPackage },
            set: { newValue in
                self.tiresPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].handling += 2
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].handling -= 2
                    remainingFunds += 500
                }
            }
        )
        
        let wheelsPackageBinding = Binding<Bool> (
            get: { self.wheelsPackage },
            set: { newValue in
                self.wheelsPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].acceleration -= 0.5
                    remainingFunds -= 500
                } else {
                    starterCars.cars[selectedCar].acceleration += 0.5
                    remainingFunds += 500
                }
            }
        )
        
        let superPackageBinding = Binding<Bool> (
            get: { self.superPackage },
            set: { newValue in
                self.superPackage = newValue
                if newValue == true {
                    starterCars.cars[selectedCar].topSpeed += 5
                    starterCars.cars[selectedCar].handling += 1
                    starterCars.cars[selectedCar].acceleration -= 0.25
                    remainingFunds -= 1000
                } else {
                    starterCars.cars[selectedCar].topSpeed -= 5
                    starterCars.cars[selectedCar].handling -= 1
                    starterCars.cars[selectedCar].acceleration += 0.25
                    remainingFunds += 1000
                }
            })
        VStack {
            Text("You have \(remainingTime) seconds")
                .onReceive(timer) { _ in
                    if self.remainingTime > 0 {
                        self.remainingTime -= 1
                    } else {
                        disableAll = true
                    }
                }
                .foregroundColor(.cyan)
                .font(.title)
            Form {
                
                VStack(alignment: .leading, spacing: 20) {
                    Text("""
                \(statDisplay.0)
                \(statDisplay.1)
                \(statDisplay.2)
                \(statDisplay.3)
                \(statDisplay.4)
                """)
                    Button("Next Car", action: {
                        if !disableAll {
                            resetToggles()
                            selectedCar += 1
                        }
                        
                    })
                    .buttonStyle(.bordered)
                }
                
                Section {
                    Toggle("Exhaust Package (Cost: 500)", isOn: exhaustPackageBinding)
                        .disabled(disableAll)
                        .disabled(!exhaustPackageEnabled)
                    Toggle("Grip Package (Cost: 500)", isOn: tiresPackageBinding)
                        .disabled(disableAll)
                        .disabled(!tiresPackageEnabled)
                    Toggle("Speedy wheels (Cost: 500)", isOn: wheelsPackageBinding)
                        .disabled(disableAll)
                        .disabled(!wheelsPackageEnabled)
                    Toggle("Upgrade all stats (Cost: 1000)", isOn: superPackageBinding)
                        .disabled(disableAll)
                        .disabled(!superPackageEnabled)
                }
            }
            Text("Remaining funds: \(remainingFunds)")
                .foregroundColor(.green)
                .baselineOffset(25)
        }
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
