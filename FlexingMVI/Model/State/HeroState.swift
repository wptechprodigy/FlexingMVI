//
//  HeroState.swift
//  FlexingMVI
//
//  Created by waheedCodes on 12/04/2022.
//

import Foundation

protocol HeroState {

}

class HeroPresenting: HeroState {
    let hero: Hero
    let nextAvailable: Bool
    let previousAvailable: Bool

    init(withHero hero: Hero, nextAvailable next: Bool, previousAvailable previous: Bool) {
        self.hero = hero
        self.nextAvailable = next
        self.previousAvailable = previous
    }
}

class HeroSelected: HeroState {
    let hero: Hero

    init(selectedHero hero: Hero) {
        self.hero = hero
    }
}
