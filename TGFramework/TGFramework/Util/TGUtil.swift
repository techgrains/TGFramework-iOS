import Foundation
import UIKit

open class TGUtil:NSObject {
    
    override init() {
        super.init()
    }
    
    /**
     * Check String Of Value
     * @param stringValue String
     * @return Boolian
     */
    public class func stringHasValue(_ stringValue: String) -> Bool {
        if stringValue.isEmpty {
            return false
        }else {
            return true
        }
    }
    
    /**
     * Check Array Of Value
     * @param arrayValue Array
     * @return Boolian
     */
    public class func arrayHasValue(_ arrayValue: [Any]) -> Bool {
        if arrayValue.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    /**
     * Check Dictionary Of Value
     * @param dictionaryValue String
     * @return boolean
     */
    public class func dictionaryHasValue(_ dictionaryValue: [AnyHashable: Any]) -> Bool {
        if dictionaryValue.isEmpty {
            return false
        } else {
            return true
        }
    }
    
    /**
     * Get String From Boolian Of Value
     * @param boolianValue String
     * @return String
     */
    public class func getStringFromBoolianValue(_ boolianValue: Bool) -> String {
        if boolianValue {
            return "true"
        }else {
            return "false"
        }
    }
    
    /**
     * Get Boolian From String Of Value
     * @param boolianText String
     * @return String
     */
    public class func getBoolianValue(_ boolianText: String) -> Bool {
        if (boolianText == "true") || (boolianText == "YES") || (boolianText == "1") {
            return true
        }else {
            return false
        }
    }
    
    /**
     * Logs provided logText
     * @param logText String
     */
    public class func log(_ logText: String) {
        print(logText);
    }
    
    /**
     * Current Time Stamp in TimeInterval
     * @return String - formatted string
     */
    public class func currentTimeStamp() -> String {
        let timeStamp: TimeInterval = (Date().timeIntervalSince1970)
        return "\(timeStamp)"
    }
    
    /**
     * Convert Date into String Date
     * @param date Date
     * @return String - formatted string
     */
    public class func dateToString(_ date: Date, formate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = formate
        return dateFormatter.string(from: date)
    }
    
    /**
     * Convert Current Date into String Date
     * @param dateFormat String
     * @return String - formatted string
     */
    public class func currentDateInString(dateFormat: String) -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        //dateFormatter.dateStyle = .long
        dateFormatter.dateFormat = dateFormat
        return dateFormatter.string(from: date)
    }
    
    /**
     * Convert Date into TimeInterval
     * @param intervalSecond Intger
     * @return String - formatted string
     */
    public class func timeIntervalToDateInString(_ intervalSecond: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(intervalSecond))
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    /**
     * Format Date with pattern
     * @param inputString String
     * @param fromFormate String
     * @param toFormate String
     * @return String - formatted string
     */
    public class func changeInDateFormat(inputString: String, fromFormate: String, toFormate: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = fromFormate
        let date = formatter.date(from: inputString)
        formatter.dateFormat = toFormate
        let outputString: String = formatter.string(from: date!)
        return outputString
    }
    
    /**
     * Show alert View
     * @param title String
     * @param msg String
     */
    public class func showAlertView(_ title: String, message msg: String) {
        DispatchQueue.main.async(execute: {() -> Void in
            let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(ok)
            let top: UIViewController? = UIApplication.shared.keyWindow?.rootViewController
            top?.present(alertController, animated: true, completion: { _ in })
        })
    }
}
