// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.11;

error AlreadyRevealed(address, bytes32, string);

contract Secret {
    bytes32 secretHash;
    string secret;
    mapping(bytes32 => string) public database;
    event SecretCommitted(address indexed sender, bytes32 indexed secretHash);
    event SecretCommittedS(address indexed sender, bytes32 indexed secretHash, string indexed s);


    function commit(bytes32 s) external {
        if (keccak256(abi.encode(database[s])) != keccak256(abi.encode(string("")))) {
            revert AlreadyRevealed(msg.sender, s, database[s]);
        }
        emit SecretCommitted(msg.sender, bytes32(s));
    }

// doesnt work
    function commit(string calldata s) external {
        bytes32 b = keccak256(abi.encode(s));
        // if (keccak256(abi.encode(database[b])) != keccak256(bytes(string("")))) {
        //     revert AlreadyRevealed(msg.sender, b, s);
        // }
        // emit SecretCommitted(msg.sender, b);
        emit SecretCommittedS(address(0), b, string(""));
    }

// doesnt work
    function verify(string calldata s) external view returns (bool) {
        bytes32 b = keccak256(abi.encode(s));
        return b == keccak256(abi.encode(database[b]));
    }

    function reveal(string calldata s) external {
        bytes32 b = keccak256(abi.encode(s));
        // if (keccak256(abi.encode(database[b])) != keccak256(abi.encode(string("")))) {
        //     revert AlreadyRevealed(msg.sender, b, s);
        // }
        database[b] = s;
        emit SecretCommitted(msg.sender, b);
    }
}
