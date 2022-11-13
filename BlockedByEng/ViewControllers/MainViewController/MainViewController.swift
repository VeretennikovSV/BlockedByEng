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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Blocked by eng"
        
        setLayout()
        addSubviews()
        
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
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.alwaysBounceVertical = true
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) 
        
        var content = UIListContentConfiguration.cell()
        content.text = viewModel.results?.sorted(by: {$0.creationDate < $1.creationDate})[indexPath.row].learningTitle
        cell.backgroundColor = .red
        
        return cell
    }  
}

extension MainViewController {
    struct Constants {
        let cellWidth: CGFloat = UIScreen.main.bounds.size.width * 0.9
        let cellHeight: CGFloat = 100
    }
}

