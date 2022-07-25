//
//  Finance.swift
//  HealthCard
//
//  Created by Dhairya on 29/04/22.
//

import UIKit

class FinanceVC: UIViewController, XIBed {
    
var array = ["OPD Consultation Building" , "Estimate Advance Billing" , "Procedure Billing" , "Lab Receipt" , "Pharmacy Receipt"]
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var homeBtn: UIButton!
    @IBOutlet weak var pencilBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FinanceCell", bundle: nil), forCellReuseIdentifier: "FinanceCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = .clear
        homeBtn.setTitle("", for: .normal)
        pencilBtn.setTitle("", for: .normal)

    }
    
    @IBAction func homeAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension FinanceVC: UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FinanceCell", for: indexPath)as! FinanceCell
        cell.financeDataLbl.text = array[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
            
        case 0:
            let vc = UIStoryboard.Finance.controller(withClass: OPDconultationBilling.self)
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            let vc = UIStoryboard.Finance.controller(withClass: AdvanceBillingVC.self)
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            let vc = UIStoryboard.Finance.controller(withClass: ProcedureBillingVC.self)
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 3:
            let vc = UIStoryboard.Finance.controller(withClass: LabTestReceiptVc.self)
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 4:
            let vc = UIStoryboard.Finance.controller(withClass: PharmacyReceiptVC.self)
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
            
        }
    }
}
