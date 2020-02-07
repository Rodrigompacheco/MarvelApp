//
//  CharacterDetailViewController.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 06/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    @IBOutlet weak var comicsCollectionView: UICollectionView! {
        didSet {
            comicsCollectionView.register(UINib(nibName: ComicCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: ComicCollectionViewCell.className)
        }
    }
        
    let presenter: CharacterDetailPresenter
    let headerIdentifier = "header"
    let headerType = UICollectionView.elementKindSectionHeader
    let footerIdentifier = "footer"
    let footerType = UICollectionView.elementKindSectionFooter
    
    init(presenter: CharacterDetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       setupCollectionView()
        
        
        DispatchQueue.main.async {
            self.presenter.loadComics(completion: { result in
                if result {
                    DispatchQueue.main.async {
                        self.comicsCollectionView.reloadData()
                    }
                }
            })
        }
    }
    
    private func setupCollectionView() {
        let nib = UINib(nibName: HeaderCharacterReusableView.className, bundle: nil)
        comicsCollectionView.register(nib,
                                forSupplementaryViewOfKind: headerType,
                                withReuseIdentifier: headerIdentifier)
        comicsCollectionView.register(UICollectionReusableView.self,
                                forSupplementaryViewOfKind: footerType,
                                withReuseIdentifier: footerIdentifier)
        comicsCollectionView.dataSource = self
        comicsCollectionView.delegate = self
    }
}

extension CharacterDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.presenter.getComics().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ComicCollectionViewCell.className, for: indexPath) as? ComicCollectionViewCell {
                        
            cell.setup(thumbnailImage: presenter.getComicThumbnailImage(at: indexPath.row))
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case headerType:
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: headerType,
                withReuseIdentifier: headerIdentifier,
                for: indexPath) as? HeaderCharacterReusableView else {
                    return UICollectionReusableView()
            }
            supplementaryView.setup(thumbnailImage: presenter.getCharacterThumbnailImage(), description: presenter.character.description)
            return supplementaryView
        case footerType:
            let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: footerType,
                withReuseIdentifier: footerIdentifier,
                for: indexPath
            )
            return supplementaryView
        default:
            return UICollectionReusableView()
        }
    }
}

extension CharacterDetailViewController: UICollectionViewDelegate {
    
}
