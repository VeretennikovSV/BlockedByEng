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
        print("User Realm User file location: \(realm.configuration.fileURL!.path)")
        
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
        let conf = Realm.Configuration(schemaVersion: 4) { migration, oldSchemaVersion in
            migration.enumerateObjects(ofType: "WordsList") { oldObject, newObject in
                newObject?["learningTitle"] = "default"
            }
        }
        do {
            self.realm = try Realm(configuration: conf)
        } catch let error {
            print(error)
            fatalError()
        }
    }
}
