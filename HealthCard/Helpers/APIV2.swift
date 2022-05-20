//
//  APIV2.swift
//  Level
//
//  Created by Pratik on 21/12/21.
//

import Foundation
import UIKit

struct BaseUrls {
    static var current: String {
        return v2
    }
    
    static var v2 = "https://nimayatecs.in/rotary_alpha_3141/public/api/"//"https://level-meditationv3-xbvmavvhka-uc.a.run.app/v1/"
}

enum APIV2: API {
    case doctorDetailsBySpecialize(id: Int)
    
    case doctorOnlineConsultScheduleByDoctor(doctorId: Int, date: String)
    
    case doctorOnlineConsultPaymentDetailsSave(doctorId: Int, patientId: Int, bookDate: String, fromTime: String, toTime: String, paymentId: Int, paymentAmount: Int, paymentMethod: String)
    
    case patientOnlineConsultScheduleDetails(patientId: Int)
    
    case concernDetailsList
    
    case orderInvoice(orderId: Int, sellerMasterId: Int, sellerType: String)
    
    case PatientDocumentUpload(patientId: Int, fileType: String, file: String, fileName: String, fileExt: String)
    
    case PatientPrescriptionHistoryGetById(patientId: Int)
    
    case SelfPrescriptionUpload(patientId: Int, docId: String, file: String, docType: String, fileExt: String, fileName: String)
    
    case ProcedureReportUpload(patientId: Int, file: String, fileType: String, fileExt: String, fileName: String)
    
    case ProcedureReportReUpload(patientId: Int, docId: String, file: String, fileType: String, fileExt: String, fileName: String)
    
    case LabTestReportUpload(patientId: Int, fileType: String, file: String, fileName: String, fileExt: String)
    
    case LabTestReportReUpload(labTestDocId: Int, patientId: Int, fileType: String, file: String, fileName: String, fileExt: String)
    
    case PatientDocumentReUpload(patientDocId: Int ,patientId: Int, fileType: String, file: String, fileName: String, fileExt: String)
    
    case GetAllPharmacyAdvice(searchValue: String)
    
    case patientRegistration(titleId: Int, firstName: String, lastName: String, mobileNo: String, password: String, gender: String, pincode: String)
    
    case OrderDtlsGetByOrderStatus(patientId: Int, orderStatus: String)
    
    case OTPAuthentication(mobileNo: String, subject: String, otpNo: Int, firebaseToken: String)
    
    case PatientHistGetById(patientID: Int)
    
    case PatientLogin(mobileNo: String, password: String, firebaseToken: String)
    
    case CommonDataGetByType(type: String)
    
    case TitleGetByTitleType(titleType: String)
    
    case GetAllLabTestInvestigation(searchValue: String)
    
    case PatientProfileUpload(patientId: Int, file: String, fileExt: String)
    
    case PatientGetById(patientId: Int)
    
    case SelfPrescriptionAdviceSave(patientId: Int, genInvest: Int)
    
    case ViewPharmacyChargesDtlsGetByMedicineId(pincode: String, medicineId: Int, docId: Int, docType: String)
    
    case RefreshCart(patientId: Int)

    case DeliveryBoyRegistration(mobileNo: String)
    
    case Qualification
    
    case State(pld: Int)
    
    case City(pld: Int)
    
    case deliveryBoyProfileDetails(deliveryBoyId: Int)
    
    case deliveryBoyOtpAuthentication(mobileNo: String, otp: Int)

    case deliveryBoyProfileUpdate(deliveryBoyId: Int, firstName: String, middleName: String, lastName: String, emailId: String, dob: String, gender: String, bloodGrpId: Int, qualificationId: Int, martialStatus: String, aadharNo: String, address: String, countryId: Int, stateId: Int, cityId: Int, mobileNo1: String, mobileNo2: String, doj: String, jobType: String, panNo: String, leaveEntitlement: Int, bankName: String, accountNo: String, ifscCode: String, pfDate: String, pfNumber: String, isActive: Int)

    case deliveryBoyDocumentList(deliveryBoyId: Int)
    
    case orderPickUpUpdate(orderId: Int, deliveryBoyId: Int, deliveryBoyLatitude: Double, deliveryBoyLongitude: Double)

    case patientDeliveryOtpGeneration(mobileNo: String)
    
    case patientDeliveryOtpAuthentication(mobileNo: String, otp: Int)
    
    case patientDeliveryOrderUpdate(deliverOrderId: Int, deliveryBoyId: Int)
    
    case deliverOrderList(deliveryBoyId: Int)
    
    case orderAcceptUpdate(upcomingOrderId: Int, deliveryBoyId: Int)
    
    case pendingOrderList(deliveryBoyId: Int)
    
    case upcomingOrderList(upcomingOrderDeliveryBoyId: Int)

    case patientOrderDetails(orderByPatientId: Int)
    
    case deliveryBoyOrderCount(deliveryBoyId: Int)
    
    case patientLatAndLngUpdate(orderId: Int, lat: Double, lng: Double)
    
    case rejectOrderUpdate(orderId: Int,deliveryBoyId: Int)
    
    case orderCashCollectionUpdate(cashCollectedOrderId: Int,deliveryBoyId: Int)
    
    case rejectedOrderList(deliveryBoyId: Int)
    
    case orderMapCordinates(orderId: Int)
    
    case orderPayableAmount(orderId: Int)
    
    case deliveryBoyLatAndLngUpdate(orderId: Int, lat: Double, lng: Double)

    case selfPrescriptionList(patientId: Int)
    
    case talukaByPincode(pincode: String)
    
    case areaGetByPincodeAndTaluka(pincode: String, taluka: String)
    
    case pharmacyPaidReceipt(pharmPatientId: Int)
    
    case patientPasswordChange(patientId: Int, oldPassword: String, newPassword: String)
    
