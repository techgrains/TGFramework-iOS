import UIKit
import TGFramework

class ServiceViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var serviceListTableView:UITableView!
    var serviceList = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
//        self.navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 125/255, green: 194/255, blue: 66/255, alpha: 1)
//        self.navigationController?.navigationBar.tintColor = UIColor(colorLiteralRed: 24/255, green: 100/255, blue: 173/255, alpha: 1)
//        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor(colorLiteralRed: 24/255, green: 100/255, blue: 173/255, alpha: 1)]
        self.navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 24/255, green: 100/255, blue: 173/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        /**
         * Add service name in list
         */
        serviceList.append(["Service Name": "Create Employee"])
        serviceList.append(["Service Name": "Employee List"])
        serviceList.append(["Service Name": "Employee List with Name"])
        serviceListTableView.reloadData()
        serviceListTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Service List"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table Delegate
    
    /**
     * Render List of Service Name
     */
    
    func numberOfSections(in aTableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serviceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        
        let servicaNameDic = serviceList[indexPath.row] as! Dictionary<String, Any>
        cell?.textLabel?.text = servicaNameDic["Service Name"] as! String?
        cell?.textLabel?.textColor = UIColor(colorLiteralRed: 24/255, green: 100/255, blue: 173/255, alpha: 1)

        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(TGSession.isInternetAvailable()) {
            self.navigationItem.title = "Back"
            if (indexPath.row == 0) {
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "CreateEmployeeServiceVC") as! CreateEmployeeServiceViewController
                self.navigationController?.pushViewController(viewController, animated: true)
            } else if(indexPath.row == 1) {
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "EmployeeListVC") as! EmployeeListViewController
                self.navigationController?.pushViewController(viewController, animated: true)
            } else if(indexPath.row == 2) {
                let viewController = self.storyboard?.instantiateViewController(withIdentifier: "FilterEmployeeListVC") as! FilterEmployeeListViewController
                self.navigationController?.pushViewController(viewController, animated: true)
            }
        } else {
            TGUtil.showAlertView("Sorry", message: "Internet is not reachable.")
        }
    }
}
