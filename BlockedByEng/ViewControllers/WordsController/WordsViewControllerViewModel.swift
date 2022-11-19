//
//  WordsViewControllerViewModel.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 17/11/2022.
//

import Foundation

protocol WordsViewControllerViewModelProtocol: BaseViewModelProtocol {
    func getWord() -> Word
}

final class WordsViewControllerViewModel: WordsViewControllerViewModelProtocol {
    private let wordsList: WordsList
    
    let coordinator: CoordinatorProtocol
    let sqlManager: RealmManagerProtocol
    
    init(
        wordsList: WordsList,
        coordinator: CoordinatorProtocol,
        sqlManager: RealmManagerProtocol = RealmManager()
    ) {
        self.wordsList = wordsList
        self.coordinator = coordinator
        self.sqlManager = sqlManager
    }
    
    func getWord() -> Word {
        return wordsList.wordsList.randomElement() ?? Word()
    }
}
