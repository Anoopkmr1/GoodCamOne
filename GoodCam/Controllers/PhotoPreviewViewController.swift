//
//  PhotoPreviewViewController.swift
//  GoodCam
//
//  Created by Anoop on 28/09/23.
//

import UIKit

class PhotoPreviewViewController: UIViewController {

    @IBOutlet weak var photoPreviewImg: UIImageView!
    var imageView: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoPreviewImg.image = imageView
    }

}
