// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EvidenceStorage {
    struct Incident {
        uint256 timestamp;
        string evidenceHash; // IPFS hash of the encrypted evidence
        string status;
        address reporter;
    }

    mapping(uint256 => Incident) public incidents;
    uint256 public incidentCount;

    event IncidentReported(uint256 indexed id, uint256 timestamp, string evidenceHash);
    event StatusUpdated(uint256 indexed id, string newStatus);

    function reportIncident(string memory _evidenceHash) public returns (uint256) {
        incidentCount++;
        incidents[incidentCount] = Incident(
            block.timestamp,
            _evidenceHash,
            "REPORTED",
            msg.sender
        );
        
        emit IncidentReported(incidentCount, block.timestamp, _evidenceHash);
        return incidentCount;
    }

    function updateStatus(uint256 _id, string memory _status) public {
        // In a real scenario, this would have access control (e.g., only authorized NGOs/Police)
        require(_id > 0 && _id <= incidentCount, "Incident does not exist");
        incidents[_id].status = _status;
        
        emit StatusUpdated(_id, _status);
    }
    
    function getIncident(uint256 _id) public view returns (uint256, string memory, string memory, address) {
        require(_id > 0 && _id <= incidentCount, "Incident does not exist");
        Incident memory inc = incidents[_id];
        return (inc.timestamp, inc.evidenceHash, inc.status, inc.reporter);
    }
}
