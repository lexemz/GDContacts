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
  
  func showInfoAlert(title: String?, message: String?) {
    let alert = UIAlertController(
      title: title,
      message: message,
      preferredStyle: .alert
    )
    let ok = UIAlertAction(title: "OK", style: .default)
    alert.addAction(ok)
    present(alert, animated: true)
  }
}
