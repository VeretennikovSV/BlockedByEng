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
    func addNew(word: Word)
    func read() -> Results<Word>?
    func removeAll()
}

final class RealmManager: RealmManagerProtocol {
    
    private var realm: Realm!
    
    func addNew(word: Word) {
        print("User Realm User file location: \(realm.configuration.fileURL!.path)")
        
        enterRealm {
            realm.add(word)
        }
    }
    
    func read() -> Results<Word>? {
        var result: Results<Word>?
        enterRealm {
            print(realm.objects(Word.self))
            result = realm.objects(Word.self)
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
        do {
            self.realm = try Realm(configuration: .defaultConfiguration)
        } catch let error {
            print(error)
            fatalError()
        }
    }
}
