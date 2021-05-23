//
//  TestAppGlobal.swift
//  TestApp
//
//  Created by ICS on 21/05/21.
//

import UIKit
class TestAppGlobal {
    private init () {}
    static let sharedInstance = TestAppGlobal()
    
    func showGeneralAlert(message: String, view: UIViewController) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: { _ in
        }))
        view.present(alert, animated: true, completion: nil)
    }
}
