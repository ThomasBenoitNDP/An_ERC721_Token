# An_ERC721_Token
An operational and secure ERC-721 Token (Ethereum Blockchain)

L'objectif de ce programme est de trouver d’autres mécanismes d’interaction entre les ERC721 que le breeding (la reproduction) présente dans cryptokitties et dans cryptozombies. Pensez à séparer le contrat de l’actif ERC721 le plus simple possible pour des raisons de sécurité et éventuellement ajouter des fonctionnalités annexes ( achat, vente ) dans un contrat séparé.

# Description du jeu : Country Conquest 

Dans cet univers, les joueurs sont à la tête de pays. Leurs objectifs est de gérer le plus de pays possibles. Chaque pays est unique et dispose des caractéristiques suivantes : 
-	Un nom 
- Une quantité d’or 
-	Une armé


La valeur d’un pays est aussi grande que ses réserves d’or et la puissance de son armée. Les joueurs peuvent utiliser leurs pays pour attaquer ceux de leurs rivaux.  En triomphant de leurs adversaires, les pays volent de l’or à leurs cibles. 
Le jeu se base sur la blockhain ethereum. Les pays sont des tokens ERC-721. Nous utilisons un mécanisme de « looting » : nos token ERC-721 peuvent s’attaquer entre eux pour gagner des caractéristiques, et ainsi, gagner en valeur sur les places marchandes.  
# Mécanismes du jeux 
Les pays sont rattachés à « un monde » (le nom du smartcontract, l’équivalent du nom d’un serveur dans les jeux en ligne standards). Le joueur crée son pays quand il s’inscrit dans le monde.  Le pays a un identifiant unique et il porte le nom définit par le joueur. 

Pour qu’un pays puisse attaquer un pays rival, il devra respecter la condition suivante: 
-	Son armée doit être un tier plus élevé que celle du pays ciblé. 
Après l’attaque, le pays gagnant récolte 10% de l’or de son pays rival. Dans tous les cas, les deux pays perdront un pourcentage de leurs armées (pour l’instant fixé à 10%). 

Pour former ses soldat, un pays doit investir son or. La mécanique actuelle est un soldat formé pour une pièce d’or investie.  



(Mécanisme conçu mais non finalisé)

En plus de voler les ressources d’un pays à un de ses rivaux, un joueur peut carrément voler des pays (la possession du jeton ERC-721) !
C’est un mécansime de « robberying » (légale au sein des règles du jeu) d’ERC-721.
Le robberying s’enclenche uniquement pendant les attaques. Si le pays du joueur attaquant dispose de deux fois plus d’or que le pays rival, l’attaquant récupère le pays ennemi. 

