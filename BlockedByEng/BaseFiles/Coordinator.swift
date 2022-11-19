//
//  Coordinator.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 13/11/2022.
//

import Foundation
import UIKit 

protocol CoordinatorProtocol {
    var navController: UINavigationController { get set }
    func showWordsList(list: WordsList)
    func start()
}

final class Coordinator: CoordinatorProtocol {
    var navController: UINavigationController
    
    func start() {
        let vc = MainViewController(viewModel: createViewModel(), title: "Blocked by Eng")
        navController.pushViewController(vc, animated: false)
    }
    
    func showWordsList(list: WordsList) {
        let listViewModel = WordsViewControllerViewModel(wordsList: list, coordinator: self)
        let wordsListVC = WordsViewController(viewModel: listViewModel)
        navController.pushViewController(wordsListVC, animated: true)
    }
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    private func createViewModel() -> ViewControllerViewModelProtocol {
        ViewControllerViewModel(coordinator: self)
    }
}
