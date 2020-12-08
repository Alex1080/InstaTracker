//
//  UIImageView+ImageLoader.swift
//  InstaTracker
//
// Created by Alex Morkovkin on 26.11.2020.
//

import UIKit

extension UIImageView {
    func loadImage(at url: URL) {
        UIImageLoader.loader.load(url, for: self)
    }

    func cancelImageLoad() {
        UIImageLoader.loader.cancel(for: self)
    }
}
