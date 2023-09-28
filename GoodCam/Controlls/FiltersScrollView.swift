//
//  FiltersScrollView.swift
//  GoodCam
//
//  Created by Anoop on 28/09/23.
//

import Foundation
import UIKit
import CoreImage

protocol FilterScrollviewDelegate {
    func didSelectFilter(filter: CIFilter)
}

class FiltersScrollView: UIScrollView {
    
    private var filtersService: FilterService!
    var filterDelegate: FilterScrollviewDelegate?
    
    init(parentView: UIView, frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        
        self.filtersService = FilterService()
        setupFilters()
    }
    
    func registerTapGesture(for view: UIView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapped(recognizer: UITapGestureRecognizer) {
        guard let selectedImage = recognizer.view as? UIImageView else {
            return
        }
        self.filterDelegate?.didSelectFilter(filter: FilterService.all()[selectedImage.tag])// we are passing the index of the selected filter
    }
    
    private func setupFilters() {
        
        var offset: CGFloat = 10.0
        
        for (index, filter) in FilterService.all().enumerated() {
            let imageView = UIImageView()
            let filterImageView = imageView.imageForFilterView()
            self.addSubview(filterImageView)
            registerTapGesture(for: filterImageView)
            filterImageView.isUserInteractionEnabled = true
            filterImageView.tag = index
            
            filterImageView.frame.origin.x = offset
            filterImageView.center.y = self.frame.height/2
            
            offset += filterImageView.frame.width + filterImageView.frame.width/4
            self.contentSize = CGSize(width: offset, height: self.frame.height) // content of the scrollview
            self.filtersService.applyFilter(filter: filter, to: filterImageView.image!) {
                filterImageView.image = $0
            }
        }
        
    }
    
}
