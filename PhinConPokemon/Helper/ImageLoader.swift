//
//  ImageLoader.swift
//  PhinConPokemon
//
//  Created by Administrator on 11/04/23.
//

import UIKit

var imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    public func loadImage(urlString: String, PlaceHolderImage:UIImage) {

        if self.image == nil{
              self.image = PlaceHolderImage
        }

        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in

            if error != nil {
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })

        }).resume()
    }
}
