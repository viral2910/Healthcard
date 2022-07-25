//
//  ProcedureReportsVC.swift
//  HealthCard
//
//  Created by Viral on 13/07/22.
//

import UIKit

class ProcedureReportsVC: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var uploadDocumentBtnRef: UIButton!

    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    var isHeaderVisible = false
    var dataValue : [ProcedureReport] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        ApiCall()
        tableview.register(UINib(nibName: "LabReportsCell", bundle: nil), forCellReuseIdentifier: "LabReportsCell")
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorColor = .clear
        headerViewHeight.constant = isHeaderVisible ? 0 : 50
        uploadDocumentBtnRef.layer.cornerRadius = uploadDocumentBtnRef.bounds.height * 0.5
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func uploadDocumentBtnTapped(_ sender: UIButton) {
        showImagePicker()
    }
    
    func ApiCall() {
        
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.ProcedureReport(patientId: 189)) { [weak self](data: ProcedureReportReponse?, error) in
            guard self == self else { return }
            self?.dataValue = data!
            self?.tableview.reloadData()
            
        }
    }
    
    func uploadDocumentApiCall(file:String , fileType: String,fileExt:String , fileName: String){
        struct demo : Codable{
            
        }
        
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        
        NetWorker.shared.callAPIService(type: APIV2.ProcedureReportUpload(patientId: patientID, file: file, fileType: fileType, fileExt: fileExt, fileName: fileName)) { (data:PrescriptionUploadDataResponse?, error) in

            let status = data?.soapEnvelope?.soapBody?.selfPrescriptionUploadResponse?.selfPrescriptionUploadResult?.user?.status ?? ""
            let message = data?.soapEnvelope?.soapBody?.selfPrescriptionUploadResponse?.selfPrescriptionUploadResult?.user?.message ?? ""

            if status == "1" {
                UIAlertController.showAlert(titleString: message)
            }
            
        }
        
    }

    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}

extension ProcedureReportsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataValue.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LabReportsCell", for: indexPath) as! LabReportsCell
        cell.selectionStyle = .none
        cell.name.text = dataValue[indexPath.row].filename
        cell.date.text = "\(dataValue[indexPath.row].date) \(dataValue[indexPath.row].type)"
        cell.mainview.backgroundColor = .lightGray
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let value = dataValue[indexPath.row].reportLink.replacingOccurrences(of: " ", with: "%20")
        guard let url = URL(string: value) else {
            print(value)
            return //be safe
        }
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
        
    }
}

extension ProcedureReportsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    func showImagePicker() {
        let vc = CustomSelectPickImagePopUpVC.instantiate(title: "Upload Document", yesButtonTitle: "Select from Gallery", noButtonTitle: "Take a picture now")
        
        self.present(vc, animated: true)
        vc.completion = { result in
            switch result {
            case .selectFromGallery:
                self.openGallery()
            case .clickAPictureNow:
                self.openCamera()
            }
                
        }
    }
    
    @objc func selectImgTap()
    {
        
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
                alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
                    self.openCamera()
                }))

                alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
                    self.openGallery()
                }))

                alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))

                self.present(alert, animated: true, completion: nil)
    }


    func openCamera()
        {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerController.SourceType.camera
                imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
            else
            {
                let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }        }

    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if picker.sourceType == .camera {
            if let pickedImage = info[.originalImage] as? UIImage {
//            imgViewRef.contentMode = .scaleAspectFill
                
                let imageData = pickedImage.pngData()!
                let base64 = imageData.base64EncodedString()
                uploadDocumentApiCall(file: base64, fileType: "USG", fileExt: "png", fileName: randomString(length: 8))
                
            }
        picker.dismiss(animated: true, completion: nil)

        } else {
        if let pickedImage = info[.editedImage] as? UIImage {
        //imgViewRef.contentMode = .scaleAspectFill
       
            let imageData = pickedImage.pngData()!
            let base64 = imageData.base64EncodedString()
            uploadDocumentApiCall(file: base64, fileType: "USG", fileExt: "png", fileName: randomString(length: 8))

    }
    picker.dismiss(animated: true, completion: nil)
        }
}
    
}

