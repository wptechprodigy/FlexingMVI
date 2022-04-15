//
//  MainIntent.swift
//  FlexingMVI
//
//  Created by waheedCodes on 12/04/2022.
//

import Foundation
import RxSwift
import RxCocoa

class MainIntent {
    var stateReplay: PublishRelay<HeroState>
    var view: MainViewController?
    let heroSelector = HeroSelector()
    var disposeBag = DisposeBag()

    init() {
        stateReplay = PublishRelay()
    }

    public func bind(toView view: MainViewController) {
        self.view = view

        stateReplay.subscribe { event in
            guard let state = event.element else {
                return
            }
            self.view?.update(withState: state)
        }.disposed(by: disposeBag)

        let hero = heroSelector.currentHero
        let next = heroSelector.isNextHeroAvailable()
        let previous = heroSelector.isPreviousHeroAvailable()

        stateReplay.accept(
            HeroPresenting(
                withHero: hero,
                nextAvailable: next,
                previousAvailable: previous))
    }

    public func onPreviousCharacterButtonClicked() {
        guard let previousHero = heroSelector.previousHero else { return }
        present(hero: previousHero)
    }

    public func onNextCharacterButtonClicked() {
        guard let nextHero = heroSelector.nextHero else { return }
        present(hero: nextHero)
    }

    public func onSelectCharacter() {
        let currentHero = heroSelector.currentHero
        stateReplay.accept(
            HeroSelected(
                selectedHero: currentHero))
    }

    public func onDismissCharacter() {
        let currentHero = heroSelector.currentHero
        present(hero: currentHero)
    }

    private func present(hero: Hero) {
        let next = heroSelector.isNextHeroAvailable()
        let previous = heroSelector.isPreviousHeroAvailable()
        stateReplay.accept(
            HeroPresenting(
                withHero: hero,
                nextAvailable: next,
                previousAvailable: previous))
    }
}
