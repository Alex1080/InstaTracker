//
// Created by Alex Morkovkin on 01.12.2020.
//

import UIKit

extension UserTableViewCell {
    func setupViews() {
        addViews()
        constraintSubviews()
    }

    fileprivate func addViews() {
        contentView.addSubview(profilePicture)
        contentView.addSubview(name)
        contentView.addSubview(username)
        contentView.addSubview(whenLeft)
        contentView.addSubview(lockIcon)
        contentView.addSubview(arrowIcon)
    }

    fileprivate func constraintSubviews() {
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: 85).isActive = true

        constraintProfilePicture()
        constraintStackView()
        constraintLockIcon()
        constraintArrowIcon()
    }

    fileprivate func constraintProfilePicture() {
        profilePicture.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profilePicture.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            profilePicture.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            profilePicture.widthAnchor.constraint(equalToConstant: 80),
            profilePicture.heightAnchor.constraint(equalToConstant: 80)
        ])
    }

    fileprivate func constraintStackView() {
        let stack = UIStackView(arrangedSubviews: [name, username, whenLeft])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: profilePicture.trailingAnchor, constant: 8),
            stack.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: lockIcon.leadingAnchor, constant: -8)
        ])
    }

    fileprivate func constraintLockIcon() {
        lockIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            lockIcon.trailingAnchor.constraint(equalTo: arrowIcon.leadingAnchor, constant: -20),
            lockIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    fileprivate func constraintArrowIcon() {
        arrowIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            arrowIcon.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            arrowIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
}
