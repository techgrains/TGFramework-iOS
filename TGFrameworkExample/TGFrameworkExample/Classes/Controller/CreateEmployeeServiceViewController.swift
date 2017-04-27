import UIKit
import TGFramework


class CreateEmployeeServiceViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    var createEmployeeService: EmployeeCreateService!
    @IBOutlet var name: UITextField!
    @IBOutlet var designation: UITextField!
    @IBOutlet var responseListTableView:UITableView!
    @IBOutlet var designationPickerView: UIPickerView!
    @IBOutlet var doneToolbar: UIToolbar!
    var selcetedDestignation: String!
    
    var responseList = [Any]()
    var designationList = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        
        /**
         * Set UITextField Border Color
         */
        let myColor : UIColor = UIColor(colorLiteralRed: 24/255, green: 100/255, blue: 173/255, alpha: 1)
        name.layer.borderColor = myColor.cgColor
        name.layer.borderWidth = 1.0
        name.layer.cornerRadius = 3.0
        designation.layer.borderColor = myColor.cgColor
        designation.layer.borderWidth = 1.0
        designation.layer.cornerRadius = 3.0
        
        /**
         * Service Name
         */
        self.navigationItem.title = "Create Employee"
        
        responseListTableView.reloadData()
        responseListTableView.tableFooterView = UIView()
        
        /**
         * Add designation in list
         */
        designationList.append("Director")
        designationList.append("Architect")
        designationList.append("Manager")
        designationList.append("Tester")
        designationPickerView.reloadAllComponents()
        
        designationPickerView.isHidden = true
        doneToolbar.isHidden = true
    }
    
    @IBAction func selectDesignation(_ sender: Any) {
        self.view.endEditing(true)
        designationPickerView.isHidden = false
        doneToolbar.isHidden = false
    }
    
    @IBAction func doneButtonClick(_ sender: UIBarButtonItem) {
        designation.text = selcetedDestignation
        designationPickerView.isHidden = true
        doneToolbar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /**
     * Call Create Employee Service
     */
    @IBAction func createEmployee(_ sender: Any) {
        self.view.endEditing(true)
        
        if(name.text?.characters.count != 0 && designation.text?.characters.count != 0) {
            var response: EmployeeCreateResponse!
            
            self.setProgressIndicatorWithTitle("Loading...", andDetail: "")
            progressIndicator.show(animated: true, whileExecuting: {() -> Void in
                let request = EmployeeCreateRequest()
                request.name = self.name.text!
                request.designation = self.designation.text!
                response = self.create(employee: request)
            }, completionBlock: {() -> Void in
                self.responseList.removeAll()
                self.responseList.append(response.employee)
                self.responseListTableView.reloadData()
            })
        } else {
            TGUtil.showAlertView("Sorry", message: "Please enter Name and Designation.")
        }
    }
    
    func create(employee request: EmployeeCreateRequest) -> EmployeeCreateResponse {
        if !(createEmployeeService != nil) {
            createEmployeeService = EmployeeCreateService.getInstance()
        }
        return createEmployeeService.createEmployee(with: request)
    }
    
    // MARK: - UITextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    // MARK: - Picker Delegate
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return designationList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return (designationList[row] as! String)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selcetedDestignation = designationList[row] as! String
    }
    
    // MARK: - Table Delegate
    
    func numberOfSections(in aTableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return responseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        
        let employee:Employee = responseList[indexPath.row] as! Employee
        cell?.textLabel?.text = employee.name
        cell?.detailTextLabel?.text = employee.designation
        cell?.textLabel?.textColor = UIColor(colorLiteralRed: 24/255, green: 100/255, blue: 173/255, alpha: 1)
        cell?.detailTextLabel?.textColor = UIColor(colorLiteralRed: 125/255, green: 194/255, blue: 66/255, alpha: 1)
        
        return cell!
    }
}