    case patientMobileNoValidation(mobileNo1: String)
    
    case Specialization
    
    case Symptoms
    
    case FrequentSpeciality
    
    case SymptomsSearching(searchVal: String)
    
    case PatientConcernSave(patientId: Int, concernId: Int, concernDesc: String)
    
    case PatientLabTestReports(patientId: Int)
    
    case PatientLabTestDetails(patientId: Int)
    
    case PatientProcedureReports(patientId: Int)
    
    case PatientLabTestAdviceDetails(patientId: Int)
    
    case PatientMedicineDetails(patientId: Int)

    case labTestSearch(searchVal: String)
    
    case medicineAndEssential(searchVal: String)

    case PatientPharmacyAdviceDetails(patientId: Int)

    case FrequentLabTest
    
    case FrequentMedicine
    
    case MyPrescription(patientId: Int)
    
    case LabTestReceipt(patientId: Int)
    
    case procedureBilling(patientID: Int)
    
    case addressPatient(patientID: Int)
    
    case consultationList(patientID: Int)
    
    case myOrderList(patientID: Int)
    
    case myCartList(patientID: Int)
    
    case OPDBillingList(patientID: Int)
    
    case estimateAdvanceBillingList(patientID: Int)
    
    case pharmacyReceiptList(patientID: Int)

    case cartRefresh(patientID: Int)
    
    case pathologyLabList(pincode: String,labInvestigation:String,docId:String,docType:String)
    
    case addLabToCart(patientID: Int,addressID:Int,labMasterID:Int,pincode: String,labInvestigation:String,docId:String,docType:String,qty:Int)
    
    case addPharmacyToCart(patientID: Int,addressID:Int,labMasterID:Int,pincode: String,labInvestigation:String,docId:String,docType:String,qty:Int)
    
    case cartRemove(cartID:Int)
    
    case prescriptionList(patientID: Int)
    
    case pharmacyList(pincode: String,labInvestigation:String,docId:String,docType:String)
    
    case cartUpdate(cartID:Int,qty:Int)
    
}



extension APIV2 {
    var baseURL: URL {
        switch self {
        case .doctorDetailsBySpecialize:
            return URL(string: Router.doctorBaseUrl)!
            
        case .doctorOnlineConsultScheduleByDoctor:
            return URL(string: Router.doctorBaseUrl)!
            
        case .doctorOnlineConsultPaymentDetailsSave:
            return URL(string: Router.doctorBaseUrl)!
            
        case .patientOnlineConsultScheduleDetails:
            return URL(string: Router.doctorBaseUrl)!
            
        case .concernDetailsList:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .orderInvoice:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .PatientDocumentUpload:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .PatientPrescriptionHistoryGetById:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .SelfPrescriptionUpload:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .ProcedureReportUpload:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .ProcedureReportReUpload:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .LabTestReportUpload:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .LabTestReportReUpload:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .PatientDocumentReUpload:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .GetAllPharmacyAdvice:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .patientRegistration:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .OrderDtlsGetByOrderStatus:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .OTPAuthentication:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .PatientHistGetById:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .PatientLogin:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .CommonDataGetByType:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .TitleGetByTitleType:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .GetAllLabTestInvestigation:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .PatientProfileUpload:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .PatientGetById:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .SelfPrescriptionAdviceSave:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .ViewPharmacyChargesDtlsGetByMedicineId:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .RefreshCart:
            return URL(string: Router.webServiceBaseUrl)!
            
        case .DeliveryBoyRegistration:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .Qualification:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .State:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .City:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .deliveryBoyProfileDetails:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .deliveryBoyOtpAuthentication:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .deliveryBoyProfileUpdate:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .deliveryBoyDocumentList:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .orderPickUpUpdate:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .patientDeliveryOtpGeneration:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .patientDeliveryOtpAuthentication:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .patientDeliveryOrderUpdate:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .deliverOrderList:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .orderAcceptUpdate:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .pendingOrderList:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .upcomingOrderList:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .patientOrderDetails:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .deliveryBoyOrderCount:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .patientLatAndLngUpdate:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .rejectOrderUpdate:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .orderCashCollectionUpdate:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .rejectedOrderList:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .orderMapCordinates:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .orderPayableAmount:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .deliveryBoyLatAndLngUpdate:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .selfPrescriptionList:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .talukaByPincode:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .areaGetByPincodeAndTaluka:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .pharmacyPaidReceipt:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .patientPasswordChange:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .patientMobileNoValidation:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .Specialization:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .Symptoms:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .FrequentSpeciality:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .SymptomsSearching:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .PatientConcernSave:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .PatientLabTestReports:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .PatientLabTestDetails:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .PatientProcedureReports:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .PatientLabTestAdviceDetails:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .labTestSearch:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .medicineAndEssential:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .PatientPharmacyAdviceDetails:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .FrequentLabTest:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .FrequentMedicine:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .MyPrescription:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .LabTestReceipt:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .procedureBilling:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .addressPatient:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .consultationList:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .myOrderList:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .myCartList:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .OPDBillingList:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .estimateAdvanceBillingList:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .pharmacyReceiptList:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .PatientMedicineDetails:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .cartRefresh:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .pathologyLabList:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .addLabToCart:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .addPharmacyToCart:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .cartRemove:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .prescriptionList:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .pharmacyList:
            return URL(string: Router.deliveryBoyBaseUrl)!
            
        case .cartUpdate:
            return URL(string: Router.deliveryBoyBaseUrl)!
        }
        
    }
    
