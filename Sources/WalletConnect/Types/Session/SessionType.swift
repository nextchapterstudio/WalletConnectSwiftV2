import Foundation
import WalletConnectUtils

// Internal namespace for session payloads.
internal enum SessionType {
    
    typealias ProposeParams = SessionProposal
    
    struct ApproveParams: Codable, Equatable {
        let relay: RelayProtocolOptions
        let responder: SessionParticipant
        let expiry: Int
        let state: SessionState
    }
    
    struct RejectParams: Codable, Equatable {
        let reason: Reason
    }
    
    struct SettlementParams: Codable, Equatable {
        // TODO
    }
    
    struct UpdateParams: Codable, Equatable {
        let state: SessionState
        
        init(state: SessionState) {
            self.state = state
        }
        
        init(accounts: Set<Account>) {
            let accountIds = accounts.map { $0.absoluteString }
            self.state = SessionState(accounts: accountIds)
        }
    }
    
    struct UpgradeParams: Codable, Equatable {
        let permissions: SessionPermissions
    }
    
    struct DeleteParams: Codable, Equatable {
        let reason: Reason
        init(reason: SessionType.Reason) {
            self.reason = reason
        }
    }
    
    struct Reason: Codable, Equatable {
        let code: Int
        let message: String
        
        init(code: Int, message: String) {
            self.code = code
            self.message = message
        }
    }
    
    struct PayloadParams: Codable, Equatable {
        let request: Request
        let chainId: String?
        
        struct Request: Codable, Equatable {
            let method: String
            let params: AnyCodable
        }
    }
    
    struct NotificationParams: Codable, Equatable {
        let type: String
        let data: AnyCodable
        
        init(type: String, data: AnyCodable) {
            self.type = type
            self.data = data
        }
    }
    
    struct PingParams: Codable, Equatable {} 
    
    struct ExtendParams: Codable, Equatable {
        let ttl: Int
    }
}

// A better solution could fit in here
internal extension Reason {
    func toInternal() -> SessionType.Reason {
        SessionType.Reason(code: self.code, message: self.message)
    }
}

extension SessionType.Reason {
    func toPublic() -> Reason {
        Reason(code: self.code, message: self.message)
    }
}
