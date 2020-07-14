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
    case example
}

extension Asset: AssetType {
    var image: UIImage {
        return UIImage(named: self.rawValue) ?? UIImage()
    }
}
