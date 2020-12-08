//
//  UIImageView+MakeCircle.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 25.11.2020.
//

import UIKit

extension UIImageView {
    
    func makeCircle() {
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
    }
    
}
