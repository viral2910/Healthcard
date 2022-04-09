//
//  GenerateToken.swift
//  Level
//
//  Created by Pratik on 21/12/21.
//

import Foundation
import UIKit
import CryptoKit

//class GenerateToken{
//    static func token <Headerr: Encodable, Payloadd: Encodable> (privatekey: String, Headers: Headerr, Payloads: Payloadd) -> String {
//        
//        let secret = privatekey
//        let privateKey = SymmetricKey(data: secret.data(using: .utf8)!)
//
//        let headerJSONData = try! JSONEncoder().encode(Headers)
//        let headerBase64String = headerJSONData.urlSafeBase64EncodedString()
//
//        let payloadJSONData = try! JSONEncoder().encode(Payloads)
//        let payloadBase64String = payloadJSONData.urlSafeBase64EncodedString()
//
//        let toSign = (headerBase64String + "." + payloadBase64String).data(using: .utf8)!
//
//        let signature = HMAC<SHA256>.authenticationCode(for: toSign, using: privateKey)
//        let signatureBase64String = Data(signature).urlSafeBase64EncodedString()
//
//        let token = [headerBase64String, payloadBase64String, signatureBase64String].joined(separator: ".")
//        
//        return token
//    }
//}

