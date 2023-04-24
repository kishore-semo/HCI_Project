//
//  RegisterViewController.swift
//  Assignment
//
//  Created by Kishore Kethineni on 16/04/23.
//
import UIKit


class RegisterViewController: UIViewController,CustomDatePickerDelegate {
   

    @IBOutlet weak var tfFullName: UITextField!
    @IBOutlet weak var tfPhoneNumber: UITextField!
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfDateofBirth: UITextField!
    @IBOutlet weak var tfUserName: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    @IBOutlet weak var btnNext: UIButton!
    private var datePicker:CustomDatePicker?
    var registerViewModel = RegisterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = CustomDatePicker()
        datePicker?.delegate = self
        datePicker?.showDatePicker(txtDatePicker:tfDateofBirth)
        btnNext.layer.cornerRadius = 8
       
        bindViewModel()
    }
    //MARK: Date Picker Delegate Methods
    func getDate(_ customDatePicker: CustomDatePicker, date: String) {
        print(date)
        tfDateofBirth.text = date
        self.view.endEditing(true)
    }
    
    func cancel(_ customDatePicker: CustomDatePicker) {
        self.view.endEditing(true)
            
    }
    func bindViewModel(){
        registerViewModel.FullName = tfFullName.text ?? ""
        registerViewModel.Email = tfEmail.text ?? ""
        registerViewModel.PhoneNumber = tfPhoneNumber.text ?? ""
        registerViewModel.DateOfBirth = tfDateofBirth.text ?? ""
        registerViewModel.UserName = tfUserName.text ?? ""
        registerViewModel.Password = tfPassword.text ?? ""
        registerViewModel.onShowError = { message in
            self.showToast(message: message, seconds: 1.0)
        }
    }
    @IBAction func nextTapped(_ sender: UIButton) {
        bindViewModel()
        if registerViewModel.validateRegister(){
            
            registerViewModel.addData()
            let vc  = storyboard?.instantiateViewController(withIdentifier: "SecondAuthenticationViewController") as? SecondAuthenticationViewController
            vc?.pid = registerViewModel.pid
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
}

