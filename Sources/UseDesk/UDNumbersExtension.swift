//
//  UDNumbersExtension.swift

import UIKit

extension Double {
    
    func udRounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

