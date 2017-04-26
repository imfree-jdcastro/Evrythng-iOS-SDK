//
//  UserDelegate.swift
//  Evrythng-iOS
//
//  Created by JD Castro on 26/04/2017.
//  Copyright © 2017 ImFree. All rights reserved.
//

import UIKit

public protocol UserDelegate {
    var gender: Gender? { get set }
    var birthday: Date? { get set }
    var canLogin: Bool? { get set }
    var project: String? { get set }
    var app: String? { get set }
    var numberOfFriends: Int { get set }
}

public enum Gender {
    case Female
    case Male
}
