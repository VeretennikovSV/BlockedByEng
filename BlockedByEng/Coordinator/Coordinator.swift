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
    
    func start()
}

final class Coordinator: CoordinatorProtocol {
    var navController: UINavigationController
    
    func start() {
        let vc = MainViewController(viewModel: createViewModel())
        navController.pushViewController(vc, animated: false)
    }
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    private func createViewModel() -> ViewControllerViewModelProtocol {
        ViewControllerViewModel(coordinator: self)
    }
}
