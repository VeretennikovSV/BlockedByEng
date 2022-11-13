//
//  ViewControllerViewModel.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 13/11/2022.
//

import Foundation
import Realm
import RealmSwift

protocol ViewControllerViewModelProtocol {
    var coordinator: CoordinatorProtocol { get }
    var sqlManager: RealmManagerProtocol { get }
    var results: Results<Word>? { get }
}

final class ViewControllerViewModel: ViewControllerViewModelProtocol {
    let coordinator: CoordinatorProtocol
    let sqlManager: RealmManagerProtocol
    let results: Results<Word>?
    
    init(
        coordinator: CoordinatorProtocol,
        sqlManager: RealmManagerProtocol = RealmManager()
    ) {
        self.sqlManager = sqlManager
        self.coordinator = coordinator
        self.results = sqlManager.read()
    }
}
