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
    let headerElementKinf = UICollectionView.elementKindSectionHeader
    let footerIdentifier = "footer"
    let footerElementKind = UICollectionView.elementKindSectionFooter
    
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
                self.updateUI(dataState: result)
            })
        }
    }
    
    private func updateUI(dataState: DataState) {
        switch dataState {
        case .initial:
            DispatchQueue.main.async {
                self.comicsCollectionView.reloadData()
            }
        case .inserted(let indexPaths):
            DispatchQueue.main.async {
                self.comicsCollectionView.insertItems(at: indexPaths)
            }
        case .loading:
            break
        default:
            break
        }
    }
    
    private func setupCollectionView() {
        let nib = UINib(nibName: HeaderCharacterReusableView.className, bundle: nil)
        comicsCollectionView.register(nib,
                                forSupplementaryViewOfKind: headerElementKinf,
                                withReuseIdentifier: headerIdentifier)
        comicsCollectionView.register(UICollectionReusableView.self,
                                forSupplementaryViewOfKind: footerElementKind,
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
        case headerElementKinf:
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: headerElementKinf,
                withReuseIdentifier: headerIdentifier,
                for: indexPath) as? HeaderCharacterReusableView else {
                    return UICollectionReusableView()
            }
            supplementaryView.setup(thumbnailImage: presenter.getCharacterThumbnailImage(), description: presenter.character.description)
            return supplementaryView
        case footerElementKind:
            let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: footerElementKind,
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

extension CharacterDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.reachedBottom, presenter.hasMoreToDownload() else { return }
        
        let indexPath = IndexPath(item: 0, section: 0)
        let footer = comicsCollectionView.supplementaryView(forElementKind: footerElementKind, at: indexPath)
        footer?.lock()
        presenter.loadComics { [weak self, footer] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                footer?.unlock()
                self.updateUI(dataState: result)
            }
        }
    }
}

