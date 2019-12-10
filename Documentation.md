# ERC-721 GAME: Country conquest

# I. Constructeur 

## constructor - read
|name |type |description
|-----|-----|-----------
|_name|string|
function Object() {
    [native code]
}
**Constructor: During the deployment, a word is generated (the playground). Each word is referrenced by its name**


# II. Variables et caractéristiques du smartcontract

## countryIndexApproved - view
|name |type |description
|-----|-----|-----------
||uint256|
**Mapping: The  addresses of approved contract during transfer**

## countryNames - view
|name |type |description
|-----|-----|-----------
||string|
**Mapping: Knowing the name list of existing countries **

## countryToOwner - view
|name |type |description
|-----|-----|-----------
||uint256|
**Mapping: Mapping the id of countires to their owners**

## userNames - view
|name |type |description
|-----|-----|-----------
||string|
**Mapping: Knowing the name list of existing users**

## wordName - view
_No parameters_
**Mapping: The name of the current word**

# III. Fonctionnalités

## joiningWorld - read
|name |type |description
|-----|-----|-----------
|_userName|string|
|_countryName|string|
**Function: When an user joins the word, he creates a country. Note that it is the only way to generate a country**

## attacking - read
|name |type |description
|-----|-----|-----------
|_idCountryAttacker|uint256|
|_idCountryOpponant|uint256|
**Function: Attacking an opposant country. Both users will lost 10% of their army. However, if the attaquant won, he would rob gold.
        Note1 that: There are some conditions:
            - country'army should be 1.3 time upper than the opposant one
        Note2 (Just initated)
            - If opponant's has 0.5 time gold than user, the user win its target.
**

## training - read
|name |type |description
|-----|-----|-----------
|_tokenId|uint256|
|_investment|uint256|
**Function: Training the army of your country. Each invested gold generates one soldier**

# IV. Fonctions du standard ERC-721 

## Transfer - read
|name |type |description
|-----|-----|-----------
|_from|address|
|_to|address|
|_tokenId|uint256|
**Event: it is emitted when a transfer takes place**

## balanceOf - view
|name |type |description
|-----|-----|-----------
|_owner|address|
**Function: Geting the balance of a specific user.**

## ownerOf - view
|name |type |description
|-----|-----|-----------
|_tokenId|uint256|
**Function: Geting the owner of a specific token.**

## exists - view
|name |type |description
|-----|-----|-----------
|_tokenId|uint256|
**Function: Useful to know if a token exists.**

## transferFrom - read
|name |type |description
|-----|-----|-----------
|_from|address|
|_to|address|
|_tokenId|uint256|
**Function: Transfering token from a transmitter user to a recipient user**

