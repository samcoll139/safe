// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title WomenSafetyVault
 * @notice Decentralized Evidence Vault & Case Escalation Ledger
 * @dev Integrates Agentic AI events, IPFS hashes, and SLA-based automated escalation.
 */
contract WomenSafetyVault {
    enum IncidentStatus { Reported, Investigating, FIR_Filed, Escalated, Resolved, Dismissed }
    enum ThreatLevel { Low, Medium, High, Critical }

    struct ChainOfCustodyRecord {
        address actor;
        string action;
        uint256 timestamp;
        string note;
    }

    struct Incident {
        uint256 id;
        bytes32 anonymousCommitment; // ZK/DID commitment for identity privacy
        string ipfsEvidenceHash;     // Off-chain encrypted audio/video/cctv metadata on IPFS
        ThreatLevel threat;
        IncidentStatus status;
        uint256 timestamp;
        uint256 lastUpdated;
        uint256 escalationDeadline;  // Audit agent triggers escalation if status inactive past deadline
        address assignedOfficer;
        bool isEscalated;
        bool isAnonymous;
    }

    address public admin;
    uint256 public incidentCount;

    mapping(uint256 => Incident) public incidents;
    mapping(uint256 => ChainOfCustodyRecord[]) private chainOfCustody;
    mapping(address => bool) public authorizedResponders; // Police, NGOs, Rapid Action Units

    // Events
    event IncidentLogged(uint256 indexed id, bytes32 indexed commitment, string ipfsHash, ThreatLevel threat, uint256 timestamp);
    event StatusUpdated(uint256 indexed id, IncidentStatus newStatus, address updatedBy, uint256 timestamp);
    event IncidentEscalated(uint256 indexed id, string reason, uint256 timestamp);
    event EvidenceAppended(uint256 indexed id, string newIpfsHash, address addedBy);
    event ResponderAuthorized(address indexed responder, bool isAuthorized);

    modifier onlyAdmin() {
        require(msg.sender == admin, "Caller is not admin");
        _;
    }

    modifier onlyAuthorized() {
        require(msg.sender == admin || authorizedResponders[msg.sender], "Not authorized responder");
        _;
    }

    constructor() {
        admin = msg.sender;
        authorizedResponders[msg.sender] = true;
    }

    function setResponderAuthorization(address responder, bool isAuthorized) external onlyAdmin {
        authorizedResponders[responder] = isAuthorized;
        emit ResponderAuthorized(responder, isAuthorized);
    }

    /**
     * @notice Registers an SOS incident with cryptographic proof and IPFS evidence hash
     */
    function recordIncident(
        bytes32 _anonymousCommitment,
        string calldata _ipfsEvidenceHash,
        ThreatLevel _threat,
        bool _isAnonymous,
        uint256 _slaHours
    ) external returns (uint256) {
        incidentCount++;
        uint256 deadline = block.timestamp + (_slaHours > 0 ? _slaHours * 1 hours : 6 hours);

        Incident storage inc = incidents[incidentCount];
        inc.id = incidentCount;
        inc.anonymousCommitment = _anonymousCommitment;
        inc.ipfsEvidenceHash = _ipfsEvidenceHash;
        inc.threat = _threat;
        inc.status = IncidentStatus.Reported;
        inc.timestamp = block.timestamp;
        inc.lastUpdated = block.timestamp;
        inc.escalationDeadline = deadline;
        inc.isEscalated = false;
        inc.isAnonymous = _isAnonymous;

        chainOfCustody[incidentCount].push(ChainOfCustodyRecord({
            actor: msg.sender,
            action: "INCIDENT_INITIATED",
            timestamp: block.timestamp,
            note: "Evidence captured and secured on-chain"
        }));

        emit IncidentLogged(incidentCount, _anonymousCommitment, _ipfsEvidenceHash, _threat, block.timestamp);
        return incidentCount;
    }

    /**
     * @notice Adds additional forensic evidence (audio/video/sensor dump)
     */
    function appendEvidence(uint256 _id, string calldata _newIpfsHash, string calldata _note) external {
        require(_id > 0 && _id <= incidentCount, "Incident not found");
        Incident storage inc = incidents[_id];

        chainOfCustody[_id].push(ChainOfCustodyRecord({
            actor: msg.sender,
            action: "EVIDENCE_APPENDED",
            timestamp: block.timestamp,
            note: _note
        }));

        emit EvidenceAppended(_id, _newIpfsHash, msg.sender);
    }

    /**
     * @notice Updates status of incident (by verified police/NGO)
     */
    function updateStatus(uint256 _id, IncidentStatus _newStatus, string calldata _remarks) external onlyAuthorized {
        require(_id > 0 && _id <= incidentCount, "Incident not found");
        Incident storage inc = incidents[_id];

        inc.status = _newStatus;
        inc.lastUpdated = block.timestamp;
        inc.assignedOfficer = msg.sender;

        chainOfCustody[_id].push(ChainOfCustodyRecord({
            actor: msg.sender,
            action: "STATUS_TRANSITION",
            timestamp: block.timestamp,
            note: _remarks
        }));

        emit StatusUpdated(_id, _newStatus, msg.sender, block.timestamp);
    }

    /**
     * @notice Audit Agent invokes this if authority response exceeds SLA time window
     */
    function triggerAuditEscalation(uint256 _id, string calldata _escalationReason) external {
        require(_id > 0 && _id <= incidentCount, "Incident not found");
        Incident storage inc = incidents[_id];

        require(!inc.isEscalated, "Already escalated");
        require(inc.status == IncidentStatus.Reported, "Already acknowledged");
        require(block.timestamp > inc.escalationDeadline, "SLA deadline not breached yet");

        inc.isEscalated = true;
        inc.status = IncidentStatus.Escalated;
        inc.lastUpdated = block.timestamp;

        chainOfCustody[_id].push(ChainOfCustodyRecord({
            actor: msg.sender,
            action: "AUTO_ESCALATED_BY_AUDIT_AGENT",
            timestamp: block.timestamp,
            note: _escalationReason
        }));

        emit IncidentEscalated(_id, _escalationReason, block.timestamp);
    }

    function getChainOfCustody(uint256 _id) external view returns (ChainOfCustodyRecord[] memory) {
        require(_id > 0 && _id <= incidentCount, "Incident not found");
        return chainOfCustody[_id];
    }
}
