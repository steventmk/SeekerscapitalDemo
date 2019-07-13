//
//  UIViewController+Extension.swift
//  GuestTracker2
//
//  Created by Tao Man Kit on 2/11/2018.
//  Copyright © 2018 ROKO. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    
    

}
