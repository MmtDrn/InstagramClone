//
//  TextField+Extension.swift
//  InstagramClone
//
//  Created by mehmet duran on 3.04.2023.
//

import UIKit

extension UITextField {
    
    public func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex // numbers iterator
        
            // iterate over the mask characters until the iterator of numbers ends
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                    // mask requires a number in this place, so take the next one
                result.append(numbers[index])
                
                    // move numbers iterator to the next index
                index = numbers.index(after: index)
                
            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
}
