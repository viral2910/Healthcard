//
//  PrescriptionListVC.swift
//  HealthCard
//
//  Created by Viral on 19/05/22.
//
import UIKit

class PrescriptionListVC: UIViewController,XIBed,PushViewControllerDelegate {
    
    var selectedvalue = 0
    var pincode = ""
    var labInvestigation = ""
    var docId = ""
    var docType = ""
    var addressReq = false
    var selectedPrescriptionId: [Int] = []

    @IBOutlet weak var selectedID: UILabel!
    @IBOutlet weak var selectedPrescriptiomImageViewRef: UIImageView!
    
    weak var pushDelegate: PushViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func cameraAction(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        showImagePicker()
    }
    
    @IBAction func prescriptionAction(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
        ApiCall()
    }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension PrescriptionListVC {
    
    func ApiCall() {
        struct demo: Codable { }
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        NetWorker.shared.callAPIService(type: APIV2.prescriptionList(patientID: patientID)) { [weak self](data: PatientPrescriptionResponseData?, error) in
            self!.showPrescriptionList(data: data ?? [])
        }
    }
    
    func uploadPrescriptionApiCall(docId: String,file:String , docType: String,fileExt:String , fileName: String){
        struct demo : Codable{
            
        }
        
        let patientID = Int(UserDefaults.standard.string(forKey: "patientID") ?? "") ?? 0
        
        NetWorker.shared.callAPIService(type: APIV2.SelfPrescriptionUpload(patientId: patientID, docId: docId, file: file, docType: docType, fileExt: fileExt, fileName: fileName)) { (data:PrescriptionUploadDataResponse?, error) in

            let status = data?.soapEnvelope?.soapBody?.selfPrescriptionUploadResponse?.selfPrescriptionUploadResult?.user?.status ?? ""

            if status == "1" {
                self.ApiCall()
            }
            
        }
        
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
}
extension PrescriptionListVC: GetSelectedPrescriptionId {
    func selectedPrescriptionIds(id: [Int], imageUrl: String) {
        print("DelegatePresId: \(id)")
        selectedID.text = "Selected ID : \(id)"
        selectedPrescriptionId = id
        self.selectedPrescriptiomImageViewRef.sd_setImage(with: URL(string: imageUrl), placeholderImage: UIImage(named: "placeholder.png"))

    }
    
    
}

extension PrescriptionListVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showPrescriptionList(data: PatientPrescriptionResponseData) {
        let vc = CustomPrescriptionListPopupVC.instantiate(arrData: data)
        vc.pushDelegate = self
        vc.selectedPresIdDelegate = self
        self.present(vc, animated: true)
        vc.completion = { result in
            switch result {
            case .add:
                let vc = LabDetailsVC.instantiate()
                vc.pincode = self.pincode
                vc.docId = self.docId
                vc.labInvestigation = self.labInvestigation
                vc.docType = self.docType
                vc.presciptionID = "\(self.selectedPrescriptionId[0])"
                vc.isMedicine = true
                self.navigationController?.pushViewController(vc, animated: true)
                //            print("Add button tap\(data)")
                
            }
            
        }
    }
    
    func showImagePicker() {
        let vc = CustomSelectPickImagePopUpVC.instantiate(title: "Upload a picture", yesButtonTitle: "Select from Gallery", noButtonTitle: "Take a picture now")
        
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
                self.selectedPrescriptiomImageViewRef.image = pickedImage
                
                let imageData = pickedImage.pngData()!
                let base64 = imageData.base64EncodedString()
                uploadPrescriptionApiCall(docId: docId, file: base64, docType: "Self Prescription", fileExt: "png", fileName: randomString(length: 8))
            
            }
        picker.dismiss(animated: true, completion: nil)

        } else {
        if let pickedImage = info[.editedImage] as? UIImage {
        //imgViewRef.contentMode = .scaleAspectFill
            self.selectedPrescriptiomImageViewRef.image = pickedImage
       
            let imageData = pickedImage.pngData()!
            let base64 = imageData.base64EncodedString()
            uploadPrescriptionApiCall(docId: docId, file: base64, docType: "Self Prescription", fileExt: "png", fileName: randomString(length: 8))

    }
    picker.dismiss(animated: true, completion: nil)
        }
}
    
}

// MARK: - PatientPrescriptionResponseDatum
struct PatientPrescriptionResponseDatum: Codable {
    let id: Int
    let procDocID, labTestDocID, labTestID, insuranceID: JSONNull?
    let insuranceDocID, insuranceName: JSONNull?
    let patientID: String
    let patientDocID, patientName, refUnitID, refUnitDocID: JSONNull?
    let refUnitName, userID, userDocID, userName: JSONNull?
    let doctorID, doctorDocID, doctorName, bankID: JSONNull?
    let bankDocID, bankName, pharmacyID, pharmacyDocID: JSONNull?
    let pharmacyName, laboratoryID, laboratoryDocID, laboratoryName: JSONNull?
    let deliveryBoyID, deliveryBoyDocID, deliveryBoyName, pharmacyOutDocID: JSONNull?
    let pharmacyOutID: Int
    let type: String
    let date, filename: String
    let displayFilename: JSONNull?
    let filePath: String
    let fileEXT: String
    let uploadFileName: String
    let createdBy, createdOn, updatedBy, updatedOn: JSONNull?
    let orgFile, currUser, investigationAdviseID, isEdit: JSONNull?
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

typealias PatientPrescriptionResponseData = [PatientPrescriptionResponseDatum]

// MARK: - PrescriptionUploadDataResponse
struct PrescriptionUploadDataResponse: Codable {
    let soapEnvelope: PrescriptionUploadSoapEnvelope?

    enum CodingKeys: String, CodingKey {
        case soapEnvelope = "soap:Envelope"
    }
}

// MARK: - SoapEnvelope
struct PrescriptionUploadSoapEnvelope: Codable {
    let xmlnsXSD, xmlnsSoap, xmlnsXsi: String?
    let soapBody: PrescriptionUploadSoapBody?

    enum CodingKeys: String, CodingKey {
        case xmlnsXSD = "_xmlns:xsd"
        case xmlnsSoap = "_xmlns:soap"
        case xmlnsXsi = "_xmlns:xsi"
        case soapBody = "soap:Body"
    }
}

// MARK: - SoapBody
struct PrescriptionUploadSoapBody: Codable {
    let selfPrescriptionUploadResponse: SelfPrescriptionUploadResponse?

    enum CodingKeys: String, CodingKey {
        case selfPrescriptionUploadResponse = "SelfPrescriptionUploadResponse"
    }
}

// MARK: - SelfPrescriptionUploadResponse
struct SelfPrescriptionUploadResponse: Codable {
    let xmlns: String?
    let selfPrescriptionUploadResult: SelfPrescriptionUploadResult?

    enum CodingKeys: String, CodingKey {
        case xmlns = "_xmlns"
        case selfPrescriptionUploadResult = "SelfPrescriptionUploadResult"
    }
}

// MARK: - SelfPrescriptionUploadResult
struct SelfPrescriptionUploadResult: Codable {
    let user: PrescriptionUploadUser?

    enum CodingKeys: String, CodingKey {
        case user = "User"
    }
}

// MARK: - User
struct PrescriptionUploadUser: Codable {
    let message, status: String?

    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case status = "Status"
    }
}
