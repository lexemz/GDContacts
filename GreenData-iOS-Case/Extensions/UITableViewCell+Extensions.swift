//
//  UITableViewCell+Extensions.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 11.10.2022.
//

import UIKit

extension UITableViewCell {
  static var reuseIdentifier: String {
    String(describing: self)
  }
}
