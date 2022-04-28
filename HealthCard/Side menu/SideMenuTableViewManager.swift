//
//  SideMenuTableViewManager.swift
//  CancerCare
//
//  Created by Pratik on 30/09/21.
//

import Foundation
import UIKit
import SDWebImage

class SideMenuTableViewManager: NSObject {
    
    weak var tableView: UITableView?
    weak var emptyView: UIView?
    var cellBackgroundColor = UIColor.clear
    weak var tvHeight: NSLayoutConstraint!
    
    var sideMenuData : [String] = []
    var iconData : [String] = []
    
    weak var pushDelegate: PushViewControllerDelegate?
    
    
    init(tableVIew: UITableView, tableViewheight: NSLayoutConstraint) {
        self.tableView = tableVIew
        self.tvHeight = tableViewheight

        self.tableView?.register(UINib(nibName: "CustomSideMenuTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomSideMenuTableViewCell")
        super.init()
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        
        
    }
    
    func start(data: [String], iconData: [String]) {
        self.sideMenuData = data
        self.iconData = iconData
        self.tableView?.tableFooterView = UIView()
        self.tableView?.separatorStyle = .none

        tableView?.reloadData()
        tableView?.layoutIfNeeded()
        emptyView?.isHidden = sideMenuData.count > 0
        guard sideMenuData.count > 0 else { return }

    }
    
}

extension SideMenuTableViewManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = sideMenuData.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomSideMenuTableViewCell", for: indexPath) as! CustomSideMenuTableViewCell
                
        //cell.sendRequestBtnRef.layer.cornerRadius = 5
        
        cell.selectionStyle = .none
        
        let title = sideMenuData[indexPath.row]
            cell.lblRef.text = title
        

//        let image = iconData[indexPath.row]
//        cell.imgViewRef.image = UIImage(named: image)
//        
        
//        cell.sendRequestBtnRef.addTarget(self, action: #selector(sendRequestBtnTap(sender:)), for: .touchUpInside)
//        cell.sendRequestBtnRef.tag = indexPath.row
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            print("Button Tap")
//            let vc = HomeViewController.instantiate()
//            self.pushDelegate?.pushViewController(vc: vc)
            
        case 1:
            print("Button Tap")

        case 2:
            print("Button Tap")

        case 3:
            print("Button Tap")
            
        case 4:
            print("Button Tap")
            
        case 5:
            print("Button Tap")
            
        case 6:
            print("Button Tap")
            
        case 7:
            print("Button Tap")

        default:
            break
        }
        
        
    }
    
    @objc func sendRequestBtnTap(sender: UIButton) {
        
    }
}

extension SideMenuTableViewManager: UITableViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.layoutIfNeeded()

        self.tvHeight.constant = tableView.contentSize.height//CGFloat(count * 99)

    }
}
