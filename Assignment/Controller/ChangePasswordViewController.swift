//
//  ChangePasswordViewController.swift
//  Assignment
//
//  Created by Durgarao on 21/04/23.
//

import UIKit
import RealmSwift

class ChangePasswordViewController: UIViewController {

    @IBOutlet weak var tfOldPassword: UITextField!
    @IBOutlet weak var tfnewPaswword: UITextField!
    @IBOutlet weak var tfConfirmPassword: UITextField!
    
    
    let realm = try! Realm()
    var isDashboard:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

     
    }
    func getPassword()->String?{
            
        let record = realm.objects(LoginModel.self).first
        return record?.Password
    }
    func validate()->Bool{
        if tfOldPassword.text == "" || tfnewPaswword.text == "" || tfConfirmPassword.text == "" {
            showToast(message: "Please fill required fields", seconds: 1.0)
            return false
        }
        if tfOldPassword.text == getPassword(){
            showToast(message: "please enter correct old password", seconds: 1.0)
            return false
        }
        if tfnewPaswword.text?.count ?? 0 < 8 || tfnewPaswword.text?.count ?? 0 < 8 {
            showToast(message: "Password atleast 8 characters of length", seconds: 1.0)
            return false
        }
        if tfnewPaswword.text != tfConfirmPassword.text {
            showToast(message: "New password and confirm password should match", seconds: 1.0)
            return false
        }
        return true
    }

    @IBAction func submitTapped(_ sender: UIButton) {
        if validate(){
            if let record = realm.objects(LoginModel.self).first{
                try! realm.write{
                    record.Password = tfnewPaswword.text
                }
            }
            
            if isDashboard{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            
        }
        
    }
    
}
