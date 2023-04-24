//
//  AddDataViewController.swift
//  Assignment
//
//  Created by Kishore Kethineni on 16/04/23.
//

import UIKit

class AddDataViewController: UIViewController,CustomDatePickerDelegate,CustomTimePickerDelegate,UITextFieldDelegate {
    
    
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var tfsugarLevelBeforeBreakfast: UITextField!
    @IBOutlet weak var tfsugarLevelBeforeBreakfastTime: UITextField!
    @IBOutlet weak var tfBreakfast: UITextField!
    @IBOutlet weak var bfBreakfastTime: UITextField!
    @IBOutlet weak var tfLunch: UITextField!
    @IBOutlet weak var tfLunchTime: UITextField!
    @IBOutlet weak var tfDinner: UITextField!
    @IBOutlet weak var tfDinnerTime: UITextField!
    @IBOutlet weak var tfSugarLevelAfterDinner: UITextField!
    @IBOutlet weak var tfSugarLevelAfterDinnerTime: UITextField!
    private var datePicker:CustomDatePicker?
    
    private var timePicker:CustomTimePicker?
    var textfieldType:String?
    
    var addDataViewModel = AddDataViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
        
        
    }
    
    
    func initialSetup(){
        datePicker = CustomDatePicker()
        datePicker?.delegate = self
        datePicker?.showDatePicker(txtDatePicker:tfDate)
        
        timePicker = CustomTimePicker()
        timePicker?.delegate = self
        
        timePicker?.showDatePicker(txtDatePicker:tfSugarLevelAfterDinnerTime)
        timePicker?.showDatePicker(txtDatePicker:tfsugarLevelBeforeBreakfastTime)
        timePicker?.showDatePicker(txtDatePicker:bfBreakfastTime)
        timePicker?.showDatePicker(txtDatePicker:tfLunchTime)
        timePicker?.showDatePicker(txtDatePicker:tfDinnerTime)
        
        tfSugarLevelAfterDinnerTime.delegate = self
        tfsugarLevelBeforeBreakfastTime.delegate = self
        bfBreakfastTime.delegate = self
        tfLunchTime.delegate = self
        tfDinnerTime.delegate = self
        
    }

    //MARK: Date Picker Delegate Methods
    func getDate(_ customDatePicker: CustomDatePicker, date: String) {
        print(date)
        tfDate.text = date
        self.view.endEditing(true)
    }
    
    func cancel(_ customDatePicker: CustomDatePicker) {
        self.view.endEditing(true)
            
    }
    func getTime(_ customDatePicker: CustomTimePicker, time: String) {
        print(time)
        if textfieldType == "beforeBreakfast"{
            tfsugarLevelBeforeBreakfastTime.text = time
        }else if textfieldType == "breakfast"{
            bfBreakfastTime.text = time
        }else if textfieldType == "lunch"{
            tfLunchTime.text = time
        }else if textfieldType == "Dinner"{
            tfDinnerTime.text = time
        }else if textfieldType == "afterDinner"{
            tfSugarLevelAfterDinnerTime.text = time
        }
        self.view.endEditing(true)
    }
    
    func cancel(_ customDatePicker: CustomTimePicker) {
        self.view.endEditing(true)
            
    }
    
    @IBAction func closeTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func saveTapped(_ sender: UIButton) {
        addDataViewModel.addData(dataModel: DataModel(Date: tfDate.text ?? "", BlooadSugarLevelBeforeBreakFast: tfsugarLevelBeforeBreakfast.text ?? "", BlooadSugarLevelBeforeBreakFastTime: tfsugarLevelBeforeBreakfastTime.text ?? "", BreakFastMenu: tfBreakfast.text ?? "", BreakFastTime: bfBreakfastTime.text ?? "", LunchMenu: tfLunch.text ?? "", LunchMenuTime: tfLunchTime.text ?? "", DinnerMenu: tfDinner.text ?? "", DinnerMenuTime: tfDinnerTime.text ?? "", BlooadSugarLevelAfterBreakFast: tfSugarLevelAfterDinner.text ?? "", BlooadSugarLevelAfterBreakFastTime: tfSugarLevelAfterDinnerTime.text ?? ""))
        dismiss(animated: true)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == tfsugarLevelBeforeBreakfastTime{
            textfieldType = "beforeBreakfast"
        }else if textField == bfBreakfastTime{
            textfieldType = "breakfast"
        }else if textField == tfLunchTime{
            textfieldType = "lunch"
        }else if textField == tfDinnerTime{
            textfieldType = "Dinner"
        }else if textField == tfSugarLevelAfterDinnerTime{
            textfieldType = "afterDinner"
        }
    }
    
}
