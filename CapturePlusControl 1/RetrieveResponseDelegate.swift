//
//  RetrieveResponseDelegate.swift
//  CapturePlusControl 1
//
//  Created by Henry Thomas on 22/11/2016.
//  Copyright © 2016 Henry Thomas. All rights reserved.
//

import Foundation
import UIKit


@objc protocol PCALookupViewDelegate: class {
    func didRecieveAddress(address: RetrieveResponseItem)
    @objc optional func pca_cellForFindResponse(findResponse: FindResponseItem) -> UITableViewCell
    @objc optional func pca_cellBackgroundColor(findResponse: FindResponseItem) -> UIColor
    @objc optional func pca_cellTextColor(findResponse: FindResponseItem) -> UIColor
    @objc optional func pca_backgroundColor() -> UIColor
    @objc optional func pca_extraFieldFormats() -> [String]
}
