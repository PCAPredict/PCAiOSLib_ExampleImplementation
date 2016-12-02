//
//  PCALookupViewController.swift
//  CapturePlusControl 1
//
//  Created by Henry Thomas on 02/12/2016.
//  Copyright © 2016 Henry Thomas. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class PCALookupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    init() {
        super.init(nibName: "PCALookupView", bundle: nil)
      
        
    }
    
    @IBAction func searchValueChanged(_ sender: Any) {
        var newText: String = searchField.text!;
        
        let isBackspace = ((lastText ?? "").characters.count) > newText.characters.count;
        if(isBackspace){
            currentItem = nil;
        }
        lastText = newText;
        if(newText == ""){
            currentResponse = nil;
            outputTable.reloadData();
        }else{
            MakeFindRequest();
        }
        
    }
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var outputTable: UITableView!
    @IBOutlet weak var searchField: UITextField!
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    var manager: Alamofire.SessionManager? = nil;
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let cont = UIApplication.shared.keyWindow?.rootViewController;
        self.topConstraint.constant += (cont?.topLayoutGuide.length)!;
        
        
        registerForKeyboardNotifications();
        manager = Alamofire.SessionManager();
        self.locationManager.distanceFilter = kCLDistanceFilterNone
        self.locationManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        searchField.becomeFirstResponder()
    }
    
    var addressDelegate:RetrieveResponseDelegate?
    
 
    
    var currentResponse: FindResponse? = nil;
    var currentItem: FindResponseItem? = nil;
    var lastText: String? = nil;


    
    let key: String = "LL00-UU00-KK00-EE00";
    //let host: String = "services.postcodeanywhere.co.uk";
    let host: String = "api.addressy.com";
    
    func MakeFindRequest(){
        
        let lat = locationManager.location?.coordinate.latitude;
        let long = locationManager.location?.coordinate.longitude;
        
        var url = "https://" + host + "/capture/interactive/find/v1.00/json3.ws?key=" + key + "&Text=" + searchField.text!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!;
        if(currentItem != nil){
            url += "&container=" + (currentItem?.Id!.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)!;
        }
        
        if(lat != nil && long != nil){
            url += "&origin=\(lat!),\(long!)"
        }
        print(url);
        manager?.request(url)
            .responseObject { (response: DataResponse<FindResponse>) in
                
                let fetchResponse = response.result.value;
                print(fetchResponse?.Items?.first?.Text ?? "")
                if(fetchResponse != nil){
                    self.currentResponse = fetchResponse!;
                    self.outputTable.reloadData();
                }
        }
        
    }
    
    func MakeRetrieveRequest(id: String){
        let url = "https://" + host + "/capture/interactive/retrieve/v1.00/json3.ws?key=" + key + "&id=" + id.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!;
        
        print(url);
        Alamofire.request(url)
            .responseObject { (response: DataResponse<RetrieveResponse>) in
                
                let retrieveResponse = response.result.value;
                
                let retrieveResponseItem = retrieveResponse?.Items?.first;
                
                /*let alertController = UIAlertController(title: "Address", message: retrieveResponseItem?.Label, preferredStyle: .alert)
                 let action = UIAlertAction(title: "ok", style: .default);
                 alertController.addAction(action)
                 self.present(alertController, animated: true)*/
                
                self.addressDelegate?.didRecieveAddress(address: retrieveResponseItem!);
                
                self.dismiss(animated: true);
                
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentResponse?.Items?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let newCell = UITableViewCell(style: .subtitle, reuseIdentifier: "")
        
        let currentItem = self.currentResponse?.Items?[indexPath.item];
        newCell.textLabel!.text = currentItem?.Text;
        newCell.detailTextLabel!.text = currentItem?.Description;
        return newCell;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentItem = self.currentResponse?.Items?[indexPath.item];
        if(currentItem?.ItemType == "Address"){
            MakeRetrieveRequest(id: (currentItem?.Id)!)
        }else{
            MakeFindRequest()
        }
    }
    
    func keyboardWasShown(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let insets = UIEdgeInsets.init(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0);
            self.outputTable.contentInset = insets;
            self.outputTable.scrollIndicatorInsets = insets;
        }
    }
    
    func keyboardWasHidden(notification: NSNotification){
        let insets = UIEdgeInsets.zero
        self.outputTable.contentInset = insets;
        self.outputTable.scrollIndicatorInsets = insets;
    }
    
    func registerForKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }


}
