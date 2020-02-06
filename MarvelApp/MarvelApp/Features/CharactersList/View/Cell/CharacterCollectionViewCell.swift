//
//  CharacterCollectionViewCell.swift
//  MarvelApp
//
//  Created by Rodrigo Pacheco on 06/02/20.
//  Copyright © 2020 RodrigoPacheco. All rights reserved.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    
    func setup(name: String, thumbnailImage: String) {
        characterNameLabel.text = name
        
        backgroundImageView.load(thumbnailImage: thumbnailImage)
//        downloadImage(from: URL(string: thumbnailImage)!)
        
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.backgroundImageView.image = UIImage(data: data)
            }
        }
    }
}
