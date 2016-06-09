import UIKit

class scoreController: UITableViewController {
    
    var playersArray:[Player] = [Player]()
    
    var nameFromGame = "" //name from game vc
    var timeFromGame = 99999 //time from game vc
    
    var tmpPlayer = Player(playerName: "", scoreTime: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ns = NSUserDefaults.standardUserDefaults()
        
//        // to empty list
//                for index in 0...9 {
//                    ns.setObject("NA", forKey: "Name\(index)")
//                    ns.setInteger(999, forKey: "Score\(index)")
//        }
        
        if let name = ns.stringForKey("isFirstTime") {
            print("is not first time")
        }else{
            for index in 0...9 {
                ns.setObject("NA", forKey: "Name\(index)")
                ns.setInteger(999, forKey: "Score\(index)")
            }
            ns.setObject("No", forKey: "isFirstTime")
        }
        
        for index in 0...9 {
            tmpPlayer = Player(playerName: ns.stringForKey("Name\(index)")!, scoreTime: ns.integerForKey("Score\(index)"))
            playersArray.append(tmpPlayer)
        }
        tmpPlayer = Player(playerName: nameFromGame, scoreTime: timeFromGame)
        playersArray.append(tmpPlayer)

        playersArray = playersArray.sort { (element1, element2) -> Bool in
            return element1.scoreTime < element2.scoreTime
        }
        
        
        for index in 0...9 {
            print("\(index): \(playersArray[index].playerName) \(playersArray[index].scoreTime)")
            ns.setObject(playersArray[index].playerName, forKey: "Name\(index)")
            ns.setInteger(playersArray[index].scoreTime, forKey: "Score\(index)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //Change to 10
        return 10
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! playerCell
        
        let playerDetails = playersArray[indexPath.row]
        
        cell.nameLabel.text = playerDetails.playerName
        cell.ScoreLabel.text = (String)(playerDetails.scoreTime)
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        
        let playerSelected = playersArray[indexPath.row]
        let detailCtr:detailsController = self.storyboard?.instantiateViewControllerWithIdentifier("detailsController") as! detailsController
        
        detailCtr.nameToPass = playerSelected.playerName
        detailCtr.timeToPass = (String)(playerSelected.scoreTime)
        
        self.presentViewController(detailCtr, animated: true, completion: nil)
        
    }
}
