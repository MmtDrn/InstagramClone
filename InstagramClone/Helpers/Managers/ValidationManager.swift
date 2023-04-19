//
//  ValidationManager.swift
//  InstagramClone
//
//  Created by mehmet duran on 3.04.2023.
//

import UIKit

class ValidationManager {
    static let shared = ValidationManager()
    private init() {}
    
    func validate(phone: String?) -> Bool {
        let clearPhone = phone?.removeWhiteSpaces()
        let phoneRegex = "^(((\\+|00)?(90)|0)[-| ]?)?((5\\d{2})[-| ]?(\\d{3})[-| ]?(\\d{2})[-| ]?(\\d{2}))$"
        let phonePredicate = NSPredicate(format:"SELF MATCHES %@", phoneRegex)
        let regexCondition = phonePredicate.evaluate(with: clearPhone)
        return regexCondition
    }
    
    func validate(password: String?) -> Bool {
        let passwordRegex = "^(?=.*\\d)(?=.*[a-zA-Z]).{6,20}$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        let regexCondition = passwordPredicate.evaluate(with: password)
        return regexCondition
    }
    
    func validate(name: String?) -> Bool {
        let nameRegex = "^[a-zA-ZöçşığüÖÇŞIĞÜ]+ ?.* [a-zA-ZöçşığüÖÇŞIĞÜ]+$"
        let namePredicate = NSPredicate(format:"SELF MATCHES %@", nameRegex)
        let regexCondition = namePredicate.evaluate(with: name)
        return regexCondition
    }
    
    func validate(email: String?) -> Bool {
        guard let email = email else { return false }
        return email.isValidEmail()

    }
    
    func validate(isNil: String?) -> Bool {
        return !(isNil == "" || isNil == nil)
    }
    
    func validate(birthday: String)  -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        guard let date = dateFormatter.date(from: birthday) else { return false }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: date)
                    
        guard let finalDate = calendar.date(from:components) else { return false }
                    
        let sixYearsAgo = Date().subtract(years: 6)
        guard let eightyYearsAgo = Date().subtract(years: 80) else { return false }
        
        if finalDate.isBetween(sixYearsAgo, and: Date()) || finalDate.isGreaterThanDateEx(Date()) || !finalDate.isGreaterThanDateEx(eightyYearsAgo) {
            return false
        } else {
            return true
        }
    }
    
    static func validate(otp: String) -> Bool {
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        let isNumeric = Set(otp).isSubset(of: nums)
        if otp.count == 4 && isNumeric {
            return true
        }
        return false
    }
    
}

protocol Validateable {
    func hasNilValue() throws -> Bool
}

extension Validateable {
    func hasNilValue() -> Bool {
        
        Mirror(reflecting: self).children.contains(where: {
            if case Optional<Any>.some(_) = $0.value {
                return false
            } else {
                return true
            }
        })
        
    }
}
