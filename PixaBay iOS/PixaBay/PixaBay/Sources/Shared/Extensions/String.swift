//
//  String.swift
//  PixaBay
//
//  Created by Bakur Khalvashi on 07.11.23.
//

import Foundation

extension String {
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        count >= 6 && count <= 12
    }
    
    var isValidAge: Bool {
        if let age = Int(self) {
            return (18...99).contains(age)
        }
        return false
    }
    
    func toInt() -> Int? {
        if let intValue = Int(self) {
            return intValue
        } else {
            return nil
        }
    }
    
    var containsOnlyNumbers: Bool {
        let decimalCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: self)
        return decimalCharacters.isSuperset(of: characterSet)
    }
}
