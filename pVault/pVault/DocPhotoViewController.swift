//The basic template for this code is based on the Swfit IOS Book by  Vandad Nahavandipoor

import UIKit
import MobileCoreServices

class DocPhotoViewController: UIViewController,
UINavigationControllerDelegate, UIImagePickerControllerDelegate , DocumentView {
    
    @IBOutlet weak var docNameTextField: UITextField!
    
    var delegate : AcceptDataDelegate!
  
    var document : Document!
    
    var controller: UIImagePickerController?
    
    //The image that is returned form the Camera or Photos
    var docIMage : UIImage?
    
    @IBOutlet weak var imagePreview: UIImageView!
    
    
    @IBAction func captureClicked(sender: AnyObject) {
        
        openCamera()
        
    }
    @IBAction func photoLibraryClicked(sender: AnyObject) {
        openPhotos()
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        docNameTextField.text = document.docName
        
        if ( document.editEnabled! ) {
            
            //TODO fix this
            //docIMage = document.docImage
            
        }
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if ( docIMage != nil)
        {
            let encodedImage = Encoder.encodeImage(docIMage!)
        
//---   takes the uiimage
            document.docImage = encodedImage //docIMage
        }
        
        let vc = segue.destinationViewController as DocumentConfirmCreateViewController
        
        vc.document = document
        
    }
    
    
    //Opens up IOS Photo picker/ requests promission from Phone
    func openPhotos() {
        
        var picker : UIImagePickerController = UIImagePickerController()
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        picker.mediaTypes = UIImagePickerController.availableMediaTypesForSourceType(.PhotoLibrary)!
        picker.delegate = self
        picker.allowsEditing = false
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func openCamera () {
        if isCameraAvailable() && doesCameraSupportTakingPhotos(){
            
            controller = UIImagePickerController()
            
            if let theController = controller{
                theController.sourceType = .Camera
                
                theController.mediaTypes = [kUTTypeImage as NSString]
                
                theController.allowsEditing = true
                theController.delegate = self
                
                presentViewController(theController, animated: true, completion: nil)
            }
            
        } else {
            println("Camera is not available")
        }
        
    }
    
    // This is called on Success for both camera and choosing pictures from the Photos
    // Most of it from  Vandad Nahavandipoor
    func imagePickerController(picker: UIImagePickerController!,
        didFinishPickingMediaWithInfo info: [NSObject : AnyObject]!){
            
            println("Picker returned successfully")
            
            let mediaType:AnyObject? = info[UIImagePickerControllerMediaType]
            
            if let type:AnyObject = mediaType{
                
                if type is String{
                    
                    let stringType = type as String
                        
                    if stringType == kUTTypeImage as NSString as NSString{
                        
                        //Gets metedata, this was from example
                        let metadata = info[UIImagePickerControllerMediaMetadata]
                            as? NSDictionary
                        
                        //This is for getting the image from camera
                        if let theMetaData = metadata{
                            
                            let image = info[UIImagePickerControllerOriginalImage]
                                as? UIImage
                            if let theImage = image{
                                
                                imagePreview.image = theImage
                                docIMage = theImage
                            }
                        }
                        //This is for getting hte image from photos
                        else {
                            let image = info[UIImagePickerControllerOriginalImage]
                                as? UIImage

                            if let appImage = image{
                                imagePreview.image = appImage
                                docIMage = appImage
                            }
                        }
                    }
                    
                }
            }
            
            picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //If the User clicks Cancel
    func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        println("Picker was cancelled")
        picker.dismissViewControllerAnimated(true, completion: nil)
        
        //This goes goes back a scene
       // navigationController?.popViewControllerAnimated(true)
    }
    
    // Vandad Nahavandipoor
    func isCameraAvailable() -> Bool{
        return UIImagePickerController.isSourceTypeAvailable(.Camera)
    }
    
    // Vandad Nahavandipoor
    func cameraSupportsMedia(mediaType: String,
        sourceType: UIImagePickerControllerSourceType) -> Bool{
            
            let availableMediaTypes =
            UIImagePickerController.availableMediaTypesForSourceType(sourceType) as
                [String]?
            
            if let types = availableMediaTypes{
                for type in types{
                    if type == mediaType{
                        return true
                    }
                }
            }
            
            return false
    }
    
    // Vandad Nahavandipoor
    func doesCameraSupportTakingPhotos() -> Bool{
        return cameraSupportsMedia(kUTTypeImage as NSString, sourceType: .Camera)
    }
    
    //THink this is needed
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
}

