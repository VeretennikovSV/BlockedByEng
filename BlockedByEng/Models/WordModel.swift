//
//  WordModel.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 13/11/2022.
//

import Foundation
import Realm
import RealmSwift

final class Word: Object {
    @Persisted var nativeTitle: String = ""
    @Persisted var learningTitle: String = ""
    @Persisted var creationDate: Date = Date()
}

final class WordsList: Object {
    @Persisted var listTitle: String = ""
    @Persisted var creationDate: Date = Date()
    @Persisted var wordsList: List<Word> 
    @Persisted var learningTitle: String = ""
}

