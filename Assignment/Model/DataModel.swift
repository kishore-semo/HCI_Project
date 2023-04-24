//
//  DataModel.swift
//  Assignment
//
//  Created by Durgarao on 19/04/23.
//

import Foundation

import RealmSwift

class DiabetiDataModel: Object {
    @objc dynamic var id  = ObjectId.generate()
    @objc dynamic var Date: String?
    @objc dynamic var BlooadSugarLevelBeforeBreakFast: String?
    @objc dynamic var BlooadSugarLevelBeforeBreakFastTime: String?
    @objc dynamic var BreakFastMenu: String?
    @objc dynamic var BreakFastTime: String?
    @objc dynamic var LunchMenu:String?
    @objc dynamic var LunchMenuTime:String?
    @objc dynamic var DinnerMenu:String?
    @objc dynamic var DinnerMenuTime:String?
    @objc dynamic var BlooadSugarLevelAfterBreakFast:String?
    @objc dynamic var BlooadSugarLevelAfterBreakFastTime:String?
    
    override static func primaryKey() -> String? {
            return "id"
        }
    
}

//MARK: - Login Database
class LoginModel: Object {
    @objc dynamic var _id = ObjectId.generate()
    @objc dynamic var FullName: String?
    @objc dynamic var Email: String?
    @objc dynamic var PhoneNumber: String?
    @objc dynamic var DateOfBirth: String?
    @objc dynamic var UserName: String?
    @objc dynamic var Password:String?
    @objc dynamic var QuestionOne:String?
    @objc dynamic var AnswerOne:String?
    @objc dynamic var QuestionTwo:String?
    @objc dynamic var AnswerTwo:String?
    @objc dynamic var QuestionThree:String?
    @objc dynamic var AnswerThree:String?
    @objc dynamic var imageName:String?
    @objc dynamic var isRegister:Bool = false
    
    override static func primaryKey() -> String? {
            return "_id"
        }
    
}
