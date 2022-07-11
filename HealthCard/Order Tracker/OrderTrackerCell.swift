//
//  OrderTrackerCell.swift
//  HealthCard
//
//  Created by Viral on 17/06/22.
//

import UIKit

protocol TrackOnMap {
    func getId(value : Int)
}
class OrderTrackerCell: UITableViewCell {

    @IBOutlet weak var viewonmapBtn: UIButton!
    @IBOutlet weak var mainview: UIView!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var orderStatusLabel: UILabel!
    @IBOutlet weak var orderNoLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var sellerNameLabel: UILabel!
    @IBOutlet weak var orderAmtLabel: UILabel!
    @IBOutlet weak var paymentModeLabel: UILabel!
    @IBOutlet weak var qtyLabel: UILabel!
    @IBOutlet weak var pricePerUnitLabel: UILabel!
    @IBOutlet weak var deliveryPinCodeLabel: UILabel!
    @IBOutlet weak var getInvoiceBtn: UIButton!
    @IBOutlet weak var getSummaryBtn: UIButton!
    var invoiceurl = ""
    var summaryurl = ""
    var delegate : TrackOnMap!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if orderStatusLabel.text == "Delivered" {
            getInvoiceBtn.isHidden = false
        } else {
            getInvoiceBtn.isHidden = true
        }
        
        getInvoiceBtn.layer.borderColor = UIColor.lightGray.cgColor
        getInvoiceBtn.layer.borderWidth = 1
        getInvoiceBtn.layer.cornerRadius = 20
        
        getSummaryBtn.layer.borderColor = UIColor.lightGray.cgColor
        getSummaryBtn.layer.borderWidth = 1
        getSummaryBtn.layer.cornerRadius = 20
        mainview.layer.cornerRadius = 10
        mainview.dropShadow()
        // Initialization code
    }
    @IBAction func viewonmapAction(_ sender: UIButton) {
        print(sender.tag)
        delegate?.getId(value: sender.tag)
    }
    
    @IBAction func getOrderSummaryAction(_ sender: UIButton) {
        
        guard let url = URL(string:  summaryurl) else {
          return //be safe
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    @IBAction func getInvoiceAction(_ sender: UIButton) {
        
        guard let url = URL(string:  invoiceurl) else {
          return //be safe
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
