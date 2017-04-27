import UIKit
import TGFramework

class FilterEmployeeListViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var employeeListTableView:UITableView!
    @IBOutlet var filterTextField:UITextField!
    
    var filterEmployeeListService: FilterEmployeeListService!
    var employeeList = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         * Show NavigationBar
         */
        self.navigationController?.navigationBar.isHidden = false
        /**
         * Set UITextField Border Color
         */
        let myColor : UIColor = UIColor(colorLiteralRed: 24/255, green: 100/255, blue: 173/255, alpha: 1)
        filterTextField.layer.borderColor = myColor.cgColor
        filterTextField.layer.borderWidth = 1.0
        filterTextField.layer.cornerRadius = 3.0
        
        employeeListTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        /**
         * Service Name
         */
        self.navigationItem.title = "Employee List with Name"
    }
    @IBAction func filterClick(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if((filterTextField.text?.characters.count)! > 0) {
            employeeListWithFilter()
        } else {
            TGUtil.showAlertView("Sorry", message: "Please enter filter Name.")
            self.employeeList.removeAll()
            self.employeeListTableView.reloadData()
        }
    }
    
    // MARK: - Employee List with filter Service
    /**
     * Call Employee List with filter Service
     */
    func employeeListWithFilter() {
        var response: FilterEmployeeListResponse!
        
        self.setProgressIndicatorWithTitle("Loading...", andDetail: "")
        progressIndicator.show(animated: true, whileExecuting: {() -> Void in
            let request = FilterEmployeeListRequest()
            request.name = self.filterTextField.text!
            response = self.employeeList(withFilter: request)
        }, completionBlock: {() -> Void in
            self.employeeList.removeAll()
            self.employeeList = response.employeeList
            if(self.employeeList.count == 0) {
                TGUtil.showAlertView("Sorry", message: "No found record!")
            }
            self.employeeListTableView.reloadData()
        })
    }
    
    func employeeList(withFilter request: FilterEmployeeListRequest) -> FilterEmployeeListResponse {
        if !(filterEmployeeListService != nil) {
            filterEmployeeListService = FilterEmployeeListService.getInstance()
        }
        return filterEmployeeListService.employeeList(withFilter: request)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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

