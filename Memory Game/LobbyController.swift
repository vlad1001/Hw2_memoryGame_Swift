import UIKit

class LobbyController: UIViewController {

    @IBOutlet weak var playerNameField: UITextField!
    
    var toPass:String! //name passing to game view controller
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "segueGame") {
            let svc = segue.destinationViewController as! ViewController;
            
            svc.nameToPass = playerNameField.text!
            
        }
    }
    
    
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject!) -> Bool {
        if identifier == "segueGame" {
            
            if (playerNameField.text!.isEmpty) {
                
                let alert = UIAlertView()
                alert.title = "Empty name"
                alert.message = "Please enter name"
                alert.addButtonWithTitle("Ok")
                alert.show()
                
                return false
            }
                
            else {
                return true
            }
        }
        
        return true
    }
    
    @IBAction func nameLabel(sender: UITextField) {
        playerNameField.becomeFirstResponder()
    }

    @IBAction func startGameButton(sender: AnyObject) {
        self.playerNameField.resignFirstResponder()
        
    }

}
