//
//  ViewController.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 13/11/2022.
//

import UIKit

final class MainViewController: BaseViewController {

    let viewModel: ViewControllerViewModelProtocol
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        title = "Blocked by eng"
    }
    
    init(viewModel: ViewControllerViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

