//
//  ViewController.swift
//  task9
//
//  Created by pavel mishanin on 25/2/24.
//

import UIKit

final class ViewController: UIViewController {
    
    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    private let cellWidth = UIScreen.main.bounds.width * 0.7
    private let cellHeight = UIScreen.main.bounds.height * 0.6
    private lazy var leftInset = collectionView.layoutMargins.left
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Collection"
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCell.id)
        
        layout.minimumLineSpacing = leftInset
        layout.scrollDirection = .horizontal
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
    }
}

// MARK: - CollectionView Delegate & DataSource

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: leftInset*2, bottom: 0, right: leftInset*2)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CollectionViewCell.id,
            for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        return cell
    }
}

// MARK: - UIScrollViewDelegate

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let oldX = targetContentOffset.pointee.x
        let offset = round((oldX - leftInset) / (cellWidth + leftInset))
        let newX = offset * (cellWidth + leftInset)
        targetContentOffset.pointee.x = offset == 0 ? newX : newX+leftInset
    }
}

// MARK: - UICollectionViewCell

final class CollectionViewCell: UICollectionViewCell {
    
    static let id = String(describing: CollectionViewCell.self)
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        backgroundColor = .lightGray
        layer.cornerRadius = 8
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
