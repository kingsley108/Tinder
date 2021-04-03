//
//  SettingsImagePicker.swift
//  Tinder App
//
//  Created by Kingsley Charles on 03/04/2021.
//

import Foundation
import UIKit
import SDWebImage

extension SettingsController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @objc func getPhotoAsset() {
             let imagePickerController = UIImagePickerController()
            imagePickerController.allowsEditing = false
            imagePickerController.sourceType = .photoLibrary
            imagePickerController.delegate = self
        imagePickerController.modalPresentationStyle = .fullScreen
            present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let tempImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        setImage(image: tempImage)
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setImage(image: UIImage) {
        guard let sender = self.sender else {return}
        sender.setImage(image, for: .normal)
    }
}
