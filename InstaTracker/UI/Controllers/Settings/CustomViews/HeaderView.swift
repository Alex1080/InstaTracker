//
// Created by Alex Morkovkin on 02.12.2020.
//

import UIKit

class HeaderView: UIView {
    var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Image")!
        return imageView
    }()

    var name: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.font = .titleFont()
        return label
    }()

    var username: UILabel = {
        let label = UILabel()
        label.text = "username"
        label.font = .defaultFont()
        return label
    }()

    var email: UILabel = {
        let label = UILabel()
        label.text = "email"
        label.font = .defaultFont()
        return label
    }()

    var phone: UILabel = {
        let label = UILabel()
        label.text = "phone"
        label.font = .defaultFont()
        return label
    }()

    convenience init(name: String?, username: String, email: String?, phone: String?, imageUrl: URL?){
        self.init()

        if name != nil {
            self.name.text = name
        } else {
            self.name.isHidden = true
        }

        self.username.text = username

        if email != nil {
            self.email.text = email
        } else {
            self.email.isHidden = true
        }

        if phone != nil {
            self.phone.text = phone
        } else {
            self.phone.isHidden = true
        }

        if let url = imageUrl {
            imageView.loadImage(at: url)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    override func layoutSubviews() {
        imageView.makeCircle()
    }
}
