//
//  CollectionViewCell.swift
//  Animaldar
//
//  Created by BahaWooD on 21/04/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var addToFavOutlet: UIButton!
    @IBOutlet weak var view_for_goods: UIView!
    
    var favourite_bool = false;
    
    override func awakeFromNib() {
        
        view_for_goods.layer.borderColor = UIColor(red: 150/255, green: 122/255, blue: 222/255, alpha: 1.0).cgColor
        view_for_goods.layer.borderWidth = 3
    
    }
    
    
    @IBAction func addToFavourites(_ sender: UIButton) {
    
        if favourite_bool == false{
            sender.setImage(UIImage(named: "favorites-add"), for: .normal)
            view_for_goods.backgroundColor = UIColor(red: 150/255, green: 122/255, blue: 222/255, alpha: 1.0)
            favourite_bool = true
        } else{
            sender.setImage(UIImage(named: "fav-add-icon"), for: .normal)
            view_for_goods.backgroundColor = UIColor.white
            favourite_bool = false;
        }
    
    }
}
