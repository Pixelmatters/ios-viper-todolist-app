//
//  Assets.swift
//  Todolist
//
//  Created by Filipe Santos on 14/07/2020.
//  Copyright © 2020 Pixelmatters. All rights reserved.
//

import UIKit

protocol AssetType {
    var image: UIImage { get }
}

enum Asset: String {
    case checked
    case unchecked
    case add
}

extension Asset: AssetType {
    var image: UIImage {
        return UIImage(named: self.rawValue) ?? UIImage()
    }
}
