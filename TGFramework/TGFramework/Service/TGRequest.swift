import Foundation

open class TGRequest: NSObject {
    
    public var serverURL: String = ""
    public var caller: String = ""
    public var version: String = ""
    
    /**
     * Initialize Request variables.
     */
    public override init() {
        super.init()
        
        caller = "iOS"
        var bundleInfo: [AnyHashable: Any]? = Bundle.main.infoDictionary
        version = bundleInfo?["CFBundleShortVersionString"] as! String
        
    }
}
