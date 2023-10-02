//
//  ViewController.swift
//  GoodCam
//
//  Created by Anoop on 27/09/23.
//

import UIKit

class ViewController: UIViewController, PhotoCollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate
, PhotoFilterViewControllerDelegate {
    
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
        // used to pass the image to the PreviewVC
        showPreviewImage(previewImage: image)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        showFilterVC(for: image)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
    
    
    func showFilterVC( for image: UIImage) {
        guard let filter = self.storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as? FilterViewController else {
            return
        }
        filter.filterImage = image
        filter.delegate = self
        self.addChildVC(filter)
    }
    
    func photoFilterDone() {
        showPhotosList()
    }
    
    func photoFilterCancel() {
        showPhotosList()
    }
    
    private func showPhotosList() {
        self.view.subviews.forEach {
            $0.removeFromSuperview()
        }
        guard let photoListCVC = self.storyboard?.instantiateViewController(withIdentifier: "PhotoCollectionViewController") as? PhotoCollectionViewController else {
            fatalError("PhotoListCollectionViewController does not exist")
        }
        photoListCVC.delegate = self
        self.addChildVC(photoListCVC)
    }
    
    
}

