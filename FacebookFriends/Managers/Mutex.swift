//
//  Mutex.swift
//  FacebookFriends
//
//  Created by yilmaz on 12.04.2023.
//

import Foundation

class Mutex {
    private let lock = NSLock()

    func sync<T>(_ closure: () -> T) -> T {
        lock.lock()
        defer { lock.unlock() }
        return closure()
    }
}
