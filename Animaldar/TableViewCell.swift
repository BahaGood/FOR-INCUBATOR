//
//  TableViewCell.swift
//  Animaldar
//
//  Created by BahaWooD on 21/04/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit
import FirebaseAuth
class TableViewCell: UITableViewCell {
    var favourite_bool = false;
    //MARK: PRoperties;
    @IBOutlet weak var view_for_goods: UIView!
    @IBOutlet weak var image_view_in_first: UIImageView!
    
    @IBOutlet weak var first_label_in_first: UILabel!
    @IBOutlet weak var second_label_in_first: UILabel!
    @IBOutlet weak var description_label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        view_for_goods.layer.borderWidth = 1
        view_for_goods.layer.borderColor = UIColor.gray.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func likePressed(_ sender: UIButton) {
        
        if favourite_bool == false && FIRAuth.auth()?.currentUser?.email != nil{
            sender.setImage(UIImage(named: "favorites-add"), for: .normal)
            print(FIRAuth.auth()?.currentUser?.email! as Any)
            favourite_bool = true
        } else{
            sender.setImage(UIImage(named: "fav-add-icon"), for: .normal)
            favourite_bool = false;
        }

        
    }
    
}
