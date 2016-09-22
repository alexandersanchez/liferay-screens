/**
* Copyright (c) 2000-present Liferay, Inc. All rights reserved.
*
* This library is free software; you can redistribute it and/or modify it under
* the terms of the GNU Lesser General Public License as published by the Free
* Software Foundation; either version 2.1 of the License, or (at your option)
* any later version.
*
* This library is distributed in the hope that it will be useful, but WITHOUT
* ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
* FOR A PARTICULAR PURPOSE. See the GNU Lesser General Public License for more
* details.
*/
import UIKit
import LiferayScreens

class AuthViewController: UIViewController, CardDeckDelegate, CardDeckDataSource {

	@IBOutlet var cardDeck: CardDeckView?

	var signInController: SignInViewController?
	var signUpController: SignUpViewController?
	var forgotPasswordController: ForgotPasswordViewController?
	var termsController: TermsViewController?

	///Method call when view controller is going to be dismissed
	var onAuthDone: (() -> ())?


	//MARK: UIViewController
	override func viewDidLoad() {
		super.viewDidLoad()

		let onDone: () -> () = {
			self.dismissViewControllerAnimated(true) {
				self.onAuthDone?()
			}
		}

		signInController = SignInViewController()
		signInController!.onDone = onDone

		forgotPasswordController = ForgotPasswordViewController()
		termsController = TermsViewController()

		signUpController = SignUpViewController()
		signUpController!.onDone = onDone

		cardDeck?.delegate = self
		cardDeck?.dataSource = self

		self.cardDeck?.layoutIfNeeded()
	}

	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)

		cardDeck?.cards[safe: 0]?.changeToState(.Minimized)
	}


	//MARK: CardDeckDataSource

	func doCreateCard(cardDeck: CardDeckView, index: Int) -> CardView? {
		if index == 1 {
			return WesterosCardView.newAutoLayoutView()
		}

		return nil
	}

	func numberOfCardsIn(cardDeck: CardDeckView) -> Int {
		return 2
	}

	func cardDeck(cardDeck: CardDeckView, controllerForCard position: CardPosition)
			-> CardViewController? {
		switch (position.card, position.page) {
    	case (0, 0):
			return signInController
		case (0, 1):
			return forgotPasswordController
		case (1, 0):
			return signUpController
		case (1, 1):
			return termsController
    	default:
			return nil
		}
	}


	//MARK: CardDeckDelegate

	func cardDeck(cardDeck: CardDeckView, customizeCard card: CardView, atIndex index: Int) {
		//SignIn card
		if index == 0 {
			//Make login only expand to half of the page on normal height
			card.normalHeight = self.view.frame.height * 0.7

			//Don't maximized when changing pages
			card.maximizeOnMove = false

			//Start sign in card hidden
			card.currentState = .Hidden
			card.resetToCurrentState()
		} else if let westerosCard = card as? WesterosCardView {
			westerosCard.activityIndicator.color = DefaultResources.EvenColorBackground
		}
	}

	func cardDeck(cardDeck: CardDeckView, titleForCard position: CardPosition) -> String? {
		switch (position.card, position.page) {
		case (0, 0):
			return "Sign In"
		case (0, 1):
			return "Forgot password"
		case (1, 0):
			return "Sign Up"
		case (1, 1):
			return "Terms and Conditions"
		default:
			return nil
		}
	}
}
