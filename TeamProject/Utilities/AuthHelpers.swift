//
//  AuthHelpers.swift
//  TeamProject
//
//  Created by Jung Hyun Kim on 2023/05/16.
//

import Foundation
import UIKit

//MARK: - Auto Layout
extension UIView {
    
    public var width: CGFloat {
        return self.frame.size.width
    }
    
    public var height: CGFloat {
        return self.frame.size.height
    }
    
    public var top: CGFloat {
        return self.frame.origin.y
    }
    
    public var bottom: CGFloat {
        return self.frame.size.height + self.frame.origin.y
    }
    
    public var left: CGFloat {
        return self.frame.origin.x
    }
    
    public var right: CGFloat {
        return self.frame.size.width + self.frame.origin.x
    }
}

//MARK: - Toggle Password Visibility Button
extension UITextField {
    func togglePasswordVisibility() {
        
        isSecureTextEntry = !isSecureTextEntry
        
        if let existingText = text, isSecureTextEntry {
            deleteBackward()
            
            if let textRange = textRange(from: beginningOfDocument, to: endOfDocument) {
                replace(textRange, withText: existingText)
            }
        }
        
        if let existingSelectedTextRange = selectedTextRange {
            selectedTextRange = nil
            selectedTextRange = existingSelectedTextRange
        }
    }
}

//MARK: - Custom Font
extension UIFont {
    static func customFont(ofSize size: CGFloat, weight: UIFont.Weight, fontName: String) -> UIFont? {
        let font = UIFont(name: fontName, size: size)
        return font?.withWeight(weight)
    }

    func withWeight(_ weight: UIFont.Weight) -> UIFont {
        var fontDescriptor = self.fontDescriptor
        let traits = [UIFontDescriptor.TraitKey.weight: weight]
        fontDescriptor = fontDescriptor.addingAttributes([UIFontDescriptor.AttributeName.traits: traits])
        return UIFont(descriptor: fontDescriptor, size: 0)
    }
}

//MARK: - Validate Email and Password Strings
extension String {
    func validateEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-Z0-9.-]+\\.[A-Za-z]{2,4}"
        return applyPredicateOnRegex(regexStr: emailRegEx)
    }
    
    func validatePassword(min: Int = 8, max: Int = 8) -> Bool {
        // Minimum 8 characters at least 1 Alphabet and 1 number...
        var passRegEx = ""
        if min >= max {
            passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(min),}$"
        } else {
            passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(min),\(max)}$"
        }
        return applyPredicateOnRegex(regexStr: passRegEx)
    }
    
    func applyPredicateOnRegex(regexStr: String) -> Bool {
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateOtherString = NSPredicate(format: "SELF MATCHES %@", regexStr)
        let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
        return isValidateOtherString
    }
    
}
