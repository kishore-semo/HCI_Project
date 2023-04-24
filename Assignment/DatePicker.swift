import UIKit

protocol CustomDatePickerDelegate:AnyObject {
    func getDate(_ customDatePicker:CustomDatePicker, date:String)
    func cancel(_ customDatePicker:CustomDatePicker)
}

class CustomDatePicker:UIView {
    
    var datePicker = UIDatePicker()
    var dateFormate = "yyyy-MM-dd"
    weak var delegate:CustomDatePickerDelegate?
    var screenWidth = UIScreen.main.bounds.width
    
    func showDatePicker(txtDatePicker:UITextField){
    
        //Formate Date
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.sizeToFit()
        datePicker.maximumDate = Date()
        //ToolBar
        let toolbar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0))
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self,action:#selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem:       UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .done, target: self, action:#selector(cancelDatePicker));
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated:       true)
         txtDatePicker.inputAccessoryView = toolbar
        txtDatePicker.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormate
        let result = formatter.string(from: datePicker.date)
        
        self.delegate?.getDate(self, date: result)
        
    }
    
    @objc func cancelDatePicker(){
        self.delegate?.cancel(self)
    }
    
}
