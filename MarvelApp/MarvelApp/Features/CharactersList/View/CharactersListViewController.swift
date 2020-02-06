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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let view: UIView = UIView(frame: self.view.bounds)
        view.backgroundColor = .red
        self.view.addSubview(view)
        
        let endpoint = MarvelApiEndpoint.characters(offset: 5)
        let marvelApiProvider = MarvelApiProvider()
        
        marvelApiProvider.request(for: endpoint) { [weak self] (result: Result<DataPackage<Character>, Error>) in
            guard let self = self else { return }
            switch result {
            case .success(let dataPackage):
//                let changeState = self.paginator.paginate(dataWrapper: dataWrapper)
                print("sucesso")
                print(dataPackage)
            case .failure(let error):
                print("falhou")
            }
        }
    }
}

