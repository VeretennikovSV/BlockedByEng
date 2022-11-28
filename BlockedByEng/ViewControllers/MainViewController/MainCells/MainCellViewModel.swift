//
//  MainCellViewModel.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 13/11/2022.
//

import Foundation

protocol MainCellViewModelProtocol {
    func getTitle() -> String
    func getLearningTitle() -> String
    func getNumberOfWords() -> String
    func addWord(word: Word)
}

final class MainCellViewModel: MainCellViewModelProtocol {
    private let wordsList: WordsList
    
    init(
        wordsList: WordsList
    ) {
        self.wordsList = wordsList
    }
    
    func getNumberOfWords() -> String {
        String(wordsList.wordsList.count)
    }
    
    func getTitle() -> String {
        wordsList.listTitle
    }
    
    func getLearningTitle() -> String {
        wordsList.learningTitle
    }
    
    func addWord(word: Word) {
        wordsList.wordsList.append(word)
    }
}
