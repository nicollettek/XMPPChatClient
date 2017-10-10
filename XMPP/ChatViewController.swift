import Foundation
import UIKit
import XMPPFramework

class ChatViewController: UIViewController, MessageDelegate {
    
    @IBOutlet weak var contactInfo: UILabel!
    @IBOutlet weak var chatWindow: UITextView!
    @IBOutlet weak var typingTextWindow: UITextField!
    @IBOutlet weak var sendMessageBtn: UIButton!
    
    var xmppController: XMPPController?
    var chatUser: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatUser = "user1@localhost"
        if xmppController != nil {
            xmppController?.messageDelegate = self
            contactInfo.text = chatUser
        }
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        if xmppController != nil {
            if let typingTxt = typingTextWindow.text {
                if !typingTxt.isEmpty {
                    xmppController?.sendMessage(typingTextWindow.text, chatUser!)
                    chatWindow.text.append("\((xmppController?.userJID)!): \(typingTextWindow.text!)\n")
                }
                typingTextWindow.text = ""
            }
        }
    }
    
    func newMessageReceived(_ messageContent: String, user: String) {
        if chatWindow != nil {
            chatWindow.text.append("\(user): \(messageContent)\n")
        }
        
        print("receivedMessage")
    }
}

