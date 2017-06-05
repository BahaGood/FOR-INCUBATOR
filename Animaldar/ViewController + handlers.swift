//
//  LoginController.swift
//  Animaldar
//
//  Created by BahaWooD on 03/05/17.
//  Copyright © 2017 Apple Inc. All rights reserved.
//

import UIKit

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func handleSelectProfileImageView(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        self.present(picker, animated: true, completion: nil)
        
    }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImage: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"]{
            selectedImage = editedImage as? UIImage
            
        } else if let originalImage = info["UIImagePickerControllerOriginalImage"] {
            
            selectedImage = originalImage as? UIImage
        }
        
        if let pickImage = selectedImage{
            if animals_add_to_sell_view.alpha == 1.0{
                animals_photo.image = pickImage
            } else if (sign_up_view.alpha == 1.0){
                avatar_sign_up.image = pickImage
            }
        }
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
