import Foundation
import TGFramework

class EmployeeListService: TGService {
    
    static var instance: EmployeeListService?
    
    class func getInstance() -> EmployeeListService {
        if (instance == nil) {
            instance = EmployeeListService()
        }
        return instance!
    }
    
    override init() {
        super.init()
        
        // Initialization code here.
        
    }
    
    func generateResponseModal(_ json: [String: Any]) -> EmployeeListResponse {
        let response = EmployeeListResponse()
    
        // Get Response Object
        if TGUtil.dictionaryHasValue((json as [AnyHashable : Any])) {
            
            if(json["status"] != nil) {
                response.status = json["status"] as! String
                
                // Get timestamp
                let timestamp: Float = json["timestamp"] as! Float
                response.timestamp = timestamp
                
                // Get error
                let error: String = json["error"] as! String
                if TGUtil.stringHasValue(error) {
                    response.error = error
                }
                
                // Get message
                let message: String = json["message"] as! String
                if TGUtil.stringHasValue(message) {
                    response.message = message
                }
            } else {
                let list:Array = (json["response"] as! [AnyObject])
                if TGUtil.arrayHasValue(list) {
                    for i in 0..<list.count {
                        let listDic:[String: Any] = list[i] as! [String : Any]
                        
                        let employee = Employee()
                        employee.id = listDic["id"] as! Int
                        employee.name = listDic["name"] as! String
                        employee.designation = listDic["designation"] as! String
                        
                        let departments:Array = (listDic["departments"] as! [AnyObject])
                        if TGUtil.arrayHasValue(departments) {
                            for j in 0..<departments.count {
                                let departmentDic:[String: Any] = departments[j] as! [String : Any]
                                let department = Department()
                                department.code = departmentDic["code"] as! Int
                                department.name = departmentDic["name"] as! String
                                employee.departments.append(department)
                            }
                        }
                        response.employeeList.append(employee)
                    }
                }
            
            }
        }
        return response
    }
    
    func serviceResponse(forURL requestUrl: String, with request: EmployeeListRequest) -> String {
        var response: String = ""
        switch REGISTER_SERVICE {
        case LIVE_SERVICE:
            response = self.serviceResponse(requestUrl)
        default:
            break
        }
        return response
    }
    
    func employee(list request: EmployeeListRequest) -> EmployeeListResponse {
        let serviceResponse: String = self.serviceResponse(forURL: request.url(), with: request)
        let json: [String: Any] = self.dictionaryfromJSON(serviceResponse)
        let response: EmployeeListResponse? = self.generateResponseModal(json)
        return response!
    }
}
