//
//  DoctorDetailsBySpecializeStruct.swift
//  HealthCard
//
//  Created by Pratik Khopkar on 24/04/22.
//

import Foundation

// MARK: - DoctorDetailBySpecializeDataResponseElement
struct DoctorDetailBySpecializeDataResponseElement: Codable {
    let doctorID: Int
    let firstName, middleName, lastName: String
    let dob, dobText, age: JSONNull?
    let gender: String
    let educationID: JSONNull?
    let education: String
    let specialityID: JSONNull?
    let speciality: String
    let mmcRegNo: JSONNull?
    let totalExperience: String
    let mobileNo1, mobileNo2, emailId1, emailId2: JSONNull?
    let aadhaarNo, department, anniversaryDate, anniversaryDateText: JSONNull?
    let flatno, bldg, road, nearby: JSONNull?
    let area, talukaID, taluka, districtID: JSONNull?
    let district, cityID, stateID, state: JSONNull?
    let countryID, country, pincode, isActive: JSONNull?
    let isActiveText, roleID, roleName, userType: JSONNull?
    let doctorDays, doctorSlot, doctorTimeFrom, doctorTimeTo: JSONNull?
    let isReferringDoc, opdProfessionFees, indoorProfessionFees: JSONNull?
    let onlineConsultationFees: String
    let doctorProfilePicURL: String
    let isPatientReg, isEdit, accountName, panCard: JSONNull?
    let bank, accNo, ifscCode, currUser: JSONNull?
    let hospitalID, pwd, cFpwd, isUserExists: JSONNull?
    let isProfile, hiddDocDetails, hiddDocOnlineConsultDetails, timePeriod: JSONNull?
    let bookDate, hiddRMODetails, timePeriodSClist: JSONNull?

    enum CodingKeys: String, CodingKey {
        case doctorID = "DoctorId"
        case firstName = "FirstName"
        case middleName = "MiddleName"
        case lastName = "LastName"
        case dob = "DOB"
        case dobText = "DOBText"
        case age = "Age"
        case gender = "Gender"
        case educationID = "EducationId"
        case education = "Education"
        case specialityID = "SpecialityId"
        case speciality = "Speciality"
        case mmcRegNo = "MMCRegNo"
        case totalExperience = "TotalExperience"
        case mobileNo1 = "MobileNo1"
        case mobileNo2 = "MobileNo2"
        case emailId1 = "EmailId1"
        case emailId2 = "EmailId2"
        case aadhaarNo = "AadhaarNo"
        case department = "Department"
        case anniversaryDate = "AnniversaryDate"
        case anniversaryDateText = "AnniversaryDateText"
        case flatno = "Flatno"
        case bldg = "Bldg"
        case road = "Road"
        case nearby = "Nearby"
        case area = "Area"
        case talukaID = "TalukaId"
        case taluka = "Taluka"
        case districtID = "DistrictId"
        case district = "District"
        case cityID = "CityId"
        case stateID = "StateId"
        case state = "State"
        case countryID = "CountryId"
        case country = "Country"
        case pincode = "Pincode"
        case isActive = "IsActive"
        case isActiveText = "IsActiveText"
        case roleID = "RoleId"
        case roleName = "RoleName"
        case userType = "UserType"
        case doctorDays = "DoctorDays"
        case doctorSlot = "DoctorSlot"
        case doctorTimeFrom = "DoctorTimeFrom"
        case doctorTimeTo = "DoctorTimeTo"
        case isReferringDoc = "IsReferringDoc"
        case opdProfessionFees = "OPDProfessionFees"
        case indoorProfessionFees = "IndoorProfessionFees"
        case onlineConsultationFees = "OnlineConsultationFees"
        case doctorProfilePicURL = "DoctorProfilePicUrl"
        case isPatientReg = "IsPatientReg"
        case isEdit = "IsEdit"
        case accountName = "AccountName"
        case panCard = "PANCard"
        case bank = "Bank"
        case accNo = "AccNo"
        case ifscCode = "IFSCCode"
        case currUser = "CurrUser"
        case hospitalID = "HospitalId"
        case pwd = "Pwd"
        case cFpwd = "CFpwd"
        case isUserExists = "IsUserExists"
        case isProfile = "IsProfile"
        case hiddDocDetails, hiddDocOnlineConsultDetails
        case timePeriod = "TimePeriod"
        case bookDate = "BookDate"
        case hiddRMODetails
        case timePeriodSClist = "TimePeriodSClist"
    }
}

typealias DoctorDetailBySpecializeDataResponse = [DoctorDetailBySpecializeDataResponseElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

// MARK: - SpecilizationResponseElement
struct SpecilizationResponseElement: Codable {
    let id: Int
    let pValue: JSONNull?
    let value: String
    let type, sortOrder, parentType, isActive: JSONNull?
    let isActiveText, isEdit, remark, createdBy: JSONNull?
    let createdOn: JSONNull?

    enum CodingKeys: String, CodingKey {
        case id = "Id"
        case pValue = "PValue"
        case value = "Value"
        case type = "Type"
        case sortOrder = "SortOrder"
        case parentType = "ParentType"
        case isActive = "IsActive"
        case isActiveText = "IsActiveText"
        case isEdit = "IsEdit"
        case remark = "Remark"
        case createdBy = "CreatedBy"
        case createdOn = "CreatedOn"
    }
}

typealias SpecilizationResponse = [SpecilizationResponseElement]

// MARK: - SymptomsDataResponseElement
struct SymptomsDataResponseElement: Codable {
    let concernID: Int?
    let concern, concernCatagoryID: String?
    let concernCatagory: String
    let concernDetailslist: [SymptomsDataResponseElement]?

    enum CodingKeys: String, CodingKey {
        case concernID = "ConcernId"
        case concern = "Concern"
        case concernCatagoryID = "ConcernCatagoryId"
        case concernCatagory = "ConcernCatagory"
        case concernDetailslist = "ConcernDetailslist"
    }
}

typealias SymptomsDataResponse = [SymptomsDataResponseElement]
