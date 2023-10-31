//
//  Double+roundedToPlaces.swift
//  CarneNoPonto Watch App
//
//  Created by Yuri Cunha on 30/10/23.
//

import Foundation

extension Double {
    /// aqui a gente pega o valor, pega 10 elevado a ele, e arredonda para ficar com 1 casa
    public func rounded(_ toPlaces: Int) -> Double {
        let divisor = pow(10.0,Double(toPlaces))
        return (self * divisor).rounded() / divisor
    }
}
