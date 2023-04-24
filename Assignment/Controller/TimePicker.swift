import UIKit

protocol CustomTimePickerDelegate:AnyObject {
    func getTime(_ customDatePicker:CustomTimePicker, time:String)
    func cancel(_ customDatePicker:CustomTimePicker)
}

class CustomTimePicker:UIView {
    
    var datePicker = UIDatePicker()
    weak var delegate:CustomTimePickerDelegate?
    var screenWidth = UIScreen.main.bounds.width
    
    func showDatePicker(txtDatePicker:UITextField){
    
        //Formate Date
        
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.sizeToFit()
        
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
        
        formatter.timeStyle = .short
        let result = formatter.string(from: datePicker.date)
        
        self.delegate?.getTime(self, time: result)
        
    }
    
    @objc func cancelDatePicker(){
        self.delegate?.cancel(self)
    }
    
}
