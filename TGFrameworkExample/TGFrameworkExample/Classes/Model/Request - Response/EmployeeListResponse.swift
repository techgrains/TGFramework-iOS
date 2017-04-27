import Foundation
import TGFramework

class EmployeeListResponse: TGResponse {
    
    public var employeeList: [Any] = []
    
    override init() {
        super.init()
    }
}
