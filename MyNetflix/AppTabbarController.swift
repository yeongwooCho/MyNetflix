//
//  AppTabbarController.swift
//  MyNetflix
//
//  Created by 조영우 on 2021/04/15.
//

import UIKit

class AppTabbarController: UITabBarController {

    // portrait 세로, landscape 가로
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

}