struct ProcedureReport: Codable {
    let id, procDocID: Int
    let labTestDocID, labTestID, insuranceID, insuranceDocID: JSONNull?
    let insuranceName: JSONNull?
    let patientID: String
    let patientDocID, patientName, refUnitID, refUnitDocID: JSONNull?
    let refUnitName, userID, userDocID, userName: JSONNull?
    let doctorID, doctorDocID, doctorName, bankID: JSONNull?
    let bankDocID, bankName, pharmacyID, pharmacyDocID: JSONNull?
    let pharmacyName, laboratoryID, laboratoryDocID, laboratoryName: JSONNull?
    let deliveryBoyID, deliveryBoyDocID, deliveryBoyName, pharmacyOutDocID: JSONNull?
    let pharmacyOutID: JSONNull?
    let type, date, filename: String
    let displayFilename: JSONNull?
    let filePath: String
    let fileEXT: FileEXT
    let uploadFileName: String
    let createdBy: CreatedBy
    let createdOn: String
    let updatedBy, updatedOn, orgFile, currUser: JSONNull?
    let investigationAdviseID, isEdit: JSONNull?
    let reportLink: String
    
    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case procDocID = "ProcDocId"
        case labTestDocID = "LabTestDocId"
        case labTestID = "LabTestId"
        case insuranceID = "InsuranceId"
        case insuranceDocID = "InsuranceDocId"
        case insuranceName = "InsuranceName"
        case patientID = "PatientId"
        case patientDocID = "PatientDocId"
        case patientName = "PatientName"
        case refUnitID = "RefUnitId"
        case refUnitDocID = "RefUnitDocId"
        case refUnitName = "RefUnitName"
        case userID = "UserId"
        case userDocID = "UserDocId"
        case userName = "UserName"
        case doctorID = "DoctorId"
        case doctorDocID = "DoctorDocId"
        case doctorName = "DoctorName"
        case bankID = "BankId"
        case bankDocID = "BankDocId"
        case bankName = "BankName"
        case pharmacyID = "PharmacyId"
        case pharmacyDocID = "PharmacyDocId"
        case pharmacyName = "PharmacyName"
        case laboratoryID = "LaboratoryId"
        case laboratoryDocID = "LaboratoryDocId"
        case laboratoryName = "LaboratoryName"
        case deliveryBoyID = "DeliveryBoyId"
        case deliveryBoyDocID = "DeliveryBoyDocId"
        case deliveryBoyName = "DeliveryBoyName"
        case pharmacyOutDocID = "PharmacyOutDocId"
        case pharmacyOutID = "PharmacyOutId"
        case type = "Type"
        case date = "Date"
        case filename = "Filename"
        case displayFilename = "DisplayFilename"
        case filePath = "FilePath"
        case fileEXT = "FileExt"
        case uploadFileName = "UploadFileName"
        case createdBy = "CreatedBy"
        case createdOn = "CreatedOn"
        case updatedBy = "UpdatedBy"
        case updatedOn = "UpdatedOn"
        case orgFile = "OrgFile"
        case currUser = "CurrUser"
        case investigationAdviseID = "InvestigationAdviseId"
        case isEdit = "IsEdit"
        case reportLink = "ReportLink"
    }
}

enum CreatedBy: String, Codable {
    case dipikaJadhav = "DIPIKA JADHAV"
    case drAjitaBhise = "DR AJITA BHISE"
    case rakshitaShetty = "RAKSHITA SHETTY"
    case superAdmin = "SUPER ADMIN"
}

enum FileEXT: String, Codable {
    case jpg = ".jpg"
    case pdf = ".pdf"
    case png = ".png"
}

typealias ProcedureReportReponse = [ProcedureReport]
