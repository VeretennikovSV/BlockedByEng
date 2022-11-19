//
//  MainViewCoordinator.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 19/11/2022.
//

import Foundation
import XCoordinator

enum MainRoute: Route {
    case mainView
    case wordListDetails(WordsList)
}

final class MainViewCoordinator: NavigationCoordinator<MainRoute> {
    
    init() {
        super.init(initialRoute: .mainView)
    }
    
    override func prepareTransition(for route: MainRoute) -> NavigationTransition {
        switch route {
        case .mainView:
            let vc = MainViewController(viewModel: ViewControllerViewModel(router: unownedRouter), title: "Learn It!")
            return .push(vc)
        case .wordListDetails(let wordsList):
            let viewModel = WordsViewControllerViewModel(wordsList: wordsList)
            let vc = WordsViewController(viewModel: viewModel)
            return .show(vc)
        }
    }
} 
