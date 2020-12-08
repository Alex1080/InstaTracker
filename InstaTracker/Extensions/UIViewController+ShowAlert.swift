//
// Created by Alex Morkovkin on 30.11.2020.
//

import UIKit

extension UIViewController {

    func showAlert(title: String, msg: String, okCompletion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: okCompletion)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }
}