# ERC-721 GAME: Country conquest

# I. Constructor 

## constructor - read
|name |type |description
|-----|-----|-----------
|_name|string|The name of your new word
function Object() {
    [native code]
}
**Constructor: During the deployment, a word is generated (the playground). Each word is referrenced by its name**


# II. The features of smartcontract

## countryIndexApproved - view
|name |type |description
|-----|-----|-----------
||uint256|The index of your country
**Mapping: The  addresses of approved contract during transfer**

## countryNames - view
|name |type |description
|-----|-----|-----------
||string|The name of your country
**Mapping: Knowing the name list of existing countries **

## countryToOwner - view
|name |type |description
|-----|-----|-----------
||uint256|The number of countries assoicated to a user
**Mapping: Mapping the id of countires to their owners**

## userNames - view
|name |type |description
|-----|-----|-----------
||string|A user name
**Mapping: Knowing the name list of existing users**

## wordName - view
_No parameters_
**String:The name of the current word**

# III. Functions

## joiningWorld - read
|name |type |description
|-----|-----|-----------
|_userName|string|Your desired name
|_countryName|string|The name of your country
**Function: When an user joins the word, he creates a country. Note that it is the only way to generate a country**

## attacking - read
|name |type |description
|-----|-----|-----------
|_idCountryAttacker|uint256|The id of your country
|_idCountryOpponant|uint256|The id of your target
**Function: Attacking an opposant country. Both users will lost 10% of their army. However, if the attaquant won, he would rob gold.
        Note1 that: There are some conditions:
            - country'army should be 1.3 time upper than the opposant one
        Note2 (Just initated)
            - If opponant's has 0.5 time gold than user, the user win its target.
**

## training - read
|name |type |description
|-----|-----|-----------
|_tokenId|uint256|The id of your country
|_investment|uint256|The amount of gold you want to invest in your army.
**Function: Training the army of your country. Each invested gold generates one soldier**

# IV. specific ERC-721 functions 

## Transfer - read
|name |type |description
|-----|-----|-----------
|_from|address|The transmitter
|_to|address|The recipient
|_tokenId|uint256|The id of the country that you want to transmit.
**Event: it is emitted when a transfer takes place**

## balanceOf - view
|name |type |description
|-----|-----|-----------
|_owner|address|The address of user who you want to check the balance
**Function: Geting the balance of a specific user.**

## ownerOf - view
|name |type |description
|-----|-----|-----------
|_tokenId|uint256|Country's id
**Function: Geting the owner of a specific token.**

## exists - view
|name |type |description
|-----|-----|-----------
|_tokenId|uint256|Country's id
**Function: Useful to know if a token exists.**

## transferFrom - read
|name |type |description
|-----|-----|-----------
|_from|address|The transmitter
|_to|address|The recipient
|_tokenId|uint256|The id of the country that you want to transmit.
**Function: Transfering token from a transmitter user to a recipient user**

