//
//  AttributedString.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 20/10/20.
//

import UIKit

extension NSMutableAttributedString{
    
    /// Global function to return attributed String with variable line spacing
    /// - Parameters:
    ///   - string: string to be formatted
    ///   - lineSpacing: line spacing
    /// - Returns: NSMutableAttributedString with proper spacing
    
    static func makeAttributedWelcomeString(_ string: String, withSpacing lineSpacing: CGFloat = 10) -> NSMutableAttributedString{
        let attributedString = NSMutableAttributedString(string: string)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        return attributedString
    }
}
