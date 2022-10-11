//
//  UIViewController+Extensions.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 11.10.2022.
//

import UIKit

extension UIViewController {
  static func instanceFromStoryboard(name: String = "Main") -> Self {
    let storyboard = UIStoryboard(name: name, bundle: nil)
    return storyboard.instantiateViewController(
      withIdentifier: String(describing: self)
    ) as! Self
  }
}
