//
//  FilterViewController.swift
//  GoodCam
//
//  Created by Anoop on 28/09/23.
//

import UIKit

class FilterViewController: UIViewController, FilterScrollviewDelegate {

    var filterImage: UIImage?
    var filterService: FilterService!
    @IBOutlet weak var filterImageView: UIImageView!
    @IBOutlet weak var filterScrollView: FiltersScrollView!
    
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
}
