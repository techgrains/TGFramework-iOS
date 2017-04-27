import Foundation

open class TGResponse: NSObject {
    
    public var success: Bool = false
    public var errorCode: Int = 0
    public var message: String = ""
    public var timestamp: Float = 0
    public var status: String = ""
    public var error: String = ""
    
    public var statusCode:Int = 0
    public var headers : Dictionary<AnyHashable, Any>?
    public var networkResponse:String = ""
    public var networkTimeInMillis: Double = 0
    //public var error : TGError?
    
    
    /**
     * Initialize Response variables.
     */
    public override init() {
        super.init()
    }
}
