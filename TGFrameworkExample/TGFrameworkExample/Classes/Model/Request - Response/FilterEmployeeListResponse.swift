import Foundation
import TGFramework

class FilterEmployeeListResponse: TGResponse {
    
    public var employeeList: [Any] = []
    
    override init() {
        super.init()
    }
}
