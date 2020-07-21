//
//  EmailComposer.swift
//  Shamela
//
//  Created by Amr Elsayed on 6/22/20.
//  Copyright © 2020 Smartech. All rights reserved.
//

import MessageUI

class EmailComposer: NSObject {
    private let parentViewController: UIViewController
    private let to: String
    private let subject: String?
    private let body: String?
    
    init(parentViewController: UIViewController, to: String, subject: String? = nil, body: String? = nil) {
        self.parentViewController = parentViewController
        self.subject = subject
        self.body = body
        self.to = to
    }
    
    func open() {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([to])
            mail.setSubject(subject ?? "")
            mail.setMessageBody(body ?? "", isHTML: true)
            parentViewController.present(mail, animated: true)
        } else if let emailURL = getEmailURL(to: to, subject: subject ?? "", body: body ?? "") {
            UIApplication.shared.open(emailURL)
        }
    }
    
    private func getEmailURL(to: String, subject: String, body: String) -> URL? {
        let subjectEncoded = subject.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        let bodyEncoded = body.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        let gmailURL = URL(string: "googlegmail://co?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let outlookURL = URL(string: "ms-outlook://compose?to=\(to)&subject=\(subjectEncoded)")
        let yahooMailURL = URL(string: "ymail://mail/compose?to=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let sparkURL = URL(string: "readdle-spark://compose?recipient=\(to)&subject=\(subjectEncoded)&body=\(bodyEncoded)")
        let appleMailURL = URL(string: "mailto:\(to)?subject=\(subjectEncoded)&body=\(bodyEncoded)")

        if let gmailURL = gmailURL, UIApplication.shared.canOpenURL(gmailURL) {
            return gmailURL
        } else if let outlookURL = outlookURL, UIApplication.shared.canOpenURL(outlookURL) {
            return outlookURL
        } else if let yahooMailURL = yahooMailURL, UIApplication.shared.canOpenURL(yahooMailURL) {
            return yahooMailURL
        } else if let sparkURL = sparkURL, UIApplication.shared.canOpenURL(sparkURL) {
            return sparkURL
        }
        return appleMailURL
    }
}

extension EmailComposer: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        switch result {
        case .cancelled:
            print("Mail cancelled")
        case .saved:
            print("Mail saved")
        case .sent:
            print("Mail sent")
        case .failed:
            print("Mail sent failure: \(String(describing: error?.localizedDescription))")
        default:
            break
        }
    }
}
