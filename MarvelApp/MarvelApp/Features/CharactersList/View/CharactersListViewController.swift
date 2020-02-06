//
//  ViewController.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 05/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit

class CharactersListViewController: UIViewController {
    
    @IBOutlet weak var charactersListCollectionView: UICollectionView!

    var presenter: CharactersListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        presenter = CharactersListPresenter()
        presenter?.loadCharacters(completion: { result in
            if result {
                self.presenter?.getCharacters().forEach({ (character) in
                    print("\(character.name)\n")
                })
            }
        })
    }
}

