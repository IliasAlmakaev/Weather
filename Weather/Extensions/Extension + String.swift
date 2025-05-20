//
//  Extension + String.swift
//  Weather
//
//  Created by Ilyas on 20.05.2025.
//

import Foundation

extension String {
  var imageUrl: URL? {
    let urlString = "https:" + self
    return URL(string: urlString)
  }
}
