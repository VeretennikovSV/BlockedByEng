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
    var results: Results<WordsList>? { get }
    var reloader: PassthroughSubject<Void, Never> { get set }
    var db: Set<AnyCancellable> { get set }
    
    func createCellViewModel(indexPath: IndexPath) -> MainCellViewModelProtocol
}

final class ViewControllerViewModel: ViewControllerViewModelProtocol {
    let coordinator: CoordinatorProtocol
    let sqlManager: RealmManagerProtocol
    var results: Results<WordsList>?
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
        
        let list = WordsList()
        
        let word1 = Word()
        word1.learningTitle = "Eng"
        word1.nativeTitle = "rus"
        sqlManager.addNew(word: word1)
        
        list.wordsList.insert(word1, at: 0)
        list.listTitle = "My test words"
        sqlManager.addNew(word: list)
        
        reloader.send(())
    }
    
    func createCellViewModel(indexPath: IndexPath) -> MainCellViewModelProtocol {
        guard let wordsList = results?.sorted(by: {$0.creationDate < $1.creationDate}) else { return MainCellViewModel(wordsList: WordsList()) }
        return MainCellViewModel(wordsList: wordsList[indexPath.row])
    }
}
