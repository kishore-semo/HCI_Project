//
//  SecondAuthenticationViewController.swift
//  Assignment
//
//  Created by Kishore Kethineni on 16/04/23.
//

import UIKit
import iOSDropDown
import RealmSwift

class SecondAuthenticationViewController: UIViewController {

    @IBOutlet weak var firstDropDown: DropDown!
    
    @IBOutlet weak var tffirstAnswer: UITextField!
    @IBOutlet weak var tfFirstQuestion: UITextField!
    
    @IBOutlet weak var tfSecondQuestion: UITextField!
    @IBOutlet weak var secondDropDown: DropDown!
    
    @IBOutlet weak var tfThirdAnswer: UITextField!
    @IBOutlet weak var tfThirdQuestion: UITextField!
    @IBOutlet weak var thirdDropDown: DropDown!
    @IBOutlet weak var tfSecondAnswer: UITextField!
    
    @IBOutlet weak var btnNext: UIButton!
    var registerViewModel = RegisterViewModel()
    
    @IBOutlet weak var tfFirstConstraint: NSLayoutConstraint!
    @IBOutlet weak var tfSecondConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tfThirdConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tfThirsBottom: NSLayoutConstraint!
    @IBOutlet weak var tfSecondBottom: NSLayoutConstraint!
    @IBOutlet weak var tfFirstBottom: NSLayoutConstraint!
    
    var record:LoginModel?
    var pid:ObjectId?
    let realm = try! Realm()
    var isDashboard:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initialSetup()
        

    }
    
    override func viewDidAppear(_ animated: Bool) {
        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        if isDashboard{
            btnNext.setTitle("Submit", for: .normal)
        }else{
            btnNext.setTitle("Next", for: .normal)
        }
    }
    func initialSetup(){
        firstDropDown.optionArray = registerViewModel.securityQuestions
        secondDropDown.optionArray = registerViewModel.securityQuestions
        thirdDropDown.optionArray = registerViewModel.securityQuestions
        self.tfFirstConstraint.constant = 0
        self.tfSecondConstraint.constant = 0
        self.tfThirdConstraint.constant = 0
        btnNext.layer.cornerRadius = 6
        self.tfFirstBottom.constant = 0
        self.tfSecondBottom.constant = 0
        self.tfThirsBottom.constant = 0
        
        
        firstDropDown.didSelect { selectedText, index, id in
            
            if selectedText == "Others"{
                self.tfFirstQuestion.isHidden = false
                self.tfFirstConstraint.constant = 42
                self.tfFirstBottom.constant = 12
                self.tfFirstQuestion.text = ""
            }else{
                self.tfFirstQuestion.isHidden = true
                self.tfFirstConstraint.constant = 0
                self.tfFirstBottom.constant = 0
                self.tfFirstQuestion.text = selectedText
            }
        }
        secondDropDown.didSelect { selectedText, index, id in
            self.tfSecondQuestion.text = selectedText
            if selectedText == "Others"{
                self.tfSecondQuestion.isHidden = false
                self.tfSecondConstraint.constant = 42
                self.tfSecondBottom.constant = 12
                self.tfSecondQuestion.text = ""
            }else{
                self.tfSecondQuestion.isHidden = true
                self.tfSecondConstraint.constant = 0
                self.tfSecondBottom.constant = 0
                self.tfSecondQuestion.text = selectedText
            }
        }
        thirdDropDown.didSelect { selectedText, index, id in
            self.tfThirdQuestion.text = selectedText
            if selectedText == "Others"{
                self.tfThirdQuestion.isHidden = false
                self.tfThirdConstraint.constant = 42
                self.tfThirsBottom.constant = 12
                self.tfThirdQuestion.text = ""
            }else{
                self.tfThirdQuestion.isHidden = true
                self.tfThirdConstraint.constant = 0
                self.tfThirsBottom.constant = 0
                self.tfThirdQuestion.text = selectedText
            }
        }
    }
    
    func getData(){
        guard let id = pid else {return}
        record = realm.object(ofType: LoginModel.self, forPrimaryKey: id)
    }
    func validate()-> Bool{
        if tfFirstQuestion.text == "" || tffirstAnswer.text == "" || tfSecondQuestion.text == "" || tfSecondAnswer.text == "" || tfThirdQuestion.text == "" || tfThirdAnswer.text == ""{
            showToast(message: "Please fill all security questions", seconds: 1.0)
            return false
        }
        return true
    }
    
    @IBAction func nextTapped(_ sender: UIButton) {
        
        if validate(){
            
                try! realm.write{
                    
                    record?.QuestionOne = tfFirstQuestion.text ?? ""
                    record?.AnswerOne = tffirstAnswer.text ?? ""
                    record?.QuestionTwo = tfSecondQuestion.text ?? ""
                    record?.AnswerTwo = tfSecondAnswer.text ?? ""
                    record?.QuestionThree = tfThirdAnswer.text ?? ""
                    record?.AnswerThree = tfThirdAnswer.text ?? ""
                    
                }
            
                
            if isDashboard {
                let vc  = storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController
                
                self.navigationController?.pushViewController(vc!, animated: true)
            }else{
                let vc  = storyboard?.instantiateViewController(withIdentifier: "ThirdAuthenticationViewController") as? ThirdAuthenticationViewController
                vc?.pid = pid
                vc?.isDashboard = false
                self.navigationController?.pushViewController(vc!, animated: true)
            }
            
            
            
        }
    }
    

}
