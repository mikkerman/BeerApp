//
//  AppLogger.swift
//  BeerApp
//
//  Created by Михаил Герман on 18.05.2023.
//

import SwiftyBeaver

let log = SwiftyBeaver.self

func setupLogging() {
    let console = ConsoleDestination()
    console.format = "$DHH:mm:ss$d $L $M"
    log.addDestination(console)
}
