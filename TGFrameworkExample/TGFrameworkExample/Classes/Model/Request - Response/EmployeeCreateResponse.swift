import Foundation
import TGFramework

class EmployeeCreateResponse: TGResponse {
    var employee = Employee()
    
    override init() {
        super.init()
    }
}
