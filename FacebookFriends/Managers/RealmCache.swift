//
//  RealmCache.swift
//  FacebookFriends
//
//  Created by yilmaz on 14.04.2023.
//

import RealmSwift

class CachedData: Object {
    @objc dynamic var data: Data?
    @objc dynamic var url: String = ""
    @objc dynamic var expiryDate: Date?
    
    override static func primaryKey() -> String? {
        return "url"
    }
}

class CacheManager {
    
    static let shared = CacheManager()
    
    private let realmQueue = DispatchQueue(label: "realmQueue")
    private var realm: Realm {
        return try! Realm()
    }
    
    private init() {}
    
    func getCachedData(for url: String) -> Data? {
        var cachedData: CachedData?
        //var message = ""
        
        realmQueue.sync {
            cachedData = self.realm.object(ofType: CachedData.self, forPrimaryKey: url)
                    
            if let expiryDate = cachedData?.expiryDate, expiryDate < Date() {
                // Cached data has expired, delete it from Realm and return nil.
                try! self.realm.write {
                    self.realm.delete(cachedData!)
                }
                //message = K.DebugMessage.expiryDate
                cachedData = nil
            }
        }
        
        //message = K.DebugMessage.fromCache
        //FastLogger.log(what: message, about: .info)
        return cachedData?.data
    }
    
    func cacheData(_ data: Data, for url: String, expiryDate: Date?) {
        realmQueue.async {
            let cachedData = CachedData()
            cachedData.data = data
            cachedData.url = url
            cachedData.expiryDate = expiryDate
            
            try! self.realm.write {
                self.realm.create(CachedData.self, value: cachedData, update: .modified)
                //FastLogger.log(what: K.DebugMessage.fromURL, about: .info)
            }
        }
    }
    
    func clearCache() {
        realmQueue.async {
            let cachedData = self.realm.objects(CachedData.self)
            try! self.realm.write {
                self.realm.delete(cachedData)
            }
        }
    }
}
