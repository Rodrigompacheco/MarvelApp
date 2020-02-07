//
//  ViewController.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 05/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit

protocol CharactersListViewControllerDelegate: class {
    func didSelectCell(at index: Int)
}

class CharactersListViewController: UIViewController {
    
    @IBOutlet weak var charactersListCollectionView: UICollectionView! {
        didSet {
            charactersListCollectionView.register(UINib(nibName: CharacterCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: CharacterCollectionViewCell.className)
            
            charactersListCollectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: footerElementKind, withReuseIdentifier: footerIdentifier)
        }
    }

    var presenter: CharactersListPresenter
    let footerIdentifier = "footer"
    let footerElementKind = UICollectionView.elementKindSectionFooter
    
    weak var delegate: CharactersListViewControllerDelegate?
    
    init(presenter: CharactersListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollection()
        setupPresenter()
        presenter.loadCharacters { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateUI(dataState: result)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupPresenter() {
        delegate = presenter
        presenter.presenterViewDelegate = self
    }
    
    private func updateUI(dataState: DataState) {
        switch dataState {
        case .initial:
            DispatchQueue.main.async {
                self.charactersListCollectionView.reloadData()
            }
        case .inserted(let indexPaths):
            DispatchQueue.main.async {
                self.charactersListCollectionView.insertItems(at: indexPaths)
            }
        case .loading:
            break
        default:
            break
        }
    }
    
    private func setupCollection() {
        charactersListCollectionView.delegate = self
        charactersListCollectionView.dataSource = self
    }
}

extension CharactersListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.getCharacters().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.className, for: indexPath) as? CharacterCollectionViewCell {
                        
            cell.setup(name: presenter.getCharacterName(at: indexPath.row), thumbnailImage: presenter.getCharacterThumbnailImage(at: indexPath.row))
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case footerElementKind:
            let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: footerElementKind,
                                                            withReuseIdentifier: footerIdentifier,
                                                            for: indexPath)
            return supplementaryView
        default:
            return UICollectionReusableView()
        }
    }
}

extension CharactersListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectCell(at: indexPath.row)
    }
}

extension CharactersListViewController: CharactersListPresenterViewDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.charactersListCollectionView.reloadData()
        }
    }
}

extension CharactersListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  30
        let collectionViewSize = collectionView.frame.size.width - padding
        let percentageOfWidth: CGFloat = 0.50
        let percentageOfHeight: CGFloat = 0.35
        
        return CGSize(width: collectionViewSize * percentageOfWidth,
                      height: collectionView.frame.height * percentageOfHeight)
    }
}

extension CharactersListViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard scrollView.reachedBottom && !presenter.isLoading() && presenter.hasMoreToDownload() else { return }
        
        let indexPath = IndexPath(item: 0, section: 0)
        let footer = charactersListCollectionView.supplementaryView(forElementKind: footerElementKind, at: indexPath)
        footer?.lock()
        presenter.loadCharacters { [weak self, footer] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                footer?.unlock()
                self.updateUI(dataState: result)
            }
        }
    }
}
