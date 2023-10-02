//
//  PhotoCollectionViewController.swift
//  GoodCam
//
//  Created by Anoop on 28/09/23.
//

import UIKit
import Photos

protocol PhotoCollectionViewDelegate {
    func didSetImage(_ image: UIImage)
}

class PhotoCollectionViewController: UICollectionViewController {
    
    var imageCollection = [PHAsset]()
    var delegate: PhotoCollectionViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateLibrary()
        
    }
    
    private func requestPermission(completion:@escaping(PHAuthorizationStatus) -> ()) {
       //responsible for accessing the user's library
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
                //used to retrieve the assests of media type
                let assets = PHAsset.fetchAssets(with: .image, options: fetchOptions)
                print("Anoop_assets:\(assets)")
                assets.enumerateObjects { object, count , stop in
                    print("Anoop_assestsObject:\(object)")
                    self.imageCollection.append(object)
                }
                self.imageCollection.reverse()
                self.collectionView.reloadData()
                print("Anoop_images:\(self.imageCollection)")
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return self.imageCollection.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell
        let assets = self.imageCollection[indexPath.row]
        let manager = PHImageManager.default()
        //uses to represent the image with the specified assest
        manager.requestImage(for: assets, targetSize: CGSize(width: 100, height: 100), contentMode: .aspectFill, options: nil) { images, _ in
            DispatchQueue.main.async{
                cell?.photoImageView.image = images
            }
        }
        return cell!
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let assest = self.imageCollection[indexPath.row]
        let manager = PHImageManager.default()
        let options = PHImageRequestOptions()
        options.isSynchronous = true
        manager.requestImage(for: assest, targetSize: CGSize(width: 320, height: 450), contentMode: .aspectFill, options: options) { images, _ in
            if let image = images {
                // used to pass the image to the previewVC
                self.delegate?.didSetImage(image)
            }
          
        }
    }
}
