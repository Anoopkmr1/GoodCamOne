//
//  FilterViewController.swift
//  GoodCam
//
//  Created by Anoop on 28/09/23.
//

import UIKit

protocol PhotoFilterViewControllerDelegate {
    func photoFilterDone()
    func photoFilterCancel()
}


class FilterViewController: UIViewController, FilterScrollviewDelegate {

    var filterImage: UIImage?
    var filterService: FilterService!
    @IBOutlet weak var filterImageView: UIImageView!
    @IBOutlet weak var filterScrollView: FiltersScrollView!
    
    var delegate: PhotoFilterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    func setUp() {
        self.filterScrollView.filterDelegate = self
        self.filterService = FilterService()
        self.filterImageView.image = filterImage
    }
    
    func didSelectFilter(filter: CIFilter) {
        self.filterService.applyFilter(filter: filter, to: filterImage!) {
            self.filterImageView.image = $0
        }
    }
    
    @IBAction func filterCancelBtn(_ sender: Any) {
        self.delegate?.photoFilterCancel()
    }
    
    @IBAction func filterDoneBtn(_ sender: Any) {
        guard let selectedImage = self.filterImageView.image else {
            return
        }
        UIImageWriteToSavedPhotosAlbum(selectedImage, self, #selector(image(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            print(error.localizedDescription)
        } else {
            self.delegate?.photoFilterDone()
        }
    }
    
}
