//
//  RegisterViewModel.swift
//  Assignment
//
//  Created by Kishore Kethineni on 16/04/23.
//

import Foundation
import RealmSwift
import UIKit

protocol RegisterDelegate{
    var FullName: String {get set}
    var Email: String {get set}
    var PhoneNumber: String {get set}
    var DateOfBirth: String {get set}
    var UserName: String {get set}
    var Password:String {get set}
    var QuestionOne:String {get set}
    var AnswerOne:String {get set}
    var QuestionTwo:String {get set}
    var AnswerTwo:String {get set}
    var QuestionThree:String {get set}
    var AnswerThree:String {get set}
    var imageName:String {get set}
}
//MARK: - Register ViewModel for Business login for Registration Authentication
class RegisterViewModel:RegisterDelegate{
    
    var FullName: String = ""
    var Email: String = ""
    var PhoneNumber: String = ""
    var DateOfBirth: String = ""
    var UserName: String = ""
    var Password: String = ""
    var QuestionOne: String = ""
    var AnswerOne: String = ""
    var QuestionTwo: String = ""
    var AnswerTwo: String = ""
    var QuestionThree: String = ""
    var AnswerThree: String = ""
    var imageName: String = ""
    
    let securityQuestions:[String] = ["What is the name of a college you applied to but didn’t attend?","What was the name of the first school you remember attending?","Where was the destination of your most memorable school field trip?","What was your math’s teacher's surname in your 8th year of school?","What was the name of your first stuffed toy?","What was your driving instructor's first name?","Others"]
    let realm = try! Realm()
    
    var onShowError: ((_ message: String) -> Void)?
    var pid:ObjectId?
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    func validateRegister() -> Bool{
        if FullName == "" || PhoneNumber == "" || DateOfBirth == "" || UserName == ""{
            onShowError?("Please fill required fields")
            return false
        }
        if isValidEmail(Email) == false{
            onShowError?("Please enter valid email")
            return false
        }
        if isValidUserName(userName: UserName) == false{
            onShowError?("Please enter valid username")
            return false
        }
        if Password.count < 8{
            onShowError?("Please enter valid Password")
            return false
        }
        return true
    }
    func isValidUserName(userName:String) -> Bool {
        // least one uppercase,
        // least one digit
        // least one lowercase
        // least one symbol
        //  min 8 characters total
        let password = userName.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: userName)

    }
    //MARK:- add data to database
    func addData(){
        let newData = LoginModel()
        newData.FullName = FullName
        newData.Email = Email
        newData.PhoneNumber = PhoneNumber
        newData.DateOfBirth = DateOfBirth
        newData.UserName = UserName
        newData.Password = Password
        
        
        save(data: newData)
        
    }
    //MARK:- saving data into database
    func save(data: LoginModel){
        do{
            try realm.write{
                realm.add(data)
                pid = data._id
               
            }
        }catch{
            print("Error saving data\(error)")
        }
    }
    
    
    
}
extension UIViewController{
    func showToast(message : String, seconds: Double) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.frame.size.height = 20
        alert.view.layer.cornerRadius = 8
        self.present(alert, animated: true)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: false)
        }
    }
}
