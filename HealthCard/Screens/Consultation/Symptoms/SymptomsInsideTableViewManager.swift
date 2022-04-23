//
//  SymptomsInsideTableViewManager.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 13/04/22.
//

import Foundation
import UIKit

class SymptomsInsideTableViewManager : NSObject {
    
    weak var tableView: UITableView?
    weak var emptyView: UIView?

    var storyData : [String] = []
            
    var pushDelegate: PushViewControllerDelegate?
    var presentDelegate: presentViewControllersDelegate?
    
    weak var tvHeight: NSLayoutConstraint!

    
    init(tableVIew: UITableView, tableViewHeight: NSLayoutConstraint) {
        self.tableView = tableVIew
        self.tvHeight = tableViewHeight


        self.tableView?.register(UINib(nibName: "SymptomsInsideTableViewCell", bundle: nil), forCellReuseIdentifier: "SymptomsInsideTableViewCell")
        super.init()
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        
        
    }
    
    func start(data: [String]) {
        self.storyData = data
        tableView?.reloadData()
        tableView?.layoutIfNeeded()
        emptyView?.isHidden = storyData.count > 0
        guard storyData.count > 0 else { return }
        
    }

}

extension SymptomsInsideTableViewManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = storyData.count
            return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SymptomsInsideTableViewCell", for: indexPath) as! SymptomsInsideTableViewCell
        cell.selectionStyle = .none
        
        cell.viewRef.layer.cornerRadius = cell.viewRef.bounds.height * 0.5
        cell.viewRef.dropShadow()
        cell.imgViewRef.layer.cornerRadius = cell.imgViewRef.bounds.height * 0.5
        
       
        return cell
    }


}

extension SymptomsInsideTableViewManager: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ConsultationDetailsViewController.instantiate()
        self.pushDelegate?.pushViewController(vc: vc)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.layoutIfNeeded()
        self.tvHeight.constant = tableView.contentSize.height + 50//CGFloat(count * 99)

        
    }

}
