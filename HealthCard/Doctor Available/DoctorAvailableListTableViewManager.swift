//
//  DoctorAvailableListTableViewManager.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 07/05/22.
//

import Foundation
import UIKit

class DoctorAvailableListTableViewManager : NSObject {
    
    weak var tableView: UITableView?
    weak var emptyView: UIView?
    
    var storyData : DoctorBySpecializationResponse = []
    
    var pushDelegate: PushViewControllerDelegate?
    var presentDelegate: presentViewControllersDelegate?
    
    var delegate: selectedIssueDelegate?
    
    init(tableVIew: UITableView) {
        self.tableView = tableVIew
        
        self.tableView?.register(UINib(nibName: "DoctorAvailableListTableViewCell", bundle: nil), forCellReuseIdentifier: "DoctorAvailableListTableViewCell")
        super.init()
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        
        
    }
    
    func start(data: DoctorBySpecializationResponse) {
        self.storyData = data
        tableView?.reloadData()
        tableView?.layoutIfNeeded()
        emptyView?.isHidden = storyData.count > 0
        guard storyData.count > 0 else { return }
        
    }
    
}

extension DoctorAvailableListTableViewManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = storyData.count
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DoctorAvailableListTableViewCell", for: indexPath) as! DoctorAvailableListTableViewCell
        cell.selectionStyle = .none
        
        cell.viewRef.layer.cornerRadius = 10
        cell.viewRef.dropShadow()
        
        cell.imgViewRef.layer.cornerRadius = 10
        cell.imgViewBgViewRef.dropShadow()
        cell.imgViewBgViewRef.layer.cornerRadius = 10
        cell.totalExpLblRef.layer.masksToBounds = true
        cell.totalExpLblRef.layer.cornerRadius = 10
        cell.consultNowBtnRef.layer.cornerRadius = 10
        cell.consultNowBtnRef.dropBtnShadow()
        
        let data = storyData[indexPath.row]
        let name = "\(data.firstName) \(data.lastName)"
        cell.nameLblRef.text = name
        
        cell.degreeLblRef.text = data.education
        
        cell.descLblRef.text = data.speciality
        
        cell.totalExpLblRef.text = "\(data.totalExperience) Years Exp"
        
                let imgUrl = data.doctorProfilePicURL
                    cell.imgViewRef.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "placeholder.png"))
                
        
        let attrs1 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : UIColor.init(hexString: "0057A6")]
        
        let attrs2 = [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 13), NSAttributedString.Key.foregroundColor : UIColor.black]
        
        let attributedString1 = NSMutableAttributedString(string:"Fee: ", attributes:attrs1)
        
        let attributedString2 = NSMutableAttributedString(string:"₹\(data.onlineConsultationFees)", attributes:attrs2)
        
        attributedString1.append(attributedString2)
        cell.feeLblRef.attributedText = attributedString1
        
        cell.consultNowBtnRef.tag = indexPath.row
        cell.consultNowBtnRef.addTarget(self, action: #selector(consultNowBtnTap(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func consultNowBtnTap(_ sender: UIButton) {
        let flag = sender.tag
        print("Consult: \(flag)")
        
        let vc = ConsultDoctorDetailsViewController.instantiate()
        vc.doctorId = storyData[flag].doctorID
        self.pushDelegate?.pushViewController(vc: vc)
    }
    
}

extension DoctorAvailableListTableViewManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.layoutIfNeeded()
        
        
    }
    
}
