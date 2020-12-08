//
//  Instagram.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 03.10.2020.
//

import Foundation
import UIKit
import SwiftyInsta

class Instagram {
    
    let handler = APIHandler()
    
    func auth(view: UIViewController) {

        let isAuthed = UserDefaults.standard.string(forKey: "current.account")
        
        if isAuthed == nil {
            
            let login = LoginWebViewController { controller, result in
                
                controller.dismiss(animated: true, completion: nil)
                
                guard let (response, _) = try? result.get() else { return print("Login failed.") }
                
                print("Login successful.")
                
                guard let key = response.persist() else { return print("`Authentication.Response` could not be persisted.") }
                
                UserDefaults.standard.set(key, forKey: "current.account")
                UserDefaults.standard.synchronize()
            }
            
            DispatchQueue.main.async {
                if #available(iOS 13, *) {
                    let navController = UINavigationController(rootViewController: login)
                    navController.modalPresentationStyle = .fullScreen
                    navController.modalTransitionStyle = .crossDissolve
                    view.present(navController, animated: true, completion: nil)
                } else {
                    view.present(UINavigationController(rootViewController: login),
                                 animated: true,
                                 completion: nil)
                }
            }
        }
        
        guard let key = UserDefaults.standard.string(forKey: "current.account") else { return print("`key` not found.") }
        guard let cache = Authentication.Response.persisted(with: key) else { return print("`Authentication.Response` not found.") }
        
        handler.authenticate(with: .cache(cache)) { _ in }
    }
}
