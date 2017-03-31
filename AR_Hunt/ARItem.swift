//
//  ARItem.swift
//  AR_Hunt
//
//  Created by harry bloch on 3/31/17.
//  Copyright © 2017 Razeware LLC. All rights reserved.
//

import Foundation
import CoreLocation
import SceneKit

struct ARItem {
  let itemDescription: String
  let location: CLLocation
  var itemNode: SCNNode?
}
