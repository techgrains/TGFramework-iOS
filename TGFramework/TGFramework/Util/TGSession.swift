import Foundation
import UIKit
import SystemConfiguration

open class TGSession: NSObject {
    
    // Static singleton instance
    private static var session: TGSession? = nil
    
    // Non-static member variables
    public var createdAt:Double? = 0.0
    
    /**
     * Initialize session member variables.
     */
    public override init() {
        super.init()
        createdAt = Double(TGUtil.currentTimeStamp())!
    }

    
    /**
     * Returns current active session. It creates if not present or invalidated before.
     *
     * @return Current session if its already created. Otherwise creates new session.
     */
    public class func instance() -> TGSession {
        let lockQueue = DispatchQueue(label: "self")
        lockQueue.sync {
            if self.session == nil {
                self.session = TGSession.init()
            }
        }
        return self.session!
    }
    
    /**
     * Number of milliseconds passed since valid session has been created.
     *
     * @return Milliseconds
     */
    public func validSince() -> Float{
        return Float(TGUtil.currentTimeStamp())! - Float(createdAt!)
    }
    
    /**
     * Check Internet rechability
     *
     * @return Bool
     */
    public class func isInternetAvailable() -> Bool
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
}
