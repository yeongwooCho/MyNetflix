//
//  PlayerViewController.swift
//  MyNetflix
//
//  Created by 조영우 on 2021/04/29.
//

import UIKit

class PlayerViewController: UIViewController {

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .landscapeRight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
}
