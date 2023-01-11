//
//  ContactTableViewCell.swift
//  ContactApp
//
//  Created by Sanzhar Zhubatkhanov on 10.01.2023.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    static let identifier = "ContactTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
        addSubviews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "person.fill")
        return imageView
    }()
    
    private let name: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = .systemFont(ofSize: 20, weight: .bold)
        name.textAlignment = .left
        name.text = "Zhubatkanov Sanzhar"
        return name
    }()
    
    private let phoneNumber: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        label.text = "87771588937"
        return label
    }()
    
    private let infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    private func addSubviews() {
        contentView.addSubview(image)
        contentView.addSubview(infoStackView)
        infoStackView.addArrangedSubview(name)
        infoStackView.addArrangedSubview(phoneNumber)

    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            infoStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            infoStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            image.trailingAnchor.constraint(equalTo: infoStackView.leadingAnchor, constant: -20),
            
        ])
    }
    
    func config(info: Contact) {
        name.text = info.name
        phoneNumber.text = info.phoneNumber
        if info.maleOrFemale == .female {
            image.image = UIImage(named: "woman")
        }else{
            image.image = UIImage(named: "man")
        }
    }
    

}
