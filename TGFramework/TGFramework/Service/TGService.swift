import Foundation
import UIKit

/**
 * TGService is the TGFramework's service layer wrapper class.
 */

open class TGService:NSObject {
    
    public var util: TGUtil!
    
    private var BUNDLEID = "BundleId"
    private var POST = "POST"
    private var GET = "GET"
    private var APPLICATION_JSON = "application/json"
    private var CONTENT_LENGTH = "Content-Length"
    private var ACCEPT = "Accept"
    private var CONTENT_TYPE = "Content-Type"
    
    public override init() {
        super.init()
        util = TGUtil()
    }
    
    /**
     * Create URLRequest
     *
     * @param requestUrl String
     */
    func createRequest(_ requestUrl: String) -> NSMutableURLRequest {
        let url = URL(string: requestUrl.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)
        let urlRequest = NSMutableURLRequest(url: url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        return urlRequest
    }
    
    /**
     * Service Response BY GET
     * @param requestUrl String
     * @return String
     */
    public func serviceResponse(_ requestUrl: String) -> String {
        let urlRequest: URLRequest? = createRequest(requestUrl) as URLRequest
        let response: String = createResponse(urlRequest!)
        return response
    }
    
    /**
     * Service Response By Post Dictionary
     * @param requestUrl String
     * @param dictionary [AnyHashable: Any]
     * @return String
     */
    public func serviceResponseByPostDictionary(_ requestUrl: String,_ dictionary: [AnyHashable: Any]) -> String {
        var urlRequest: URLRequest = createRequest(requestUrl) as URLRequest
        
        var httpPostString = String()
        let keyArray: [Any] = dictionary.flatMap(){ $0.0 as? String }
        for key in keyArray {
            let value: Any = dictionary[String(describing: key)]!
            httpPostString = httpPostString + ("\(key)=\(value)&")
        }
        if (httpPostString.characters.count) > 0 {
            httpPostString = httpPostString.substring(to: httpPostString.index(httpPostString.startIndex, offsetBy: (httpPostString.characters.count ) - 1))
        }
        urlRequest.httpMethod = POST
        urlRequest.httpBody = httpPostString.data(using: String.Encoding.utf8)
        let response: String = createResponse(urlRequest)
        return response
    }
    
    /**
     * Service Response By Get Dictionary
     * @param requestUrl String
     * @param dictionary [AnyHashable: Any]
     * @return String
     */
    public func serviceResponseByGetDictionary(_ requestUrl: String,_ dictionary: [AnyHashable: Any]) -> String {
        var httpGetString = String()
        let keyArray: [Any] = dictionary.flatMap(){ $0.0 as? String }
        for key in keyArray {
            let value: Any = dictionary[String(describing: key)]!
            httpGetString = httpGetString + ("\(key)=\(value)&")
        }
        if (httpGetString.characters.count) > 0 {
            httpGetString = httpGetString.substring(to: httpGetString.index(httpGetString.startIndex, offsetBy: (httpGetString.characters.count ) - 1))
        }
        var url: String = requestUrl
        if (httpGetString == "") == false {
            url = "\(requestUrl)?\(httpGetString)"
        }
        var urlRequest: URLRequest = createRequest(url) as URLRequest
        urlRequest.httpMethod = GET
        let response: String = createResponse(urlRequest)
        return response
    }
    
    /**
     * Service Response By Post JSON
     * @param requestUrl String
     * @param jsonParameter String
     * @return String
     */
    public func serviceResponseByPostJSON(_ requestUrl: String,_ jsonParameter: String) -> String {
        let jsonParameter = addCommonRequestParametersIntoJSONBody(jsonParameter)
        var urlRequest: URLRequest? = createRequest(requestUrl) as URLRequest
        var requestData = jsonParameter.data(using: String.Encoding.utf8, allowLossyConversion: false)!
        urlRequest?.httpMethod = POST
        urlRequest?.setValue("\(UInt(requestData.count))", forHTTPHeaderField: CONTENT_LENGTH)
        urlRequest?.setValue(APPLICATION_JSON, forHTTPHeaderField: ACCEPT)
        urlRequest?.setValue(APPLICATION_JSON, forHTTPHeaderField: CONTENT_TYPE)
        urlRequest?.httpBody = requestData
        let response: String = createResponse(urlRequest!)
        return response
    }
    
    /**
     * Create Response
     * @param urlRequest URLRequest
     * @return String
     */
    public func createResponse(_ urlRequest: URLRequest) -> String {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var resultJson = ""
        let semaphore = DispatchSemaphore(value: 0)
        let task = session.dataTask(with: urlRequest, completionHandler: { (data, returnResponse, error) in
            if let data = data {
                let returnResponse = returnResponse as! HTTPURLResponse
                resultJson = String(data: data, encoding: String.Encoding.utf8)!
            }
            
            semaphore.signal()
        })
        task.resume()
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        return resultJson
    }
    
    /**
     * Convert JSON to Dictionary
     * @param body String
     * @return Dictionary
     */
    public func dictionaryfromJSON(_ body: String) -> Dictionary<String, Any> {
        var body = body
        if (!TGUtil.stringHasValue(body)) {
            body = "{}"
        }
        
        var dictonary:Dictionary<String, Any>?
        dictonary = convertJsonToDic(body: body)
        
        if(dictonary == nil) {
            body = addKeyParameterIntoJsonString(jsonString: body)
            dictonary = convertJsonToDic(body: body)
        }
        return dictonary!
    }
    
    /**
     * Convert String to Dictionary
     * @param body String
     * @return Dictionary
     */
    func convertJsonToDic(body: String) -> Dictionary<String, Any>? {
        var dictonary:Dictionary<String, Any>?
        if let data = body.data(using: String.Encoding.utf8) {
            do {
                dictonary = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
            } catch let error as NSError {
                print(error)
            }
        }
        return dictonary
    }
    
    /**
     * Add key parameter in JsonString if not present
     * @param jsonString String
     * @return String
     */
    func addKeyParameterIntoJsonString(jsonString: String) -> String {
        var body = jsonString
        let firstChar = body[body.index(body.startIndex, offsetBy: 0)]
        let lastChar = body[body.index(before: body.endIndex)]
        
        if(firstChar == "[" && lastChar == "]") {
            body = body.replacingCharacters(in: body.startIndex..<body.startIndex, with: "{\"response\":")
            body = body + "}"
        }
        
        return body
    }
    
    /**
     * Convert Dictionary to JSON
     * @param dictionary Dictionary
     * @return String - formatted string
     */
    public func jsonRepresentation(_ dictionary: Dictionary<String, Any>) -> String {
        var jsonString = String()
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
            let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
            if  let dictFromJSON = decoded as? [String:String] {
                jsonString = String(describing: dictFromJSON)
            }
        } catch {
            print(error.localizedDescription)
        }
        return jsonString
    }
    
    /**
     * Add RequestParameters Into JSONBody
     * @param body String
     * @return String - formatted string
     */
    public func addCommonRequestParametersIntoJSONBody(_ body: String) -> String {
        var body = body
        if (TGUtil.stringHasValue(body)) {
            body = "{}"
        }
        var bodyParameters = dictionaryfromJSON(body)
        let appBundle = Bundle.main
        let bundleID: String? = appBundle.bundleIdentifier
        bodyParameters[BUNDLEID] = bundleID
        let jsonBody: String? = jsonRepresentation(bodyParameters)
        return jsonBody!
    }
    
}
