//
//  AddDataViewModel.swift
//  Assignment
//
//  Created by Durgarao on 19/04/23.
//

import Foundation
import RealmSwift
import UIKit




struct DataModel{
    let Date:String
    let BlooadSugarLevelBeforeBreakFast: String
    let BlooadSugarLevelBeforeBreakFastTime: String
    let BreakFastMenu: String
    let BreakFastTime: String
    let LunchMenu:String
    let LunchMenuTime:String
    let DinnerMenu:String
    let DinnerMenuTime:String
    let BlooadSugarLevelAfterBreakFast:String
    let BlooadSugarLevelAfterBreakFastTime:String
}


class AddDataViewModel {
    
    
    let realm = try! Realm()
    
    var diabeticData:Results<DiabetiDataModel>?
    
    
    init() {
        loadData()
    }
    //MARK:- Getting data from database
    func loadData(){
        diabeticData = realm.objects(DiabetiDataModel.self)
         
        
    }
    
    //MARK:- add data to database
    func addData(dataModel:DataModel){
        let newData = DiabetiDataModel()
        newData.Date = dataModel.Date
        newData.BlooadSugarLevelBeforeBreakFast = dataModel.BlooadSugarLevelBeforeBreakFast
        newData.BlooadSugarLevelBeforeBreakFastTime = dataModel.BlooadSugarLevelBeforeBreakFastTime
        newData.BreakFastMenu = dataModel.BreakFastMenu
        newData.BreakFastTime = dataModel.BreakFastTime
        newData.LunchMenu = dataModel.LunchMenu
        newData.LunchMenuTime = dataModel.LunchMenuTime
        newData.DinnerMenu = dataModel.DinnerMenu
        newData.DinnerMenuTime = dataModel.DinnerMenuTime
        newData.BlooadSugarLevelAfterBreakFast = dataModel.BlooadSugarLevelAfterBreakFast
        newData.BlooadSugarLevelAfterBreakFastTime = dataModel.BlooadSugarLevelBeforeBreakFastTime
        
        
        save(data: newData)
        
    }
    //MARK:- saving data into database
    func save(data: DiabetiDataModel){
        do{
            try realm.write{
                realm.add(data)
                
               
            }
        }catch{
            print("Error saving data\(error)")
        }
    }
    
    
    //MARK: Generate PDF
    func createRows() -> String {
        var s = ""
        guard let diabeticData = diabeticData else {return ""}
        for i in 0..<diabeticData.count{
            s = s + "<tr>\n<td>\(diabeticData[i].Date ?? "" )</td>\n<td>\(diabeticData[i].BlooadSugarLevelBeforeBreakFast ?? "") \(diabeticData[i].BlooadSugarLevelBeforeBreakFastTime ?? "")</td>\n<td>\(diabeticData[i].BreakFastMenu ?? "") \(diabeticData[i].BreakFastTime ?? "")</td>\n<td>\(diabeticData[i].LunchMenu ?? "" ) \(diabeticData[i].LunchMenuTime ?? "")</td>\n<td>\(diabeticData[i].DinnerMenu ?? "" ) \(diabeticData[i].DinnerMenuTime ?? "")</td>\n<td>\(diabeticData[i].BlooadSugarLevelAfterBreakFast ?? "" ) \(diabeticData[i].BlooadSugarLevelAfterBreakFastTime ?? "")</td>\n</tr>"
        }
        return s
    }
    
    func createPDF() -> String {
        let html = """
        <!DOCTYPE html>
        <html>
        
        <style>
        table, th, td {
          border:1px solid black;
        }
        </style>
        <body>
            <h2 style=\("color:white;background-color:black;"), align = center>Diabetes Information</h2>
        <table style=\("width:100%")>
        <tr style=\("color:white;background-color:black;")>
        <th>Date</th>
        <th>Blood suggar level in am</th>
        <th>Breakfask Menu</th>
        <th>Lunch Menu</th>
        <th>Dinner Menu</th>
        <th>Blood sugar level in am</th>
        
        </tr>
            
          \(createRows())
        
        </table>
        </body>
        </html>
"""
        let fmt = UIMarkupTextPrintFormatter(markupText: html)
        
        // 2. Assign print formatter to UIPrintPageRenderer
        
        let render = UIPrintPageRenderer()
        render.addPrintFormatter(fmt, startingAtPageAt: 0)
        
        // 3. Assign paperRect and printableRect
        
        let page = CGRect(x: 0, y: 0, width: 595.2, height: 841.8) // A4, 72 dpi
        let printable = page.insetBy(dx: 0, dy: 0)
        
        render.setValue(NSValue(cgRect: page), forKey: "paperRect")
        render.setValue(NSValue(cgRect: printable), forKey: "printableRect")
        
        // 4. Create PDF context and draw
        
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, .zero, nil)
        
        for i in 1...render.numberOfPages {
            UIGraphicsBeginPDFPage();
            let bounds = UIGraphicsGetPDFContextBounds()
            render.drawPage(at: i - 1, in: bounds)
        }
        
        UIGraphicsEndPDFContext();
        
        // 5. Save PDF file
        
        let documentsPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        
        pdfData.write(toFile: "\(documentsPath)/document.pdf", atomically: true)
       
        return "\(documentsPath)/document.pdf"
    }
    
}
