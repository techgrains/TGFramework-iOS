import UIKit
import TGFramework

class UtilityViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet var utilityListTableView:UITableView!
    var utilityList = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 24/255, green: 100/255, blue: 173/255, alpha: 1)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        utilityList.append(["Utility Name": "String Has Value", "Info" : "Utility"])
        utilityList.append(["Utility Name": "String Has Value", "Info" : "(null)"])
        utilityList.append(["Utility Name": "Array Has Value", "Info" : "[1,2]"])
        utilityList.append(["Utility Name": "Array Has Value", "Info" : "[]"])
        utilityList.append(["Utility Name": "Dictionary Has Value", "Info" : "[key:value]"])
        utilityList.append(["Utility Name": "Dictionary Has Value", "Info" : "[:]"])
        
        
        utilityList.append(["Utility Name": "Current Time Stamp"])
        utilityList.append(["Utility Name": "Date To String", "Info" : "12/25/2016 (dd, MMM yyyy)"])
        utilityList.append(["Utility Name": "Current Date In String" ,"Info" : "dd/MM/yyyy"])
        utilityList.append(["Utility Name": "Change In Date Format", "Info" : "08-06-1990 (dd-MM-yyyy to MMM, dd yyyy)"])

        utilityListTableView.reloadData()
        utilityListTableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Utility List"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table Delegate
    
    func numberOfSections(in aTableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return utilityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell?
        
        cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell?.selectionStyle = UITableViewCellSelectionStyle.none
        
        let utilityDic = utilityList[indexPath.row] as! Dictionary<String, Any>
        cell?.textLabel?.text = utilityDic["Utility Name"] as! String?
        cell?.textLabel?.textColor = UIColor(colorLiteralRed: 24/255, green: 100/255, blue: 173/255, alpha: 1)
        cell?.detailTextLabel?.text = utilityDic["Info"] as! String?
        cell?.detailTextLabel?.textColor = UIColor(colorLiteralRed: 125/255, green: 194/255, blue: 66/255, alpha: 1)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let utilityDic = utilityList[indexPath.row] as! Dictionary<String, Any>
        
        if (indexPath.row == 0) {
            let result = TGUtil.stringHasValue((utilityDic["Info"] as! String?)!)
            TGUtil.showAlertView("Check String Has Value", message: "hasValue : " + TGUtil.getStringFromBoolianValue(result))
        } else if(indexPath.row == 1) {
            let result = TGUtil.stringHasValue("")
            TGUtil.showAlertView("Check String Has Value", message: "hasValue : " + TGUtil.getStringFromBoolianValue(result))
        } else if(indexPath.row == 2) {
            let result = TGUtil.arrayHasValue([1,2])
            TGUtil.showAlertView("Check Array Has Value", message: "hasValue : " + TGUtil.getStringFromBoolianValue(result))
        } else if(indexPath.row == 3) {
            let result = TGUtil.arrayHasValue([])
            TGUtil.showAlertView("Check Array Has Value", message: "hasValue : " + TGUtil.getStringFromBoolianValue(result))
        } else if(indexPath.row == 4) {
            let result = TGUtil.dictionaryHasValue(["key": "value"])
            TGUtil.showAlertView("Check Dictionary Has Value", message: "hasValue : " + TGUtil.getStringFromBoolianValue(result))
        } else if(indexPath.row == 5) {
            let result = TGUtil.dictionaryHasValue([:])
            TGUtil.showAlertView("Check Dictionary Has Value", message: "hasValue : " + TGUtil.getStringFromBoolianValue(result))
        }
        
        
        
        else if(indexPath.row == 6) {
            let currentTimeStamp = TGUtil.currentTimeStamp()
            TGUtil.showAlertView("Current Time Stamp", message: currentTimeStamp)
        } else if(indexPath.row == 7) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM/dd/yyyy"
            let myDate = dateFormatter.date(from: "12/25/2016")
            
            let dateString = TGUtil.dateToString(myDate!, formate: "dd, MMM yyyy")
            TGUtil.showAlertView("Date To String", message: dateString)
        } else if(indexPath.row == 8) {
            let dateString = TGUtil.currentDateInString(dateFormat: "dd/MM/yyyy")
            TGUtil.showAlertView("Current Date", message: dateString)
        } else if(indexPath.row == 9) {
            let formatedString = TGUtil.changeInDateFormat(inputString: "08-06-1990", fromFormate: "dd-MM-yyyy", toFormate: "MMM, dd yyyy")
            TGUtil.showAlertView("Date Formate", message: formatedString)
        }
    }
}
