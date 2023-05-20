//
//  DetailViewController.swift
//  AssignmentTest
//
//  Created by Muhhmmd Jawed Ansari on 20/05/23.
//

import UIKit

@objc class DetailViewController: UIViewController {

    @objc let objDetailModel = DetailViewModel()
    
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblDOB: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblState: UILabel!
    @IBOutlet weak var lblPostCode: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        objDetailModel.objDetailVC = self
    }

    @IBAction func tapTOBack(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }

}
