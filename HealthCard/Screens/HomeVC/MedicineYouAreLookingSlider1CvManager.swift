//
//  MedicineYouAreLookingSlider1CvManager.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 30/04/22.
//

import Foundation
import UIKit
import SDWebImage

class MedicineYouAreLookingSlider1CvManager: NSObject {

    weak var collectionView: UICollectionView?
    weak var emptyView: UIView?
        
    var storyData : [String] = []
    
    weak var pushDelegate: PushViewControllerDelegate?
    weak var presentDelegate: presentViewControllersDelegate?
//    //var moreOptionDropDown = DropDown_()
//    var moreButtonDropDown = DropDown_()
//    var view = UIView()
    
    
    
    func start(data: [String], collectionVIew: UICollectionView) {
        self.collectionView = collectionVIew
        self.storyData = data
        let cellNib = UINib(nibName: "SliderCollectionViewCell", bundle: nil)
        collectionView?.register(cellNib, forCellWithReuseIdentifier: "SliderCollectionViewCell")
        self.collectionView?.dataSource = self
        self.collectionView?.delegate = self

        collectionView?.reloadData()
        collectionView?.layoutIfNeeded()
        emptyView?.isHidden = storyData.count > 0
        
        Timer.scheduledTimer(timeInterval: 4.0, target: self, selector: #selector(self.scrollAutomatically), userInfo: nil, repeats: true)
        
        guard storyData.count > 0 else { return }
        let attributes = self.collectionView?.collectionViewLayout.layoutAttributesForSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, at: IndexPath(item: 0, section: 0))
        let offsetPoint = CGPoint(x: 0, y: (attributes?.frame.origin.y ?? 0) - (collectionView?.contentInset.top ?? 0))
        self.collectionView?.setContentOffset(offsetPoint, animated: true)
                
    }
    
    @objc func scrollAutomatically(_ timer: Timer) {
        if let coll  = collectionView {
            for cell in coll.visibleCells {
                let indexPath: IndexPath? = coll.indexPath(for: cell)
                if ((indexPath?.row)!  < storyData.count - 1){
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: (indexPath?.row)! + 1, section: (indexPath?.section)!)
                    
                    coll.scrollToItem(at: indexPath1!, at: .right, animated: true)
                }
                else{
                    let indexPath1: IndexPath?
                    indexPath1 = IndexPath.init(row: 0, section: (indexPath?.section)!)
                    coll.scrollToItem(at: indexPath1!, at: .left, animated: true)
                }
                
            }
        }
   }

    
}


extension MedicineYouAreLookingSlider1CvManager: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = storyData.count
        return count//storyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SliderCollectionViewCell", for:indexPath) as! SliderCollectionViewCell
        //cell.borderView.layer.borderColor = UIColor(hexString: borderColor).cgColor

        cell.imgViewRef.image = UIImage(named: storyData[indexPath.row])
//        if let imgUrl = storyData[indexPath.row].banner {
//            cell.imgViewRef.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "placeholder.png"))
//        }
        
        cell.imgViewRef.layer.cornerRadius = 10

        return cell
    }
    
    

    
    
}

extension MedicineYouAreLookingSlider1CvManager: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //self.viewCourse?(AppDelegate.shared.getStubCourse())
//        let vc = EventDetailsViewController.instantiate()
//        vc.eventId = storyData[indexPath.row].eventID ?? 0
//        pushDelegate?.pushViewController(vc: vc)
            
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}

//extension CoursesCollectionViewManager: PushViewControllerDelegate {
//    func pushViewController(vc: UIViewController) {
//        self.navigationController?.pushViewController(vc, animated: true)
//    }
//
//}
