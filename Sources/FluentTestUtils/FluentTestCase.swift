//
//  FluentTestCase.swift
//  FluentTestUtils
//
//  Created by Brian Strobach on 6/27/18.
//

import Foundation
import VaporTestUtils
import Vapor
import Fluent

open class FluentTestCase: VaporTestCase{

	open override func configure(_ config: inout Config, _ env: inout Environment, _ services: inout Services) throws {

		try super.configure(&config, &env, &services)

		// Configure migrations
		var migrations = MigrationConfig()
		configure(migrations: &migrations)
		services.register(migrations)
	}

	open func configure(migrations: inout MigrationConfig){
		
	}
}
