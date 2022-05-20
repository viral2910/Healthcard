//
//  ConsultSpecialityTableViewManager.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 12/04/22.
//

import Foundation
import UIKit

class ConsultSpecialityTableViewManager : NSObject {
    
    weak var tableView: UITableView?
    weak var emptyView: UIView?

    var storyData : SpecilizationResponse = []
            
    var pushDelegate: PushViewControllerDelegate?
    var presentDelegate: presentViewControllersDelegate?
    
    init(tableVIew: UITableView) {
        self.tableView = tableVIew

        self.tableView?.register(UINib(nibName: "ConsultSpecialityTableViewCell", bundle: nil), forCellReuseIdentifier: "ConsultSpecialityTableViewCell")
        super.init()
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        
        
    }
    
    func start(data: SpecilizationResponse) {
        self.storyData = data
        tableView?.reloadData()
        tableView?.layoutIfNeeded()
        emptyView?.isHidden = storyData.count > 0
        guard storyData.count > 0 else { return }
        
    }

}

extension ConsultSpecialityTableViewManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = storyData.count
            return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConsultSpecialityTableViewCell", for: indexPath) as! ConsultSpecialityTableViewCell
        cell.selectionStyle = .none
        
        cell.viewRef.layer.cornerRadius = 10
        cell.viewRef.dropShadow()
        
        let dataArr = storyData[indexPath.row]
        cell.lblRef.text = dataArr.value
        
       
        return cell
    }


}

extension ConsultSpecialityTableViewManager: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ConsultationDetailsViewController.instantiate()
        vc.specializationId = storyData[indexPath.row].id
        self.pushDelegate?.pushViewController(vc: vc)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.layoutIfNeeded()

        
    }

}
