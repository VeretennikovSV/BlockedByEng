//
//  RealmManager.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 13/11/2022.
//

import Foundation
import Realm
import RealmSwift
import Combine

protocol RealmManagerProtocol {
    func addNew<T: Object>(word: T)
    func read<T: Object>() -> Results<T>?
    func removeAll()
}

final class RealmManager: RealmManagerProtocol {
    
    private var realm: Realm!
    
    func addNew<T: Object>(word: T) {
        
        enterRealm {
            realm.add(word)
        }
    }
    
    func read<T: Object>() -> Results<T>? {
        var result: Results<T>?
        enterRealm {
            result = realm.objects(T.self)
        }
        return result
    }
    
    func removeAll() {
        enterRealm {
            realm.deleteAll()
        }
    }
    
    private func enterRealm(action: () -> Void) {
        do {
            try realm.write {
                action()
                try realm.commitWrite()
                
            }
        } catch let error {
            print(error)
        }
    }
    
    init() {
    let fileManager = FileManager.default
    var conf = Realm.Configuration()
    
    let urls = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask)
    
        if let applicationURL = urls.last {
            do {
                try fileManager.createDirectory(at: applicationURL, withIntermediateDirectories: true)
                conf.fileURL = applicationURL.appendingPathComponent("release.realm")
                self.realm = try Realm(configuration: conf)
            } catch {
                print(error)
            }
        }
    }
}
