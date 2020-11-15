//
//  UIColor+DarkMode.swift
//  ThinkersDiary
//
//  Created by jyothish.johnson on 15/11/20.
//

import UIKit
import Foundation

extension UIColor {
    
  static func color(_ name: CustomColors) -> UIColor? {
     return UIColor(named: name.rawValue)
  }
}
