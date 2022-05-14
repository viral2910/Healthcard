//
//  DoctorsTimingCollectionViewManager.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 08/05/22.
//

import Foundation
import UIKit
import Razorpay

protocol SelectedConsultationDetailsPtotocol: AnyObject {
    func getConsultationDetailsData(data: DoctorOnlineConsultTimeSClist)
}

class DoctorsTimingCollectionViewManager: NSObject {

    weak var collectionView: UICollectionView?
    weak var emptyView: UIView?
        
    weak var pushDelegate: PushViewControllerDelegate?
    weak var presentDelegate: presentViewControllersDelegate?
    
    weak var delegate: SelectedConsultationDetailsPtotocol?
    
    var storyData : [TimePeriodSClist] = [] {
        didSet {
            collectionView?.reloadData()
            emptyView?.isHidden = storyData.count > 0
            guard storyData.count > 0 else { return }
            let attributes = self.collectionView?.collectionViewLayout.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0))
            let offsetPoint = CGPoint(x: 0, y: (attributes?.frame.origin.y ?? 0) - (collectionView?.contentInset.top ?? 0))
            self.collectionView?.setContentOffset(offsetPoint, animated: true)
        }
    }
    
    
    func start(collectionView: UICollectionView, learnData: [TimePeriodSClist] ) {

        self.collectionView = collectionView
        self.storyData = learnData
        
        let cellHeaderNib = UINib(nibName: "timingShiftHeaderCell", bundle: nil)
        collectionView.register(cellHeaderNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "timingShiftHeaderCell")
        
        let cellNib = UINib(nibName: "TimingsCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "TimingsCollectionViewCell")


        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
    
}

extension DoctorsTimingCollectionViewManager: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return storyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storyData[section].doctorOnlineConsultTimeSClist?.count ?? 0 //storyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TimingsCollectionViewCell", for:indexPath) as! TimingsCollectionViewCell
        //cell.borderView.layer.borderColor = UIColor(hexString: borderColor).cgColor
        //managers.borderColor = UIColor.pinkColor
        cell.viewRef.layer.cornerRadius = 10
        cell.viewRef.dropShadow()
        
        let data = storyData[indexPath.section]
        
        cell.lblRef.text = "\(data.doctorOnlineConsultTimeSClist?[indexPath.section].fromTime ?? "")" + "\n" + "\(data.doctorOnlineConsultTimeSClist?[indexPath.section].toTime ?? "")"
//        if let title = storyData[indexPath.section].courseList?[indexPath.row].courseName {
//            cell.titleLblRef.text = title
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
        let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "timingShiftHeaderCell", for: indexPath) as! timingShiftHeaderCell
            let data = storyData[indexPath.section]

            cell.lblRef.text = "\(data.doctorOnlineConsultTimeSClist?.count ?? 0) Slots available in \(data.timePeriod)"
//            if let title = storyData[indexPath.section].categoryName {
//                cell.titleLblRef.text = title
//            }
            
        
        return cell
        } else {
            fatalError("No Footer register")
        }
        
    }

}

extension DoctorsTimingCollectionViewManager: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Index: \(indexPath)")
        if let data = storyData[indexPath.section].doctorOnlineConsultTimeSClist?[indexPath.row] {
        delegate?.getConsultationDetailsData(data: data)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.size.width / 3, height: 70)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    

}
