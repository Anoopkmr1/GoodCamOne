//
//  PhotoCollectionViewController.swift
//  GoodCam
//
//  Created by Anoop on 28/09/23.
//

import UIKit
import Photos


class PhotoCollectionViewController: UICollectionViewController {
    
    var imageCollection = [PHAsset]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateLibrary()
        
    }
    
    private func requestPermission(completion:@escaping(PHAuthorizationStatus) -> ()) {
        PHPhotoLibrary.requestAuthorization { status in
            DispatchQueue.main.async {
                print("Success")
                completion(status)
            }
        }
    }
    
    private func populateLibrary() {
        requestPermission { status in
            if status == .authorized {
                print("Authorized")
                let fetchOptions = PHFetchOptions()
                let assets = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                assets.enumerateObjects { object, count , stop in
                    self.imageCollection.append(object)
                }
                self.imageCollection.reverse()
                self.collectionView.reloadData()
                print("Anoop_images:\(self.imageCollection)")
            }
        }
    }
    
    
}
