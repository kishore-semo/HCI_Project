//
//  LoginViewController.swift
//  Assignment
//
//  Created by Durgarao on 20/04/23.
//

import UIKit
import SwiftSMTP
import RealmSwift

class LoginViewController: UIViewController {
    //MARK: Properties
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var btnPopup: UIButton!
    @IBOutlet weak var vwPopup: UIView!
    
    @IBOutlet weak var tfEmailId: UITextField!
   
    var loginData:LoginModel?
    var randomPassword:String?
    var registerViewModel = RegisterViewModel()
    let smtp = SMTP(
        hostname: "smtp.gmail.com",     // SMTP server address
        email: "kishore.hci.test@gmail.com",        // username to login
        password: "alxaihzydcuqsqpr",
        port: 465,
        tlsMode: .requireTLS,
        authMethods: [.plain],
        timeout: 10

    )
    let fromMail = Mail.User(name: "Kishore Kethineni", email: "kishore.hci.test@gmail.com")
    let realm = try! Realm()
    
    //MARK: View Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        btnPopup.isHidden = true
        vwPopup.isHidden = true
        
        isRegister()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    func isRegister(){
        if loginData?.isRegister == false{
            let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    func loadData(){
        if realm.objects(LoginModel.self).count > 0 {
           loginData = realm.objects(LoginModel.self)[0]
        }else{
            let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterViewController") as? RegisterViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
    }
    //MARK:  SMTP mail sending function
    func sendMail(){
           
        let mail = Mail(
                from: fromMail,
                to: [Mail.User(email: tfEmailId.text ?? "")],
                subject: "Password Reset",
                text: "Your new login password is \(randaomPassword())"
            )
            print(mail)
            smtp.send(mail) { (error) in
                if let error = error {
                    print(error.localizedDescription)
                }else{
                    print("sended")
                    DispatchQueue.main.async {
                        self.showToast(message: "Your password sent successfully", seconds: 1.5)
                        try! self.realm.write{
                            self.loginData?.Password = self.randomPassword
                        }
                        
                    }
                    
                }
            }
            smtp.send(mail)
           
        }
    ///random 8 characters password generator
    func randaomPassword()->String{
        let len = 8
        let pswdChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
        randomPassword = String((0..<len).compactMap{ _ in pswdChars.randomElement() })
        guard let randomPassword = randomPassword else {return ""}
        return randomPassword
    }
    //MARK:  Actions
    @IBAction func forgotTapped(_ sender: UIButton) {
        btnPopup.isHidden = false
        vwPopup.isHidden = false
        
        
    }
    
    @IBAction func sendTapped(_ sender: UIButton) {
        btnPopup.isHidden = true
        vwPopup.isHidden = true
        DispatchQueue.main.async {
            if self.registerViewModel.isValidEmail(self.tfEmailId.text ?? ""){
                
                self.sendMail()
            }else{
                self.showToast(message: "Please valid email id", seconds: 1.0)
            }
        }
        
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        btnPopup.isHidden = true
        vwPopup.isHidden = true
    }
    @IBAction func loginTapped(_ sender: UIButton) {
        if tfUserName.text == loginData?.UserName && tfPassword.text == loginData?.Password {
            let vc = storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController
            self.navigationController?.pushViewController(vc!, animated: true)
        }else{
            showToast(message: "Your Username or password incorrect", seconds: 1.0)
        }
        
    }
    
}
