//
//  EmptyRouter.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 27/11/2022.
//

import XCoordinator
import UIKit

class EmptyRouter<T: Route>: Router {
    var viewController: UIViewController!
    func contextTrigger(_ route: T, with options: XCoordinator.TransitionOptions, completion: XCoordinator.ContextPresentationHandler?) {}
}

extension UnownedRouter {
    static func preview<T: Route>() -> UnownedRouter<T> {
        return UnownedRouter(EmptyRouter<T>(), erase: { StrongRouter<T>($0) })
    }
}
