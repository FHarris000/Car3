//
//  Car.swift
//  CarCustomiser
//
//  Created by Fiennes Harris on 12/01/2023.
//

import Foundation

struct Car {
    let make: String
    let model: String
    var topSpeed: Int
    var acceleration: Double
    var handling: Int
    
    public func displayStats() -> (String, String, String, String, String) {
        let statsList = (make: "Make: \(self.make)", model: "Model: \(self.model)", topSpeed: "Top speed: \(self.topSpeed)mph", acceleration: "Acceleration (0-60): \(self.acceleration)s", handling: "Handling: \(self.handling)")
        return statsList
    }
}
