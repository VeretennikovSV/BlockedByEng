//
//  ViewControllerViewModel.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 13/11/2022.
//

import Foundation
import Realm
import RealmSwift
import Combine

protocol ViewControllerViewModelProtocol {
    var coordinator: CoordinatorProtocol { get }
    var sqlManager: RealmManagerProtocol { get }
    var results: Results<Word>? { get }
    var reloader: PassthroughSubject<Void, Never> { get set }
    var db: Set<AnyCancellable> { get set }
}

final class ViewControllerViewModel: ViewControllerViewModelProtocol {
    let coordinator: CoordinatorProtocol
    let sqlManager: RealmManagerProtocol
    var results: Results<Word>?
    var reloader = PassthroughSubject<Void, Never>()
    var db = Set<AnyCancellable>()
    
    init(
        coordinator: CoordinatorProtocol,
        sqlManager: RealmManagerProtocol = RealmManager()
    ) {
        self.sqlManager = sqlManager
        self.sqlManager.removeAll()
        self.coordinator = coordinator
        self.results = sqlManager.read()
        
    }
}
