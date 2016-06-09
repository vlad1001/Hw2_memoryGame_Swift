import UIKit

class addImagesController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var showImage: UIImageView!
    
    @IBOutlet weak var pictureUrlText: UITextField!
    
    @IBOutlet weak var saveBtnuAction: UIButton!

    @IBOutlet weak var Loadbtn: UIButton!
    
    let imagePicker = UIImagePickerController()
    let ns = NSUserDefaults.standardUserDefaults()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pictureUrlText.hidden = true
        Loadbtn.hidden = true
        imagePicker.delegate = self
        saveBtnuAction.userInteractionEnabled = false
        
        if let first = ns.stringForKey("isFirstTimePhoto") {// First time - put value in nsuserdefaults
            print("is not first time")
        }else{
            ns.setInteger(0, forKey: "numOfUserCards")
            ns.setObject("No", forKey: "isFirstTimePhoto")
            
        }

    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            showImage.contentMode = .ScaleAspectFit
            showImage.image = pickedImage
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    @IBAction func galleryBtn(sender: UIButton) {
        pictureUrlText.hidden = true
        Loadbtn.hidden = true
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true, completion: nil)
        saveBtnuAction.userInteractionEnabled = true


    }

    @IBAction func saveBtn(sender: UIButton) {
        importImages()
    }

    
    @IBAction func webBtn(sender: UIButton) {
        
       pictureUrlText.hidden = false
       Loadbtn.hidden = false
    }
    
    
    
    func GetUrl() -> String {
        var tmpURL:String
        
        tmpURL = pictureUrlText.text!
        
        return tmpURL
    }
    
    
    @IBAction func loadPictureToScreen(sender: UIButton) {

        let str = pictureUrlText.text!
        let url = NSURL(string: str)
        let data = NSData(contentsOfURL: url!)
        
        pictureUrlText.hidden = true
        Loadbtn.hidden = true
        
        if(data != nil){
            showImage.image = UIImage(data: data!)
            saveBtnuAction.userInteractionEnabled = true

        }
        
        
    }
    
    @IBAction func loadPicToImageView(sender: UIButton) {
        
    }
    
    func importImages() {
        var nextNumber = ns.integerForKey("numOfUserCards")
        nextNumber = nextNumber+1
        ns.setInteger(nextNumber, forKey: "numOfUserCards")
        nextNumber = nextNumber+10

        print(nextNumber)
        let myImageName = "card\(nextNumber).jpg"
        let imagePath = fileInDocumentsDirectory(myImageName)
    
        
        if let image = showImage.image {
            saveImage(image, path: imagePath)
        } else { print("some error message") }
    
        if let loadedImage = loadImageFromPath(imagePath) {
            print(" Loaded Image: \(loadedImage)")
        } else { print("some error message 2") }
    
    }
    
    func getDocumentsURL() -> NSURL {
        let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        return documentsURL
    }
    
    func fileInDocumentsDirectory(filename: String) -> String {
        
        let fileURL = getDocumentsURL().URLByAppendingPathComponent(filename)
        return fileURL.path!
        
    }
    
    func saveImage (image: UIImage, path: String ) -> Bool{
        let jpgImageData = UIImageJPEGRepresentation(image, 1.0)   // if you want to save as JPEG
        let result = jpgImageData!.writeToFile(path, atomically: true)
        
        return result
        
    }
    
    func loadImageFromPath(path: String) -> UIImage? {
        
        let image = UIImage(contentsOfFile: path)
        
        if image == nil {
            
            print("missing image at: \(path)")
        }
        print("Loading image from path: \(path)") // this is just for you to see the path in case you want to go to the directory, using Finder.
        return image
        
    }
}
