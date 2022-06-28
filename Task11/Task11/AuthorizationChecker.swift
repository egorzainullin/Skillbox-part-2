//
//  AuthorizationChecker.swift
//  Task11
//
//  Created by Егор Зайнуллин on 28.06.2022.
//

import Foundation

class Checker {
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    static func isValidPassword(_ password: String) -> Bool {
        func isDigit(_ c: Character) -> Bool {
            return c >= "0" && c <= "9"
        }
        
        func isUpperCaseCharacter(_ c: Character) -> Bool {
            return c >= "A" && c <= "Z"
        }
        
        func isLowerCaseCharacter(_ c: Character) -> Bool {
            return c >= "a" && c <= "z"
        }
        
        func hasMoreOrEqualThanSixCharacters(_ str: String) -> Bool {
            return str.count >= 6
        }
        let hasDigit = password.filter{isDigit($0)}.count > 0
        let hasUpperCase = password.filter{isUpperCaseCharacter($0)}.count > 0
        let hasLowerCase = password.filter{isLowerCaseCharacter($0)}.count > 0
        let hasMoreOrEqualThanSix  = hasMoreOrEqualThanSixCharacters(password)
        return hasDigit && hasUpperCase && hasLowerCase && hasMoreOrEqualThanSix
    }
    
}



