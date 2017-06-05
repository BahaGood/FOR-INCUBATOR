//
//  ForEditKeyboard.swift
//  Animaldar
//
//  Created by BahaWooD on 01/05/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController{
    
    func hideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dissmissKeyboard))
        
        tap.cancelsTouchesInView = false;
        view.addGestureRecognizer(tap);
    }
    
    func dissmissKeyboard(){
        view.endEditing(true)
    }
    
}
