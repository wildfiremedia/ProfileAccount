import Turnstile        //comment out?
import TurnstileCrypto  //comment out?
import PostgresStORM
import StORM

open class ProfileAccount : PostgresStORM, Account {
    
    public var uniqueID: String = ""
    public var fullname: String = ""
    public var firstname: String = ""
    public var lastname: String = ""
    public var email: String = ""
    
    
    /// The table to store the data
    override open func table() -> String {
        return "accountprofile"
    }
    
    /// Shortcut to store the unique id or render {{accountid}}
    public func id(_ newid: String) {
        uniqueID = newid
    }
    
    // to() mean retrieve from source to object
    // see code - to(self.results.rows[0])
    // will map the result of the first row to that of this object’s properties.
    /// Set incoming data from database to object
    override open func to(_ this: StORMRow) {
        uniqueID	= this.data["uniqueid"] as? String ?? ""
        fullname	= this.data["fullname"] as? String ?? ""
        firstname	= this.data["firstname"] as? String ?? ""
        lastname	= this.data["lastname"] as? String ?? ""
        email		= this.data["email"] as? String ?? ""
    }
    
    /// Iterate through rows and set to object data
    public func rows() -> [ProfileAccount] {
        var rows = [ProfileAccount]()
        for i in 0..<self.results.rows.count {
            let row = ProfileAccount()      //Create class
            row.to(self.results.rows[i])    //Create object from data retrieve from db
            rows.append(row)                //Append to array
        }
        return rows                         //Then return array
    }
    
    
    //TODO: modify for retrieve user profile if has unique ID after login
    /// Performs a find on supplied username, and matches hashed password
    open func get(_ un: String, _ pw: String) throws -> AuthAccount {
        let cursor = StORMCursor(limit: 1, offset: 0)   //Limit only one row
        do {
            try select(whereclause: "username = $1", params: [un], orderby: [], cursor: cursor)
            if self.results.rows.count == 0 {
                throw StORMError.noRecordFound
            }
            //Map first result to object in to(...)
            to(self.results.rows[0])
        } catch {
            print(error)
            throw StORMError.noRecordFound
        }
        
        //Encrypt user pwd and bcrypt before matching existing acc
        if try BCrypt.verify(password: pw, matchesHash: password) {
            //self is returning "PerfectTurnstilePostgreSQL.AuthAccount"
            return self
        } else {
            throw StORMError.noRecordFound  //return if user acc not found
        }
        
    }
    
    /// Returns a true / false depending on if the username exits in the database.
    /*
     func exists(_ un: String) -> Bool {
     do {
     try select(whereclause: "username = $1", params: [un], orderby: [], cursor: StORMCursor(limit: 1, offset: 0))
     if results.rows.count == 1 {
     return true
     } else {
     return false
     }
     } catch {
     print("Exists error: \(error)")
     return false
     }
     }
     */
}