    var path: String {
        switch self {
        case .doctorDetailsBySpecialize(let id):
            return "SpecializationId=\(id)"
            
        case .doctorOnlineConsultScheduleByDoctor(let doctorId, let date):
            return "ConsultDoctorId=\(doctorId)&vConsultDate=\(date)"
            
        case .doctorOnlineConsultPaymentDetailsSave(let doctorId, let patientId, let bookDate, let fromTime, let toTime, let paymentId, let paymentAmount, let paymentMethod):
            return "PatientId=\(patientId)&vDoctorId=\(doctorId)&vBookDate=\(bookDate)vFromTime=\(fromTime)&vToTime=\(toTime)&vPaymentId=\(paymentId)&vPaymentAmount=\(paymentAmount)&vPaymentMethod=\(paymentMethod)"
            
        case .patientOnlineConsultScheduleDetails(let patientId):
            return "PatientId=\(patientId)"
            
        case .concernDetailsList:
            return "=ConcernDtlsList"
            
        case .orderInvoice:
            return "=OrderInvoiceReport"
            
        case .PatientDocumentUpload:
            return "=PatientDocumentUpload"
            
        case .PatientPrescriptionHistoryGetById:
            return "=PatientPrescriptionHistoryGetById"
            
        case .SelfPrescriptionUpload:
            return "=SelfPrescriptionUpload"
            
        case .ProcedureReportUpload:
            return "=ProcedureReportUpload"
            
        case .ProcedureReportReUpload:
            return "=ProcedureReportReUpload"
            
        case .LabTestReportUpload:
            return "=LabTestReportUpload"
            
        case .LabTestReportReUpload:
            return "=LabTestReportReUpload"
            
        case .PatientDocumentReUpload:
            return "=PatientDocumentReUpload"
            
        case .GetAllPharmacyAdvice:
            return "=GetAllPharmacyAdvice"
            
        case .patientRegistration:
            return "=SavePatient"
            
        case .OrderDtlsGetByOrderStatus:
            return "=OrderDtlsGetByOrderStatus"
            
        case .OTPAuthentication:
            return "=OTPAuthentication"
            
        case .PatientHistGetById(patientID: let patientId):
            return "HealthHistory?vPatientHistId=\(patientId)"
            
        case .PatientLogin:
            return "=PatientLogin"
            
        case .CommonDataGetByType:
            return "=CommonDataGetByType"
            
        case .TitleGetByTitleType:
            return "=TitleGetByTitleType"
            
        case .GetAllLabTestInvestigation:
            return "=GetAllLabTestInvestigation"
            
        case .PatientProfileUpload:
            return "=PatientProfileUpload"
            
        case .PatientGetById:
            return "=PatientGetById"
            
        case .SelfPrescriptionAdviceSave:
            return "=SelfPrescriptionAdviceSave"
            
        case .ViewPharmacyChargesDtlsGetByMedicineId:
            return "=ViewPharmacyChargesDtlsGetByMedicineId"
            
        case .RefreshCart:
            return "=RefreshCart"
            
        case .DeliveryBoyRegistration(mobileNo: let mobileNo):
            return "Common?vMobileNo=\(mobileNo)&vSubject=DeliveryBoyRegistration"
            
        case .Qualification:
            return "Common?vType=Qualification"
            
        case .State(pld: let pld):
            return "Common?vType=State&vPId=\(pld)"
            
        case .City(pld: let pld):
            return "Common?vType=City&vPId=\(pld)"
            
        case .deliveryBoyProfileDetails(deliveryBoyId: let deliveryBoyId):
            return "DeliveryBoy?vDeliveryBoyId=\(deliveryBoyId)"
            
        case .deliveryBoyOtpAuthentication(mobileNo: let mobileNo, otp: let otp):
            return "Common?vMobileNo=\(mobileNo)&vSubject=DeliveryBoyLogin&vOtpNo=\(otp)&vFireBaseToken="
            
        case .deliveryBoyProfileUpdate(deliveryBoyId: let deliveryBoyId, firstName: let firstName, middleName: let middleName, lastName: let lastName, emailId: let emailId, dob: let dob, gender: let gender, bloodGrpId: let bloodGrpId, qualificationId: let qualificationId, martialStatus: let martialStatus, aadharNo: let aadharNo, address: let address, countryId: let countryId, stateId: let stateId, cityId: let cityId, mobileNo1: let mobileNo1, mobileNo2: let mobileNo2, doj: let doj, jobType: let jobType, panNo: let panNo, leaveEntitlement: let leaveEntitlement, bankName: let bankName, accountNo: let accountNo, ifscCode: let ifscCode, pfDate: let pfDate, pfNumber: let pfNumber, isActive: let isActive):
            return "DeliveryBoy?vDeliveryBoyId=\(deliveryBoyId)&vFirstName=\(firstName)&vMiddleName=\(middleName)&vLastName=\(lastName)&vEmailId=\(emailId)&vDOB=\(dob)&vGender=\(gender)&vBloodGroupId=\(bloodGrpId)&vQualificationId=\(qualificationId)&vMartialStatus=\(martialStatus)&vAadharNo=\(aadharNo)&vAddress=\(address)&vCountryId=\(countryId)&vStateId=\(stateId)&vCityId=\(cityId)&vMobileNo1=\(mobileNo1)&vMobileNo2=\(mobileNo2)&vDOJ=\(doj)&vJobType=\(jobType)&vPANNo=\(panNo)&vLeaveEntitlement=\(leaveEntitlement)&vBankName=\(bankName)&vAccountNo=\(accountNo)&vIFSCCode=\(ifscCode)&vPFDate=\(pfDate)&vPFNumber=\(pfNumber)&vIsActive=\(isActive)"
            
        case .deliveryBoyDocumentList(deliveryBoyId: let deliveryBoyId):
            return "DeliveryBoy?DeliveryBoyId=\(deliveryBoyId)"
            
        case .orderPickUpUpdate(orderId: let orderId, deliveryBoyId: let deliveryBoyId, deliveryBoyLatitude: let deliveryBoyLatitude, deliveryBoyLongitude: let deliveryBoyLongitude):
            return "DeliveryBoy?vOrderId=\(orderId)&vDeliveryBoyId=\(deliveryBoyId)&vDeliveryBoyLatitude=\(deliveryBoyLatitude)&vDeliveryBoyLongitude=\(deliveryBoyLongitude)"
            
        case .patientDeliveryOtpGeneration(mobileNo: let mobileNo):
            return "Common?vSubject=PatientOrderDelivery&vMobileNo=\(mobileNo)"
            
        case .patientDeliveryOtpAuthentication(mobileNo: let mobileNo, otp: let otp):
            return "Common?vSubject=PatientOrderDelivery&vMobileNo=\(mobileNo)&vOtpNo=\(otp)"
            
        case .patientDeliveryOrderUpdate(deliverOrderId: let deliverOrderId, deliveryBoyId: let deliveryBoyId):
            return "DeliveryBoy?vDeliverOrderId=\(deliverOrderId)&vDeliveryBoyId=\(deliveryBoyId)"
            
        case .deliverOrderList(deliveryBoyId: let deliveryBoyId):
            return "DeliveryBoy?vDeliverOrderDeliveryBoyId=\(deliveryBoyId)"
            
        case .orderAcceptUpdate(upcomingOrderId: let upcomingOrderId, deliveryBoyId: let deliveryBoyId):
            return "DeliveryBoy?vUpcomingOrderId=\(upcomingOrderId)&vDeliveryBoyId=\(deliveryBoyId)"
            
        case .pendingOrderList(deliveryBoyId: let deliveryBoyId):
            return "DeliveryBoy?vOrderDeliveryBoyId=\(deliveryBoyId)"
            
        case .upcomingOrderList(upcomingOrderDeliveryBoyId: let upcomingOrderDeliveryBoyId):
            return "DeliveryBoy?vUpcomingOrderDeliveryBoyId=\(upcomingOrderDeliveryBoyId)"
            
        case .patientOrderDetails(orderByPatientId: let orderByPatientId):
            return "Patient?vOrderByPatientId=\(orderByPatientId)"
            
        case .deliveryBoyOrderCount(deliveryBoyId: let deliveryBoyId):
            return "DeliveryBoy?vCountDeliveryBoyId=\(deliveryBoyId)"
            
        case .patientLatAndLngUpdate(orderId: let orderId, lat: let lat, lng: let lng):
            return "DeliveryBoy?vOrderId=\(orderId)&vLatitude=\(lat)&vLongitude=\(lng)"
            
        case .rejectOrderUpdate(orderId: let orderId, deliveryBoyId: let deliveryBoyId):
            return "DeliveryBoy?vRejectOrderId=\(orderId)&vDeliveryBoyId=\(deliveryBoyId)"
            
        case .orderCashCollectionUpdate(cashCollectedOrderId: let cashCollectedOrderId, deliveryBoyId: let deliveryBoyId):
            return "DeliveryBoy?vCashCollectOrderId=\(cashCollectedOrderId)&vDeliveryBoyId=\(deliveryBoyId)"
            
        case .rejectedOrderList(deliveryBoyId: let deliveryBoyId):
            return "vRejectOrderDeliveryBoyId=\(deliveryBoyId)"
            
        case .orderMapCordinates(orderId: let orderId):
            return "DeliveryBoy?vCordOrderId=\(orderId)"
            
        case .orderPayableAmount(orderId: let orderId):
            return "DeliveryBoy?vOrderId=\(orderId)"
            
        case .deliveryBoyLatAndLngUpdate(orderId: let orderId, lat: let lat, lng: let lng):
            return "DeliveryBoy?vOrderId=\(orderId)&vDeliveryBoyLatitude=\(lat)&vDeliveryBoyLongitude=\(lng)"
            
        case .selfPrescriptionList(patientId: let patientId):
            return "Pharmacy?vPatientId=\(patientId)"
            
        case .talukaByPincode(pincode: let pincode):
            return "Pincode?vPincodeId=\(pincode)"
            
        case .areaGetByPincodeAndTaluka(pincode: let pincode, taluka: let taluka):
            return "Pincode?vPincodeId=\(pincode)&vTaluka=\(taluka)"
            
        case .pharmacyPaidReceipt(pharmPatientId: let pharmPatientId):
            return "vPharmPatientId=\(pharmPatientId)"
            
        case .patientPasswordChange(patientId: let patientId, oldPassword: let oldPassword, newPassword: let newPassword):
            return "Patient?vPatientId=\(patientId)&vOldPwd=\(oldPassword)&vNewPwd=\(newPassword)"
            
        case .patientMobileNoValidation(mobileNo1: let mobileNo1):
            return "Patient?vMob1=\(mobileNo1)"
            
        case .Specialization:
            return "Common?vType=Specialization"
            
        case .Symptoms:
            return "Concern?vConcernList="
            
        case .FrequentSpeciality:
            return "Common?vSpecType=Specialization"
            
        case .SymptomsSearching(searchVal: let searchVal):
            return "Patient?vSrchVal=\(searchVal)"
            
        case .PatientConcernSave(patientId: let patientId, concernId: let concernId, concernDesc: let concernDesc):
            return "Patient?vPatientId=\(patientId)&vConcernId=\(concernId)&vConcernDesc=\(concernDesc)"
            
        case .PatientLabTestReports(patientId: let patientId):
            return "HealthHistory?vLabTestDocPatientId=\(patientId)"
            
        case .PatientLabTestDetails(patientId: let patientId):
            return "HealthHistory?vLabTestDtlsPatientId=\(patientId)"
            
        case .PatientProcedureReports(patientId: let patientId):
            return "HealthHistory?vProcedureDocPatientId=\(patientId)"
            
        case .PatientLabTestAdviceDetails(patientId: let patientId):
            return "Pathology?vLabTestAdviseDtlsPatientId=\(patientId)"
            
        case .labTestSearch(searchVal: let searchVal):
            return "Pathology?vSrchVal=\(searchVal)"
            
        case .medicineAndEssential(searchVal: let searchVal):
            return "Pharmacy?vSrchVal=\(searchVal)"
            
        case .PatientPharmacyAdviceDetails(patientId: let patientId):
            return "Pharmacy?vPatientId=\(patientId)"
            
        case .FrequentLabTest:
            return "Pathology"
            
        case .FrequentMedicine:
            return "Pharmacy"
            
        case .MyPrescription(patientId: let patientId):
            return "HealthHistory?vPrescriptionHistPatientId=\(patientId)"
            
        case .LabTestReceipt(patientId: let patientId):
            return "Pathology?vLabPathologyPaidListPatientId=\(patientId)"
            
        case .procedureBilling(patientID: let patientId):
            return "Finance?vEstimateBillingListPatientId=\(patientId)"
            
        case .addressPatient(patientID: let patientId):
            return "Patient?vPatientAddressPatientId=\(patientId)"
            
        case .consultationList(patientID: let patientId):
            return "Doctor?vPatientId=\(patientId)"
            
        case .myOrderList(patientID: let patientId):
            return "Order?vPatientId=\(patientId)&vOrderStatus=All"
            
        case .myCartList(patientID: let patientId):
            return "Cart?vRefPatientId=\(patientId)"
            
        case .OPDBillingList(patientID: let patientId):
            return "Finance?vOPDBillingListPatientId=\(patientId)"
            
            
        case .estimateAdvanceBillingList(patientID: let patientId):
            return "Finance?vEstimateAdvanceBillingListPatientId=\(patientId)"
            
        case .pharmacyReceiptList(patientID: let patientId):
            return "Pharmacy?vPharmPatientId=\(patientId)"
            
        case .PatientMedicineDetails(patientId: let patientId):
            return "Pharmacy?vPatientId=\(patientId)"
            
        case .cartRefresh(patientID: let patientID):
            return "Cart?vPatientId=\(patientID)"
            
        case .pathologyLabList(pincode: let pincode,labInvestigation: let labInvestigation,docId: let docId,docType:let docType):
            return "Pathology?vPincode=\(pincode)&vLabInvestigation=\(labInvestigation)&vDocId=\(docId)&vDocType=\(docType)"
            
        case .addLabToCart(patientID: let patientID,addressID: let addressID,labMasterID: let labMasterID,pincode:  let pincode,labInvestigation: let labInvestigation,docId: let docId,docType: let docType,qty: let qty):
            return "Pathology?vPatientId=\(patientID)&vPatientAddressId=\(addressID)&vLabMasterId=\(labMasterID)&vDocId=\(docId)&vDocType=\(docType)&vLabInvestigation=\(labInvestigation)&vQty=\(qty)&vSellerType=Lab&vDeliveryPincode=\(pincode)"
            
        case .addPharmacyToCart(patientID: let patientID,addressID: let addressID,labMasterID: let labMasterID,pincode:  let pincode,labInvestigation: let labInvestigation,docId: let docId,docType: let docType,qty: let qty):
            return "Pharmacy?vPatientId=\(patientID)&vPatientAddressId=\(addressID)&vPharmacyMasterId=\(labMasterID)&vDocId=\(docId)&vDocType=\(docType)&vMedicineId=226&vQty=\(qty)&vSellerType=Pharmacy&vDeliveryPincode=\(pincode)"
            
        case .cartRemove(cartID: let cartId):
            return "Cart?vCartId=\(cartId)"
            
        case .prescriptionList(patientID: let patientID):
            return "Pharmacy?vSelfPrescPatientId=\(patientID)"
            
        case .pharmacyList(pincode: let pincode, labInvestigation: let labInvestigation, docId: let docId, docType: let docType):
            return "Pharmacy?vPincode=\(pincode)&vMedicineId=\(labInvestigation)&vDocId=\(docId)&vDocType=\(docType)"
            
        case .cartUpdate(cartID: let cartId,qty: let qty):
            return "Cart?vCartId=\(cartId)&vQty=\(qty)"
            
        }
    }
    
    
    var method: String {
        switch self {
        case .doctorDetailsBySpecialize:
            return "GET"
            
        case .doctorOnlineConsultScheduleByDoctor:
            return "GET"
            
        case .doctorOnlineConsultPaymentDetailsSave:
            return "GET"
            
        case .patientOnlineConsultScheduleDetails:
            return "GET"
            
        case .concernDetailsList:
            return "POST"
            
        case .orderInvoice:
            return "POST"
            
        case .PatientDocumentUpload:
            return "POST"
            
        case .PatientPrescriptionHistoryGetById:
            return "POST"
            
        case .SelfPrescriptionUpload:
            return "POST"
            
        case .ProcedureReportUpload:
            return "POST"
            
        case .ProcedureReportReUpload:
            return "POST"
            
        case .LabTestReportUpload:
            return "POST"
            
        case .LabTestReportReUpload:
            return "POST"
            
        case .PatientDocumentReUpload:
            return "POST"
            
        case .GetAllPharmacyAdvice:
            return "POST"
            
        case .patientRegistration:
            return "POST"
            
        case .OrderDtlsGetByOrderStatus:
            return "POST"
            
        case .OTPAuthentication:
            return "POST"
            
        case .PatientHistGetById:
            return "GET"
            
        case .PatientLogin:
            return "POST"
            
        case .CommonDataGetByType:
            return "POST"
            
        case .TitleGetByTitleType:
            return "POST"
            
        case .GetAllLabTestInvestigation:
            return "POST"
            
        case .PatientProfileUpload:
            return "POST"
            
        case .PatientGetById:
            return "POST"
            
        case .SelfPrescriptionAdviceSave:
            return "POST"
            
        case .ViewPharmacyChargesDtlsGetByMedicineId:
            return "POST"
            
        case .RefreshCart:
            return "POST"
            
        case .DeliveryBoyRegistration:
            return "GET"
            
        case .Qualification:
            return "GET"
            
        case .State:
            return "GET"
            
        case .City:
            return "GET"
            
        case .deliveryBoyProfileDetails:
            return "GET"
            
        case .deliveryBoyOtpAuthentication:
            return "GET"
            
        case .deliveryBoyProfileUpdate:
            return "GET"
            
        case .deliveryBoyDocumentList:
            return "GET"
            
        case .orderPickUpUpdate:
            return "GET"
            
        case .patientDeliveryOtpGeneration:
            return "GET"
            
        case .patientDeliveryOtpAuthentication:
            return "GET"
            
        case .patientDeliveryOrderUpdate:
            return "GET"
            
        case .deliverOrderList:
            return "GET"
            
        case .orderAcceptUpdate:
            return "GET"
            
        case .pendingOrderList:
            return "GET"
            
        case .upcomingOrderList:
            return "GET"
            
        case .patientOrderDetails:
            return "GET"
            
        case .deliveryBoyOrderCount:
            return "GET"
            
        case .patientLatAndLngUpdate:
            return "GET"
            
        case .rejectOrderUpdate:
            return "GET"
            
        case .orderCashCollectionUpdate:
            return "GET"
            
        case .rejectedOrderList:
            return "GET"
            
        case .orderMapCordinates:
            return "GET"
            
        case .orderPayableAmount:
            return "GET"
            
        case .deliveryBoyLatAndLngUpdate:
            return "GET"
            
        case .selfPrescriptionList:
            return "GET"
            
        case .talukaByPincode:
            return "GET"
            
        case .areaGetByPincodeAndTaluka:
            return "GET"
            
        case .pharmacyPaidReceipt:
            return "GET"
            
        case .patientPasswordChange:
            return "GET"
            
        case .patientMobileNoValidation:
            return "GET"
            
        case .Specialization:
            return "GET"
            
        case .Symptoms:
            return "GET"
            
        case .FrequentSpeciality:
            return "GET"
            
        case .SymptomsSearching:
            return "GET"
            
        case .PatientConcernSave:
            return "GET"
            
        case .PatientLabTestReports:
            return "GET"
            
        case .PatientLabTestDetails:
            return "GET"
            
        case .PatientProcedureReports:
            return "GET"
            
        case .PatientLabTestAdviceDetails:
            return "GET"
            
        case .labTestSearch:
            return "GET"
            
        case .medicineAndEssential:
            return "GET"
            
        case .PatientPharmacyAdviceDetails:
            return "GET"
            
        case .FrequentLabTest:
            return "GET"
            
        case .FrequentMedicine:
            return "GET"
            
        case .MyPrescription:
            return "GET"
            
        case .LabTestReceipt:
            return "GET"
            
        case .procedureBilling:
            return "GET"
            
        case .addressPatient:
            return "GET"
            
        case .consultationList:
            return "GET"
            
        case .myOrderList:
            return "GET"
            
        case .myCartList:
            return "GET"
            
        case .OPDBillingList:
            return "GET"
            
        case .estimateAdvanceBillingList:
            return "GET"
            
        case .pharmacyReceiptList:
            return "GET"
            
        case .PatientMedicineDetails:
            return "GET"
            
        case .cartRefresh:
            return "GET"
            
        case .pathologyLabList:
            return "GET"
            
        case .addLabToCart:
            return "GET"
            
        case .addPharmacyToCart:
            return "GET"
            
        case .cartRemove:
            return "GET"
            
        case .prescriptionList:
            return "GET"
            
        case .pharmacyList:
            return "GET"
            
        case .cartUpdate:
            return "GET"
        }
    }
}


