//
//  FormViewController.swift
//  CapturePlusControl 1
//
//  Created by Henry Thomas on 02/12/2016.
//  Copyright © 2016 Henry Thomas. All rights reserved.
//

import UIKit

class FormViewController: UIViewController, PCALookupViewDelegate {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var txtLine2: UITextField!
    @IBOutlet weak var txtLine1: UITextField!
    @IBOutlet weak var txtCounty: UITextField!
    @IBOutlet weak var txtTown: UITextField!
    @IBOutlet weak var txtPostcode: UITextField!
    
    @IBAction func lookupAddressPressed(_ sender: Any) {
        let viewController = PCALookupViewController(licenseKey: "LL00-UU00-KK00-EE00");
        viewController.addressDelegate = self;
        self.present(viewController, animated: true, completion: nil)
    }
    func didRecieveAddress(address: RetrieveResponseItem) {
        print(address)
        txtLine1.text = address.Line1
        txtLine2.text = address.Line2
        txtCounty.text = address.Province
        txtTown.text = address.City;
        txtPostcode.text = address.PostalCode
    }

    /*func pca_cellBackgroundColor(findResponse: FindResponseItem) -> UIColor {
        return UIColor.blue;
    }
    
    func pca_cellTextColor(findResponse: FindResponseItem) -> UIColor {
        return UIColor.red;
    }
    
    func pca_backgroundColor() -> UIColor {
        return .blue;
    }*/
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
