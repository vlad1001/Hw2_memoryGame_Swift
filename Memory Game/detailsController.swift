
import UIKit

class detailsController: UIViewController {

    @IBOutlet weak var detailNameLabel: UILabel!
    
    @IBOutlet weak var detailTimeLabel: UILabel!
    
    
    
    var nameToPass = ""
    var timeToPass = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()

        detailNameLabel.text = nameToPass
        detailTimeLabel.text = timeToPass
    }


}
