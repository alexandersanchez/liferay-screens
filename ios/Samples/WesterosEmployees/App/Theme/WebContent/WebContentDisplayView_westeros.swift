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

public class WebContentDisplayView_westeros: WebContentDisplayView_default {

	private let styles =
		".MobileCSS {padding: 0% 4%; width: 92%; color: white;} " +
		".MobileCSS, .MobileCSS span, .MobileCSS p, .MobileCSS h1, .MobileCSS h2, .MobileCSS h3 { " +
			"font-size: 110%; font-family: \"Helvetica Neue\", Helvetica, Arial, sans-serif; font-weight: 200; } " +
		".MobileCSS img { width: 100% !important; } " +
		".span2, .span3, .span4, .span6, .span8, .span10 { width: 100%; }"

	override public func createProgressPresenter() -> ProgressPresenter {
		return WesterosCardProgressPresenter(screenlet: screenlet)
	}

	//MARK: WebContentDisplayViewModel

	public override var htmlContent: String? {
		get {
			return ""
		}
		set {
			let styledHtml = "<style>\(styles)</style><div class=\"MobileCSS\">\(newValue ?? "")</div>"

			webView!.loadHTMLString(styledHtml, baseURL: NSURL(string:LiferayServerContext.server))
		}
	}
}
