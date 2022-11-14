//
//  MainCellViewModel.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 13/11/2022.
//

import Foundation

protocol MainCellViewModelProtocol {
    var wordsList: WordsList { get set }
}

final class MainCellViewModel: MainCellViewModelProtocol {
    var wordsList: WordsList
    
    init(
        wordsList: WordsList
    ) {
        self.wordsList = wordsList
    }
}
