//
//  HeroSelector.swift
//  FlexingMVI
//
//  Created by waheedCodes on 12/04/2022.
//

import Foundation

class HeroSelector {

    // MARK: - State
    let heroes: [Hero]
    var heroID: Int = 0

    // MARK: - Properties
    var previousHero: Hero? {
        getPreviousHero()
    }
    var nextHero: Hero? {
        getNextHero()
    }
    var currentHero: Hero {
        heroes[heroID]
    }

    // MARK: - Initializers
    init() {
        heroes = [
            Hero("Son-Goku", speed: 7.0, power: 7.0, stamina: 5.0),
            Hero("Far_Cry", speed: 10.0, power:5.0, stamina: 5.0),
            Hero("Iron_Man", speed: 6.0, power: 6.0, stamina: 7.0),
            Hero("Shooter_Raider", speed: 9.0, power: 7.5, stamina: 8.0),
            Hero("Tomb_Raider", speed: 9.5, power: 9.8, stamina: 9.8)
        ]
    }

    // MARK: - Methods
    private func getPreviousHero() -> Hero? {
        if !isPreviousHeroAvailable() {
            return nil
        }

        heroID -= 1
        return heroes[heroID]
    }

    private func getNextHero() -> Hero? {
        if !isNextHeroAvailable() {
            return nil
        }

        heroID += 1
        return heroes[heroID]
    }

    func isNextHeroAvailable() -> Bool {
        heroes.count - 1 > heroID
    }

    func isPreviousHeroAvailable() -> Bool {
        heroID > 0
    }
}
