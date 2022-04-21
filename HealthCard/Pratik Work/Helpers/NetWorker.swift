//
//  NetWorker.swift
//  Level
//
//  Created by Pratik on 21/12/21.
//

import Foundation
import UIKit
import XMLParsing

class NetWorker {
    static var shared = NetWorker()
    
    public var showHud: () -> () = {}
    public var hideHud: () -> () = {}
        
    private func requestFromAuthType(_ api: API) -> URLRequest {
        
        let url = api.fullURL
        let method = api.method
        let params: String = api.params
        let headers = api.headers
        let methods = api.method
        if methods == "GET" {
            
            var request = URLRequest(url: url)
            request.httpMethod = method
            request.allHTTPHeaderFields = headers
            
            
            print("url- ", url)
            print("method- ", method)
            print("params- ", params)
            print("headers- ", headers ?? "")
            
            print("Endpoint - \(url)")
            print("Params - \(params)")
            
            return request
        } else {
        //let body = (try? JSONSerialization.data(withJSONObject: params, options: [])) ?? Data()
        
        
        
        var request = URLRequest(url: url)
        request.httpMethod = method
            request.httpBody = params.data(using: .utf8)
        request.allHTTPHeaderFields = headers
        
        
        print("url- ", url)
        print("method- ", method)
        print("params- ", params)
        print("headers- ", headers ?? "")
        //print("body- ", body)
        
        print("Endpoint - \(url)")
        print("Params - \(params)")
        
        return request
        }
    }
    
    public func callAPIService <T: Codable> (type: API, completion: @escaping (T?, Error?) -> Void) {
        let request = requestFromAuthType(type)
        
        self.showHud()
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.global().async {
                DispatchQueue.main.sync {
                    self.hideHud()
                    print("--- Entering Response ---")
                    let responseString = String(data: data ?? Data(), encoding: .utf8) ?? ""
                    
                    print(responseString)
                    
                    if responseString.isEmpty {
                        // show error alert
                    }
                    
                    do {
                        let xmlStr = responseString
                        let parser = ParseXMLData(xml: xmlStr)
                        let jsonStr = parser.parseXML()
                        print(jsonStr)

                        guard let json = jsonStr.data(using: .utf8) else {return}
                        let decodedResponse = try JSONDecoder().decode(T.self, from: json)
                            completion(decodedResponse, nil)

                    } catch {
                        completion(nil, error)
                        print(error.localizedDescription)
                        UIAlertController.showAlert(titleString: error.localizedDescription)
                    }
                }
            }
        }.resume()
    }
    
}

class ParseXMLData: NSObject, XMLParserDelegate {

var parser: XMLParser
var elementArr = [String]()
var arrayElementArr = [String]()
var str = "{"

init(xml: String) {
    parser = XMLParser(data: xml.replaceAnd().replaceAposWithApos().data(using: String.Encoding.utf8)!)
    super.init()
    parser.delegate = self
}

func parseXML() -> String {
    parser.parse()

    // Do all below steps serially otherwise it may lead to wrong result
    for i in self.elementArr{
        if str.contains("\(i)@},\"\(i)\":"){
            if !self.arrayElementArr.contains(i){
                self.arrayElementArr.append(i)
            }
        }
        str = str.replacingOccurrences(of: "\(i)@},\"\(i)\":", with: "},") //"\(element)@},\"\(element)\":"
    }

    for i in self.arrayElementArr{
        str = str.replacingOccurrences(of: "\"\(i)\":", with: "\"\(i)\":[") //"\"\(arrayElement)\":}"
    }

    for i in self.arrayElementArr{
        str = str.replacingOccurrences(of: "\(i)@}", with: "\(i)@}]") //"\(arrayElement)@}"
    }

    for i in self.elementArr{
        str = str.replacingOccurrences(of: "\(i)@", with: "") //"\(element)@"
    }

    // For most complex xml (You can ommit this step for simple xml data)
    self.str = self.str.removeNewLine()
    self.str = self.str.replacingOccurrences(of: ":[\\s]?\"[\\s]+?\"#", with: ":{", options: .regularExpression, range: nil)

    return self.str.replacingOccurrences(of: "\\", with: "").appending("}")
}

// MARK: XML Parser Delegate
func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {

    //print("\n Start elementName: ",elementName)

    if !self.elementArr.contains(elementName){
        self.elementArr.append(elementName)
    }

    if self.str.last == "\""{
        self.str = "\(self.str),"
    }

    if self.str.last == "}"{
        self.str = "\(self.str),"
    }

    self.str = "\(self.str)\"\(elementName)\":{"

    var attributeCount = attributeDict.count
    for (k,v) in attributeDict{
        //print("key: ",k,"value: ",v)
        attributeCount = attributeCount - 1
        let comma = attributeCount > 0 ? "," : ""
        self.str = "\(self.str)\"_\(k)\":\"\(v)\"\(comma)" // add _ for key to differentiate with attribute key type
    }
}

func parser(_ parser: XMLParser, foundCharacters string: String) {
    if self.str.last == "{"{
        self.str.removeLast()
        self.str = "\(self.str)\"\(string)\"#" // insert pattern # to detect found characters added
    }
}

func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

    //print("\n End elementName \n",elementName)
    if self.str.last == "#"{ // Detect pattern #
        self.str.removeLast()
    }else{
        self.str = "\(self.str)\(elementName)@}"
    }
}
}

extension String{
    // remove amp; from string
func removeAMPSemicolon() -> String{
    return replacingOccurrences(of: "amp;", with: "")
}

// replace "&" with "And" from string
func replaceAnd() -> String{
    return replacingOccurrences(of: "&", with: "And")
}

// replace "\n" with "" from string
func removeNewLine() -> String{
    return replacingOccurrences(of: "\n", with: "")
}

func replaceAposWithApos() -> String{
    return replacingOccurrences(of: "Andapos;", with: "'")
}
}
