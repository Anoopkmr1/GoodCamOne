//
//  ExtensionViewController.swift
//  GoodCam
//
//  Created by Anoop on 28/09/23.
//

import UIKit
import UIKit

extension UIViewController {
    
    func addChildVC(_ childVC: UIViewController) {
        self.addChild(childVC)
        childVC.view.frame = self.view.frame
        self.view.addSubview(childVC.view)
        childVC.didMove(toParent: self)
    }
}
