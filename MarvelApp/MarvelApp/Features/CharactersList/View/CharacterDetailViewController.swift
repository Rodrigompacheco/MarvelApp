//
//  CharacterDetailViewController.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 06/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit

class CharacterDetailViewController: UIViewController {
    
    let presenter: CharacterDetailPresenter
    
    init(presenter: CharacterDetailPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let viewC = UIView(frame: self.view.bounds)
        viewC.backgroundColor = .green
        
        let label = UILabel(frame: CGRect(x: 50, y: 50, width: 100, height: 100))
        label.text = presenter.character.name
        
        viewC.addSubview(label)
        self.view.addSubview(viewC)
    }
}
