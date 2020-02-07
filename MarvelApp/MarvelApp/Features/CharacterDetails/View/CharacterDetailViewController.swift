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
    let headerElementKind = UICollectionView.elementKindSectionHeader
    let footerIdentifier = "footer"
    let footerElementKind = UICollectionView.elementKindSectionFooter
    var originalHeaderHeight: CGFloat = 0
    var headerHeight: CGFloat = 0
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = false
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
                                forSupplementaryViewOfKind: headerElementKind,
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
        case headerElementKind:
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                ofKind: headerElementKind,
                withReuseIdentifier: headerIdentifier,
                for: indexPath) as? HeaderCharacterReusableView else {
                    return UICollectionReusableView()
            }
            supplementaryView.setup(thumbnailImage: presenter.getCharacterThumbnailImage(), description: presenter.character.description)
            originalHeaderHeight = supplementaryView.headerHeightConstraint.constant
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

extension CharacterDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let collectionViewSize = collectionView.frame.size

        let width = collectionViewSize.width * 0.8
        let font = UIFont.systemFont(ofSize: 19)
        let deafultHeight: CGFloat = originalHeaderHeight * 1.2
        
        let calculedHeight = presenter.character.description.height(withConstrainedWidth: width, font: font)
        headerHeight = deafultHeight + calculedHeight
        return CGSize(width: width, height: deafultHeight + calculedHeight)
     }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.sizeForCards
    }
}

extension CharacterDetailViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let indexPath = IndexPath(item: 0, section: 0)
        
        if let reusableView = comicsCollectionView.supplementaryView(forElementKind: headerElementKind, at: indexPath) as? HeaderCharacterReusableView {
            let offset = scrollView.contentOffset.y
            if offset < 0 {
                reusableView.headerHeightConstraint.constant = originalHeaderHeight - offset
                reusableView.frame.size.height = headerHeight - offset

            } else {
                reusableView.headerHeightConstraint.constant = originalHeaderHeight
                reusableView.frame.size.height = headerHeight
            }
        }
        
        guard scrollView.reachedBottom && !presenter.isLoading() && presenter.hasMoreToDownload() else { return }
        
        
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

