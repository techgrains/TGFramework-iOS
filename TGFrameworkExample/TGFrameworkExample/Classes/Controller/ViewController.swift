import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var serviceTableView:UITableView!
    @IBOutlet var responceTableView:UITableView!
    var serviceList = [Any]()
    var responseList = [Any]()

    var createEmployeeService: EmployeeCreateService!
    var employeeListService: EmployeeListService!
    var filterEmployeeListService: FilterEmployeeListService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        serviceList.append(["Service Name": "Employee List","Service Type": "Get Dictionary - without parameter"])
        serviceList.append(["Service Name": "Employee List with filter","Service Type": "Get Dictionary - with parameter"])
        serviceList.append(["Service Name": "Create Employee","Service Type": "Post Dictionary - with parameter"])
        serviceTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Mark - Table Delegate
    
    func numberOfSections(in aTableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(tableView == serviceTableView) {
            return serviceList.count
        } else if(tableView == responceTableView) {
            return responseList.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        if(tableView == serviceTableView) {
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let servicaNameDic = serviceList[indexPath.row] as! Dictionary<String, Any>
            cell?.textLabel?.text = servicaNameDic["Service Name"] as! String?
            cell?.detailTextLabel?.text = servicaNameDic["Service Type"] as! String?
        } else if(tableView == responceTableView) {
            cell = tableView.dequeueReusableCell(withIdentifier: "responseCell", for: indexPath)
            let employee:Employee = responseList[indexPath.row] as! Employee
            cell?.textLabel?.text = employee.name
            cell?.detailTextLabel?.text = employee.designation
        }
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.row == 0) {
            employeeList()
        } else if(indexPath.row == 1) {
            employeeListWithFilter()
        } else if(indexPath.row == 2) {
            createEmployee()
        }
    }
    
    // MARK: -----------------------------------------------
    
    // MARK: Employee List Service
    func employeeList() {
        DispatchQueue.global().async(execute: {
            let request = EmployeeListRequest()
            let response: EmployeeListResponse! = self.employee(list: request)
            DispatchQueue.main.sync{
                self.responseList.removeAll()
                self.responseList = response.employeeList
                self.responceTableView.reloadData()
            }
        })
    }
    
    func employee(list request: EmployeeListRequest) -> EmployeeListResponse {
        if !(employeeListService != nil) {
            employeeListService = EmployeeListService.getInstance()
        }
        return employeeListService.employee(list: request)
    }
    
    // MARK: Employee List with filter Service
    func employeeListWithFilter() {
        DispatchQueue.global().async(execute: {
            let request = FilterEmployeeListRequest()
            request.name = "S"
            let response: FilterEmployeeListResponse! = self.employeeList(withFilter: request)
            DispatchQueue.main.sync{
                self.responseList.removeAll()
                self.responseList = response.employeeList
                self.responceTableView.reloadData()
            }
        })
    }
    
    func employeeList(withFilter request: FilterEmployeeListRequest) -> FilterEmployeeListResponse {
        if !(filterEmployeeListService != nil) {
            filterEmployeeListService = FilterEmployeeListService.getInstance()
        }
        return filterEmployeeListService.employeeList(withFilter: request)
    }
    
    // MARK: Create Employee Service
    func createEmployee() {
        
        DispatchQueue.global().async(execute: {
            let request = EmployeeCreateRequest()
            request.name = "Nikunj"
            request.designation = "Manager"
            let response: EmployeeCreateResponse! = self.create(employee: request)
            
            DispatchQueue.main.sync{
                self.responseList.removeAll()
                self.responseList.append(response.employee)
                self.responceTableView.reloadData()
            }
        })
    }
    
    func create(employee request: EmployeeCreateRequest) -> EmployeeCreateResponse {
        if !(createEmployeeService != nil) {
            createEmployeeService = EmployeeCreateService.getInstance()
        }
        return createEmployeeService.createEmployee(with: request)
    }

}
