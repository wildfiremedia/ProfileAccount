import Turnstile        //comment out?
import TurnstileCrypto  //comment out?
import PostgresStORM
import StORM

open class ProfileAccount : PostgresStORM, Account {
    
    //in the setup() will created table structure below if not exist
    public var uniqueID             : String = ""
    public var fullname 			: String = ""
    public var firstname 			: String = ""
    public var lastname 			: String = ""
    public var gender 				: String = ""
    public var nationality 			: String = ""
    public var nric 				: String = ""
    public var dob                  : String = ""
    public var mobile 				: String = ""
    public var email 				: String = ""
    public var address1 			: String = ""
    public var postal               : String = ""
    public var photo				: String = ""
    public var height 				: String = ""
    public var weight 				: String = ""
    public var langproficiency 		: String = ""
    public var highedu              : String = ""
    public var fieldofstudy 		: String = ""
    public var school				: String = ""
    public var aboutme              : String = ""
    public var pastexperience		: String = ""
    public var medicalconditions	: String = ""
    public var jobsinterested		: String = ""
    public var agreement			: Int = 0
    public var timestampcreated     : String = ""
    public var timestampupdated     : String = ""
    
    
    /// The table to store the data
    override open func table() -> String {
        return "accountprofile"
    }
    
    /// Create/Make/Modified value
    //func make() throws {
      //  do {
    //        email =
        //} catch {
     //       print(error)
        //}
    //}

    
    /// Shortcut to store the unique id or render {{accountid}}
    public func id(_ newid: String) {
        uniqueID = newid
    }
    
    // to() mean retrieve from source to object
    // see code - to(self.results.rows[0])
    // will map the result of the first row to that of this object’s properties.
    /// Set incoming data from database to object
    override open func to(_ this: StORMRow) {
        uniqueID            = this.data["uniqueid"] as? String ?? ""
        fullname            = this.data["fullname"] as? String ?? ""
        firstname           = this.data["firstname"] as? String ?? ""
        lastname            = this.data["lastname"] as? String ?? ""
        gender              = this.data["gender"] as? String ?? ""
        nationality         = this.data["nationality"] as? String ?? ""
        nric                = this.data["nric"] as? String ?? ""
        dob                 = this.data["doc"] as? String ?? ""
        mobile              = this.data["mobile"] as? String ?? ""
        email               = this.data["email"] as? String ?? ""
        address1            = this.data["address1"] as? String ?? ""
        photo               = this.data["photo"] as? String ?? ""
        height              = this.data["height"] as? String ?? ""
        weight              = this.data["weight"] as? String ?? ""
        langproficiency     = this.data["langproficiency"] as? String ?? ""
        highedu             = this.data["highedu"] as? String ?? ""
        fieldofstudy        = this.data["fieldofstudy"] as? String ?? ""
        school              = this.data["school"] as? String ?? ""
        aboutme             = this.data["aboutme"] as? String ?? ""
        pastexperience      = this.data["pastexperience"] as? String ?? ""
        medicalconditions   = this.data["medicalconditions"] as? String ?? ""
        jobsinterested      = this.data["jobsinterested"] as? String ?? ""
    }
    
    /// Iterate through rows and set to object data
    public func rows() -> [ProfileAccount] {
        var rows = [ProfileAccount]()
        for i in 0..<self.results.rows.count {
            let row = ProfileAccount()      //Create class
            row.to(self.results.rows[i])    //see to() above, create obj fr data retrieve fr db
            rows.append(row)                //Append to array
        }
        return rows                         //Then return array
    }
    
    
    /// Performs a find on supplied username, and matches hashed password
    open func geta(_ un: String) throws -> ProfileAccount {
        let cursor = StORMCursor(limit: 1, offset: 0)   //Limit only one row
        do {
            try select(whereclause: "uniqueid = $1", params: [un], orderby: [], cursor: cursor)
            if self.results.rows.count == 0 {
                throw StORMError.noRecordFound
            }
            //Map first result to object in to(...)
            to(self.results.rows[0])    //Create obj then...
            return self                 //...return self
        } catch {
            print(error)
            throw StORMError.noRecordFound
        }
        
    }
    
    /// Returns a true / false depending on if the username exits in the database.
    
    open func existsid(_ un: String) -> Bool {
        do {
            try select(whereclause: "uniqueid = $1", params: [un], orderby: [], cursor: StORMCursor(limit: 1, offset: 0))
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

    func exists(_ un: String) -> Bool {
        do {
            try select(whereclause: "uniqueid = $1", params: [un], orderby: [], cursor: StORMCursor(limit: 1, offset: 0))
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

}
