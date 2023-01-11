//
//  NewContactViewController.swift
//  ContactApp
//
//  Created by Sanzhar Zhubatkhanov on 10.01.2023.
//

import UIKit

protocol NewContactViewControllerDelegate: AnyObject {
    func didAddContact(contact: Contact)
        
}

class NewContactViewController: UIViewController {
    weak var delegate: NewContactViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Contact"
        view.backgroundColor = .systemBackground
        pickerView.delegate = self as UIPickerViewDelegate
        pickerView.dataSource = self as UIPickerViewDataSource
        pickerView.center = self.view.center
        addSubViews()
        setConstraints()
    }
    
    private let nameField: UITextField = {
        let name = UITextField()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.backgroundColor = .white
        name.leftViewMode = .always
        name.attributedPlaceholder = NSAttributedString (
            string: "Name",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        name.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: name.frame.height))
        name.keyboardType = .emailAddress
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 16)
        name.layer.cornerRadius = 8
        name.autocapitalizationType = .none
        name.returnKeyType = .done
        name.layer.borderWidth = 1
        name.layer.borderColor = UIColor.systemGray.cgColor
        name.autocorrectionType = .no
        return name
    }()
    
    private var humanSex = ["male", "female"]
    private var selectedValue = ""
    private let pickerView: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    
    
    private let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: .normal)
        button.backgroundColor = .link
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(saveButtonTapped(sender:)), for: .touchUpInside)
        return button
    }()
    
    @objc func saveButtonTapped(sender: UIButton){
        guard let name = nameField.text,
        let phone = phoneField.text else { return }
        if selectedValue == "male" {
            let addedContact = Contact(image: UIImage(named: "man"), name: name, phoneNumber: phone, maleOrFemale: .male)
            delegate?.didAddContact(contact: addedContact)
        } else {
            let addedContact = Contact(image: UIImage(named: "woman"), name: name, phoneNumber: phone, maleOrFemale: .female)
            delegate?.didAddContact(contact: addedContact)
        }
        
        
        navigationController?.popViewController(animated: true)
    }
    
    private let phoneField: UITextField = {
        let name = UITextField()
        name.translatesAutoresizingMaskIntoConstraints = false
        name.backgroundColor = .white
        name.leftViewMode = .always
        name.attributedPlaceholder = NSAttributedString (
            string: "Phone number",
            attributes: [NSAttributedString.Key.foregroundColor : UIColor.black])
        name.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: name.frame.height))
        name.keyboardType = .numberPad
        name.textColor = .black
        name.font = UIFont.systemFont(ofSize: 16)
        name.layer.cornerRadius = 8
        name.autocapitalizationType = .none
        name.returnKeyType = .done
        name.layer.borderWidth = 1
        name.layer.borderColor = UIColor.systemGray.cgColor
        return name
    }()
    
    private let infoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 10
        stack.distribution = .fillEqually
        return stack
    }()
    
    
    private func addSubViews(){
        infoStackView.addArrangedSubview(nameField)
        infoStackView.addArrangedSubview(phoneField)
        view.addSubview(infoStackView)
        view.addSubview(pickerView)
        view.addSubview(saveButton)
    }
    
    private func setConstraints(){
        NSLayoutConstraint.activate([
            // infoStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            infoStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            infoStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            infoStackView.bottomAnchor.constraint(equalTo: pickerView.topAnchor, constant: 20),
            infoStackView.heightAnchor.constraint(equalToConstant: 140),
            
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            saveButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

extension NewContactViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return humanSex.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let row = humanSex[row]
        selectedValue = row
        return row
    }
    
}
