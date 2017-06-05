//
//  ViewController.swift
//  Animaldar
//
//  Created by BahaWooD on 20/04/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage

class ViewController: UIViewController, UIPickerViewDelegate, FBSDKLoginButtonDelegate,
                        UIPickerViewDataSource{
    //MARK: Properties
    @IBOutlet weak var path_to_profile_view: UIView!
    @IBOutlet weak var categories_view: UIView!
    @IBOutlet weak var profile_information_view: UIView!
    @IBOutlet weak var add_an_animal: UIView!
    @IBOutlet weak var categories_button: UIButton!
    @IBOutlet weak var animals_add_to_sell_view: UIView!
    
    //View Sign in and may register
    @IBOutlet weak var exitOnSignView: UIButton!
    @IBOutlet weak var signInView: UIView!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var check_on_correct_button: UIButton!
    @IBOutlet weak var show_hide_password_button: UIButton!
    @IBOutlet weak var forget_password_button: UIButton!
    
    //View Sign UP (REGISTER)
    @IBOutlet weak var inRegisterBackButton: UIButton!
    @IBOutlet weak var email_register_field: UITextField!
    @IBOutlet weak var sign_up_view: UIView!
    @IBOutlet weak var user_name_field: UITextField!
    @IBOutlet weak var user_surname_field: UITextField!
    @IBOutlet weak var user_password_field: UITextField!
    @IBOutlet weak var avatar_sign_up: UIImageView!
    
    //View add animal to sell
    @IBOutlet weak var exit_on_add_view_button: UIButton!
    @IBOutlet weak var name_of_animal_field: UITextField!
    @IBOutlet weak var categories_picker: UIPickerView!
    @IBOutlet weak var description_text_view: UITextView!
    @IBOutlet weak var price_field: UITextField!
    @IBOutlet weak var animals_photo: UIImageView!
    
    //MARK: PROPERTIES NO IN STORYBOARD
    var loginButton = FBSDKLoginButton()
    let attributes_register: [String: Any] = [NSFontAttributeName: UIFont.systemFont(ofSize: 14),
                                              NSForegroundColorAttributeName: UIColor.black,
                                              NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue]
    
    var refUser: FIRDatabaseReference!
    var userId: String = String()
    var pickerData: [String] = [String]()
    var valueOfPicker: String = "Mammals"
    var viewControllerB = ProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatar_sign_up.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                   action: #selector(handleSelectProfileImageView)))
        avatar_sign_up.isUserInteractionEnabled = true
        
        animals_photo.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                  action: #selector(handleSelectProfileImageView)))
        animals_photo.isUserInteractionEnabled = true
        
        self.exitOnSignView.layer.cornerRadius = 15
        self.inRegisterBackButton.layer.cornerRadius = 15
        self.exit_on_add_view_button.layer.cornerRadius = 15
        
        //FOR UNDERLINE NEXT 2 lines
        let attributeString = NSMutableAttributedString(string: "Register",
                                                        attributes: attributes_register)
        self.registerButton.setAttributedTitle(attributeString, for: .normal)
                self.pickerData = ["Mammals", "Birds", "Fish", "Amphibians", "Arthropods", "Reptiles"]
        
        self.loginButton.center = CGPoint(x: 187, y: 500)
        self.loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        self.loginButton.delegate = self
        self.signInView.addSubview(loginButton)
        
        passwordField.isSecureTextEntry = true;
        user_password_field.isSecureTextEntry = true;
        
        refUser = FIRDatabase.database().reference()
        
        self.categories_picker.dataSource = self
        self.categories_picker.delegate = self
        
        if (FIRAuth.auth()?.currentUser?.email != nil){
            self.userId = (FIRAuth.auth()?.currentUser?.uid)!
            if let x = UserDefaults.standard.object(forKey: "username") as? String{
                let username = x
                let password = UserDefaults.standard.object(forKey: "password") as! String
            
                self.emailField.text = username
                self.passwordField.text = password
            
                self.path_to_profile_view.alpha = 0.0
                self.signInView.alpha = 0.0
                self.navigationController?.isNavigationBarHidden = false
                self.profile_information_view.alpha = 1.0
                self.add_an_animal.alpha = 1.0
            }
        }
        self.hideKeyboard()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profile_info"{
            let destination = segue.destination as! ProfileViewController
            destination.myVC = self
        }
        
    }
    
    //Try to sign to profile
    @IBAction func signPressed(_ sender: UIButton) {
        
        self.navigationController?.isNavigationBarHidden = true
        signInView.alpha = 1.0
        
        
    }
    
    //FACEBOOK BUTTON FUNCTIONS
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil{
            print("you have an error")
            self.loginButton.isHidden = false
        } else if(result.isCancelled){
            //HUI EGO
            self.loginButton.isHidden = false
        }
            
        else{
            print("Loged in ")
            
            let credential = FIRFacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
            FIRAuth.auth()?.signIn(with: credential) { (user, error) in
                print("User login into firebase app")
            }
            self.path_to_profile_view.alpha = 0.0
            self.signInView.alpha = 0.0
            self.navigationController?.isNavigationBarHidden = false
            self.profile_information_view.alpha = 1.0
            self.add_an_animal.alpha = 1.0
//            UserDefaults.standard.set(self.emailField.text, forKey: "username")
//            UserDefaults.standard.set(self.passwordField.text, forKey: "password")
//            self.loginButton.isHidden = true
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Log out")
    }
    @IBAction func addAnimalToSell(_ sender: UIButton) {
        
        self.animals_add_to_sell_view.alpha = 1.0
        self.navigationController?.isNavigationBarHidden = true
        
    }
    
    @IBAction func addToFirebaseAnimalData(_ sender: UIButton) {
       
        if name_of_animal_field.text != "" && description_text_view.text != "" {
            let key = refUser.childByAutoId().key
 
            addToFirebaseAnimal(key: key, name: self.name_of_animal_field.text!, description: self.description_text_view.text, price: self.price_field.text!, category: self.valueOfPicker)
        }
    }
    
    func addToFirebaseAnimal(key: String, name: String, description: String, price: String, category: String){
        
        let animal = ["name": name,
                      "description": description,
                      "price": price,
                      "user_email": FIRAuth.auth()?.currentUser?.email]

        self.refUser.child("animals").child(category).child(self.userId).child(key).setValue(animal)
        self.refUser.child("all_animals").child(category).child(key).setValue(animal)
        
    }
    
    @IBAction func hideAnimalView(_ sender: UIButton) {
     
        self.animals_add_to_sell_view.alpha = 0.0
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    @IBAction func backToMore(_ sender: UIButton) {
    
        self.navigationController?.isNavigationBarHidden = false
        self.signInView.alpha = 0.0
    
    }
    @IBAction func show_and_hide(_ sender: UIButton) {
        
        switch self.passwordField.isSecureTextEntry{
        case true:
            self.passwordField.isSecureTextEntry = false
        case false:
            self.passwordField.isSecureTextEntry = true
        }
        
        
    }
    @IBAction func register_pressed(_ sender: UIButton) {
        
        signInView.alpha = 0.0
        sign_up_view.alpha = 1.0
        
    }
    
    @IBAction func back_to_sign_in(_ sender: UIButton) {
        
        sign_up_view.alpha = 0.0
        signInView.alpha = 1.0
        
    }
    @IBAction func sign_in_pressed(_ sender: UIButton) {
        
        FIRAuth.auth()?.signIn(withEmail: self.emailField.text!, password: passwordField.text!, completion: { (user, error) in
            
            if error == nil{
                
                self.path_to_profile_view.alpha = 0.0
                self.signInView.alpha = 0.0
                self.navigationController?.isNavigationBarHidden = false
                self.profile_information_view.alpha = 1.0
                self.add_an_animal.alpha = 1.0
                UserDefaults.standard.set(self.emailField.text, forKey: "username")
                UserDefaults.standard.set(self.passwordField.text, forKey: "password")
                
                let transition: CATransition = CATransition()
                transition.duration = 0.75
                transition.type = kCATransitionPush
                transition.subtype = kCATransitionFromLeft
                self.signInView.layer.add(transition, forKey: nil)
                
            } else{
                let alert = UIAlertController(title: "ERROR", message: "You had uncorrect email or password", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
            }
            
        })
        
    }
    
    @IBAction func createAccount(_ sender: UIButton) {
        
        FIRAuth.auth()?.createUser(withEmail: email_register_field.text!, password: user_password_field.text!, completion: { (user, error) in
            if error == nil && self.user_password_field.text != "" && self.user_surname_field.text != "" && self.user_name_field.text != "" && self.email_register_field.text != ""{
                
                self.addUser(user: user!)
                
                self.sign_up_view.alpha = 0.0
                self.navigationController?.isNavigationBarHidden = false
                
                let storageRef = FIRStorage.storage().reference().child((user?.uid)!)
                
                if let uploadData = UIImagePNGRepresentation(self.animals_photo.image!){
                    
                    storageRef.put(uploadData, metadata: nil, completion: { (metadata, error) in
                        
                        if error != nil{
                            print(error.debugDescription)
                            return
                        }
                    })
                    
                }
                
            } else{
                let alert = UIAlertController(title: "Error", message: "Complete all components", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                
                if let errorcode = FIRAuthErrorCode(rawValue: (error?._code)!){
                    
                    switch errorcode{
                    case .errorCodeInvalidEmail:
                        alert.message = "invalid Email"
                    case .errorCodeEmailAlreadyInUse:
                        alert.message = "This email already exist"
                    case .errorCodeWeakPassword:
                        alert.message = "You have a weak password"
                    default:
                        print("wws")
                    }
                }
                self.present(alert, animated: true, completion: nil)
                
            }

        })
        
    }
    
    func addUser(user: FIRUser){
        
        let key = user.uid
        let user = ["uid": key,
                    "username": user_name_field.text!,
                    "surname": user_surname_field.text!,
                    "email": email_register_field.text!,
        ]
        
        refUser.child("users").child(key).setValue(user)
    
    }
    
    //PICKER VIEW FUNCTIONS
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.valueOfPicker = pickerData[row]
    }
}
//    func loginButtonClicked() {
//        let login = FBSDKLoginManager()
//        login.logIn(withReadPermissions: ["public_profile"], fromViewController: self, handler: {(_ result: FBSDKLoginManagerLoginResult, _ error: Error?) -> Void in
//            if error != nil {
//                print("Process error")
//            }
//            else if result.isCancelled() {
//                print("Cancelled")
//            }
//            else {
//                print("Logged in")
//            }
//
//        })
//    }
