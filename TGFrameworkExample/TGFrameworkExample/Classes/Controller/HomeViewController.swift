import UIKit

class HomeViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var functionalityTableView:UITableView!
    var serviceList = [Any]()
    
    convenience init() {
        self.init()
        // Get Instance Of Session Manager
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
         * Add functionality name in list
         */
        serviceList.append(["Functionality Name": "Service"])
        serviceList.append(["Functionality Name": "Utility"])
        functionalityTableView.reloadData()
        functionalityTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table Delegate
    
    /**
     * Render List of functionality
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
        cell?.textLabel?.text = servicaNameDic["Functionality Name"] as! String?
        cell?.textLabel?.textColor = UIColor(colorLiteralRed: 24/255, green: 100/255, blue: 173/255, alpha: 1)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.row == 0) {
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "ServiceViewController") as! ServiceViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        } else if(indexPath.row == 1) {
            let viewController = self.storyboard?.instantiateViewController(withIdentifier: "UtilityVC") as! UtilityViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
}
