//
//  BlockedByEngTests.swift
//  BlockedByEngTests
//
//  Created by Сергей Веретенников on 27/11/2022.
//

import Realm
import RealmSwift
import XCTest
import XCoordinator
import Combine
//@testable import BlockedByEng

final class BlockedByEngTests: XCTestCase {
    
    func testMainViewControllerModelCountInListTest() {
        ifTestFunc {
            let viewModel: MockMainVC = MockMainVC(router: UnownedRouter<MainRoute>.preview())
            viewModel.removeAll()
            let expection = 1
            viewModel.addNewListWith(title: "Foo", and: "Boo")
            
            XCTAssertTrue(viewModel.getNumberOfLists() == expection)
        }
    }
    
    func testMainViewContrikkerModelForReturningCellModel() {
        
        ifTestFunc {
            let viewModel: MockMainVC = MockMainVC(router: UnownedRouter<MainRoute>.preview())
            viewModel.removeAll()
            let title = "Fam"
            let lang = "Bam"
            
            let expectedWordList = WordsList()
            expectedWordList.listTitle = title
            expectedWordList.learningTitle = lang
            
            viewModel.addNewListWith(title: title, and: lang)
            viewModel.addNewListWith(title: "Foo", and: "Boo")
            
            let cellModel = viewModel.createCellViewModel(indexPath: IndexPath(row: 1, section: 0))
            let expectation = MainCellViewModel(wordsList: expectedWordList)
            
            XCTAssertTrue(expectation.getTitle() == cellModel.getTitle())
            XCTAssertTrue(expectation.getLearningTitle() == cellModel.getLearningTitle())
        }
    }
    
    func testIsRightWordInViewModelAfterInitialization() {
        
        ifTestFunc {
            let viewModel: MockMainVC = MockMainVC(router: UnownedRouter<MainRoute>.preview())
            viewModel.removeAll()
            let title = "Fam"
            let lang = "Bam"
            
            let wordNative = "Привет"
            let wordTranslate = "Hello"
            
            let word = Word()
            word.learningTitle = wordTranslate
            word.nativeTitle = wordNative
            
            let expectedWordList = WordsList()
            expectedWordList.listTitle = title
            expectedWordList.learningTitle = lang
            expectedWordList.wordsList.append(word)
            
            viewModel.addNewListWith(title: title, and: lang)
            let cellModel = viewModel.createCellViewModel(indexPath: IndexPath(row: 0, section: 0))
            
            
        }
    }
    
    private func ifTestFunc(action: () -> ()) {
        if UserDefaults.standard.bool(forKey: "testOnly") {
            action()
        }
    }
}


final class MockMainVC: ViewControllerViewModelProtocol {
    private var results: [WordsList]
    
    var reloader = PassthroughSubject<Void, Never>()
    var sqlManager: RealmManagerProtocol?
    var db = Set<AnyCancellable>()
    var router: UnownedRouter<MainRoute>
    
    func addNewListWith(title: String, and language: String) {
        let list = WordsList()
        list.learningTitle = language
        list.listTitle = title
        results.append(list)
    }
    
    func createCellViewModel(indexPath: IndexPath) -> MainCellViewModelProtocol {
        let wordsList = results.sorted(by: {$0 > $1})
        return MainCellViewModel(wordsList: wordsList[indexPath.row])
    }
    
    func getListFor(indexPath: IndexPath) {
        let wordsList = results.sorted(by: {$0 > $1})
        router.trigger(.wordListDetails(wordsList[indexPath.item]))
    }
    
    func getNumberOfLists() -> Int {
        results.count
    }
    
    init(router: UnownedRouter<MainRoute>) {
        self.router = router
        self.results = []
    }
}

//final class MockRealm: RealmManagerProtocol {
//    
//    private var realm: Realm!
//    
//    func addNew<T: Object>(word: T) {
//        
//        
//        enterRealm {
//            realm.add(word)
//        }
//    }
//    
//    func read<T: Object>() -> Results<T>? {
//        var result: Results<T>?
//        enterRealm {
//            result = realm.objects(T.self)
//        }
//        return result
//    }
//    
//    func removeAll() {
//        enterRealm {
//            realm.deleteAll()
//        }
//    }
//    
//    private func enterRealm(action: () -> Void) {
//        do {
//            try realm.write {
//                action()
//                try realm.commitWrite()
//                
//            }
//        } catch let error {
//            print(error)
//        }
//    }
//    
//    init(baseName: String) {
//        let fileManager = FileManager.default
//        var conf = Realm.Configuration()
//        
//        let urls = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask)
//        
//        if let applicationURL = urls.last {
//            do {
//                try fileManager.createDirectory(at: applicationURL, withIntermediateDirectories: true)
//                conf.fileURL = applicationURL.appendingPathComponent("\(baseName).realm")
//                self.realm = try Realm(configuration: conf)
//            } catch {
//                print(error)
//            }
//        }
//    }
//}
