//
//  ViewController.swift
//  BlockedByEng
//
//  Created by Сергей Веретенников on 13/11/2022.
//

import UIKit
import Combine
import XCoordinator



final class MainViewController: BaseViewController {

    private let constants = Constants()
    private var viewModel: ViewControllerViewModelProtocol
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private let layout = UICollectionViewFlowLayout()
    private let addButton = UIImageView()
    private lazy var addListGesture = UITapGestureRecognizer(target: self, action: #selector(addButtonTapped))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.addGestureRecognizer(addListGesture)
        setLayout()
        addSubviews()
        setConstraints()
        
        collectionView.contentInset.top = 20
        
        viewModel.reloader.sink { _ in
            self.collectionView.reloadData()
        }.store(in: &viewModel.db)
    }
    
    init(viewModel: ViewControllerViewModelProtocol, title: String) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        addButton.isUserInteractionEnabled = true
        view.addSubview(addButton)
        view.insertSubview(collectionView, belowSubview: addButton)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MainViewControllerCell.self, forCellWithReuseIdentifier: MainViewControllerCell.cellID)
        collectionView.alwaysBounceVertical = true
        
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.image = UIImage(systemName: "plus.rectangle.fill")
        addButton.tintColor = Asset.basicColor.color
        addButton.contentMode = .scaleAspectFit
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            addButton.widthAnchor.constraint(equalToConstant: constants.cellWidth * 0.2),
            addButton.heightAnchor.constraint(equalToConstant: constants.cellWidth * 0.2)
        ])  
    }
    
    private func setLayout() {
        layout.estimatedItemSize = CGSize(width: constants.cellWidth, height: constants.cellHeight)
    }
    
    private func addNewListAlert() {
        let alertController = UIAlertController(title: "Add new list", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { $0.placeholder = "Enter list name"}
        
        alertController.addTextField { $0.placeholder = "Enter target language"}
        
        let firstTF = NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: alertController.textFields?[0])
            .map { ($0.object as? UITextField)?.text ?? "" }
        
        let secondTF = NotificationCenter.default
            .publisher(for: UITextField.textDidChangeNotification, object: alertController.textFields?[1])
            .map { ($0.object as? UITextField)?.text ?? "" }
        
        let sender = PassthroughSubject<(String, String), Never>()
        
        let first: AnyCancellable = firstTF.combineLatest(secondTF).sink { str in
            sender.send(str)
        } 
        
        let cancel: AnyCancellable = secondTF.combineLatest(firstTF).sink { str in
            sender.send(str)
        }
        
        first.store(in: &viewModel.db)
        cancel.store(in: &viewModel.db)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        let alertAction = UIAlertAction(title: "Add", style: .default) { [weak self] action in
            guard let title = alertController.textFields?[0].text else { return }
            guard let language = alertController.textFields?[1].text else { return }
            self?.viewModel.addNewListWith(title: title, and: language)
        }
        alertAction.isEnabled = false
        
        alertController.addAction(cancelAction)
        alertController.addAction(alertAction)
        
        sender.map { strings in
            print(strings)
            return !strings.0.isEmpty && !strings.1.isEmpty
        }.assign(to: \.isEnabled, on: alertAction).store(in: &viewModel.db)
        
        present(alertController, animated: true)
    }
    
    @objc private func addButtonTapped() {
        let animation = CABasicAnimation(keyPath: "opacity")
        
        animation.timingFunction = CAMediaTimingFunction(name: .linear)

        animation.fromValue = 1
        animation.toValue = 0.65
        
        animation.autoreverses = true
        animation.duration = 0.1
        
        addButton.layer.add(animation, forKey: nil)
        addNewListAlert()
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getNumberOfLists()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainViewControllerCell.cellID, for: indexPath) as? MainViewControllerCell else { return UICollectionViewCell() }
        
        cell.configureCellWith(viewModel: viewModel.createCellViewModel(indexPath: indexPath))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.getListFor(indexPath: indexPath)
    }
}

extension MainViewController {
    struct Constants {
        let cellWidth: CGFloat = UIScreen.main.bounds.size.width * 0.9
        let cellHeight: CGFloat = 100
    }
}

