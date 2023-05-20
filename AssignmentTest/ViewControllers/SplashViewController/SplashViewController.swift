//
//  SplashViewController.swift
//  AssignmentTest
//
//  Created by Muhhmmd Jawed Ansari on 20/05/23.
//

import UIKit

class SplashViewController: UIViewController {

    let objSplashModel = SplashViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        objSplashModel.objSplashVC = self

    }

}
