//
//  UIColor+Hex.swift
//  BeerApp
//
//  Created by Михаил Герман on 05.05.2023.
//

import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let hexString = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexString.hasPrefix("#") {
            let index = hexString.index(hexString.startIndex, offsetBy: 1)
            let newHexString = String(hexString[index...])
            let scanner = Scanner(string: newHexString)
            var hexNumber: UInt64 = 0
            if scanner.scanHexInt64(&hexNumber) {
                let red = CGFloat((hexNumber & 0xFF0000) >> 16) / 255
                let green = CGFloat((hexNumber & 0x00FF00) >> 8) / 255
                let blue = CGFloat(hexNumber & 0x0000FF) / 255
                self.init(red: red, green: green, blue: blue, alpha: alpha)
                return
            }
        }
        self.init(red: 0, green: 0, blue: 0, alpha: 1)
    }
}
