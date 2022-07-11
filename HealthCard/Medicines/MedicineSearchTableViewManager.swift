//
//  MedicineSearchTableViewManager.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 03/07/22.
//

import Foundation
import UIKit

protocol medicineSearchDelegate: AnyObject {
    func removeMedicineIndex(index: Int)
}

class MedicineSearchTableViewManager : NSObject {
    
    
    weak var tableView: UITableView?
    weak var emptyView: UIView?

    var labListData : [PharmacyDtlsSClist] = []
            
    var pushDelegate: PushViewControllerDelegate?
    var presentDelegate: presentViewControllersDelegate?
    
    weak var tvHeight: NSLayoutConstraint!

    var tableViewHeight: CGFloat = 0
    
    var removeDelegate: medicineSearchDelegate?
    
    init(tableVIew: UITableView, tableViewHeight: NSLayoutConstraint) {
        self.tableView = tableVIew
        self.tvHeight = tableViewHeight


        self.tableView?.register(UINib(nibName: "MedicineCell", bundle: nil), forCellReuseIdentifier: "MedicineCell")
        super.init()
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        
        
    }
    
    func start(data: [PharmacyDtlsSClist]) {
        self.labListData = data
        self.tableView?.reloadData()
        tableView?.layoutIfNeeded()
        emptyView?.isHidden = labListData.count > 0
        guard labListData.count > 0 else { return }

    }
    

}

extension MedicineSearchTableViewManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = labListData.count
        //self.tvHeight.constant = tableView.contentSize.height + 50//CGFloat(count * 99)
        //self.tvHeight.constant = CGFloat(160 * labListData.count)

            return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MedicineCell", for: indexPath) as! MedicineCell
        cell.selectionImageView.isHidden = true
        cell.crossBtnRef.isHidden = false
        cell.brandName.text = labListData[indexPath.row].brandName
        cell.genericName.text = labListData[indexPath.row].genericName
        cell.doseWithUnitLabel.text = labListData[indexPath.row].dose
        cell.packageLabel.text = labListData[indexPath.row].package
        cell.companyLabel.text = labListData[indexPath.row].manufactureCompany
        cell.prescriptionLabel.text = (labListData[indexPath.row].isPrescription == "True") ? "Yes" : "No"
//        cell.subtitleLabel.text = labListData[indexPath.row].
        let url = URL(string: "\(labListData[indexPath.row].drugImageURL ?? "")")!
        
//        if selectedID.contains(Int(labListData[indexPath.row].medicineID) ?? 0) && LabID.contains(Int(labListData[indexPath.row].docID) ?? 0){
//            cell.selectionImageView.image = UIImage(named: "checkedcircle");
//        } else {
//            cell.selectionImageView.image = UIImage(named: "circle");
//        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                cell.testImageView.image = image
            }
        }.resume()
        cell.selectionStyle = .none
        
        cell.crossBtnRef.tag = indexPath.row
        cell.crossBtnRef.addTarget(self, action: #selector(crossBtnTap), for: .touchUpInside)
        
        return cell
    }

    @objc func crossBtnTap(_ sender: UIButton) {
        let flag = sender.tag
        removeDelegate?.removeMedicineIndex(index: flag)
    }
    
}

extension MedicineSearchTableViewManager: UITableViewDelegate {
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        tableView.layoutIfNeeded()
        
        self.tvHeight.constant = tableView.contentSize.height

    }
    

}
