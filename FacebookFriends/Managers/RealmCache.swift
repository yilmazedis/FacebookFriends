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
    
    private var realm: Realm {
        return try! Realm()
    }
    
    private init() {}
    
    func getCachedData(for url: String, completion: @escaping (Data?) -> Void) {
        var cachedData: CachedData?
        
        DispatchQueue.main.async {
            cachedData = self.realm.object(ofType: CachedData.self, forPrimaryKey: url)
                    
            if let expiryDate = cachedData?.expiryDate, expiryDate < Date() {
                // Cached data has expired, delete it from Realm and return nil.
                try! self.realm.write {
                    self.realm.delete(cachedData!)
                }
                FastLogger.log(what: K.DebugMessage.expiryDate, about: .info)
                cachedData = nil
                completion(cachedData?.data)
            } else {
                FastLogger.log(what: K.DebugMessage.fromCache, about: .info)
                completion(cachedData?.data)
            }
        }
    }
    
    func cacheData(_ data: Data, for url: String, expiryDate: Date?) {
        DispatchQueue.main.async {
            let cachedData = CachedData()
            cachedData.data = data
            cachedData.url = url
            cachedData.expiryDate = expiryDate
            
            try! self.realm.write {
                self.realm.create(CachedData.self, value: cachedData, update: .modified)
                FastLogger.log(what: K.DebugMessage.fromURL, about: .info)
            }
        }
    }
    
    func clearCache() {
        DispatchQueue.main.async {
            let cachedData = self.realm.objects(CachedData.self)
            try! self.realm.write {
                self.realm.delete(cachedData)
            }
        }
    }
}
