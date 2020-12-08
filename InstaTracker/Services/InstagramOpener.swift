//
//  InstagramOpener.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 25.11.2020.
//

import Foundation
import UIKit

struct InstagramOpener {
    
    func open(username: String) {
        let instagramHooks = "instagram://user?username=\(username)"
        let instagramUrl = URL(string: instagramHooks)!

        let application = UIApplication.shared
        
        if application.canOpenURL(instagramUrl)
        {
            application.open(instagramUrl)
        } else {
            let browserLink = URL(string: "https://instagram.com/\(username)")!

            application.open(browserLink)
        }
    }
    
}
