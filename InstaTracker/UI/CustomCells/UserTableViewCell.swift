//
//  UserTableViewCell.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 25.11.2020.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    var profilePicture: UIImageView! = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()

    var name: UILabel! = {
        let label = UILabel()
        label.font = .titleFont()
        return label
    }()

    var username: UILabel! = {
        let label = UILabel()
        label.font = .defaultFont()
        return label
    }()

    var whenLeft: UILabel! = {
        let label = UILabel()
        label.font = .defaultFont()
        label.textColor = UIColor.gray
        return label
    }()

    var lockIcon: UIImageView! = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "lock")
        imageView.isHidden = true
        return imageView
    }()

    var arrowIcon: UIImageView! = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "arrowshape.turn.up.right")
        return imageView
    }()

    var viewModel: UserCellViewModel! {
        didSet {
            name.text = viewModel.name
            username.text = viewModel.username
            whenLeft.text = viewModel.whenLeft

            name.isHidden = viewModel.nameHidden
            whenLeft.isHidden = viewModel.whenLeftHidden
            lockIcon.isHidden = viewModel.lockIconHidden

            profilePicture.image = UIImage(named: "Image")

            if let url = viewModel.profilePicture {
                profilePicture.loadImage(at: url)
            }
        }
    }
    
    var onReuse: () -> Void = {}

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        profilePicture.image = nil
        profilePicture.cancelImageLoad()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.profilePicture.makeCircle()
    }
}

extension UserTableViewCell: ReuseIdentifying {}
