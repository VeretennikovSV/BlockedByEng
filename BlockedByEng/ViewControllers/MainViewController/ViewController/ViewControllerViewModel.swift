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
import XCoordinator
import XCoordinatorCombine

protocol ViewControllerViewModelProtocol: BaseViewModelProtocol {
    var reloader: PassthroughSubject<Void, Never> { get set }
    var db: Set<AnyCancellable> { get set }
    var router: UnownedRouter<MainRoute> { get set }
    
    func addNewListWith(title: String, and language: String)
    func createCellViewModel(indexPath: IndexPath) -> MainCellViewModelProtocol
    func getListFor(indexPath: IndexPath)
    func getNumberOfLists() -> Int
}

class ViewControllerViewModel: ViewControllerViewModelProtocol {
    private var results: Results<WordsList>?
    var router: UnownedRouter<MainRoute>
    
    var sqlManager: RealmManagerProtocol?
    var reloader = PassthroughSubject<Void, Never>()
    var db = Set<AnyCancellable>()
    
    init(
        sqlManager: RealmManagerProtocol = RealmManager(),
        router: UnownedRouter<MainRoute>
    ) {
        self.sqlManager = sqlManager
        self.results = sqlManager.read()
        self.router = router
        
        reloader.send(())
    }
    
    func addNewListWith(title: String, and language: String) {
        let list = WordsList()
        list.listTitle = title
        list.learningTitle = language
        
        sqlManager?.addNew(word: list)
        reloader.send(())
    }
    
    func createCellViewModel(indexPath: IndexPath) -> MainCellViewModelProtocol {
        guard let wordsList = results?.sorted(by: {$0.creationDate > $1.creationDate}) else { return MainCellViewModel(wordsList: WordsList()) }
        return MainCellViewModel(wordsList: wordsList[indexPath.row])
    }
    
    func getListFor(indexPath: IndexPath) {
        guard let wordsList = results?.sorted(by: {$0.creationDate > $1.creationDate}) else { return }
        router.trigger(.wordListDetails(wordsList[indexPath.item]))
    }
    
    func getNumberOfLists() -> Int {
        results?.count ?? 0
    }
}

extension ViewControllerViewModelProtocol {
    #if DEBUG
    
    func removeAll() {
        sqlManager?.removeAll()
    }
    
    #endif
}
