import Foundation
import TGFramework

class EmployeeListRequest: TGRequest {
    var serviceMethodName: String = ""
    
    var uniqueDeviceID: String = ""
    
    
    override init() {
        super.init()
        
        // Initialization code here.
        serverURL = LIVE_SERVICE_TG_RESTFUL
        serviceMethodName = EMPLOYEE_LIST
    }
    
    func url() -> String {
        // Append Service Method Name
        let urlString = serverURL + "/\(serviceMethodName)"
        return urlString
    }
}
