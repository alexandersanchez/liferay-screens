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

public class LoadRatingsInteractor: Interactor, LRCallback {
    
    let entryId: Int64
    let stepCount: Int32
    
    var resultRating: RatingEntry?
    
    init(screenlet: BaseScreenlet, entryId: Int64, stepCount: Int32) {
        self.entryId = entryId
        self.stepCount = stepCount
        super.init(screenlet: screenlet)
    }
    
    public override func start() -> Bool {
        let session = SessionContext.createSessionFromCurrentSession()
        session?.callback = self
        
        let service = LRScreensratingsentryService_v70(session: session)
        
        do {
            try service.getRatingsEntriesWithEntryId(entryId, stepCount: stepCount)
            return true
        } catch {
            return false
        }
    }
    
    public func onFailure(error: NSError!) {
        self.onFailure?(error)
    }
    
    public func onSuccess(result: AnyObject!) {
        resultRating = RatingEntry(attributes: result as! [String: AnyObject])
        self.onSuccess?()
    }

}
