import XMPPFramework
import UIKit


class ViewController: UIViewController {
    
    var xmppController: XMPPController!
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var serverAddress: UITextField!
    @IBOutlet weak var loginFailed: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func login(_ sender: UIButton) {
        
        let user = username.text
        let pass = password.text
        let host = serverAddress.text
        
        if user != nil && pass != nil && host != nil {
            do {
                try self.xmppController = XMPPController(hostName: host!,
                                                         userJIDString: user!,
                                                         password: pass!)
                self.xmppController.xmppStream.addDelegate(self, delegateQueue: DispatchQueue.main)
                self.xmppController.connect()
            } catch {
                print("Something went wrong")
                self.loginFailed.isHidden = false

            }
        } else {
            print("Username, password and host cannot be empty")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginSegue" {
            if let nextVC = segue.destination as? ChatViewController {
                print("going to chat view controller")
                nextVC.xmppController = self.xmppController
            }
        }
    }
}

extension ViewController: XMPPStreamDelegate {
    
    func xmppStreamDidAuthenticate(_ sender: XMPPStream!) {
        self.loginFailed.isHidden = true
        performSegue(withIdentifier: "LoginSegue", sender: nil)

    }
    
    func xmppStream(_ sender: XMPPStream!, didNotAuthenticate error: DDXMLElement!) {
        self.loginFailed.isHidden = false
    }
    
}

