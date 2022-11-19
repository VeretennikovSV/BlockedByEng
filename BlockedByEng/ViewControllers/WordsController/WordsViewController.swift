//
//  WordsViewController.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 17/11/2022.
//

import UIKit

final class WordsViewController: BaseViewController {
    
    
    
    var barHeightt: CGFloat { (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0) + (navigationController?.navigationBar.frame.height ?? 0) }
    
    private let constants = Constants()
    private let viewModel: WordsViewControllerViewModelProtocol
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private var layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout.itemSize = CGSize(width: constants.cellWidth, height: constants.cellHeight - barHeightt / 2)
        layout.sectionInset.left = view.frame.width * 0.03
        layout.sectionInset.right = view.frame.width * 0.03
        layout.sectionInset.top = view.frame.width * 0.03
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        
        setConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(viewModel.getWord())
    }
    
    init(viewModel: WordsViewControllerViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension WordsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        
        cell.backgroundColor = .red
        cell.layer.cornerRadius = 16
        
        return cell
    }
}

extension WordsViewController {
    
    struct Constants {
        var cellHeight: CGFloat { UIScreen.main.bounds.size.height * 0.43 }
        var cellWidth: CGFloat { UIScreen.main.bounds.size.width * 0.45 }
    }
}
