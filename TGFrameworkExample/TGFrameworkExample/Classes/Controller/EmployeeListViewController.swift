import UIKit
import TGFramework

class EmployeeListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var employeeListTableView:UITableView!
    var employeeListService: EmployeeListService!
    var employeeList = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        employeeListTableView.tableFooterView = UIView()
        /**
         * Service Name
         */
        self.navigationItem.title = "Employee List"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getEmployeeList()
    }
    
    // MARK: - Employee List Service
    /**
     * Call Employee List Service
     */
    func getEmployeeList() {
        var response: EmployeeListResponse!
        self.setProgressIndicatorWithTitle("Loading...", andDetail: "")
        progressIndicator.show(animated: true, whileExecuting: {() -> Void in
            let request = EmployeeListRequest()
            response = self.employee(list: request)
        }, completionBlock: {() -> Void in
            self.employeeList.removeAll()
            self.employeeList = response.employeeList
            self.employeeListTableView.reloadData()
        })
    }
    
    func employee(list request: EmployeeListRequest) -> EmployeeListResponse {
        if !(employeeListService != nil) {
            employeeListService = EmployeeListService.getInstance()
        }
        return employeeListService.employee(list: request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table Delegate
    func numberOfSections(in aTableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        
        let employee:Employee = employeeList[indexPath.row] as! Employee
        cell?.textLabel?.text = employee.name
        cell?.detailTextLabel?.text = employee.designation
        cell?.textLabel?.textColor = UIColor(colorLiteralRed: 24/255, green: 100/255, blue: 173/255, alpha: 1)
        cell?.detailTextLabel?.textColor = UIColor(colorLiteralRed: 125/255, green: 194/255, blue: 66/255, alpha: 1)
        
        return cell!
    }
}
