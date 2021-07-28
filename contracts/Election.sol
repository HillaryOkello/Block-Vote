pragma solidity ^0.8.0;

contract Election {

  event votedEvent (
    uint indexed _candidateId
  );

  constructor () {
    addCandidate("Candidate 1");
    addCandidate("Candidate 2");
  }
  
  // constructor ( string memory candidate_1_, string memory candidate_2_ ){
  //     addCandidate(candidate_1_);
  //     addCandidate(candidate_2_);
  // }
  
  struct Candidate {
    uint id;
    string name;
    uint voteCount;
  }
  
  mapping(uint => Candidate) public candidates;
  uint public candidatesCount;
  
  function addCandidate (string memory _name) private {
    candidatesCount++;
    candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
  }
  
  function setElections ( string memory candidate_1_, string memory candidate_2_ ) public {
    addCandidate(candidate_1_);
    addCandidate(candidate_2_);
  }

	mapping(address => bool) public voters;

  function vote (uint _candidateId) public {
    // require that they haven't voted before
    require(!voters[msg.sender]);

    // require a valid candidate
    require(_candidateId > 0 && _candidateId <= candidatesCount);

    // record that voter has voted
    voters[msg.sender] = true;

    // update candidate vote Count
    candidates[_candidateId].voteCount ++;

    // trigger voted event
    emit votedEvent(_candidateId);
    }
}



