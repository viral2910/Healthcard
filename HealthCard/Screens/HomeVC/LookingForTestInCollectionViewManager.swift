//
//  LookingForTestInCollectionViewManager.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 30/04/22.
//

import Foundation
import UIKit
import SDWebImage

class LookingForTestInCollectionViewManager: NSObject {
    
    weak var collectionView: UICollectionView?
    weak var emptyView: UIView?
    
    var storyData : LookingForTestInDataResponse = []
    
    var totalItemToShow = CGFloat()
    //    //var moreOptionDropDown = DropDown_()
    //    var moreButtonDropDown = DropDown_()
    //    var view = UIView()
    
    weak var delegate: PushViewControllerDelegate?
    weak var presentDelegate: presentViewControllersDelegate?
    
    
    func start(data: LookingForTestInDataResponse, collectionVIew: UICollectionView, totalItemToShow: CGFloat) {
        self.collectionView = collectionVIew
        self.totalItemToShow = totalItemToShow
        self.storyData = data
        let cellNib = UINib(nibName: "LookForTestCollectionViewCell", bundle: nil)
        collectionView?.register(cellNib, forCellWithReuseIdentifier: "LookForTestCollectionViewCell")
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


extension LookingForTestInCollectionViewManager: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = storyData.count
        return count//storyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LookForTestCollectionViewCell", for:indexPath) as! LookForTestCollectionViewCell
        //cell.borderView.layer.borderColor = UIColor(hexString: borderColor).cgColor
        
        cell.viewRef.layer.cornerRadius = 10
        cell.viewRef.clipsToBounds = false
        
        cell.viewRef.layer.masksToBounds = true
        cell.viewRef.dropShadow()
        
        cell.lblRef.text = storyData[indexPath.row].labTestText
        
        let imgUrl = storyData[indexPath.row].labTestImageURL.replacingOccurrences(of: " ", with: "%20")
        cell.imgViewRef.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "lab.jpeg"))
        
        //cell.lblRef.text = storyData[indexPath.row]
        //cell.imgViewRef.image = UIImage(named: imgData[indexPath.row])
        
        return cell
    }
    
    
    
    
    
}

extension LookingForTestInCollectionViewManager: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //self.viewCourse?(AppDelegate.shared.getStubCourse())
        
        //        switch indexPath.row {
        //        case 0:
        //            let vc = SearchMemberViewController.instantiate()
        //
        //            self.delegate?.pushViewController(vc: vc)
        //
        //        case 1:
        //            let vc = UpcomingEventsViewController.instantiate()
        //
        //            self.delegate?.pushViewController(vc: vc)
        //
        //        case 2:
        //            let vc = BirthdayViewController.instantiate()
        //
        //            self.delegate?.pushViewController(vc: vc)
        //
        //        case 3:
        //            let vc = PublicationsViewController.instantiate()
        //
        //            self.delegate?.pushViewController(vc: vc)
        //
        //        case 4:
        //            let vc = PhotosViewController.instantiate()
        //
        //            self.delegate?.pushViewController(vc: vc)
        //
        //        case 5:
        //            let vc = VideosViewController.instantiate()
        //
        //            self.delegate?.pushViewController(vc: vc)
        //
        //        case 6:
        //            let vc = AlphaDirectoryViewController.instantiate()
        //
        //            self.delegate?.pushViewController(vc: vc)
        //
        //        case 7:
        //            let vc = EventResourcesViewController.instantiate()
        //
        //            self.delegate?.pushViewController(vc: vc)
        //
        //        case 8:
        //            let vc = CommunicationViewController.instantiate()
        //
        //            self.delegate?.pushViewController(vc: vc)
        //
        //        default:
        //            break
        //        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.frame.size.width - 10)/totalItemToShow, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

//extension CoursesCollectionViewManager: PushViewControllerDelegate {
//    func pushViewController(vc: UIViewController) {
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//}
