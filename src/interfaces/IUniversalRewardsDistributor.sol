// SPDX-License-Identifier: MIT
pragma solidity >=0.7.4;

/// @notice The pending root struct for a merkle tree distribution during the timelock.
struct PendingRoot {
    /// @dev The block timestamp of the pending root submission.
    uint256 submittedAt;
    /// @dev The submitted pending root.
    bytes32 root;
    /// @dev The optional ipfs hash containing metadata about the root (e.g. the merkle tree itself).
    bytes32 ipfsHash;
}

/// @title IUniversalRewardsDistributor
/// @author Morpho Labs
/// @custom:contact security@morpho.org
/// @notice UniversalRewardsDistributor's interface.
interface IUniversalRewardsDistributor {
    /* EXTERNAL */

    function root() external view returns (bytes32);
    function owner() external view returns (address);
    function timelock() external view returns (uint256);
    function ipfsHash() external view returns (bytes32);
    function isUpdater(address) external view returns (bool);
    function pendingRoot() external view returns (uint256 submittedAt, bytes32 root, bytes32 ipfsHash);
    function claimed(address, address) external view returns (uint256);

    function acceptRootUpdate() external;
    function forceUpdateRoot(bytes32 newRoot, bytes32 newIpfsHash) external;
    function updateTimelock(uint256 newTimelock) external;
    function updateRootUpdater(address updater, bool active) external;
    function revokePendingRoot() external;
    function setDistributionOwner(address newOwner) external;

    function proposeRoot(bytes32 newRoot, bytes32 ipfsHash) external;

    function claim(address account, address reward, uint256 claimable, bytes32[] memory proof) external;
}

interface IPendingRoot {
    function pendingRoot() external view returns (PendingRoot memory);
}
