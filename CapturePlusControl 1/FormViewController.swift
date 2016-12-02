//
//  FormViewController.swift
//  CapturePlusControl 1
//
//  Created by Henry Thomas on 02/12/2016.
//  Copyright © 2016 Henry Thomas. All rights reserved.
//

import UIKit

class FormViewController: UIViewController, RetrieveResponseDelegate {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var txtLine2: UITextField!
    @IBOutlet weak var txtLine1: UITextField!
    @IBOutlet weak var txtCounty: UITextField!
    @IBOutlet weak var txtTown: UITextField!
    @IBOutlet weak var txtPostcode: UITextField!
    
    @IBAction func lookupAddressPressed(_ sender: Any) {
        let viewController = PCALookupViewController();
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

}
