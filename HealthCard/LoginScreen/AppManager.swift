//
//  Common.swift
//  HealthCard
//
//  Created by Viral on 02/04/22.
//

import Foundation
import UIKit

class AppManager{
    
    static let shared = AppManager()
    
    init(){}
    
    
    func getLoginUserName()-> String{
        if let userId = UserDefaults.standard.object(forKey: "user_Name") {
            return userId as! String
            }
        return "";
    }
    
    func setViewSettingWithBgShade(view: UIView)
    {
        view.layer.cornerRadius = 10
        //MARK:- Shade a view
        view.layer.shadowOpacity = 0.7
        view.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        view.layer.shadowRadius = 3.0
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.masksToBounds = false
    }
    
    func getLoginUserEmail()-> String{
        if let userId = UserDefaults.standard.object(forKey: "user_Email") {
            return userId as! String
            }
        return "";
    }
    
    func showAlert(title:String,msg:String,vc:UIViewController){
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Dismiss", style: .default) { (_) in
        }
        alert.addAction(okAction)
        vc.present(alert, animated: true, completion: nil)
    }
    
    func doUserLogin(){
        UserDefaults.standard.set("yes", forKey: "login_done")
        UserDefaults.standard.synchronize()
    }
    
    
    func saveLoginUserId(userId: String){
        UserDefaults.standard.set(userId, forKey: "user_id")
        UserDefaults.standard.synchronize()
    }
    
    func getLoginUserId()-> String{
        if let userId = UserDefaults.standard.object(forKey: "user_id") {
            return userId as! String
            }
        return "";
    }
    
    func isUserLoggedIn()->Bool{
        if let _ = UserDefaults.standard.object(forKey: "login_done") {
            return true
        }
        return false;
    }
    
    
    
    
    
    func showLeftViewInTF(tf:UITextField,imgName:String){
        let paddingView = UIView(frame: CGRect(x: 0, y: 5, width: 25, height: 20))
        let imgV = UIImageView(image: UIImage(named: imgName))
        imgV.contentMode = .scaleAspectFit
        imgV.frame = CGRect(x: 5, y: 0, width: 20, height: 20)
        paddingView.addSubview(imgV)
        tf.leftView = paddingView
        tf.leftViewMode = .always
    }
    
    func doLogout(){
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
}
extension UIToolbar {
    
    public func setDefaultStyle(){
        self.barStyle = UIBarStyle.default
        self.isTranslucent = true
        self.tintColor = UIView().tintColor
        self.sizeToFit()
        self.isUserInteractionEnabled = true
    }
}
