//
//  LookForTestCollectionViewCell.swift
//  HealthCard
//
//  Created by Pratik on 09/04/22.
//

import UIKit

class LookForTestCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var viewRef: UIView!
    @IBOutlet weak var lblRef: UILabel!
    @IBOutlet weak var imgViewRef: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        lblRef.adjustsFontSizeToFitWidth = true
//        lblRef.minimumScaleFactor = 0.2
//        lblRef.numberOfLines = 2 // or 1

    }

}
