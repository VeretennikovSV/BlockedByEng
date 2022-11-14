//
//  ViewController.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 13/11/2022.
//

import UIKit
import Combine

final class MainViewController: BaseViewController {

    private let constants = Constants()
    private var viewModel: ViewControllerViewModelProtocol
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private let layout = UICollectionViewFlowLayout()
    private let addButton = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Blocked by eng"
        
        setLayout()
        addSubviews()
        
        collectionView.contentInset.top = 20
        viewModel.reloader.sink { _ in
            self.collectionView.reloadData()
        }.store(in: &viewModel.db)
        
        setConstraints()
    }
    
    init(viewModel: ViewControllerViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        view.addSubview(collectionView)
        view.insertSubview(addButton, aboveSubview: collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MainViewControllerCell.self, forCellWithReuseIdentifier: MainViewControllerCell.cellID)
        collectionView.alwaysBounceVertical = true
        
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.image = UIImage(systemName: "plus.rectangle.fill")
        addButton.tintColor = #colorLiteral(red: 0, green: 0.6058987975, blue: 1, alpha: 1)
        addButton.contentMode = .scaleAspectFit
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addButton.widthAnchor.constraint(equalToConstant: constants.cellWidth * 0.2),
            addButton.heightAnchor.constraint(equalToConstant: constants.cellWidth * 0.2)
        ])  
    }
    
    private func setLayout() {
        layout.estimatedItemSize = CGSize(width: constants.cellWidth, height: constants.cellHeight)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.results?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewControllerCell.cellID, for: indexPath) as? MainViewControllerCell else { return UICollectionViewCell() }
        
        cell.configureCellWith(viewModel: viewModel.createCellViewModel(indexPath: indexPath))
        
        return cell
    }  
}

extension MainViewController {
    struct Constants {
        let cellWidth: CGFloat = UIScreen.main.bounds.size.width * 0.9
        let cellHeight: CGFloat = 100
    }
}

