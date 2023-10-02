//
//  UIImageView+Extension.swift
//  GoodCam
//
//  Created by Anoop on 28/09/23.
//

import Foundation
import UIKit

extension UIImageView {
    
     func imageForFilterView() -> UIImageView {
        let filterImageView = UIImageView(image: UIImage(named: "filter-default-image"))
        filterImageView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 80, height: 80))
        filterImageView.layer.cornerRadius = 6.0
        filterImageView.layer.masksToBounds = true
        return filterImageView
    }
    
}
