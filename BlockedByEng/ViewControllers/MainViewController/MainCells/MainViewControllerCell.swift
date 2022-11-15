//
//  MainViewControllerCell.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 13/11/2022.
//

import Foundation
import UIKit

final class MainViewControllerCell: UICollectionViewCell {
    
    static let cellID = "MainCell"
    
    var viewModel: MainCellViewModelProtocol!
    private let listTitle = UILabel()
    private let numberOfWords = UILabel()
    private let numberTitle = UILabel()
    private let stack = UIStackView()
    private let layerTwo = CALayer()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel = nil
        
        subviews.forEach { $0.isHidden = true }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        contentView.backgroundColor = .systemBackground
        
        addSubviews(views: listTitle, numberOfWords, numberTitle)
        
        layerTwo.bounds = self.layer.bounds
        layerTwo.position = layer.position
        layer.insertSublayer(layerTwo, at: 0)
        
        listTitle.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        numberTitle.text = "Количество слов"
        numberTitle.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        numberOfWords.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        
        setInterface()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews(views: UIView...) {
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview(view)
        }
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            listTitle.centerXAnchor.constraint(equalTo: centerXAnchor),
            listTitle.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            listTitle.widthAnchor.constraint(lessThanOrEqualToConstant: bounds.width),
            
            numberTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            numberTitle.topAnchor.constraint(equalTo: listTitle.bottomAnchor, constant: 8),
            
            numberOfWords.centerYAnchor.constraint(equalTo: numberTitle.centerYAnchor),
            numberOfWords.topAnchor.constraint(equalTo: listTitle.bottomAnchor, constant: 8),
            numberOfWords.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
        ])
    }
    
    private func setInterface() {
        layer.cornerRadius = 16
        contentView.layer.cornerRadius = 16
//        
//        layerTwo.shadowColor = UIColor.gray.cgColor
//        layerTwo.shadowRadius = 4
//        layerTwo.shadowOffset = CGSize(width: -25, height: -6)
//        layerTwo.shadowPath = UIBezierPath(roundedRect: bounds.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -5)), cornerRadius: 16).cgPath
//        layerTwo.shadowOpacity = 0.2
//        layerTwo.masksToBounds = false
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 7, height: 7)
        layer.shadowPath = UIBezierPath(roundedRect: bounds.inset(by: UIEdgeInsets(top: 0, left: -6, bottom: 0, right: 0)), cornerRadius: 16).cgPath
        layer.shadowOpacity = 0.45
        layer.masksToBounds = false
    }
    
    func configureCellWith(viewModel: MainCellViewModelProtocol) {
        self.viewModel = viewModel
        
        listTitle.text = viewModel.wordsList.listTitle
        numberOfWords.text = String(viewModel.wordsList.wordsList.count)
        DispatchQueue.main.asyncAfter(deadline: .now()) { [unowned self] in
            setConstraints()
            subviews.forEach { $0.isHidden = false }
        }
    }
}
