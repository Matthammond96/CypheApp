
import Foundation
import UIKit

protocol registerDelagate {
    func fillInForm()
}

class registerViewController: UIViewController {
    
    //Varibles 
    var delegate: registerDelagate?
    
    //form IB
    @IBOutlet weak var UsernameForm: UITextField!
    @IBOutlet weak var passwordForm: UITextField!
    
    @IBAction func registerButton(sender: AnyObject) {
        print(UsernameForm.text)
        print(passwordForm.text)
        delegate?.fillInForm()
        performSegueWithIdentifier("registerFormFilled", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "registerFormFilled" {
            let registeredButton = segue.destinationViewController as! loginScreenViewController
            registeredButton.usernameForm = UsernameForm.text
            registeredButton.passwordForm = passwordForm.text
        }
    }
}