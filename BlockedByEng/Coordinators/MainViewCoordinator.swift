//
//  MainViewCoordinator.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 19/11/2022.
//

import UIKit
import XCoordinator

enum MainRoute: Route {
    case mainView
    case wordListDetails(WordsList)
    case cards
    case test
    case dictant
    case match
}

final class MainViewCoordinator: NavigationCoordinator<MainRoute> {
    
    init() {
        super.init(initialRoute: .mainView)
    }
    
    override func prepareTransition(for route: MainRoute) -> NavigationTransition {
        switch route {
        case .mainView:
            if UserDefaults.standard.bool(forKey: "testOnly") {
                return .show(UIViewController())
            } else {
                let vc = MainViewController(viewModel: ViewControllerViewModel(sqlManager: RealmManager() ,router: unownedRouter), title: "Learn It!")
                return .push(vc)
            }
        case .wordListDetails(let wordsList):
            let viewModel = WordsViewControllerViewModel(wordsList: wordsList, router: unownedRouter)
            let vc = WordsViewController(viewModel: viewModel)
            return .show(vc)
        case .test: 
            return .show(UIViewController())
        case .dictant:
            return .show(UIViewController())
        case .cards:
            return .show(UIViewController())
        case .match:
            return .show(UIViewController())
        }
    }
} 
