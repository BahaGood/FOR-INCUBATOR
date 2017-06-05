//
//  SignInViewController.swift
//  Animaldar
//
//  Created by BahaWooD on 30/04/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import FirebaseAuth
import FBSDKLoginKit

class ProfileViewController: UIViewController {
    var myVC :ViewController!
    
    @IBOutlet weak var email_show: UILabel!
    @IBOutlet weak var name_and_surname: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        email_show.text = FIRAuth.auth()?.currentUser?.email
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signOutPressed(_ sender: UIButton) {
       
        try! FIRAuth.auth()?.signOut()
        
        myVC.path_to_profile_view.alpha = 1.0
        myVC.navigationController?.isNavigationBarHidden = false
        myVC.profile_information_view.alpha = 0.0
        myVC.add_an_animal.alpha = 0.0

        let nvc: UINavigationController = navigationController!
        nvc.popViewController(animated: true)
    }
    @IBAction func editProfile(_ sender: UIButton) {
        
        
        
    }

    
}
