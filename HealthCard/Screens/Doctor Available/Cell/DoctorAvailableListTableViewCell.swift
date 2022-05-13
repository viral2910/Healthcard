//
//  DoctorAvailableListTableViewCell.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 07/05/22.
//

import UIKit

class DoctorAvailableListTableViewCell: UITableViewCell {
    @IBOutlet weak var viewRef: UIView!
    @IBOutlet weak var imgViewRef: UIImageView!
    @IBOutlet weak var imgViewBgViewRef: UIView!
    @IBOutlet weak var nameLblRef: UILabel!
    @IBOutlet weak var degreeLblRef: UILabel!
    @IBOutlet weak var descLblRef: UILabel!
    @IBOutlet weak var totalExpLblRef: UILabel!
    @IBOutlet weak var feeLblRef: UILabel!
    @IBOutlet weak var consultNowBtnRef: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
