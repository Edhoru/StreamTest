//
//  Broadcast.swift
//  StreamTest
//
//  Created by Alberto Huerdo on 5/27/19.
//  Copyright © 2019 Huerdo. All rights reserved.
//

import UIKit

struct Broadcast: Codable {
    var id: String
    var stream: Stream
    var streamer: Streamer
}
