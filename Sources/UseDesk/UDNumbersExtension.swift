//
//  UDNumbersExtension.swift

import UIKit

extension Double {
    func udRounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Int {
    func timeString() -> String {
        let h = self / 3600
        let m = (self % 3600) / 60
        let s = (self % 3600) % 60
        var string = ""
        if h != 0 {
            if h > 9 {
                string += "\(h):"
            } else {
                string += "0\(h):"
            }
        }
        if m > 9 {
            string += "\(m)"
        } else {
            string += "0\(m)"
        }
        if h == 0 {
            if s > 9 {
                string += ":\(s)"
            } else {
                string += ":0\(s)"
            }
        }
        return string
    }
}
