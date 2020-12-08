//
//  UIFont+DefaultFonts.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 26.11.2020.
//

import UIKit

extension UIFont {

    static func titleFont() -> UIFont! {
        UIFont.init(name: "avenir", size: 18)
    }
    
    static func defaultFont() -> UIFont! {
        UIFont.init(name: "avenir", size: 14)
    }
}
