//
//  Contact.swift
//  ContactApp
//
//  Created by Sanzhar Zhubatkhanov on 10.01.2023.
//

import Foundation
import UIKit

enum MaleOrFemale {
    case male
    case female
}

struct Contact {
    let image: UIImage?
    let name: String?
    let phoneNumber: String?
    let maleOrFemale: MaleOrFemale
}
