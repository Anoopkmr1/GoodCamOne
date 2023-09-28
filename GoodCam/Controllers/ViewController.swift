//
//  ViewController.swift
//  GoodCam
//
//  Created by Anoop on 27/09/23.
//

import UIKit

class ViewController: UIViewController, PhotoCollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let photoCVC = self.children.first as? PhotoCollectionViewController else {
            return
        }
        photoCVC.delegate = self
    }

    
    @IBAction func cameraBtnClk(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true)
        }
    }
    
    func showPreviewImage(previewImage: UIImage) {
        guard let photoPreviewVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoPreviewViewController") as? PhotoPreviewViewController else {
            return
        }
        photoPreviewVC.imageView = previewImage
        self.navigationController?.pushViewController(photoPreviewVC, animated: true)
    }
    
    func didSetImage(_ image: UIImage) {
        showPreviewImage(previewImage: image)
    }
    

    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        showFilterVC(for: image!)
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    
    func showFilterVC( for image: UIImage) {
        guard let filter = self.storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as? FilterViewController else {
            return
        }
        filter.filterImage = image
        self.addChildVC(filter)
    }

}