extension APIV2 {
    var params: String {
        var params: String = ""
        switch self {
        case .doctorDetailsBySpecialize:
            break
            
        case .doctorOnlineConsultScheduleByDoctor:
            break
            
        case .doctorOnlineConsultPaymentDetailsSave:
            break
            
        case .patientOnlineConsultScheduleDetails:
            break
            
        case .concernDetailsList:
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><ConcernDtlsList xmlns=\"http://tempuri.org/\" /></soap:Body></soap:Envelope>"
            
            
        case .orderInvoice(orderId: let orderId, sellerMasterId: let sellerMasterId, sellerType: let sellerType):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><OrderInvoiceReport xmlns=\"http://tempuri.org/\"><vOrderId>\(orderId)</vOrderId><vSellerMasterId>\(sellerMasterId)</vSellerMasterId><vSellerType>\(sellerType)</vSellerType></OrderInvoiceReport></soap:Body></soap:Envelope>"
            
        case .PatientDocumentUpload(patientId: let patientId, fileType: let fileType, file: let file, fileName: let fileName, fileExt: let fileExt):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><PatientDocumentUpload xmlns=\"http://tempuri.org/\"><vPatientId>\(patientId)</vPatientId><vFileType>\(fileType)</vFileType><vFile>\(file)</vFile><vFileName>\(fileName)</vFileName><vFileExt>\(fileExt)</vFileExt></PatientDocumentUpload></soap:Body></soap:Envelope>"
            
        case .PatientPrescriptionHistoryGetById(patientId: let patientId):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><PatientPrescriptionHistoryGetById xmlns=\"http://tempuri.org/\"><vPatientId>\(patientId)</vPatientId></PatientPrescriptionHistoryGetById></soap:Body></soap:Envelope>"
            
        case .SelfPrescriptionUpload(patientId: let patientId, docId: let docId, file: let file, docType: let docType, fileExt: let fileExt, fileName: let fileName):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SelfPrescriptionUpload xmlns=\"http://tempuri.org/\"><vFile>\(file)</vFile><vFileName>\(fileName)</vFileName><vDocId>\(docId)</vDocId><vDocType>\(docType)</vDocType><vPatientId>\(patientId)</vPatientId><vFileExt>\(fileExt)</vFileExt></SelfPrescriptionUpload></soap:Body></soap:Envelope>"
            
        case .ProcedureReportUpload(patientId: let patientId, file: let file, fileType: let fileType, fileExt: let fileExt, fileName: let fileName):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><ProcedureReportUpload xmlns=\"http://tempuri.org/\"><vPatientId>\(patientId)</vPatientId><vFileType>\(fileType)</vFileType><vFile>\(file)</vFile><vFileName>\(fileName)</vFileName><vFileExt>\(fileExt)</vFileExt></ProcedureReportUpload></soap:Body></soap:Envelope>"
            
        case .ProcedureReportReUpload(patientId: let patientId, docId: let docId, file: let file, fileType: let fileType, fileExt: let fileExt, fileName: let fileName):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><ProcedureReportReUpload xmlns=\"http://tempuri.org/\"><vProcDocId>\(docId)</vProcDocId><vPatientId>\(patientId)</vPatientId><vFileType>\(fileType)</vFileType><vFile>\(file)</vFile><vFileName>\(fileName)</vFileName><vFileExt>\(fileExt)</vFileExt></ProcedureReportReUpload></soap:Body></soap:Envelope>"
            
            
        case .LabTestReportUpload(patientId: let patientId, fileType: let fileType, file: let file, fileName: let fileName, fileExt: let fileExt):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><LabTestReportUpload xmlns=\"http://tempuri.org/\"><vPatientId>\(patientId)</vPatientId><vFileType>\(fileType)</vFileType><vFile>\(file)</vFile><vFileName>\(fileName)</vFileName><vFileExt>\(fileExt)</vFileExt></LabTestReportUpload></soap:Body></soap:Envelope>"
            
        case .LabTestReportReUpload(labTestDocId: let labTestDocId, patientId: let patientId, fileType: let fileType, file: let file, fileName: let fileName, fileExt: let fileExt):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><LabTestReportReUpload xmlns=\"http://tempuri.org/\"><vLabTestDocId>\(labTestDocId)</vLabTestDocId><vPatientId>\(patientId)</vPatientId><vFileType>\(fileType)</vFileType><vFile>\(file)</vFile><vFileName>\(fileName)</vFileName><vFileExt>\(fileExt)</vFileExt></LabTestReportReUpload></soap:Body></soap:Envelope>"
            
        case .PatientDocumentReUpload(patientDocId: let patientDocId, patientId: let patientId, fileType: let fileType, file: let file, fileName: let fileName, fileExt: let fileExt):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><PatientDocumentReUpload xmlns=\"http://tempuri.org/\"><vPatientDocId>\(patientDocId)</vPatientDocId><vPatientId>\(patientId)</vPatientId><vFileType>\(fileType)</vFileType><vFile>\(file)</vFile><vFileName>\(fileName)</vFileName><vFileExt>\(fileExt)</vFileExt></PatientDocumentReUpload></soap:Body></soap:Envelope>"
            
        case .GetAllPharmacyAdvice(searchValue: let searchValue):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetAllPharmacyAdvice xmlns=\"http://tempuri.org/\"><vSrchVal>\(searchValue)</vSrchVal></GetAllPharmacyAdvice></soap:Body></soap:Envelope>"
            
        case .patientRegistration(titleId: let titleId, firstName: let firstName, lastName: let lastName, mobileNo: let mobileNo, password: let password, gender: let gender, pincode: let pincode):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SavePatient xmlns=\"http://tempuri.org/\"><vTitleId>\(titleId)</vTitleId><vFirstName>\(firstName)</vFirstName><vLastName>\(lastName)</vLastName><vMobileNo1>\(mobileNo)</vMobileNo1><vpwd>\(password)</vpwd><vGender>\(gender)</vGender><vPincode>\(pincode)</vPincode></SavePatient></soap:Body></soap:Envelope>"
            
        case .OrderDtlsGetByOrderStatus(patientId: let patientId, orderStatus: let orderStatus):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><OrderDtlsGetByOrderStatus xmlns=\"http://tempuri.org/\"><vPatientId>\(patientId)</vPatientId><vOrderStatus>\(orderStatus)</vOrderStatus></OrderDtlsGetByOrderStatus></soap:Body></soap:Envelope>"
            
        case .OTPAuthentication(mobileNo: let mobileNo, subject: let subject, otpNo: let otpNo, firebaseToken: let firebaseToken):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><OTPAuthentication xmlns=\"http://tempuri.org/\"><vMobileNo>\(mobileNo)</vMobileNo><vSubject>\(subject)</vSubject><vOtpNo>\(otpNo)</vOtpNo><vFireBaseToken>\(firebaseToken)</vFireBaseToken></OTPAuthentication></soap:Body></soap:Envelope>"
            
        case .PatientLogin(mobileNo: let mobileNo, password: let password, firebaseToken: let firebaseToken):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><PatientLogin xmlns=\"http://tempuri.org/\"><vMob1>\(mobileNo)</vMob1><vPwd>\(password)</vPwd><vFireBaseToken>\(firebaseToken)</vFireBaseToken></PatientLogin></soap:Body></soap:Envelope>"
            
        case .CommonDataGetByType(type: let type):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><CommonDataGetByType xmlns=\"http://tempuri.org/\"><vType>\(type)</vType></CommonDataGetByType></soap:Body></soap:Envelope>"
            
        case .TitleGetByTitleType(titleType: let titleType):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><TitleGetByTitleType xmlns=\"http://tempuri.org/\"><vTitleType>\(titleType)</vTitleType></TitleGetByTitleType></soap:Body></soap:Envelope>"
            
        case .GetAllLabTestInvestigation(searchValue: let searchValue):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetAllLabTestInvestigation xmlns=\"http://tempuri.org/\"><vSrchVal>\(searchValue)</vSrchVal></GetAllLabTestInvestigation></soap:Body></soap:Envelope>"
            
        case .PatientProfileUpload(patientId: let patientId, file: let file, fileExt: let fileExt):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><PatientProfileUpload xmlns=\"http://tempuri.org/\"><vPatientId>\(patientId)</vPatientId><vFile>\(file)</vFile><vFileExt>\(fileExt)</vFileExt></PatientProfileUpload></soap:Body></soap:Envelope>"
            
        case .PatientGetById(patientId: let patientId):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><PatientGetById xmlns=\"http://tempuri.org/\"><vPatientId>\(patientId)</vPatientId></PatientGetById></soap:Body></soap:Envelope>"
            
        case .SelfPrescriptionAdviceSave(patientId: let patientId, genInvest: let genInvest):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SelfPrescriptionAdviceSave xmlns=\"http://tempuri.org/\"><vPatientId>\(patientId)</vPatientId><vGenInvest>\(genInvest)</vGenInvest></SelfPrescriptionAdviceSave></soap:Body></soap:Envelope>"
            
        case .ViewPharmacyChargesDtlsGetByMedicineId(pincode: let pincode, medicineId: let medicineId, docId: let docId, docType: let docType):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><ViewPharmacyChargesDtlsGetByMedicineId xmlns=\"http://tempuri.org/\"><vPincode>\(pincode)</vPincode><vMedicineId>\(medicineId)</vMedicineId><vDocId>\(docId)</vDocId><vDocType>\(docType)</vDocType></ViewPharmacyChargesDtlsGetByMedicineId></soap:Body></soap:Envelope>"
            
        case .RefreshCart(patientId: let patientId):
            params = "<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><RefreshCart xmlns=\"http://tempuri.org/\"><vPatientId>\(patientId)</vPatientId></RefreshCart></soap:Body></soap:Envelope>"
            
        case .DeliveryBoyRegistration:
            break
            
        case .Qualification:
            break
            
        case .State:
            break
            
        case .City:
            break
            
        case .deliveryBoyProfileDetails:
            break
            
        case .deliveryBoyOtpAuthentication:
            break
            
        case .deliveryBoyProfileUpdate:
            break
            
        case .deliveryBoyDocumentList:
            break
            
        case .orderPickUpUpdate:
            break
            
        case .patientDeliveryOtpGeneration:
            break
            
        case .patientDeliveryOtpAuthentication:
            break
            
        case .patientDeliveryOrderUpdate:
            break
            
        case .deliverOrderList:
            break
            
        case .orderAcceptUpdate:
            break
            
        case .pendingOrderList:
            break
            
        case .upcomingOrderList:
            break
            
        case .patientOrderDetails:
            break
            
        case .deliveryBoyOrderCount:
            break
            
        case .patientLatAndLngUpdate:
            break
            
        case .rejectOrderUpdate:
            break
            
        case .orderCashCollectionUpdate:
            break
            
        case .rejectedOrderList:
            break
            
        case .orderMapCordinates:
            break
            
        case .orderPayableAmount:
            break
            
        case .deliveryBoyLatAndLngUpdate:
            break
            
        case .selfPrescriptionList:
            break
            
        case .talukaByPincode:
            break
            
        case .areaGetByPincodeAndTaluka:
            break
            
        case .pharmacyPaidReceipt:
            break
            
        case .patientPasswordChange:
            break
            
        case .patientMobileNoValidation:
            break
            
        case .Specialization:
            break
            
        case .Symptoms:
            break
            
        case .FrequentSpeciality:
            break
            
        case .SymptomsSearching:
            break
            
        case .PatientConcernSave:
            break
            
        case .PatientLabTestReports:
            break
            
        case .PatientLabTestDetails:
            break
            
        case .PatientProcedureReports:
            break
            
        case .PatientLabTestAdviceDetails:
            break
            
        case .labTestSearch:
            break
            
        case .medicineAndEssential:
            break
            
        case .PatientPharmacyAdviceDetails:
            break
            
        case .FrequentLabTest:
            break
            
        case .FrequentMedicine:
            break
            
        case .MyPrescription:
            break
            
        case .LabTestReceipt:
            break
            
        case .procedureBilling:
            break
            
        case .addressPatient:
            break
            
        case .consultationList:
            break
            
        case .PatientHistGetById:
            break
            
        case .myOrderList:
            break
            
        case .myCartList:
            break
            
        case .OPDBillingList:
            break
            
        case .estimateAdvanceBillingList:
            break
            
        case .pharmacyReceiptList:
            break
            
        case .PatientMedicineDetails:
            break
            
        case .cartRefresh:
            break
            
        case .pathologyLabList:
            break
            
        case .addLabToCart:
            break
        
        case .addPharmacyToCart:
            break
            
        case .cartRemove:
            break
            
        case .prescriptionList:
            break
            
        case .pharmacyList:
            break
            
        case .cartUpdate:
            break
        }
        return params

    }
}

extension APIV2 {
    var headers: [String : String]? {
        var headers: [String : String] = [:]
        let token = UserDefaults.standard.login_token ?? ""
        if token != "" {
            headers = ["Content-Type" : "text/xml", "Authorization": "Bearer \(token)"]
        } else {
            headers = ["Content-Type" : "text/xml"]
        }
        
        return headers    }
    
}

