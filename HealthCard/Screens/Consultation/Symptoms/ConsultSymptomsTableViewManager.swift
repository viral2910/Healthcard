//
//  ConsultSymptomsTableViewManager.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 13/04/22.
//

import Foundation
import UIKit

class ConsultSymptomsTableViewManager : NSObject {
    
    weak var tableView: UITableView?
    weak var emptyView: UIView?

    var storyData : SymptomsDataResponse = []
            
    var pushDelegate: PushViewControllerDelegate?
    var presentDelegate: presentViewControllersDelegate?
    
    init(tableVIew: UITableView) {
        self.tableView = tableVIew

        self.tableView?.register(UINib(nibName: "ConsultSymptomsTableViewCell", bundle: nil), forCellReuseIdentifier: "ConsultSymptomsTableViewCell")
        super.init()
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        
        
    }
    
    func start(data: SymptomsDataResponse) {
        self.storyData = data
        tableView?.reloadData()
        tableView?.layoutIfNeeded()
        emptyView?.isHidden = storyData.count > 0
        guard storyData.count > 0 else { return }
        
    }

}

extension ConsultSymptomsTableViewManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = storyData.count
            return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConsultSymptomsTableViewCell", for: indexPath) as! ConsultSymptomsTableViewCell
        cell.selectionStyle = .none
        
        cell.viewRef.layer.cornerRadius = 10
        cell.viewRef.dropShadow()
        
        cell.tableViewManager.start(data: storyData[indexPath.row].concernDetailslist ?? [])
        cell.tableViewManager.pushDelegate = pushDelegate
        cell.tableViewManager.presentDelegate = presentDelegate
       
        cell.lblRef.text = storyData[indexPath.row].concernCatagory
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tableViewTapped))
        
        cell.tvRef.addGestureRecognizer(tapGesture)
        
        return cell
    }


}

extension ConsultSymptomsTableViewManager: UITableViewDelegate {
        
    @objc func tableViewTapped(_ gesture:UITapGestureRecognizer){

    guard let indexPath = tableView!.indexPathForRow(at: gesture.location(in: self.tableView)) else {
        print("Error: indexPath)")
        return
    }

    print("indexPath.row: \(indexPath.row)")
        
        let vc = ConsultationDetailsViewController.instantiate()
        vc.concernList = storyData[indexPath.row].concernDetailslist ?? []
        self.pushDelegate?.pushViewController(vc: vc)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ConsultationDetailsViewController.instantiate()
        vc.concernList = storyData[indexPath.row].concernDetailslist ?? []
        self.pushDelegate?.pushViewController(vc: vc)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.layoutIfNeeded()

        
    }

}

