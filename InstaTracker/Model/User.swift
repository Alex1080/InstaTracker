//
//  User.swift
//  InstaTracker
//
//  Created by Alex Morkovkin on 02.10.2020.
//

import Foundation

public class User: NSObject, Codable, NSCoding {
    let username: String
    let name: String
    let picture: URL?
    let isPrivate: Bool
    
    override public func isEqual(_ object: Any?) -> Bool {
        guard let object = object as? User else { return false }
        return username == object.username && name == object.name
    }
    
    override public var hash: Int {
        var hasher = Hasher()
        hasher.combine(username)
        hasher.combine(name)
        return hasher.finalize()
    }

    init(username: String, name: String, picture: URL?, isPrivate: Bool) {
        self.username = username
        self.name = name
        self.picture = picture
        self.isPrivate = isPrivate
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(username, forKey: "username")
        coder.encode(name, forKey: "name")
        coder.encode(picture, forKey: "picture")
        coder.encode(isPrivate, forKey: "isPrivate")
    }
    
    public required init?(coder: NSCoder) {
        self.username = coder.decodeObject(forKey: "username") as! String
        self.name = coder.decodeObject(forKey: "name") as! String
        self.picture = coder.decodeObject(forKey: "picture") as? URL
        self.isPrivate = coder.decodeBool(forKey: "isPrivate")
    }
}
