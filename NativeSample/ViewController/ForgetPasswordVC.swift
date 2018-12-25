//
//  ForgetPasswordVC.swift
//  NativeSample
//
//  Created by Vishwajeet K on 12/25/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit

private enum ForgetPassword: Int, CaseIterable {
    case fields
    case buttons
    
    static var sections: Int {
        return ForgetPassword.allCases.count
    }
    
    var rows: Int {
        switch self {
        case .fields:
            return Fields.allCases.count
        case .buttons:
            return Buttons.allCases.count
        }
    }
    
    // enum for fields
    enum Fields: Int, CaseIterable {
        case email = 100
        case message
        
        func details() -> (title: String?, placeholder: String?) {
            switch self {
            case .email:
                return  (emailTitle, emailPlaceholer)
            case .message:
                return (forgetPasswordComment, nil)
            }
        }
    }
    
    // enum for buttons
    enum Buttons: Int, CaseIterable {
        case ForgetPassword = 1
        
        var title: String? {
            switch self {
            case .ForgetPassword:
                return forgetPasswordTitle
            }
        }
    }
}

class ForgetPasswordVC: UITableViewController {
    
    //MARK:  Identifier
    static var identifier: String {
        return "ForgetPasswordVC"
    }
    
    // MARK:  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialization()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let cell = self.tableView.cellForRow(at: IndexPath.init(row: ForgetPassword.Fields.email.rawValue - textFieldTag, section: ForgetPassword.fields.rawValue)) as? TextFieldCell  {
            cell.textField.becomeFirstResponder()
        }
    }
    
    // MARK:  Button Action
    @objc private func forgetPasswordButtonAction(_ button: DownloadingButton) {
        var emailCell: TextFieldCell? = nil
        
        if let cell = self.tableView.cellForRow(at: IndexPath.init(row: ForgetPassword.Fields.email.rawValue - textFieldTag, section: ForgetPassword.fields.rawValue)) as? TextFieldCell  {
            emailCell = cell
        }
        guard let emailField =  emailCell?.textField, isValidRequest(.email, emailField) else {
            emailCell?.highlighted()
            emailCell?.textField.becomeFirstResponder()
            return
        }
        button.setLoadingMode()
        emailField.isEnabled = false

        // Call API
    }
    
    // MARK:  Check Validation
    private func isValidRequest(_ field: ForgetPassword.Fields, _ textField: UITextField) -> Bool {
        switch field {
        case .email:
            if textField.isEmpty || textField.text?.count == 0 {
                UIAlertController.show(self, KAlertTitle, enterEmailAddress)
                return false
            }
            if !(textField.text!.isValidEmail)  {
                UIAlertController.show(self, KAlertTitle, enterValidEmailAddress)
                return false
            }
        case .message:
            break
        }
        return true
    }
    
    // MARK:  Initialization
    private func initialization() {
        
        func setUpNavigationBar() {
            self.navigationController?.isNavigationBarHidden = false
            
            if #available(iOS 11.0, *) {
                self.navigationController?.navigationBar.prefersLargeTitles = true
                self.navigationItem.largeTitleDisplayMode = .always
            }
            self.navigationItem.title = title
        }
        
        func registerCell() {
            self.tableView.registerCell(ofType: TextFieldCell.self)
            self.tableView.registerCell(ofType: TextLabelCell.self)
            self.tableView.registerCell(ofType: ButtonCell.self)
        }
        
        func setUpTableView() {
            self.tableView.backgroundColor = CustomColor.customGray
            self.tableView.delaysContentTouches = false
            self.tableView.allowsSelection = false
            self.tableView.estimatedRowHeight = UITableView.automaticDimension
            self.tableView.rowHeight = UITableView.automaticDimension
            self.tableView.tableHeaderView = UIView()
            self.tableView.tableFooterView = UIView()
        }
        setUpNavigationBar()
        registerCell()
        setUpTableView()
    }
}

extension ForgetPasswordVC {
    
    // MARK:  Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return ForgetPassword.sections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ForgetPassword.allCases[section].rows
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var labelWidth: CGFloat = 0
        for text in [emailTitle] {
            let font = UIFont.system(.regular, 17)
            let fontAttributes = [NSAttributedString.Key.font: font]
            let calculatedSize = NSString.init(string: text).size(withAttributes: fontAttributes)
            labelWidth.setIfFewer(when: calculatedSize.width + 1)
        }
        switch ForgetPassword.allCases[indexPath.section] {
        case .fields:
            if ForgetPassword.Fields.allCases[indexPath.row] == .message {
                let cell: TextLabelCell = tableView.dequeueReusableCell(for: indexPath)
                cell.label.text = ForgetPassword.Fields.allCases[indexPath.row].details().title
                cell.separatorInset.left = 0
                return cell
            }
            else {
                let cell: TextFieldCell = tableView.dequeueReusableCell(for: indexPath)
                cell.label.text = ForgetPassword.Fields.allCases[indexPath.row].details().title
                cell.textField.placeholder = ForgetPassword.Fields.allCases[indexPath.row].details().placeholder
                cell.textField.delegate = self
                cell.textField.tag = ForgetPassword.Fields.allCases[indexPath.row].rawValue
                cell.fixWidthLabel = labelWidth
                cell.separatorInset.left = 0
                return cell
            }
        case .buttons:
            let cell: ButtonCell = tableView.dequeueReusableCell(for: indexPath)
            cell.button.setTitle(ForgetPassword.Buttons.allCases[indexPath.row].title, for: .normal)
            cell.separatorInset.left = 0
            cell.button.tag = ForgetPassword.Buttons.allCases[indexPath.row].rawValue
            cell.button.addTarget(self, action: #selector(forgetPasswordButtonAction(_:)), for: .touchUpInside)
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
}

extension ForgetPasswordVC: UITextFieldDelegate {
    
    // MARK:  Text field delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

