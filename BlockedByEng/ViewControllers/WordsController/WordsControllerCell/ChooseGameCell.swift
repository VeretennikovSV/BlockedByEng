//
//  ChooseGameCell.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 27/11/2022.
//

import UIKit

final class ChooseGameCell: UICollectionViewCell {
    
    static let cellID = "ChooseGameCell"
    
    private let apperance = Constants()
    private var routeAdress: MainRoute!
    private var gameNameTitle = UILabel()
    private weak var delegate: RouteDelegate?
    private lazy var tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(route))
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = .systemBackground
        view.addGestureRecognizer(tapRecognizer)
        setConstraints()
        setCellInterface()
    }
    
    private func setConstraints() {
        contentView.addSubview(gameNameTitle)
        gameNameTitle.translatesAutoresizingMaskIntoConstraints = false
        gameNameTitle.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        gameNameTitle.numberOfLines = 0
        gameNameTitle.textAlignment = .center
        
        NSLayoutConstraint.activate([
            gameNameTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            gameNameTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            gameNameTitle.widthAnchor.constraint(lessThanOrEqualToConstant: view.layer.bounds.width * 0.8)
        ])
    }
    
    private func setCellInterface() {
        layer.cornerRadius = apperance.cornerRadius
        setShadow(cornerRadius: apperance.cornerRadius)
    }
    
    func setLabel(_ data: (title: String, route: MainRoute), delegate: RouteDelegate) {
        self.gameNameTitle.text = data.title
        self.routeAdress = data.route
        self.delegate = delegate
    }
    
    @objc func route() {
        delegate?.routeTo(routeAdress)
    }
}

extension ChooseGameCell {
    private struct Constants {
        let cornerRadius: CGFloat = 15
    }
}
