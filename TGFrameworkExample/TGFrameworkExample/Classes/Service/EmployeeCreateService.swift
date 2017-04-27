import Foundation
import TGFramework

class EmployeeCreateService: TGService {
    
    static var instance:EmployeeCreateService?
    
    //Initialization service class instance
    class func getInstance() -> EmployeeCreateService {
        if instance == nil {
            instance = EmployeeCreateService()
        }
        return instance!
    }
    
    override init() {
        super.init()
        
        // Initialization code here.
        
    }
    
    func serviceParams(_ request: EmployeeCreateRequest) -> [AnyHashable: Any] {
        var dictionary = [AnyHashable: Any]()
        // Set MobileNumber
        if TGUtil.stringHasValue(request.name) {
            dictionary["name"] = request.name
        } else {
            dictionary["name"] = ""
        }
        // Set Live
        if TGUtil.stringHasValue(request.designation) {
            dictionary["designation"] = request.designation
        } else {
            dictionary["designation"] = ""
        }
        return dictionary
    }
    
    func generateResponseModal(_ json: [AnyHashable: Any]) -> EmployeeCreateResponse {
        let response = EmployeeCreateResponse()
        // Get Response Object
        if TGUtil.dictionaryHasValue((json as [AnyHashable : Any])) {
            
            if(json["status"] != nil) {
                response.status = json["status"] as! String
                
                // Get timestamp
                let timestamp: Float = (json["timestamp"] as! Float)
                response.timestamp = timestamp
                
                // Get error
                let error: String = (json["error"] as! String)
                if TGUtil.stringHasValue(error) {
                    response.error = error
                }
                
                // Get message
                let message: String = (json["message"] as! String)
                if TGUtil.stringHasValue(message) {
                    response.message = message
                }
            } else {
                
                let employee = Employee()
                // Get id
                let id: Int = (json["id"] as! Int)
                employee.id = id
                //response.id = id
                
                // Get name
                let name: String = (json["name"] as! String)
                if TGUtil.stringHasValue(name) {
                    employee.name = name
                }
                
                // Get designation
                let designation: String = (json["designation"] as! String)
                if TGUtil.stringHasValue(designation) {
                    employee.designation = designation
                }
                
                // Get created
                let created: Float = (json["created"] as! Float)
                employee.created = created
                
                // Get modified
                let modified: Float = (json["modified"] as! Float)
                employee.modified = modified
                
                let departments:[AnyObject] = (json["departments"] as! Array)
                if TGUtil.arrayHasValue(departments) {
                    for j in 0..<departments.count {
                        let departmentDic:[String: Any] = departments[j] as! [String : Any]
                        let department = Department()
                        department.code = departmentDic["code"] as! Int
                        department.name = departmentDic["name"] as! String
                        employee.departments.append(department)
                    }
                }
                response.employee = employee
            }
        }
        return response
    }
    
    func serviceResponse(forURL requestUrl: String, with request: EmployeeCreateRequest) -> String {
        var response: String = ""
        switch REGISTER_SERVICE {
        case LIVE_SERVICE:
            let dictionary: [AnyHashable: Any] = self.serviceParams(request)
            response = self.serviceResponseByPostDictionary(requestUrl, dictionary)
        default:
            break
        }
        return response
    }
    
    func createEmployee(with request: EmployeeCreateRequest) -> EmployeeCreateResponse {
        let serviceResponse: String = self.serviceResponse(forURL: request.url(), with: request)
        let json: [AnyHashable: Any] = self.dictionaryfromJSON(serviceResponse)
        let response: EmployeeCreateResponse? = self.generateResponseModal(json)
        return response!
    }
}
