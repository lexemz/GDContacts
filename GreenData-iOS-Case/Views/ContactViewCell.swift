//
//  ContactViewCell.swift
//  GreenData-iOS-Case
//
//  Created by Igor Buzykin on 11.10.2022.
//

import Kingfisher
import UIKit

final class ContactViewCell: UITableViewCell {
  // MARK: - Private properties

  // UI
  private let contactImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.kf.indicatorType = .activity
    return imageView
  }()
  
  private let contactLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 2
    return label
  }()
  
  // MARK: - Class lifecycle methods

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
    contactImageView.layer.masksToBounds = true
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    contactImageView.image = nil
  }
  
  // MARK: - Flow internal metnods
  
  func configure(with contact: Contact) {
    contactLabel.text = contact.fullname
    contactImageView.contentMode = .scaleAspectFit
    contactImageView.kf.setImage(
      with: URL(string: contact.picURL)
    )
  }
  
  // MARK: - Flow private methods
  
  private func configureUI() {
    accessoryType = .disclosureIndicator
    
    contentView.addSubview(contactImageView)
    contentView.addSubview(contactLabel)
    
    NSLayoutConstraint.activate([
      contactImageView.widthAnchor.constraint(equalTo: contactImageView.heightAnchor, multiplier: 1.0 / 1.0),
      contactImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
      contactImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
      contactImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      
      contactLabel.leadingAnchor.constraint(equalTo: contactImageView.trailingAnchor, constant: 10),
      contactLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      contactLabel.centerYAnchor.constraint(equalTo: contactImageView.centerYAnchor)
    ])
  }
}
