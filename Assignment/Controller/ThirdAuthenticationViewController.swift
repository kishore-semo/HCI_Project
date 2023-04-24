//
//  ThirdAuthenticationViewController.swift
//  Assignment
//
//  Created by Kishore Kethineni on 16/04/23.
//

import UIKit
import RealmSwift

class ThirdAuthenticationViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet weak var collectionView: UICollectionView!
    var registerViewModel = RegisterViewModel()
    @IBOutlet weak var btnSubmit: UIButton!
    var images = ["bridge","stair","trafficLight","bus","building","mountain","road","car","bicycle"]
    var selectedIndexPath: IndexPath?
    var pid:ObjectId?
    let realm = try! Realm()
    var record:LoginModel?
    var isDashboard:Bool = false
    var isLogin:Bool = false
    //MARK:  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        btnSubmit.layer.cornerRadius = 8
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        loadData()
    }
    func validate()->Bool{
        if selectedIndexPath != nil{
            return true
        }else{
            return false
        }
    }
    
    func loadData(){
        guard let id = pid else {return}
        record = realm.object(ofType: LoginModel.self, forPrimaryKey: id)
    }
    @IBAction func submitTapped(_ sender: UIButton) {
        guard let selectedIndexPath = selectedIndexPath else {return}
       
            if validate(){
                try! realm.write{
                    record?.imageName = images[selectedIndexPath.row]
                    record?.isRegister = true
                }
                if isDashboard{
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "DashboardViewController") as? DashboardViewController
                    self.navigationController?.pushViewController(vc!, animated: true)
                }else{
                    self.navigationController?.popToRootViewController(animated: true)
                }

            
        }
        
    }
}
//MARK:  CollectionView Delegate and Data Source Methods
extension ThirdAuthenticationViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photosCell", for: indexPath) as? PhotosCollectionViewCell
        cell?.img.layer.cornerRadius = 8
        cell?.img.image = UIImage(named: images[indexPath.row])
         
        if selectedIndexPath != nil && indexPath == selectedIndexPath {
            cell?.checkmarkImg.image = UIImage(named: "checked")

            }else{

                cell?.checkmarkImg.image = UIImage(named: "")
            }
        return cell!
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let nbCol = 3
            let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
            let totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(nbCol - 1))
            let size = Int((collectionView.bounds.width - totalSpace) / CGFloat(nbCol))
        return CGSize(width: size, height: size)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotosCollectionViewCell

        cell.checkmarkImg.image = UIImage(named: "checked")
            self.selectedIndexPath = indexPath
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! PhotosCollectionViewCell

        cell.checkmarkImg.image = UIImage(named: "")
            self.selectedIndexPath = nil
    }
}
