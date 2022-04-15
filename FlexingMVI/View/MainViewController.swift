//
//  MainViewController.swift
//  FlexingMVI
//
//  Created by waheedCodes on 11/04/2022.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    @IBOutlet weak var speedProgressView: UIProgressView!
    @IBOutlet weak var powerProgressView: UIProgressView!
    @IBOutlet weak var staminaProgressView: UIProgressView!

    @IBOutlet weak var previousCharacterButton: UIButton!
    @IBOutlet weak var nextCharacterButton: UIButton!
    @IBOutlet weak var selectCharacterButton: UIButton!

    // MARK: - Properties
    private let intent = MainIntent()
    private let disposeBag = DisposeBag()

    var selectedAlert: UIAlertController?

    // MARK: - Object Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        bindButtons()
        intent.bind(toView: self)
        selectedAlert = UIAlertController(title: "You selected",
                                          message: "",
                                          preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Dismiss", style: .cancel) { _ in
            self.intent.onDismissCharacter()
        }
        selectedAlert?.addAction(dismiss)
    }

    /// <#Description#>
    /// - Parameter state: <#state description#>
    func update(withState state: HeroState) {
        switch state {
            case is HeroPresenting:
                let heroState = state as! HeroPresenting
                showPresentState(withPresentState: heroState)
                break
            case is HeroSelected:
                let heroState = state as! HeroSelected
                showSelectedState(withHeroName: heroState.hero.name)
                break
            default:
                break
        }
    }

    private func showPresentState(
        withPresentState state: HeroPresenting) {
            let hero = state.hero
            self.updateHeroDetails(with: hero)

            nextCharacterButton.isEnabled = state.nextAvailable
            previousCharacterButton.isEnabled = state.previousAvailable
    }

    /// <#Description#>
    /// - Parameter hero: <#hero description#>
    private func updateHeroDetails(with hero: Hero) {
        let TOTAL_PROGRESS: Float = 10
        
        nameLabel.text = hero.name
        imageView.image = UIImage(named: hero.name)
        speedProgressView.progress = hero.speed / TOTAL_PROGRESS
        powerProgressView.progress = hero.power / TOTAL_PROGRESS
        staminaProgressView.progress = hero.stamina / TOTAL_PROGRESS
    }

    /// <#Description#>
    /// - Parameter name: <#name description#>
    private func showSelectedState(withHeroName name: String) {
        guard let alert = selectedAlert else { return }
        alert.message = name
        self.present(alert, animated: true)
    }

    /// <#Description#>
    private func bindButtons() {
        previousCharacterButton.rx.tap.bind {
            self.intent.onPreviousCharacterButtonClicked()
        }.disposed(by: disposeBag)

        nextCharacterButton.rx.tap.bind {
            self.intent.onNextCharacterButtonClicked()
        }.disposed(by: disposeBag)

        selectCharacterButton.rx.tap.bind {
            self.intent.onSelectCharacter()
        }.disposed(by: disposeBag)
    }
}
