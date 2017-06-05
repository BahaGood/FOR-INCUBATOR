//
//  FavouriteGood.swift
//  Animaldar
//
//  Created by BahaWooD on 30/04/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import Foundation

class FavouriteGood{
    
    var id: String
    var name: String
    var price: String
    var description: String
    
    init(id: String, name: String, price: String, description: String){
        self.id = id;
        self.name = name;
        self.price = price;
        self.description = description;
    }
}
