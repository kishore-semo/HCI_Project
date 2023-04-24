//
//  loadindIndicator.swift
//  medimagic
//
//  Created by Clorida on 07/01/20.
//  Copyright © 2020 Clorida. All rights reserved.
//

import UIKit
public class LoadingOverlay{
    
    var overlayView = UIView()
    
    var activityIndicator = UIActivityIndicatorView()
    
    var bgView = UIView()
    
    var infoLabel = UILabel()
    class var shared: LoadingOverlay {
        
        struct Static {
            
            static let instance: LoadingOverlay = LoadingOverlay()
            
        }
        
        return Static.instance
    }
    
    public func showOverlay(view: UIView, infoText: String) {
        bgView.frame = view.bounds
        
        //        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        
        bgView.backgroundColor = UIColor.clear
        
        bgView.addSubview(overlayView)
        
        bgView.autoresizingMask = [.flexibleLeftMargin,.flexibleTopMargin,.flexibleRightMargin,.flexibleBottomMargin,.flexibleHeight, .flexibleWidth]
        
        //        overlayView.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        overlayView.frame = CGRect(x: view.bounds.size.width/2 - 50, y: view.bounds.size.height/2 - 50, width: 100, height: 100)
        
        //        overlayView.center = view.center
        
        overlayView.autoresizingMask = [.flexibleLeftMargin,.flexibleTopMargin,.flexibleRightMargin,.flexibleBottomMargin]
        
        //        overlayView.backgroundColor = UIColor.clear
        
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        overlayView.clipsToBounds = true
        
        overlayView.layer.cornerRadius = 8
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        
        activityIndicator.style = UIActivityIndicatorView.Style.large
        
        //        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 3)
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        infoLabel.frame = CGRect(x: 0, y: activityIndicator.bounds.origin.y + activityIndicator.bounds.height + 10, width: overlayView.bounds.width, height: 30)
        
        infoLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
        infoLabel.backgroundColor = UIColor.clear
        infoLabel.font = UIFont(name: "hkgrotesk_medium", size: 28)
        infoLabel.text = infoText
        //        infoLabel.text = ""
        overlayView.addSubview(activityIndicator)
        overlayView.addSubview(infoLabel)
        view.addSubview(bgView)
        self.activityIndicator.startAnimating()
    }
    
    public func showOverlay(view: UIView, viewController: UIViewController, infoText: String) {
        bgView.frame = view.bounds
        
        bgView.backgroundColor = UIColor.clear
        
        bgView.addSubview(overlayView)
        
        bgView.autoresizingMask = [.flexibleLeftMargin,.flexibleTopMargin,.flexibleRightMargin,.flexibleBottomMargin,.flexibleHeight, .flexibleWidth]
        
        if viewController.navigationController?.isNavigationBarHidden == true {
            overlayView.frame = CGRect(x: view.bounds.size.width/2 - 50, y: view.bounds.size.height/2 - 114, width: 100, height: 100)
        }
        else {
            overlayView.frame = CGRect(x: view.bounds.size.width/2 - 50, y: view.bounds.size.height/2 - 50, width: 100, height: 100)
        }
        
        //        overlayView.center = view.center
        
        overlayView.autoresizingMask = [.flexibleLeftMargin,.flexibleTopMargin,.flexibleRightMargin,.flexibleBottomMargin]
        
        //        overlayView.backgroundColor = UIColor.clear
        
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        overlayView.clipsToBounds = true
        
        overlayView.layer.cornerRadius = 8
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
        
        activityIndicator.style = UIActivityIndicatorView.Style.large
        
        activityIndicator.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        infoLabel.frame = CGRect(x: 0, y: activityIndicator.bounds.origin.y + activityIndicator.bounds.height + 10, width: overlayView.bounds.width, height: 30)
        
        infoLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        infoLabel.textAlignment = .center
        infoLabel.numberOfLines = 0
        infoLabel.backgroundColor = UIColor.clear
        infoLabel.font = UIFont(name: "hkgrotesk_medium", size: 28)
        infoLabel.text = ""
        overlayView.addSubview(activityIndicator)
        overlayView.addSubview(infoLabel)
        view.addSubview(bgView)
        self.activityIndicator.startAnimating()
    }
    
    public func hideOverlayView() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            //UIApplication.shared.endIgnoringInteractionEvents()
            self.bgView.removeFromSuperview()
        }
        
    }
}
