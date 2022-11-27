//
//  WordsViewControllerViewModel.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 17/11/2022.
//

import Foundation
import XCoordinator

protocol WordsViewControllerViewModelProtocol: BaseViewModelProtocol {
    var router: UnownedRouter<MainRoute> { get set }
    func getWord() -> Word
}

final class WordsViewControllerViewModel: WordsViewControllerViewModelProtocol {
    private let wordsList: WordsList
    
    let sqlManager: RealmManagerProtocol
    var router: UnownedRouter<MainRoute>
    
    init(
        wordsList: WordsList,
        sqlManager: RealmManagerProtocol = RealmManager(),
        router: UnownedRouter<MainRoute>
    ) {
        self.wordsList = wordsList
        self.sqlManager = sqlManager
        self.router = router
    }
    
    func getWord() -> Word {
        return wordsList.wordsList.randomElement() ?? Word()
    }
}
