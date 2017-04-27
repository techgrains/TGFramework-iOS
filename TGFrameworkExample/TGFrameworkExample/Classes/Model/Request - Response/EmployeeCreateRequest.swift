import Foundation
import TGFramework

class EmployeeCreateRequest: TGRequest {
    var serviceMethodName: String = ""
    var name: String = ""
    var designation = ""
    
    var uniqueDeviceID: String = ""
    
    
    override init() {
        super.init()
        
        // Initialization code here.
        serverURL = LIVE_SERVICE_TG_RESTFUL
        serviceMethodName = EMPLOYEE_CREATE
    }
    
    func url() -> String {
        // Append Service Method Name
        let urlString = serverURL + "/\(serviceMethodName)"
        return urlString
    }
}
