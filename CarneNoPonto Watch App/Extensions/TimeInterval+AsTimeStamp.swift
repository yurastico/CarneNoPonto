//
//  TimeInterval+AsTimeStamp.swift
//  CarneNoPonto Watch App
//
//  Created by Yuri Cunha on 30/10/23.
//

import Foundation

extension TimeInterval {
    /// Retorna uma String contendo o valor representado em Minutos:Segundos
    var asTimeStamp: String {
        let minutes = Int(self/60)
        let seconds = Int(self) % 60
        return String(format: "%02i:%02i", minutes,seconds)
    }
}
