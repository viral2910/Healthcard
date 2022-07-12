//
//  CategoryCollectionViewManager.swift
//  HealthCard
//
//  Created by Pratik on 09/04/22.
//

import Foundation
import UIKit

class CategoryCollectionViewManager: NSObject {

    weak var collectionView: UICollectionView?
    weak var emptyView: UIView?
        
    var storyData : LookinForConcernDataResponse = []
    
//    //var moreOptionDropDown = DropDown_()
//    var moreButtonDropDown = DropDown_()
//    var view = UIView()
    
    weak var delegate: PushViewControllerDelegate?
    weak var presentDelegate: presentViewControllersDelegate?
    
    
    func start(data: LookinForConcernDataResponse, collectionVIew: UICollectionView) {
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


extension CategoryCollectionViewManager: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = storyData.count
        return count//storyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell", for:indexPath) as! CategoryCollectionViewCell
        //cell.borderView.layer.borderColor = UIColor(hexString: borderColor).cgColor

        cell.viewRef.layer.cornerRadius = 10
        cell.viewRef.dropShadow()
        
        cell.lblRef.text = storyData[indexPath.row].concern
        
        return cell
    }
    
    

    
    
}

extension CategoryCollectionViewManager: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = self.storyData[indexPath.row].concern
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

extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
