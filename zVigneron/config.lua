
Config = {
    

    --Config Marker

    MarkerType = 22, -- Pour voir les différents type de marker: https://docs.fivem.net/docs/game-references/markers/
    MarkerSizeLargeur = 0.3, -- Largeur du marker
    MarkerSizeEpaisseur = 0.3, -- Épaisseur du marker
    MarkerSizeHauteur = 0.3, -- Hauteur du marker
    MarkerDistance = 6.0, -- Distance de visibiliter du marker (1.0 = 1 mètre)
    MarkerColorR = 170, -- Voir pour les couleurs RGB : https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
    MarkerColorG = 0, -- Voir pour les couleurs RGB : https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
    MarkerColorB = 170, -- Voir pour les couleurs RGB : https://www.google.com/search?q=html+color+picker&rlz=1C1GCEA_enFR965FR965&oq=html+color+&aqs=chrome.2.69i59j0i131i433i512j0i512l5j69i60.3367j0j7&sourceid=chrome&ie=UTF-8
    MarkerOpacite = 255, -- Opacité du marker (min: 0, max: 255)
    MarkerSaute = true, -- Si le marker saute (true = oui, false = non)
    MarkerTourne = true, -- Si le marker tourne (true = oui, false = non)
    
    --Config Blips

    blipname = "Vigneron",
    blipscale = 0.8, 
    blipcolour = 27, 
    blipsprite = 85, 
    blipdisplay = 4, 
    position = {vector3(-1907.193, 2044.195, 140.737)},
    
    --Config Point

    Position = {
        Coffre = {vector3(-1869.954, 2056.283, 140.976)}, -- Menu coffre 
        GarageVehicule = {vector3(-1922.568, 2040.581, 140.734)}, -- Menu Garage Vehicule
        RangerVehicule = {vector3(-1919.140, 2052.329, 140.735)}, -- Menu ranger votre véhicule
        Boss = {vector3(-1875.745, 2061.267, 145.573)}, -- Menu Boss
    },

     --Config Farm

     Farm = {
        Recolte = {vector3(-1802.378, 2214.389, 91.753)}, -- Menu Récolte
        Traitement = {vector3(-1904.579, 2528.6755371094, 0.891)}, -- Menu Traitement
        Vente = {vector3(-354.950, 6066.669, 31.498)}, -- Menu Vente
    },
    
    --Config Texte

    TextCoffre = "Appuyez sur ~p~[E] ~s~pour accèder au ~p~Coffre ~s~",
    TextGarage = "Appuyez sur ~p~[E] ~s~pour accèder au ~p~Garage",
    TextRangerGarage = "Appuyez sur ~p~[E] ~s~pour ranger votre ~p~Véhicule",
    TextBoss = "Appuyez sur ~p~[E] ~s~pour accèder à ~p~l'Ordinateur",
    
    --Config GPS

    Recolte = vector3(-1802.378, 2214.389, 91.753), -- GPS Récolte
    Traitement = vector3(-1904.579, 2528.6755371094, 0.891), -- GPS Traitement
    Vente = vector3(-354.950, 6066.669, 31.498), -- GPS Vente

    --Config Prix

    Jus = 40,
    JusEntreprise = 40, 
    GrandCru = 70,
    GrandCruEntreprise = 70,

    --Config Vehicule

    VehiculeVigne = { 
        {buttoname = "Guardian", rightlabel = "→→", spawnname = "guardian", spawnzone = vector3(-1906.021, 2028.441, 140.739), headingspawn = 260.354}, -- Garage Voiture
        {buttoname = "Burrito", rightlabel = "→→", spawnname = "burrito", spawnzone = vector3(-1906.021, 2028.441, 140.739), headingspawn = 260.354}, -- Garage Voiture
        {buttoname = "Véhicule de déplacement", rightlabel = "→→", spawnname = "sultan", spawnzone = vector3(-1910.068, 2035.559, 140.738), headingspawn = 260.354}, -- Garage Voiture
    }
    

    }