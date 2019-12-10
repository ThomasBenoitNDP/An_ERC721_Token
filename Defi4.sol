pragma solidity  ^0.5.0 ;

/* The  ERC721(simple)'s functions */
import "https://github.com/ThomasBenoitNDP/An_ERC721_Token/blob/master/ERC721Simple.sol";
/* Useful for Upgrading :  a smartcontract to store the previous versions of this contract */
import "https://github.com/ThomasBenoitNDP/An_ERC721_Token/blob/master/SomeRegister.sol";
/* Operations for safe Math */
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";


/*
    --- Main Contract : "Defi4" ---
    
*/
contract Defi4 is ERC721Simple {
    
    /* Constructor:
        - Each world is referrenced by its name
    */
    string public worldName;

    constructor (string memory _name) public {
        worldName = _name;

    }
    
    
    /* The country type */
    struct Country{
        // An unic id is associated to each country
        uint256 id;
        // Country's name
        string name;
        // Existes?
        bool exists;
        // Its finance
        uint256 gold;
        // Its army
        uint256 army; 
        // When the country was created  
        uint256 birthtime;
    }
    
    /* The user type*/
    struct User{
        // an unic id per user
        uint256 id;
        // user's name
        string name;
        // Noting that he has already existed
        bool exists;
        // its associated address
        address userAdress;
        // When the country was created  
        uint256 birthtime;

    }
    
    /* Common amount of information */
    Country[] countries;
    User[]  users;
    
    // Mapping the id of countires to their owners
    mapping (uint256 => User) public countryToOwner;
    
    // Useful mapping to count the number of country for each user 
    mapping (address => uint256) ownershipTokenCount;
    
    // The  addresses of approved contract during transfer
    mapping (uint256 => address) public countryIndexApproved;

    // Knowing existing names and used addresses
        // for country names
    mapping (string => bool) public countryNames;
        // for user anmes
    mapping (string => bool) public userNames;
        // for used address
    mapping (address => bool ) internal usedAddresses;
    
    
    
    /*
        --- Contract's functions ---
    */
    
    
    /* When an user joins the world, he creates a country. Note that it is the only way to generate a country */
    function joiningWorld (string memory _userName, string memory _countryName) public{
        require(countryNames[_userName] == false, "This user name has already used!");
        require(countryNames[_countryName] == false, "This country name has already used!");
        require(usedAddresses[msg.sender] == false, "Sorry, you have already played in this world!");
        
        uint256 idUser = users.length;
        uint256 idCountry = users.length;
        User memory user = User(idUser, _userName, true, msg.sender, now);
        Country memory country = Country(idCountry, _countryName, true, 1000, 100, now);
      
        users.push(user);
        countries.push(country);
        countryToOwner[idCountry] = user;
        ownershipTokenCount[user.userAdress] = 1;
        countryNames[_countryName] = true;
        userNames[_userName] = true;
        usedAddresses[msg.sender] = true;
        
    }
    
    /* Attacking an opposant country. Both users will lost 10% of their army. However, if the attaquant won, he would rob gold.
        Note that: There are some conditions:
            - country'army should be 1.3 time upper than the opposant one
        Note2:
            - If opponant's has 0.5 time gold than user, the user win oponnat's country */
    function attacking(uint256 _idCountryAttacker , uint256 _idCountryOpponant ) public {
        require(countryToOwner[_idCountryAttacker].userAdress == msg.sender, "Hey, it is not your country!");
        require(countries[_idCountryOpponant].exists == true, "You cloud not attack imaginary lands!");
        require(_idCountryAttacker != _idCountryOpponant, "You could not attack yourself!");
        
        uint256 armyA = countries[_idCountryAttacker].army;
        uint256 armyB = countries[_idCountryOpponant].army;
        uint256 goldA = countries[_idCountryAttacker].gold;
        uint256 goldB = countries[_idCountryOpponant].gold;
        
        // Note1 : To win a battle, country'army should be 1.3 time upper than the opposant one
        // armyRatio is a percentage, as  armyRation = armyA/armyB
        uint256 armyRatio = SafeMath.div(SafeMath.mul(armyA,10000),SafeMath.mul(armyB,100));
        require(armyRatio >= 100, "Your army is too weak to attack this opponant!");
        
        // both armyA and armyB lost 10% of their soldiers.
        armyA =  SafeMath.sub( armyA, SafeMath.div(SafeMath.mul(armyA,10),100));
        armyB =  SafeMath.sub( armyB, SafeMath.div(SafeMath.mul(armyB,10),100));
        
        // GoldA ogtanins 10% of goldB
        // GoldB losts 10% of its gold
        // The loot is 10% of goldB
        uint256 loot = SafeMath.div(SafeMath.mul(goldB,10),100);
        goldB = SafeMath.sub(goldB,loot);
        goldA = SafeMath.add(goldA,loot);
        
        countries[_idCountryAttacker].army = armyA;
        countries[_idCountryOpponant].army = armyB;
        countries[_idCountryAttacker].gold = goldA;
        countries[_idCountryOpponant].gold = goldB;
        
        // Note2 : If opponant's has 0.5 time gold than user, the user win the country of opponant
        // goldRatio is a percentage, as  goldRation = goldB/goldA
        /*
        uint256 goldRatio = SafeMath.div(SafeMath.mul(goldB,10000),SafeMath.mul(goldA,100));
        if (goldRatio < 50){
            address userA = countryToOwner[_idCountryAttacker].userAdress;
            address userB = countryToOwner[_idCountryOpponant].userAdress;
            transferFrom(userB, userA, _idCountryOpponant);
        
        }*/
    }
    
    /* Training the army of your country.
       Each invested gold generates one soldier */ 
    function training (uint256 _tokenId,  uint256 _investment) public{
        require(countryToOwner[_tokenId].userAdress == msg.sender, "Hey, it is not your country!");

        uint256 army = countries[_tokenId].army;
        uint256 gold = countries[_tokenId].gold;
        
        uint256 goldDiff = SafeMath.sub(gold, _investment);
        
        require (goldDiff > 0, "Sorry, you have no gold. Let's attack other countries!");
        army = SafeMath.add(army, _investment);
        gold = SafeMath.sub(gold, _investment);
        
        countries[_tokenId].army = army;
        countries[_tokenId].gold = gold;
        
    }
    
    

    /* 
        --- functions and events proper to ERC721 tokens ---
    */
    
    event Transfer(address indexed _from, address indexed _to, uint256 _tokenId);

    function balanceOf(address _owner) public view returns (uint256 balance){
        return ownershipTokenCount[_owner];
    }
    
    function ownerOf(uint256 _tokenId) public view returns (address _owner){
        return countryToOwner[_tokenId].userAdress;
    }
    
    function exists(uint256 _tokenId) public view returns (bool exists){
        return countries[_tokenId].exists;
    }

    function transferFrom(address _from, address _to, uint256 _tokenId) public{
        require(_from == msg.sender, "Usurper!");
        require(_from == countryToOwner[_tokenId].userAdress, "Swiper, no swiping!");
        require(_to != address(0), "Not a valid recipient");
        require(_from != _to, "You could not send ");
        // new Owner 
        countryToOwner[_tokenId].userAdress = _to;
        // Asset managing
        ownershipTokenCount[_from] -= 1;
        ownershipTokenCount[_to] += 1;
        // emit the transfer event 
        emit Transfer(_from, _to, _tokenId);
    }
    
    /* 
        Get functions for unit tests 
    */ 
    
    function getOwnershipTokenCount (address _address) public view returns(uint256){
        return ownershipTokenCount[_address];
    }

    function getUserName (uint256 _userId) public view returns(string memory){
        return users[_userId].name;
    }
    
    function getUserAdress (uint256 _userId) public view returns(address){
        return users[_userId].userAdress;
    }
    
    
    function getCountryName (uint256 _tokenId) public view returns(string memory){
        return countries[_tokenId].name;
    }
    
    function getCountryGold (uint256 _tokenId) public view returns(uint256){
        return countries[_tokenId].gold;
    }
    
    function getCountryArmy (uint256 _tokenId) public view returns(uint256){
        return countries[_tokenId].army;
    }
    

    function getCountryOwner (uint256 _tokenId) public view returns(string memory){
        return countryToOwner[_tokenId].name;
    }
}

