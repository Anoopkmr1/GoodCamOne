//
//  ViewController.swift
//  GoodCam
//
//  Created by Anoop on 27/09/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func cameraBtnClk(_ sender: Any) {
        guard let photoFilter = self.storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as? FilterViewController else {
            print("Error")
            return
        }
        self.addChildVC(photoFilter)        
    }
    
}

