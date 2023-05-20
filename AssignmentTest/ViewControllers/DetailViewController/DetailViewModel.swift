//
//  DetailViewModel.swift
//  AssignmentTest
//
//  Created by Muhhmmd Jawed Ansari on 20/05/23.
//

import UIKit
import CoreData
import SDWebImage

@objc class DetailViewModel: NSObject {
    
    //MARK: OutSide Variable
    var objDetailVC: DetailViewController? { didSet { self.setUpUI() } }
    
    @objc var UserListData:[NSManagedObject]? = []
    @objc var selectedIndex:Int = 0
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func setUpUI() {
        fillData()
    }
    func fillData(){
        guard let objVC = self.objDetailVC else { return }
        
        objVC.lblTitle.text = UserListData![selectedIndex].value(forKey: "name") as? String
        
        objVC.lblEmail.text = "Email: \(UserListData![selectedIndex].value(forKey: "email") as! String)"
        objVC.lblDate.text = "Date Joined: \(UserListData?[selectedIndex].value(forKey: "registerdate") as! String)"
        objVC.lblDOB.text = "DOB: \(UserListData?[selectedIndex].value(forKey: "dob") as! String)"
        objVC.lblCity.text = "City: \(UserListData?[selectedIndex].value(forKey: "city") as! String)"
        objVC.lblState.text = "State: \(UserListData?[selectedIndex].value(forKey: "state") as! String)"
        objVC.lblCountry.text = "Country: \(UserListData?[selectedIndex].value(forKey: "country") as! String)"
        objVC.lblPostCode.text = "Passcode: \(UserListData?[selectedIndex].value(forKey: "passcode") as! String)"
        objVC.userImageView.sd_setImage(with: URL(string: (UserListData?[selectedIndex].value(forKey: "image")) as! String), placeholderImage: UIImage(named: "placeholder.png"))
        
    }
    
}
