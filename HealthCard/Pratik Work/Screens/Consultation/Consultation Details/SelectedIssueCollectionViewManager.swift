//
//  SelectedIssueCollectionViewManager.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 13/04/22.
//

import Foundation
import UIKit

protocol removeSelectedIssue: AnyObject {
    func removeIssueAtIndex(index: Int)
}

class SelectedIssueCollectionViewManager: NSObject {

    weak var collectionView: UICollectionView?
    weak var emptyView: UIView?
        
    weak var pushDelegate: PushViewControllerDelegate?
    weak var outerPushDelegate: PushViewControllerDelegate?

    weak var presentDelegate: presentViewControllersDelegate?
    
    var delegate: removeSelectedIssue?
    
    var storyData : [String] = [] {
        didSet {
            collectionView?.reloadData()
            emptyView?.isHidden = storyData.count > 0
            guard storyData.count > 0 else { return }
            let attributes = self.collectionView?.collectionViewLayout.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0))
            let offsetPoint = CGPoint(x: 0, y: (attributes?.frame.origin.y ?? 0) - (collectionView?.contentInset.top ?? 0))
            self.collectionView?.setContentOffset(offsetPoint, animated: true)
        }
    }
    
    
    func start(collectionView: UICollectionView, storyData: [String] ) {

        self.collectionView = collectionView
        self.storyData = storyData
        
        let cellNib = UINib(nibName: "SelectedIssueCollectionViewCell", bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: "SelectedIssueCollectionViewCell")


        collectionView.dataSource = self
        collectionView.delegate = self

    }
        
}

extension SelectedIssueCollectionViewManager: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storyData.count //storyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelectedIssueCollectionViewCell", for:indexPath) as! SelectedIssueCollectionViewCell
        //cell.borderView.layer.borderColor = UIColor(hexString: borderColor).cgColor
        //managers.borderColor = UIColor.pinkColor

        cell.lblRef.text = storyData[indexPath.row]
          
        cell.viewRef.layer.cornerRadius = 10
        
        cell.crossBtnRef.tag = indexPath.row
        cell.crossBtnRef.addTarget(self, action: #selector(crossBtnTap(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func crossBtnTap(_ sender: UIButton) {
        let flag = sender.tag
        delegate?.removeIssueAtIndex(index: flag)
    }

}

extension SelectedIssueCollectionViewManager: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.size.width - 15) / 2, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    
}

