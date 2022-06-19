//
//  PrescriptionListCollectionViewManager.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 21/05/22.
//

import Foundation
import UIKit
import SDWebImage

protocol GetSelectedPrescriptionId: AnyObject {
    func selectedPrescriptionIds(id: [Int])
}

class PrescriptionListCollectionViewManager: NSObject {

    weak var collectionView: UICollectionView?
    weak var emptyView: UIView?
        
    var storyData : PatientPrescriptionResponseData = []
    
    weak var pushDelegate: PushViewControllerDelegate?
    weak var presentDelegate: presentViewControllersDelegate?
//    //var moreOptionDropDown = DropDown_()
//    var moreButtonDropDown = DropDown_()
//    var view = UIView()
    
    var buttonCounter = [Int]()

    var selectedPrescriptionId: [Int] = []
    
    var selectedPresDelegate: GetSelectedPrescriptionId?
    
    func start(data: PatientPrescriptionResponseData, collectionVIew: UICollectionView) {
        self.collectionView = collectionVIew
        self.storyData = data
        let cellNib = UINib(nibName: "PrescriptionListCollectionViewCell", bundle: nil)
        collectionView?.register(cellNib, forCellWithReuseIdentifier: "PrescriptionListCollectionViewCell")
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


extension PrescriptionListCollectionViewManager: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = storyData.count
        return count//storyData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrescriptionListCollectionViewCell", for:indexPath) as! PrescriptionListCollectionViewCell
        //cell.borderView.layer.borderColor = UIColor(hexString: borderColor).cgColor

       // cell.imgViewRef.image = UIImage(named: storyData[indexPath.row])
        cell.viewRef.dropShadow()
        cell.viewRef.layer.cornerRadius = 10
        let imgUrl = storyData[indexPath.row].reportLink
            cell.imgViewRef.sd_setImage(with: URL(string: imgUrl), placeholderImage: UIImage(named: "placeholder.png"))
        
        
        cell.imgViewRef.layer.cornerRadius = 10

        var BoxOn = UIImage(named: "checkedcircle")
        var BoxOff = UIImage(named: "circle")
        
        cell.checkBoxImgViewRef.image = BoxOff
        if buttonCounter.contains(indexPath.row){
            cell.checkBoxImgViewRef.image = BoxOn

        }
        else{
            cell.checkBoxImgViewRef.image = BoxOff

        }
        
        return cell
    }
    
    

    
    
}

extension PrescriptionListCollectionViewManager: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //self.viewCourse?(AppDelegate.shared.getStubCourse())
//        let vc = EventDetailsViewController.instantiate()
//        vc.eventId = storyData[indexPath.row].eventID ?? 0
//        pushDelegate?.pushViewController(vc: vc)
            
        if buttonCounter.contains(indexPath.row){
            let index = buttonCounter.firstIndex(of: indexPath.row)
            
            buttonCounter.remove(at: index!)
            collectionView.reloadItems(at: [indexPath])
        }
        else{
            buttonCounter.append(indexPath.row)
            collectionView.reloadItems(at: [indexPath])
        }

        if selectedPrescriptionId.contains(storyData[indexPath.row].pharmacyOutID){
            let index = selectedPrescriptionId.firstIndex(of: storyData[indexPath.row].pharmacyOutID)
            
            selectedPrescriptionId.remove(at: index!)
        }
        else{
            selectedPrescriptionId.append(storyData[indexPath.row].pharmacyOutID)
        }
        print(buttonCounter)

        print("Selected Prescription: \(selectedPrescriptionId)")
        
        selectedPresDelegate?.selectedPrescriptionIds(id: selectedPrescriptionId)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: (collectionView.bounds.width-25)/1.2, height: collectionView.bounds.height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
}
