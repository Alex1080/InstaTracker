//
// Created by Alex Morkovkin on 02.12.2020.
//

import UIKit

extension HeaderView {
    func setupViews() {
        self.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 230)

        addViews()
        constraintSubviews()
    }

    fileprivate func addViews() {
        self.addSubview(imageView)
        self.addSubview(name)
        self.addSubview(username)
        self.addSubview(email)
        self.addSubview(phone)
    }

    fileprivate func constraintSubviews() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120)
        ])

        let stack = UIStackView(arrangedSubviews: [name, username, email, phone])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .center
        self.addSubview(stack)

        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            stack.centerXAnchor.constraint(equalTo: imageView.centerXAnchor)
        ])
    }
}