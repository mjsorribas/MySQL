//
//  Statement.swift
//  MySQL
//
//  Created by Alsey Coleman Miller on 12/11/15.
//  Copyright © 2015 ColemanCDA. All rights reserved.
//

import SwiftFoundation
import CMySQL

public extension MySQL {
    
    public final class Statement {
        
        // MARK: - Properties
        
        public let connection: Connection
        
        // MARK: - Internal Methods
        
        internal let internalPointer: UnsafeMutablePointer<MYSQL_STMT>
        
        // MARK: - Initialization
        
        deinit { mysql_stmt_close(internalPointer) }
        
        public init(connection: Connection) throws {
            
            self.connection = connection
            
            self.internalPointer = mysql_stmt_init(connection.internalPointer)
            
            guard self.internalPointer != nil else { throw connection.statusCodeError }
            
        }
        
        // MARK: - Methods
        
        public func prepare(statement: String) throws {
            
            guard mysql_stmt_prepare(internalPointer, statement, UInt(statement.utf8.count)) == 0
                else { throw MySQL.Error.ErrorCode(<#T##UInt32#>, <#T##String#>) }
        }
            
        
    }
}

