//
//  Hero.swift
//  FlexingMVI
//
//  Created by waheedCodes on 12/04/2022.
//

import Foundation

class Hero {
    let name: String
    let speed: Float
    let power: Float
    let stamina: Float

    init(_ name: String,
         speed: Float,
         power: Float,
         stamina: Float) {
        self.name = name
        self.speed = speed
        self.power = power
        self.stamina = stamina
    }
}
