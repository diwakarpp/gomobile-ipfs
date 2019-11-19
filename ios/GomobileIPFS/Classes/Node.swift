//
//  Node.swift
//  GomobileIPFS
//
//  Created by Guilhem Fanton on 07/11/2019.
//

import Foundation
import Ipfs

public enum NodeError: Error {
  case error(String)
  case runtimeError(Error, String)
}

public class Node {
    let node: IpfsNodeProtocol
    
    public init(_ repo: Repo) throws {
        var err: NSError?
        
        if let node = IpfsNewNode(repo.goRepo, &err) {
            self.node = node
        } else if let error = err {
            throw NodeError.runtimeError(error, "failed to start node")
        } else {
            throw RepoError.error("failed start node, unknow error")
        }
    }

    public func close() throws {
        try self.node.close()
    }
    
    public func serve(sockpath: String) throws {
        try self.node.serve(sockpath)
    }
}
