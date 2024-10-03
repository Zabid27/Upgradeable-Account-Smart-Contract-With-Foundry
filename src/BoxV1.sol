// SPDX-License-Identifier: MIT

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

// storage is stored in the proxy, NOT the implementation

// Proxy (borrowing funcs) -> implementation (number 1)
pragma solidity ^0.8.18;

contract BoxV1 is Initializable, UUPSUpgradeable, OwnableUpgradeable {
    uint256 internal number;

    // according to the initializable contract, a proxy contract can't have a constructor and to do so, we can use a constructor that will not get passed anything but the disableInitializer function. This constructor will then be followed by an "initialize" function that we can then pass our proxy contract params inside. Note: This function will onl be called once
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    // let's say we do want a constructor

    function initialize() public initializer {
        __Ownable_init(msg.sender); // sets the owner to msg.sender
        __UUPSUpgradeable_init();
    }

    function getNumber() external view returns (uint256) {
        return number;
    }

    function version() external pure returns (uint256) {
        return 1;
    }

    function _authorizeUpgrade(address newImplementation) internal override {
        // if (msg.sender != owner){
        //     revert("Unath")
        // }
    }
}
