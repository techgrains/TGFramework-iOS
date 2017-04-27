import UIKit
import Foundation
import QuartzCore
import TGFramework
import SystemConfiguration

class BaseViewController: UIViewController, MBProgressHUDDelegate {
    var progressIndicator: MBProgressHUD!
    var session: TGSession!
    
    convenience init() {
        self.init()
        // Get Instance Of Session Manager
        session = TGSession.instance()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    /**
     * Trim String
     * @param string String
     * @param range Int
     * @return String - formatted string
     */
    func trimStringFromRange(_ string:String,_ range:Int) -> String {
        let startIndex = string.index(string.startIndex, offsetBy: string.characters.count > range ? range : string.characters.count)
        return string.substring(to: startIndex)
    }
    
    /**
     * Get Application Delegate
     * @return AppDelegate
     */
    func appDelegate() -> AppDelegate {
        return (UIApplication.shared.delegate! as? AppDelegate)!
    }
    
    // Get Whole Screen
    /**
     * Get Screen
     * @return window
     */
    func getAppScreen() -> UIWindow {
        return self.appDelegate().window!
    }
    
    /**
     * Check Internet Rechability
     * @return Bool
     */
    public func isInternetAvailable() -> Bool
    {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
    
    /**
     * Progress Indicator Method
     */
    func setProgressIndicatorWithTitle(_ title: String, andDetail detail: String) {
        // Hide Any Ongoing Progress Indicator
        if progressIndicator != nil {
            progressIndicator.hide(true)
            progressIndicator = nil
        }
        // Show Indicator
        progressIndicator = MBProgressHUD(window: self.getAppScreen())
        self.getAppScreen().addSubview(progressIndicator)
        progressIndicator.dimBackground = true
        //progressIndicator.delegate = self
        progressIndicator.labelText = title
        progressIndicator.detailsLabelText = detail
        progressIndicator.animationType = MBProgressHUDAnimationZoomOut
        progressIndicator.mode = MBProgressHUDModeIndeterminate
    }
    
     func showProgressIndicator() {
        // Display Indicator
        if progressIndicator != nil {
            progressIndicator.show(false)
        }
    }
    
    func showProgressIndicator(withTitle title: String, andDetail detail: String, animated: Bool) {
        // Set Indicator Details
        self.setProgressIndicatorWithTitle(title, andDetail: detail)
        // Display Indicator
        self.showProgressIndicator()
    }
    
     func hideProgressIndicator(_ animated: NSNumber) {
        // Hide Indicator
        if progressIndicator != nil {
            progressIndicator.hide(animated != 0)
            progressIndicator = nil
        }
    }
    
     func updateProgressIndicatorTitle(_ title: String, andDetail detail: String) {
        DispatchQueue.main.sync() {
            progressIndicator.labelText = title
            progressIndicator.detailsLabelText = detail
            progressIndicator.setNeedsDisplay()
        }
    }
    
    // MBProgressHUD Delegate Methods
    
     func hudWasHidden(_ hud: MBProgressHUD) {
        // Remove HUD from screen when the HUD was hidded
        if progressIndicator != nil {
            progressIndicator.removeFromSuperview()
            progressIndicator = nil
        }
    }
}
