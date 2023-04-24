//
//  DashboardViewController.swift
//  Assignment
//
//  Created by Kishore Kethineni on 16/04/23.
//

import UIKit
import RealmSwift

class DashboardViewController: UIViewController,SideMenuDelegate {

    @IBOutlet weak var btnAdd: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    let realm = try! Realm()
    var diabeticData:Results<DiabetiDataModel>?
    var vm = AddDataViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        btnAdd.layer.cornerRadius = btnAdd.frame.height/2
        
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    func loadData(){
         diabeticData = realm.objects(DiabetiDataModel.self)
        tableView.reloadData()
    }
    //MARK: - Side menu setup
    func sidemenuSetup(sender:UIButton){
        if (sender.tag == 10)
        {
            // To Hide Menu If it already there
            self.sideMenuItemSelectedAtIndex(-1);
            sender.tag = 0;
            let viewMenuBack : UIView = view.subviews.last!
            UIView.animate(withDuration: 0.3, animations: { () -> Void in
                var frameMenu : CGRect = viewMenuBack.frame
                frameMenu.origin.x = -1 * UIScreen.main.bounds.size.width
                viewMenuBack.frame = frameMenu
                viewMenuBack.layoutIfNeeded()
                viewMenuBack.backgroundColor = UIColor.clear
            }, completion: { (finished) -> Void in
                viewMenuBack.removeFromSuperview()
            })
            return
        }
        sender.isEnabled = false
        sender.tag = 10
        let menuVC : SideMenuViewController = self.storyboard!.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        menuVC.btnMenu = sender
        menuVC.delegate = self
        self.view.addSubview(menuVC.view)
        self.addChild(menuVC)
        menuVC.view.layoutIfNeeded()
        menuVC.modalPresentationStyle = .currentContext
        menuVC.view.frame=CGRect(x: 0 - UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            menuVC.view.frame=CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height);
            sender.isEnabled = true
        }, completion:nil)
    }
    
        
    func sideMenuItemSelectedAtIndex(_ index: Int) {
        print(index)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            if index == 1{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController") as?  ChangePasswordViewController
                vc?.isDashboard = true
                self.navigationController?.pushViewController(vc!, animated: true)
            }else if index == 2{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SecondAuthenticationViewController") as?  SecondAuthenticationViewController
                vc?.isDashboard = true
                self.navigationController?.pushViewController(vc!, animated: true)
            }else if index == 3{
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "ThirdAuthenticationViewController") as?  ThirdAuthenticationViewController
                vc?.isDashboard = true
                self.navigationController?.pushViewController(vc!, animated: true)
            }else if index == -1{
                print(index)
            }else{
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
        
    @IBAction func sidemenuTapped(_ sender: UIButton) {
        sidemenuSetup(sender: sender)
    }
    @IBAction func printTapped(_ sender: UIButton) {
        let path = vm.createPDF()
        let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: path))
        dc.delegate = self
        dc.presentPreview(animated: true)
    }
    
}

//MARK: - Tableview Delegate and Datasource methods
extension DashboardViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return diabeticData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddDataTableViewCell", for: indexPath) as? AddDataTableViewCell
        cell?.lblDate.text = diabeticData?[indexPath.row].Date ?? ""
        cell?.lblBloodSugarBeforeBreakfast.text = diabeticData?[indexPath.row].BlooadSugarLevelBeforeBreakFast ?? ""
        cell?.lblBloodSugarBeforeBreakfastTime.text = diabeticData?[indexPath.row].BlooadSugarLevelBeforeBreakFastTime ?? ""
        cell?.lblBreakfast.text = diabeticData?[indexPath.row].BreakFastMenu ?? ""
        cell?.lblBreakfasttime.text = diabeticData?[indexPath.row].BreakFastTime ?? ""
        cell?.lblLunch.text = diabeticData?[indexPath.row].LunchMenu ?? ""
        cell?.lblLunchTime.text = diabeticData?[indexPath.row].LunchMenuTime ?? ""
        cell?.lblDinner.text = diabeticData?[indexPath.row].DinnerMenu ?? ""
        cell?.lblDinnerTime.text = diabeticData?[indexPath.row].DinnerMenuTime ?? ""
        cell?.lblBloodSugarAfterBreakfast.text = diabeticData?[indexPath.row].BlooadSugarLevelAfterBreakFast ?? ""
        cell?.lblBloodSugarAfterBreakfastTime.text = diabeticData?[indexPath.row].BlooadSugarLevelAfterBreakFastTime ?? ""
        cell?.selectionStyle = .none
        return cell!
        
    }
    
    
}
//MARK: Delete Delagate and document interaction delegate
extension DashboardViewController:UIDocumentInteractionControllerDelegate{
    
    
    //MARK: UIDocumentInteractionController delegates
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self//or use return self.navigationController for fetching app navigation bar colour
    }
}
