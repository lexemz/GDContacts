//
//  ContactViewCell.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 11.10.2022.
//

import UIKit

class ContactViewCell: UITableViewCell {
  
  private let contactImageView = UIImageView()
  private let contactLabel = UILabel()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    configureUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    contactImageView.layer.cornerRadius = contactImageView.frame.height / 2
  }
  
  func configure(with contact: ContactRepresentable) {
    contactLabel.text = contact.fullname
  }
  
  private func configureUI() {
    contentView.addSubview(contactImageView)
    contentView.addSubview(contactLabel)
    
    contactImageView.translatesAutoresizingMaskIntoConstraints = false
    contactLabel.translatesAutoresizingMaskIntoConstraints = false
    
    contactLabel.numberOfLines = 2
    
    NSLayoutConstraint.activate([
      contactImageView.widthAnchor.constraint(equalTo: contactImageView.heightAnchor, multiplier: 1.0/1.0),
      contactImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      contactImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      contactImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      
      contactLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
      contactLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      contactLabel.centerYAnchor.constraint(equalTo: contactImageView.centerYAnchor)
    ])
  }
}
