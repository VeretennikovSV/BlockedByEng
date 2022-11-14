//
//  BaseViewController.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 13/11/2022.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationSettings()
    }
    
    private func setNavigationSettings() {
        let navApp = UINavigationBarAppearance()
        navApp.backgroundColor = #colorLiteral(red: 0, green: 0.6058987975, blue: 1, alpha: 1)
        
        navApp.largeTitleTextAttributes = [.font: UIFont.systemFont(ofSize: 24), .foregroundColor: UIColor.white]
        navApp.titleTextAttributes = [.font: UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.white]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        navigationController?.navigationBar.scrollEdgeAppearance = navApp
        navigationController?.navigationBar.standardAppearance = navApp
        navigationController?.navigationBar.compactAppearance = navApp
    }
}
