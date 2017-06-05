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


class InitialViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var slideShow: UIImageView!
    @IBOutlet weak var goodTableView: UITableView!

    //Reference var
    var firbaseRef: FIRDatabaseReference!
    var animalsList: [FavouriteGood] = [FavouriteGood]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        slideShow.animationImages = [
            UIImage(named: "eagle")!,
            UIImage(named: "wolf")!,
            UIImage(named: "horse")!
        ]
        slideShow.animationDuration = 10
        slideShow.startAnimating()
        
        goodTableView.separatorStyle = .none
        
        firbaseRef = FIRDatabase.database().reference()
        
//        if let x = UserDefaults.standard.
        
        self.setterInfo()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animalsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myMainCell") as! TableViewCell
        
        cell.first_label_in_first.text = animalsList[indexPath.row].name
        cell.second_label_in_first.text = animalsList[indexPath.row].price + " $"
        cell.description_label.text = animalsList[indexPath.row].description
        
        return cell
    }
    
    //Setter function
    func setterInfo(){
        
        self.firbaseRef.child("all_animals").child("Mammals").observe(.value, with: {
            snapshot in
            
            for zhanuar in snapshot.children.allObjects as![FIRDataSnapshot]{
                
                let snapshotValue = zhanuar.value as? [String: String]
                let name_of_pet = snapshotValue?["name"]
                let description = snapshotValue?["description"]
                let price = snapshotValue?["price"]
                
                let animal = FavouriteGood(id: (FIRAuth.auth()?.currentUser?.uid)!,
                                           name: name_of_pet!,
                                           price: price!,
                                           description: description!)
                self.animalsList.append(animal)
            }
            self.goodTableView.reloadData()
            print(self.animalsList)
        })
        
        self.firbaseRef.child("all_animals").child("Birds").observe(.value, with: {
            snapshot in
            
            for zhanuar in snapshot.children.allObjects as![FIRDataSnapshot]{
                
                let snapshotValue = zhanuar.value as? [String: String]
                let name_of_pet = snapshotValue?["name"]
                let description = snapshotValue?["description"]
                let price = snapshotValue?["price"]
                
                let animal = FavouriteGood(id: (FIRAuth.auth()?.currentUser?.uid)!,
                                           name: name_of_pet!,
                                           price: price!,
                                           description: description!)
                self.animalsList.append(animal)
            }
            self.goodTableView.reloadData()

        })
        self.firbaseRef.child("all_animals").child("Fish").observe(.value, with: {
            snapshot in
            
            for zhanuar in snapshot.children.allObjects as![FIRDataSnapshot]{
                
                let snapshotValue = zhanuar.value as? [String: String]
                let name_of_pet = snapshotValue?["name"]
                let description = snapshotValue?["description"]
                let price = snapshotValue?["price"]
                
                let animal = FavouriteGood(id: (FIRAuth.auth()?.currentUser?.uid)!,
                                           name: name_of_pet!,
                                           price: price!,
                                           description: description!)
                self.animalsList.append(animal)
            }
            self.goodTableView.reloadData()

        })
        self.firbaseRef.child("all_animals").child("Amphibians").observe(.value, with: {
            snapshot in
            
            for zhanuar in snapshot.children.allObjects as![FIRDataSnapshot]{
                
                let snapshotValue = zhanuar.value as? [String: String]
                let name_of_pet = snapshotValue?["name"]
                let description = snapshotValue?["description"]
                let price = snapshotValue?["price"]
                
                let animal = FavouriteGood(id: (FIRAuth.auth()?.currentUser?.uid)!,
                                           name: name_of_pet!,
                                           price: price!,
                                           description: description!)
                self.animalsList.append(animal)
            }
            self.goodTableView.reloadData()

        })
        self.firbaseRef.child("all_animals").child("Arthropods").observe(.value, with: {
            snapshot in
            
            for zhanuar in snapshot.children.allObjects as![FIRDataSnapshot]{
                
                let snapshotValue = zhanuar.value as? [String: String]
                let name_of_pet = snapshotValue?["name"]
                let description = snapshotValue?["description"]
                let price = snapshotValue?["price"]
                
                let animal = FavouriteGood(id: (FIRAuth.auth()?.currentUser?.uid)!,
                                           name: name_of_pet!,
                                           price: price!,
                                           description: description!)
                self.animalsList.append(animal)
            }
            self.goodTableView.reloadData()
            
        })
        self.firbaseRef.child("all_animals").child("Reptiles").observe(.value, with: {
            snapshot in
            
            for zhanuar in snapshot.children.allObjects as![FIRDataSnapshot]{
                
                let snapshotValue = zhanuar.value as? [String: String]
                let name_of_pet = snapshotValue?["name"]
                let description = snapshotValue?["description"]
                let price = snapshotValue?["price"]
                
                let animal = FavouriteGood(id: (FIRAuth.auth()?.currentUser?.uid)!,
                                           name: name_of_pet!,
                                           price: price!,
                                           description: description!)
                self.animalsList.append(animal)
            }
            self.goodTableView.reloadData()

            
        })


        
    }
    
}














