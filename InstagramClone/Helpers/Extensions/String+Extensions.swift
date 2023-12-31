//
//  String+Extensions.swift
//  InstagramClone
//
//  Created by mehmet duran on 3.04.2023.
//

import UIKit

extension String {
    
    public func removeWhiteSpaces() -> String{
        return self.replacingOccurrences(of: " ", with: "")
    }
    
    public func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
        
    }
    
    public func toDate(withFormat format: String = "YYYY-MM-dd'T'HH:mm:ss") -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        guard let date = dateFormatter.date(from: self) else {
            return Date()
        }
        return date
    }
}
