//
//  ConsultationCategoryCollectionViewManager.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 30/04/22.
//

import Foundation
import UIKit

class ConsultationCategoryCollectionViewManager: NSObject {

    weak var collectionView: UICollectionView?
    weak var emptyView: UIView?
        
    var storyData : LookinForConsultationDataResponse = []
    
//    //var moreOptionDropDown = DropDown_()
//    var moreButtonDropDown = DropDown_()
//    var view = UIView()
    
    weak var delegate: PushViewControllerDelegate?
    weak var presentDelegate: presentViewControllersDelegate?
    
    
    func start(data: LookinForConsultationDataResponse, collectionVIew: UICollectionView) {
        self.collectionView = collectionVIew
        self.storyData = data
        let cellNib = UINib(nibName: "CategoryCollectionViewCell", bundle: nil)
        collectionView?.register(cellNib, forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self

        collectionView?.reloadData()
        collectionView?.layoutIfNeeded()
        emptyView?.isHidden = storyData.count > 0
        guard storyData.count > 0 else { return }
        let attributes = self.collectionView?.collectionViewLayout.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0))
        let offsetPoint = CGPoint(x: 0, y: (attributes?.frame.origin.y ?? 0) - (collectionView?.contentInset.top ?? 0))
        self.collectionView?.setContentOffset(offsetPoint, animated: true)
                
    }
    

    
}


extension ConsultationCategoryCollectionViewManager: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = storyData.count
        return count//storyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for:indexPath) as! CategoryCollectionViewCell
        //cell.borderView.layer.borderColor = UIColor(hexString: borderColor).cgColor

        cell.viewRef.layer.cornerRadius = 10
        cell.viewRef.dropShadow()
        
        cell.lblRef.text = storyData[indexPath.row].value
        
        return cell
    }
    
    

    
    
}

extension ConsultationCategoryCollectionViewManager: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ConsultationDetailsViewController.instantiate()
        //vc.concernList = storyData[indexPath.row].concernDetailslist ?? []
        vc.selectedIssueArr = [storyData[indexPath.row].value]
        vc.specializationId = storyData[indexPath.row].id
        vc.concernList.append(SymptomsDataResponseElement(concernID: storyData[indexPath.row].id, concern: storyData[indexPath.row].value, concernCatagoryID: "", concernCatagory: "", concernDetailslist: []))
        vc.selectedSp = storyData[indexPath.row].value
        self.delegate?.pushViewController(vc: vc)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = self.storyData[indexPath.row].value
        let cellWidth = text.width(withConstrainedHeight: 50, font: UIFont.systemFont(ofSize: 16)) + 40.0//.size(withAttributes:[.font: UIFont.init(name: "Lato-Regular", size: 12.0)!]).width + 10.0
        print("Text: \(text.size(withAttributes:[.font: UIFont.systemFont(ofSize: 16)]).width) : cellWidth: \(cellWidth)")
        
        return CGSize(width:  cellWidth, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

