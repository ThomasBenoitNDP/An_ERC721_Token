pragma solidity >=0.5.0 <0.6.0;
      import "remix_tests.sol"; // this import is automatically injected by Remix.

      // Importing the contract to test
      import "Defi4.sol";
      /* Operations for safe Math */
      import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/math/SafeMath.sol";

      
      // file name has to end with '_test.sol'
      contract testDefi4{
         
        // Deploying the contract
        Defi4 d4 = new Defi4("world0");
        
        /* initialisation des tests */
         // notre utilisateur A
         string userA = "user1";
         string countryA = "country1";
         uint256 indexUserA = 0 ; // l'index d'un utilisateur est sa position dans la table des utilisateurs
         uint256 indexCountryA = 0 ; // l'index d'un pays est sa position dans la table des pays
        
         // Son rival, l'utilisateur B 
         string userB = "user2";
         string countryB = "country2";
         uint256 indexUserB = 1 ; // l'index d'un utilisateur est sa position dans la table des utilisateurs
         uint256 indexCountryB = 1 ; // l'index d'un pays est sa position dans la table des pays


        /* Avant chaque test unitaire, nous créons une instance de notre smartcontract */
        function beforeAll() public {
                     
        }
        
        /* Test sur le nom du "world" à la cr"ation du contrat */
        function T1_testWorldName() public {
            Assert.equal(d4.worldName(), "world0", "The world name could not change");
        }
        
        /* Tests sur l'existance du pays */
        function T2_countryExisted() public {
          d4.joiningWorld(userA,countryA);
          Assert.equal(d4.exists(indexCountryA), true, "T 1.1 : le pays 1 n'existe pas");
        }
        
        /* Tests sur les noms attribués */
        function T3_Names() public {
          d4.joiningWorld(userA,countryA);
          /* Test 2.1 : Le nom de l'utilisateur est correcte */
          Assert.equal(d4.getUserName(indexUserA), userA, "T 2.1 : l'utilisateur A n'a pas le bon nom");
          
          /* Test 2.2 : Le nom du pays est correcte */ 
          Assert.equal(d4.getCountryName(indexCountryA), countryA, "T 2.2 : le pays A n'a pas le bon nom");
        }
                    
        /* Test 3 : Le pays appartient bien à son utilisateur */
        function T3_countryOwner() public {
            d4.joiningWorld(userA,countryA);
            Assert.equal(d4.getCountryOwner(indexCountryA), userA, "T 3 : le pays A n'appartient pas à son utilisateur!");
        }
        
        /* Test 4 : Après une attaque, l'utilisateur vole de l'or à sa cible et il perd des soldats 
            /!\ n'p=oubliez pas de créer l'utilisateur B parallèlement au test*/
        function T4_userAttacking() public {
            uint256 goldA_init = d4.getCountryGold(indexCountryA);
            uint256 armyA_init = d4.getCountryArmy(indexCountryA);
            uint256 goldB_init = d4.getCountryGold(indexCountryB);
            uint256 armyB_init = d4.getCountryArmy(indexCountryB);
            
            d4.attacking(indexCountryA,indexCountryB);
            
            uint256 goldA_current = d4.getCountryGold(indexCountryA);
            uint256 armyA_current = d4.getCountryArmy(indexCountryA);
            uint256 goldB_current = d4.getCountryGold(indexCountryB);
            uint256 armyB_current = d4.getCountryArmy(indexCountryB);
            
            uint256 loot = SafeMath.div(SafeMath.mul(goldB_init,10),100);
            uint256 goldB_expected = SafeMath.sub(goldB_init,loot);
            uint256 goldA_expected = SafeMath.add(goldA_init,loot);
            
            uint256 armyA_expected =  SafeMath.sub( armyA_init, SafeMath.div(SafeMath.mul(armyA_init,10),100));
            uint256 armyB_expected =  SafeMath.sub( armyB_init, SafeMath.div(SafeMath.mul(armyB_init,10),100));
            
            Assert.notEqual(userA, userB, "Le destinataire ne peut pas être l'émetteur!" ); 
            Assert.equal(armyA_expected, armyA_current, "T 4.1 : l'érosion des troupes n'est pas correcte pour l'utilisateur A!");
            Assert.equal(armyB_expected, armyB_current, "T 4.2 : l'érosion des troupes n'est pas correcte pour l'utilisateur B!");
            Assert.equal(goldA_expected, goldA_current, "T 4.3 : les gains en or de l'utilisateur A ne sont pas bon!");
            Assert.equal(goldB_expected, goldB_current, "T 4.4 : les pertes en or de l'utilisateur B ne sont pas bon!");

        }
        /* Test 5 : Après un investissement, chaque pièce d'or investie forme un nouveau soldat  */
        function T5_userInvesting() public {
            uint256 goldA_init = d4.getCountryGold(indexCountryA);
            uint256 armyA_init = d4.getCountryArmy(indexCountryA);
            
            uint256 invest = 100;
            d4.training(indexCountryA,invest);
            
            uint256 goldA_current = d4.getCountryGold(indexCountryA);
            uint256 armyA_current = d4.getCountryArmy(indexCountryA);

            Assert.equal(goldA_current, goldA_init - invest, "T 5.1 : l'or n'est pas bien investi !");
            Assert.equal(armyA_current, armyA_init + invest, "T 5.2 : l'armé n'est pas bien entrainée !");
        }
        
        /* Test 6 : Transfert de fonds entre un émetteur (utilisater A) et un destinataire (utilisateur B) 
             /!\ n'p=oubliez pas de créer l'utilisateur B parallèlement au test */
        function T5_transfering() public {
            string memory initOwner = d4.getCountryOwner(indexCountryA);
            address addressUserA = d4.getUserAdress(indexUserA);
            address addressUserB = d4.getUserAdress(indexUserB);
            
            d4.transferFrom(addressUserA, addressUserB, indexCountryA);
            
            string memory currentOwner = d4.getCountryOwner(indexCountryA);
            
            Assert.notEqual(addressUserA, addressUserB, "Le destinataire ne peut pas être l'émetteur!" ); 
            Assert.equal(currentOwner, userB, "Le jeton n'appartient pas à la bonne personne!"); 
            
        }

      }
