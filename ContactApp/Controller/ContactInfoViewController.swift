//
//  ContactInfoViewController.swift
//  ContactApp
//
//  Created by Sanzhar Zhubatkhanov on 10.01.2023.
//

import UIKit

class ContactInfoViewController: UIViewController {
    var contact: Contact?
    var didDeleteContact: ((Contact) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addSubViews()
        setConstraints()
        guard let contact = contact else { return }
        image.image = contact.image
        name.text = contact.name
        phoneNumber.text = contact.phoneNumber
        title = "Contact info"
    }
    
    
    private let image: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let name: UILabel = {
        let name = UILabel()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.font = .systemFont(ofSize: 20, weight: .bold)
        name.textAlignment = .left
        return name
    }()
    
    private let phoneNumber: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        return label
    }()
    
    private let infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 15
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let callButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Call", for: .normal)
        button.backgroundColor = .systemGreen
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Delete", for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func deleteButtonTapped() {
        guard let contact = contact else { return }
        didDeleteContact?(contact)
        navigationController?.popViewController(animated: true)
    }
    
    private let buttonStack: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        return stack
    }()
    
    private func addSubViews(){
        infoStackView.addArrangedSubview(name)
        infoStackView.addArrangedSubview(phoneNumber)
        buttonStack.addArrangedSubview(callButton)
        buttonStack.addArrangedSubview(deleteButton)
        view.addSubview(image)
        view.addSubview(infoStackView)
        view.addSubview(buttonStack)
    }
    
    
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            
            infoStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            buttonStack.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            buttonStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            buttonStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            image.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            image.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            image.trailingAnchor.constraint(equalTo: infoStackView.leadingAnchor, constant: -20),
            image.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
