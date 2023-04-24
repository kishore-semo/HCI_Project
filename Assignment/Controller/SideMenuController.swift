//
//  SideMenuController.swift
//  AutoTrack
//
//  Created by Halcyon Tek on 09/12/22.
//

import Foundation
import UIKit
import RealmSwift

class SideMenuViewController: UIViewController {

    @IBOutlet weak var buttonOverlay: UIButton!
    var btnMenu : UIButton!
    var delegate : SideMenuDelegate?
    var isHide:Bool = false
    var selectedIndex:Int?
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblNameLetter: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    let realm = try! Realm()
    var loginData:LoginModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        stackView.isHidden = true
        
        getData()
        

    }
    override func viewDidAppear(_ animated: Bool) {
        getData()
    }
    func getData(){
        if let name = realm.objects(LoginModel.self).first?.FullName{
            lblName.text =  name
            let char = name
           
            lblNameLetter.text = "\(String(describing: char.first!)))"
//            lblNameLetter.text = loginData.FullName.
        }
    }
    
    @IBAction func buttonClicked(_ button: UIButton) {
        btnMenu.tag = 0
        
        if (self.delegate != nil) {
            var index = button.tag
            if (button == self.buttonOverlay) {
                index = -1
            }
            delegate?.sideMenuItemSelectedAtIndex(index)
        }
        
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width,height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.init(white: 0, alpha: 0)
        }, completion: { (finished) -> Void in
            self.view.removeFromSuperview()
            self.removeFromParent()
        })
    }
    
    func closeSidemenu(){
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
   
    @IBAction func changePasswordTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected{
            stackView.isHidden = false
        }else{
            stackView.isHidden = true
        }
        
        
    }
    
    
    @IBAction func passwordChooseTapped(_ sender: UIButton) {
        delegate?.sideMenuItemSelectedAtIndex(sender.tag)
        
            self.closeSidemenu()
        
    }
    
}

protocol SideMenuDelegate {
    func sideMenuItemSelectedAtIndex(_ index : Int)
}

