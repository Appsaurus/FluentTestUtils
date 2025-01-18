//
//  FluentTestCase.swift
//  FluentTestUtils
//
//  Created by Brian Strobach on 6/27/18.
//

import Foundation
import XCTVaporExtensions
import Vapor
import Fluent
import XCTVapor
import VaporTestUtils

open class FluentTestCase: VaporTestCase{

    open override func afterAppConfiguration() async throws {
        try await super.afterAppConfiguration()
        try await app.autoMigrate()
    }
	

//	open func configure(migrations: inout MigrationConfig){
//		
//	}
}
