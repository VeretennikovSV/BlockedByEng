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

protocol ViewControllerViewModelProtocol: BaseViewModelProtocol {
    var reloader: PassthroughSubject<Void, Never> { get set }
    var db: Set<AnyCancellable> { get set }
    
    
    func addNewListWith(title: String, and language: String)
    func createCellViewModel(indexPath: IndexPath) -> MainCellViewModelProtocol
    func getListFor(indexPath: IndexPath) -> WordsList
    func getNumberOfLists() -> Int
}

final class ViewControllerViewModel: ViewControllerViewModelProtocol {
    private var results: Results<WordsList>?
    
    let coordinator: CoordinatorProtocol
    let sqlManager: RealmManagerProtocol
    var reloader = PassthroughSubject<Void, Never>()
    var db = Set<AnyCancellable>()
    
    init(
        coordinator: CoordinatorProtocol,
        sqlManager: RealmManagerProtocol = RealmManager()
    ) {
        self.sqlManager = sqlManager
        self.coordinator = coordinator
        self.results = sqlManager.read()
        
        reloader.send(())
    }
    
    func addNewListWith(title: String, and language: String) {
        let list = WordsList()
        list.listTitle = title
        list.learningTitle = language
        
        sqlManager.addNew(word: list)
        reloader.send(())
    }
    
    func createCellViewModel(indexPath: IndexPath) -> MainCellViewModelProtocol {
        guard let wordsList = results?.sorted(by: {$0.creationDate > $1.creationDate}) else { return MainCellViewModel(wordsList: WordsList()) }
        return MainCellViewModel(wordsList: wordsList[indexPath.row])
    }
    
    func getListFor(indexPath: IndexPath) -> WordsList {
        guard let wordsList = results?.sorted(by: {$0.creationDate > $1.creationDate}) else { return WordsList() }
        return wordsList[indexPath.item]
    }
    
    func getNumberOfLists() -> Int {
        results?.count ?? 0
    }
}
