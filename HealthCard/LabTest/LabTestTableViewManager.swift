//
//  LabTestTableViewManager.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 03/07/22.
//

import Foundation
import UIKit

protocol LabTestSearchDelegate: AnyObject {
    func removeLabTestIndex(index: Int)
}

class LabTestTableViewManager : NSObject {
    
    
    weak var tableView: UITableView?
    weak var emptyView: UIView?

    var labListData : [LabTestDtlslist] = []
            
    var pushDelegate: PushViewControllerDelegate?
    var presentDelegate: presentViewControllersDelegate?
    
    weak var tvHeight: NSLayoutConstraint!

    var tableViewHeight: CGFloat = 0
    
    var removeDelegate: LabTestSearchDelegate?
    
    init(tableVIew: UITableView, tableViewHeight: NSLayoutConstraint) {
        self.tableView = tableVIew
        self.tvHeight = tableViewHeight


        self.tableView?.register(UINib(nibName: "LabTestCell", bundle: nil), forCellReuseIdentifier: "LabTestCell")
        super.init()
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        
        
    }
    
    func start(data: [LabTestDtlslist]) {
        self.labListData = data
        self.tableView?.reloadData()
        tableView?.layoutIfNeeded()
        emptyView?.isHidden = labListData.count > 0
        guard labListData.count > 0 else { return }

    }
    

}

extension LabTestTableViewManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = labListData.count
        //self.tvHeight.constant = tableView.contentSize.height + 50//CGFloat(count * 99)
        //self.tvHeight.constant = CGFloat(160 * labListData.count)

            return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabTestCell") as! LabTestCell
        cell.titleLabel.text = labListData[indexPath.row].labTestText ?? ""
        let url = URL(string: "\(labListData[indexPath.row].labTestImageURL ?? "")")!
//        if selectedID.contains(labListData[indexPath.row].labTestID ?? 0) && LabID.contains(Int(labListData[indexPath.row].docID ?? "") ?? 0){
//            cell.selectionImageView.image = UIImage(named: "checkedcircle");
//        } else {
//            cell.selectionImageView.image = UIImage(named: "circle");
//        }
            cell.testImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "lab.jpeg"))
        cell.selectionStyle = .none
        cell.crossBtnRef.isHidden = false
        cell.crossBtnRef.tag = indexPath.row
        cell.crossBtnRef.addTarget(self, action: #selector(crossBtnTap), for: .touchUpInside)
        
        return cell
    }

    @objc func crossBtnTap(_ sender: UIButton) {
        let flag = sender.tag
        removeDelegate?.removeLabTestIndex(index: flag)
    }
    
}

extension LabTestTableViewManager: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.layoutIfNeeded()
        
        self.tvHeight.constant = tableView.contentSize.height

    }
    

}
