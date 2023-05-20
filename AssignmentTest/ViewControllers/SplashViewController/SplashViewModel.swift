//
//  SplashViewModel.swift
//  AssignmentTest
//
//  Created by Muhhmmd Jawed Ansari on 20/05/23.
//

import UIKit
import CoreData

var userGlobalData:[NSManagedObject]? = []

class SplashViewModel: NSObject,MBProgressHUDDelegate {
    
    //MARK: OutSide Variable
    var objSplashVC: SplashViewController? { didSet { self.setUpUI() } }
    var UserDataResult:[Result]? = []
    var UserListData:[NSManagedObject]? = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    func setUpUI() {
        
        if let isSaved = UserDefaults.standard.value(forKey: "isDataSaved") as? Bool, isSaved == true {
            print("Data Saved")
            fetchAllDataFromCoreData()
            
        }else{
            
            apiCallForUserData()
        }
        
    }
    
    //MARK: Data From API
    
    func apiCallForUserData(){
        
        showHud("Loading...")
        let urlString = "https://randomuser.me/api/?results=100"
        let session = URLSession.shared
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) in
            guard let jsonData = data else {return}
            
            do {
                
                let All = try JSONDecoder().decode(UserData.self, from: jsonData)
                self.UserDataResult = All.results
                self.saveDataToCoreData()
                
            }catch let error {
                print(error.localizedDescription)
            }
            
            
        }).resume()
        
    }
    
    //MARK: Data Save into core Data
    
    func saveDataToCoreData(){
        
        let context = appDelegate.persistentContainer.viewContext
        
        for i in 0..<(UserDataResult?.count ?? 0){
            
            
            let entity = NSEntityDescription.entity(forEntityName: "Users", in: context)
            let newUser = NSManagedObject(entity: entity!, insertInto: context)
            
            let name = "\(UserDataResult?[i].name?.first ?? "")" + " " + "\(UserDataResult?[i].name?.last ?? "")"
            newUser.setValue(UserDataResult?[i].location?.city, forKey: "city")
            newUser.setValue(UserDataResult?[i].location?.country, forKey: "country")
            newUser.setValue(UserDataResult?[i].dob?.date, forKey: "dob")
            newUser.setValue(UserDataResult?[i].email, forKey: "email")
            newUser.setValue(UserDataResult?[i].picture?.large, forKey: "image")
            newUser.setValue(name, forKey: "name")
            newUser.setValue("12345", forKey: "passcode") // because wrong jason data coming
            newUser.setValue(UserDataResult?[i].registered?.date, forKey: "registerdate")
            newUser.setValue(UserDataResult?[i].location?.state, forKey: "state")
        }
        
        do {
            try context.save()
            self.fetchAllDataFromCoreData()
            
        } catch {
            print("Failed saving")
        }
    }
    
    //MARK: Data Fetch from core Data
    
    func fetchAllDataFromCoreData(){
        guard let objVC = self.objSplashVC else { return }
        
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "name") as! String)
                UserListData?.append(data)
            }
            hideHUD()
            UserDefaults.standard.set(true, forKey: "isDataSaved")
            DispatchQueue.main.async {
                
                userGlobalData = self.UserListData
                
                let nextview = objVC.storyboard?.instantiateViewController(withIdentifier: "ListsViewController") as? ListsViewController
                nextview?.dataArray = self.UserListData!
                objVC.navigationController?.pushViewController(nextview!, animated: true)
                
            }
            
            
        } catch {
            
            hideHUD()
            print("Failed")
        }
        
        
    }
    
    //MARK: Progress Bar
    
    func showHud(_ message: String) {
        guard let objVC = self.objSplashVC else { return }
        
        let hud = MBProgressHUD.showAdded(to: objVC.view, animated: true)
        hud.delegate = self
        hud.label.text = message
        hud.bezelView.style = .solidColor
        hud.bezelView.color = UIColor.white
        //hud.bezelView.color = .darkGray
        hud.isUserInteractionEnabled = false
        objVC.view.isUserInteractionEnabled = false
    }
    
    func hideHUD() {
        guard let objVC = self.objSplashVC else { return }
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: objVC.view, animated: true)
            objVC.view.isUserInteractionEnabled = true
        }
    }
}
