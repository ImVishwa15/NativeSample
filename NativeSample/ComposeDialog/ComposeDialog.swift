//
//  ComposeDialog.swift
//  NativeSample
//
//  Created by Vishwajeet K on 12/3/18.
//  Copyright © 2018 Vishwajeet K. All rights reserved.
//

import UIKit
import MessageUI

public typealias EmailAction = (MFMailComposeResult, Error?) -> Void
public typealias MessageAction = (MessageComposeResult) -> Void

class Composer {
    
    var subject = String()
    var body = String()
    var recipients = [String]()
    
    init() {
    }
    
    convenience init(_ subject: String, _ body: String, _ recipients: [String]) {
        self.init()
        self.subject = subject
        self.body = body
        self.recipients = recipients
    }
}

open class ComposeDialog: NSObject {
    
    //  shared
    static let shared = ComposeDialog()

    //  private
    private var viewController: UIViewController?
    private var emailAction: EmailAction?
    private var messageAction: MessageAction?
    
    //MARK:  open email dialog
    func email(_ viewController: UIViewController, _ composer: Composer = Composer(), _ handler: @escaping EmailAction) {
        self.viewController = viewController
        
        if MFMailComposeViewController.canSendMail() {
            let mailVC = MFMailComposeViewController()
            mailVC.mailComposeDelegate  = self
            mailVC.setSubject(composer.subject)
            mailVC.setMessageBody(composer.body, isHTML:false)
            mailVC.setToRecipients(composer.recipients)
            self.viewController!.present(mailVC, animated:true, completion:nil)
        }
        else {
            UIAlertController.show(self.viewController!, "Alert", "Your device could not send email. \n Please check email configuration and try again.")
        }
        self.emailAction = handler
    }
    
    //MARK:  open message dialog
    func message(_ viewController: UIViewController, _ composer: Composer = Composer(), _ handler: @escaping MessageAction) {
        self.viewController = viewController
        if MFMessageComposeViewController.canSendText() {
            let controller = MFMessageComposeViewController()
            controller.subject = composer.subject
            controller.body = composer.body
            controller.recipients = composer.recipients
            controller.messageComposeDelegate = self
            self.viewController!.present(controller, animated: true, completion: nil)
        }
        else {
            UIAlertController.show(self.viewController!, "Alert", "Your device could not send message. \n Please check message configuration and try again.")
        }
        self.messageAction = handler
    }
    
}

extension ComposeDialog: MFMailComposeViewControllerDelegate {
    
    // MARK:  MFMailComposeViewControllerDelegate
    public func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            break
        case .saved:
            break
        case .sent:
            break
        case .failed:
            break
        }
        if let emailAction = self.emailAction {
            DispatchQueue.main.async {
                emailAction(result, error)
            }
        }
        self.viewController!.dismiss(animated: true, completion: nil)
    }
}

extension ComposeDialog: MFMessageComposeViewControllerDelegate {
    
    //MARK:  MFMessageComposeViewControllerDelegate
    public func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .cancelled:
            print("Cancelled")
        case .failed:
            print("Failed")
        default:
            print("Sent")
        }
        if let messageAction = self.messageAction {
            DispatchQueue.main.async {
                messageAction(result)
            }
        }
        self.viewController!.dismiss(animated: true, completion: nil)
    }
}
