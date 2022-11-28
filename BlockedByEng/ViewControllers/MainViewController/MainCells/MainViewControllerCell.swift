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
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setInterface()
        setConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        contentView.backgroundColor = .systemBackground
        
        addSubviews(views: listTitle, numberOfWords, numberTitle)
        
        listTitle.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        numberTitle.text = "Количество слов"
        numberTitle.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        numberOfWords.font = UIFont.systemFont(ofSize: 13, weight: .regular)
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
        setShadow(cornerRadius: 16)
    }
    
    func configureCellWith(viewModel: MainCellViewModelProtocol) {
        self.viewModel = viewModel
        listTitle.text = viewModel.getTitle()
        numberOfWords.text = String(viewModel.getNumberOfWords())
    }
}
