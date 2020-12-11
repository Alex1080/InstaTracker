//
//  UsersViewController+SetupViews.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 30.11.2020.
//

import UIKit

extension UsersViewController {
    func setupViews() {
        addViews()
        constrainSubviews()
        setupLongPress()
    }
    
    fileprivate func addViews() {
        view.addSubview(tableView)
        view.addSubview(loading)
    }

    fileprivate func constrainSubviews() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        loading.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loading.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func setupLongPress() {
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress(longPressGestureRecognizer:)))
        tableView.addGestureRecognizer(longPressRecognizer)
    }
    
    // MARK: - Selectors
    
    @objc func longPress(longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = longPressGestureRecognizer.location(in: tableView)
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                
                let user = getUserForSection(indexPath: indexPath)

                let viewController = UIViewController()
                viewController.modalPresentationStyle = .automatic
                viewController.modalTransitionStyle = .crossDissolve
                
                let imageView = UIImageView()
                imageView.contentMode = .scaleAspectFit
                imageView.image = UIImage(named: "Image")

                if let url = user.profilePicture {
                    imageView.loadImage(at: url)
                }

                viewController.view.addSubview(imageView)
                
                imageView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    imageView.leadingAnchor.constraint(equalTo: viewController.view.leadingAnchor),
                    imageView.trailingAnchor.constraint(equalTo: viewController.view.trailingAnchor),
                    imageView.topAnchor.constraint(equalTo: viewController.view.topAnchor),
                    imageView.bottomAnchor.constraint(equalTo: viewController.view.bottomAnchor)
                ])
                
                present(viewController, animated: true, completion: nil)
             }
        }
    }
}
