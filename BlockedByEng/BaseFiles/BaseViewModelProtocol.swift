//
//  BaseViewModelProtocol.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 17/11/2022.
//

import Foundation
protocol BaseViewModelProtocol {
    var coordinator: CoordinatorProtocol { get }
    var sqlManager: RealmManagerProtocol { get }
} 
