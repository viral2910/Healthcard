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
        showPrescriptionList()
    }

    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
extension PrescriptionListVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func showPrescriptionList() {
        let vc = CustomPrescriptionListPopupVC.instantiate(arrData: ["","","","",""])
        vc.pushDelegate = self
        
        self.present(vc, animated: true)
        vc.completion = { result in
            switch result {
            case .add:
                
            print("Add button tap")
         
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
//            imgViewRef.image = pickedImage
            
            }
        picker.dismiss(animated: true, completion: nil)

        } else {
        if let pickedImage = info[.editedImage] as? UIImage {
        //imgViewRef.contentMode = .scaleAspectFill
        //imgViewRef.image = pickedImage
       
    }
    picker.dismiss(animated: true, completion: nil)
        }
}
}
