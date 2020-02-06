//
//  ViewController.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 05/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit

protocol CharactersListViewControllerDelegate: ViewControllerDelegate {
    func didSelectCell(at index: Int)
}

class CharactersListViewController: UIViewController {
    
    @IBOutlet weak var charactersListCollectionView: UICollectionView! {
        didSet {
            charactersListCollectionView.register(UINib(nibName: CharacterCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: CharacterCollectionViewCell.className)
        }
    }

    var presenter: CharactersListPresenter?
    
    weak var delegate: CharactersListViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        charactersListCollectionView.delegate = self
        charactersListCollectionView.dataSource = self
        
        setupPresenter()
        delegate?.setupView()
    }
    
    private func setupPresenter() {
        presenter = CharactersListPresenter()
        delegate = presenter
        presenter?.delegate = self
    }
}

extension CharactersListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.getCharacters().count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let presenter = presenter, let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.className, for: indexPath) as? CharacterCollectionViewCell {
                        
            cell.setup(name: presenter.getCharacterName(at: indexPath.row), thumbnailImage: presenter.getCharacterThumbnailImage(at: indexPath.row))
            
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension CharactersListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension CharactersListViewController: CharactersListPresenterDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.charactersListCollectionView.reloadData()
        }
    }
}
