//
//  MeatTemperature.swift
//  CarneNoPonto Watch App
//
//  Created by Yuri Cunha on 30/10/23.
//

import Foundation

enum MeatTemperature: Int {
    case rare
    case mediumRare
    case medium
    case wellDone
    
    var stringValue: String {
       let doneness = ["Cru","Mal passado","ao ponto","bem passado"]
        return doneness[self.rawValue]
    }
    
    private var timeModifier: Double {
        let modifier = [0.5,0.75,1.0,1.5]
        return modifier[self.rawValue]
    }
    
    func cooktimeFor(kg: Double) -> TimeInterval {
        let baseTime: TimeInterval = 60 * 3
        let baseWeight = 0.5
        let weightModifier = kg/baseWeight
        return baseTime * weightModifier * self.timeModifier
        
    }
}
