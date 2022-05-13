//
//  MyConsultation.swift
//  HealthCard
//
//  Created by Dhairya on 29/04/22.
//

import UIKit

class MyConsultation: UIViewController, XIBed {

    @IBOutlet weak var tableView: UITableView!
    var dataValue = [Consultation]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorColor = .clear
        tableView.register(UINib(nibName: "MyConsultationCell", bundle: nil), forCellReuseIdentifier: "MyConsultationCell")
        tableView.delegate = self
        tableView.dataSource = self
        apiCall()
    }
    @IBAction func backBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension MyConsultation{

    //MARK: - API CALL
    func apiCall()  {
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.consultationList(patientID: patientID)) { [weak self](data: [Consultation]?, error) in
                self?.dataValue = data!
                self?.tableView.reloadData()
               // print(patientIDval)
        }
    }
}

extension MyConsultation: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyConsultationCell", for: indexPath)as! MyConsultationCell
        cell.consultDateLbl.text = dataValue[indexPath.row].bookDate
        cell.FromTimeLbl.text = dataValue[indexPath.row].fromTime
        cell.ToTimeLbl.text = dataValue[indexPath.row].toTime
        cell.DocNameLbl.text = dataValue[indexPath.row].doctorName
        cell.paymentMethodLbl.text = dataValue[indexPath.row].paymentMethod
        cell.paymentAmtLbl.text = dataValue[indexPath.row].paymentAmount
        cell.getInvoiceBtn.tag = indexPath.row
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataValue.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
extension MyConsultation:consultationDelegate {
    func getInvoiceFunction(value: Int) {
        guard let url = URL(string: dataValue[value].onlineConsultationInvoiceLink) else {
          return //be safe
        }

        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
}

// MARK: - WelcomeElement
struct Consultation: Codable {
    let onlineConsultationPaymentID, patientID: String
    let patientName: JSONNull?
    let doctorID, doctorName, bookDate, fromTime: String
    let toTime: String
    let paymentID: JSONNull?
    let paymentAmount, paymentMethod: String
    let status, message: JSONNull?
    let onlineConsultationInvoiceLink: String

    enum CodingKeys: String, CodingKey {
        case onlineConsultationPaymentID = "OnlineConsultationPaymentId"
        case patientID = "PatientId"
        case patientName = "PatientName"
        case doctorID = "DoctorId"
        case doctorName = "DoctorName"
        case bookDate = "BookDate"
        case fromTime = "FromTime"
        case toTime = "ToTime"
        case paymentID = "PaymentId"
        case paymentAmount = "PaymentAmount"
        case paymentMethod = "PaymentMethod"
        case status = "Status"
        case message = "Message"
        case onlineConsultationInvoiceLink = "OnlineConsultationInvoiceLink"
    }
}

typealias Welcomecon = [Consultation]


