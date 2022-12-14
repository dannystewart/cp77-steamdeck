local GameLocale = require('GameLocale')

local Localization = {
    version = '1.0'
}

-- en-us pl-pl es-es fr-fr it-it de-de es-mx kr-kr zh-cn ru-ru pt-br jp-jp zh-tw ar-ar cz-cz hu-hu tr-tr th-th
local languagesShort = {}
local languageCurrent

languagesShort['system'] = 1
languagesShort['en-us'] = 2
languagesShort['pl-pl'] = 3
languagesShort['fr-fr'] = 4
languagesShort['ru-ru'] = 5
languagesShort['zh-tw'] = 6
languagesShort['pt-br'] = 7
languagesShort['zh-cn'] = 8
languagesShort['de-de'] = 9

Localization.Categories = {}
Localization.Names = {}
Localization.Descriptions = {}

-- English
Localization.Categories[languagesShort['en-us']] = {}
Localization.Categories[languagesShort['en-us']]['Visibility'] = "Clothes Visibility"
Localization.Categories[languagesShort['en-us']]['Preferences'] = "Preferences"

Localization.Names[languagesShort['en-us']] = {}
Localization.Names[languagesShort['en-us']]['Head'] = "Head"
Localization.Names[languagesShort['en-us']]['Face'] = "Face"
Localization.Names[languagesShort['en-us']]['OuterChest'] = "Outer Torso"
Localization.Names[languagesShort['en-us']]['InnerChest'] = "Inner Torso"
Localization.Names[languagesShort['en-us']]['Legs'] = "Legs"
Localization.Names[languagesShort['en-us']]['Feet'] = "Feet"
Localization.Names[languagesShort['en-us']]['Outfit'] = "Outfit"
Localization.Names[languagesShort['en-us']]['Inventory'] = "UI Toggle"
Localization.Names[languagesShort['en-us']]['Breast'] = "Breast fix"

Localization.Descriptions[languagesShort['en-us']] = {}
Localization.Descriptions[languagesShort['en-us']]['Head'] = "Controls visibility of the headgear"
Localization.Descriptions[languagesShort['en-us']]['Face'] = "Controls visibility of the facegear"
Localization.Descriptions[languagesShort['en-us']]['OuterChest'] = "Controls visibility of the jackets"
Localization.Descriptions[languagesShort['en-us']]['InnerChest'] = "Controls visibility of the shirts"
Localization.Descriptions[languagesShort['en-us']]['Legs'] = "Controls visibility of the trouses"
Localization.Descriptions[languagesShort['en-us']]['Feet'] = "Controls visibility of the footwear"
Localization.Descriptions[languagesShort['en-us']]['Outfit'] = "Controls visibility of the outfit"
Localization.Descriptions[languagesShort['en-us']]['Inventory'] = "Experimental: Enables visibility toggle in the inventory UI"
Localization.Descriptions[languagesShort['en-us']]['Breast'] = "Experimental: Fixes breast size"

-- Polish
Localization.Categories[languagesShort['pl-pl']] = {}
Localization.Categories[languagesShort['pl-pl']]['Visibility'] = "Widoczno???? ubra??"
Localization.Categories[languagesShort['pl-pl']]['Preferences'] = "Preferencje"

Localization.Names[languagesShort['pl-pl']] = {}
Localization.Names[languagesShort['pl-pl']]['Head'] = "G??owa"
Localization.Names[languagesShort['pl-pl']]['Face'] = "Twarz"
Localization.Names[languagesShort['pl-pl']]['OuterChest'] = "Tu????w (odzie?? wierzchnia)"
Localization.Names[languagesShort['pl-pl']]['InnerChest'] = "Tu????w (odzie?? spodnia)"
Localization.Names[languagesShort['pl-pl']]['Legs'] = "Nogi"
Localization.Names[languagesShort['pl-pl']]['Feet'] = "Obuwie"
Localization.Names[languagesShort['pl-pl']]['Outfit'] = "Str??j"
Localization.Names[languagesShort['pl-pl']]['Inventory'] = "Prze????cznik w UI"
Localization.Names[languagesShort['pl-pl']]['Breast'] = "Poprawka piersi"

Localization.Descriptions[languagesShort['pl-pl']] = {}
Localization.Descriptions[languagesShort['pl-pl']]['Head'] = "Ustawia widoczno???? nakrycia g??owy"
Localization.Descriptions[languagesShort['pl-pl']]['Face'] = "Ustawia widoczno???? dodatk??w twarzy"
Localization.Descriptions[languagesShort['pl-pl']]['OuterChest'] = "Ustawia widoczno???? odzie??y wierzchniej"
Localization.Descriptions[languagesShort['pl-pl']]['InnerChest'] = "Ustawia widoczno???? odzie??y spodniej"
Localization.Descriptions[languagesShort['pl-pl']]['Legs'] = "Ustawia widoczno???? spodni"
Localization.Descriptions[languagesShort['pl-pl']]['Feet'] = "Ustawia widoczno???? obuwia"
Localization.Descriptions[languagesShort['pl-pl']]['Outfit'] = "Ustawia widoczno???? stroju"
Localization.Descriptions[languagesShort['pl-pl']]['Inventory'] = "Eksperymentalne: Dodaje prze????cznik widoczno??ci w UI ekwipunku"
Localization.Descriptions[languagesShort['pl-pl']]['Breast'] = "Eksperymentalne: Poprawia rozmiar piersi"

-- French
Localization.Categories[languagesShort['fr-fr']] = {}
Localization.Categories[languagesShort['fr-fr']]['Visibility'] = "Visibilit??"
Localization.Categories[languagesShort['fr-fr']]['Preferences'] = "Pr??f??rences"
 
Localization.Names[languagesShort['fr-fr']] = {}
Localization.Names[languagesShort['fr-fr']]['Head'] = "T??te"
Localization.Names[languagesShort['fr-fr']]['Face'] = "Visage"
Localization.Names[languagesShort['fr-fr']]['OuterChest'] = "Haut"
Localization.Names[languagesShort['fr-fr']]['InnerChest'] = "Haut l??ger"
Localization.Names[languagesShort['fr-fr']]['Legs'] = "Bas"
Localization.Names[languagesShort['fr-fr']]['Feet'] = "Pieds"
Localization.Names[languagesShort['fr-fr']]['Outfit'] = "Ensembles vestimentaires"
Localization.Names[languagesShort['fr-fr']]['Inventory'] = "Basculer dans l'interface"
Localization.Names[languagesShort['fr-fr']]['Breast'] = "Correction du sein"

 
Localization.Descriptions[languagesShort['fr-fr']] = {}
Localization.Descriptions[languagesShort['fr-fr']]['Head'] = "Contr??le la visibilit?? du couvre-chef"
Localization.Descriptions[languagesShort['fr-fr']]['Face'] = "Contr??le la visibilit?? du masque/lunette"
Localization.Descriptions[languagesShort['fr-fr']]['OuterChest'] = "Contr??le la visibilit?? du manteau"
Localization.Descriptions[languagesShort['fr-fr']]['InnerChest'] = "Contr??le la visibilit?? du tee-shirt"
Localization.Descriptions[languagesShort['fr-fr']]['Legs'] = "Contr??le la visibilit?? du pantalon/short"
Localization.Descriptions[languagesShort['fr-fr']]['Feet'] = "Contr??le la visibilit?? des chaussures/bottes"
Localization.Descriptions[languagesShort['fr-fr']]['Outfit'] = "Contr??le la visibilit?? du costumes"
Localization.Descriptions[languagesShort['fr-fr']]['Inventory'] = "Exp??rimental??: Active le basculement de la visibilit?? dans l'interface d'inventaire"
Localization.Descriptions[languagesShort['fr-fr']]['Breast'] = "Exp??rimental??: fixe la taille des seins"

-- Russian
Localization.Categories[languagesShort['ru-ru']] = {}
Localization.Categories[languagesShort['ru-ru']]['Visibility'] = "??????????????????"
Localization.Categories[languagesShort['ru-ru']]['Preferences'] = "??????????????????"

Localization.Names[languagesShort['ru-ru']] = {}
Localization.Names[languagesShort['ru-ru']]['Head'] = "????????????"
Localization.Names[languagesShort['ru-ru']]['Face'] = "????????"
Localization.Names[languagesShort['ru-ru']]['OuterChest'] = "???????? (????????)"
Localization.Names[languagesShort['ru-ru']]['InnerChest'] = "???????? (??????)"
Localization.Names[languagesShort['ru-ru']]['Legs'] = "????????"
Localization.Names[languagesShort['ru-ru']]['Feet'] = "????????????"
Localization.Names[languagesShort['ru-ru']]['Outfit'] = "???????????? ????????????"
Localization.Names[languagesShort['ru-ru']]['Inventory'] = "???????????? ?? ????????????????????"

Localization.Descriptions[languagesShort['ru-ru']] = {}
Localization.Descriptions[languagesShort['ru-ru']]['Head'] = "?????????????????????????? ?????????????????? ???????????????? ?? ?????????? ????????????"
Localization.Descriptions[languagesShort['ru-ru']]['Face'] = "?????????????????????????? ?????????????????? ???????????????? ?? ?????????? ????????"
Localization.Descriptions[languagesShort['ru-ru']]['OuterChest'] = "?????????????????????????? ?????????????????? ???????????????? ?? ?????????? ?????????? (????????)"
Localization.Descriptions[languagesShort['ru-ru']]['InnerChest'] = "?????????????????????????? ?????????????????? ???????????????? ?? ?????????? ?????????? (??????)"
Localization.Descriptions[languagesShort['ru-ru']]['Legs'] = "?????????????????????????? ?????????????????? ???????????????? ?? ?????????? ??????"
Localization.Descriptions[languagesShort['ru-ru']]['Feet'] = "?????????????????????????? ?????????????????? ???????????????? ?? ?????????? ??????????????"
Localization.Descriptions[languagesShort['ru-ru']]['Outfit'] = "?????????????????????????? ?????????????????? ???????????????? ?? ?????????? ?????????????? ????????????"
Localization.Descriptions[languagesShort['ru-ru']]['Inventory'] = "????????????????????????????????: ???????????????? ?????????????????????????? ?????????????????? ?? ???????????????????? ??????????????????"

-- Traditional Chinese
Localization.Categories[languagesShort['zh-tw']] = {}
Localization.Categories[languagesShort['zh-tw']]['Visibility'] = "????????????"
Localization.Categories[languagesShort['zh-tw']]['Preferences'] = "??????"
 
Localization.Names[languagesShort['zh-tw']] = {}
Localization.Names[languagesShort['zh-tw']]['Head'] = "??????"
Localization.Names[languagesShort['zh-tw']]['Face'] = "??????"
Localization.Names[languagesShort['zh-tw']]['OuterChest'] = "????????????"
Localization.Names[languagesShort['zh-tw']]['InnerChest'] = "????????????"
Localization.Names[languagesShort['zh-tw']]['Legs'] = "??????"
Localization.Names[languagesShort['zh-tw']]['Feet'] = "??????"
Localization.Names[languagesShort['zh-tw']]['Outfit'] = "?????????"
Localization.Names[languagesShort['zh-tw']]['Inventory'] = "???????????????"
Localization.Names[languagesShort['zh-tw']]['Breast'] = "????????????"
 
Localization.Descriptions[languagesShort['zh-tw']] = {}
Localization.Descriptions[languagesShort['zh-tw']]['Head'] = "????????????????????????????????????"
Localization.Descriptions[languagesShort['zh-tw']]['Face'] = "????????????????????????????????????"
Localization.Descriptions[languagesShort['zh-tw']]['OuterChest'] = "??????????????????????????????????????????"
Localization.Descriptions[languagesShort['zh-tw']]['InnerChest'] = "??????????????????????????????????????????"
Localization.Descriptions[languagesShort['zh-tw']]['Legs'] = "????????????????????????????????????"
Localization.Descriptions[languagesShort['zh-tw']]['Feet'] = "????????????????????????????????????"
Localization.Descriptions[languagesShort['zh-tw']]['Outfit'] = "???????????????????????????????????????"
Localization.Descriptions[languagesShort['zh-tw']]['Inventory'] = "???????????????????????????????????????????????????"
Localization.Descriptions[languagesShort['zh-tw']]['Breast'] = "??????????????????????????????"

-- Brazilian Portuguese
Localization.Categories[languagesShort['pt-br']] = {}
Localization.Categories[languagesShort['pt-br']]['Visibility'] = "Deseja exibir que equipamentos?"
Localization.Categories[languagesShort['pt-br']]['Preferences'] = "Prefer??ncias"

Localization.Names[languagesShort['pt-br']] = {}
Localization.Names[languagesShort['pt-br']]['Head'] = "Cabe??a"
Localization.Names[languagesShort['pt-br']]['Face'] = "Rosto"
Localization.Names[languagesShort['pt-br']]['OuterChest'] = "Peitoral Externo"
Localization.Names[languagesShort['pt-br']]['InnerChest'] = "Peitoral Interno"
Localization.Names[languagesShort['pt-br']]['Legs'] = "Pernas"
Localization.Names[languagesShort['pt-br']]['Feet'] = "P??s"
Localization.Names[languagesShort['pt-br']]['Outfit'] = "Roupas Especiais"
Localization.Names[languagesShort['pt-br']]['Inventory'] = "Mudar pelo Invent??rio?"
Localization.Names[languagesShort['pt-br']]['Breast'] = "Corre????o de mama"

Localization.Descriptions[languagesShort['pt-br']] = {}
Localization.Descriptions[languagesShort['pt-br']]['Head'] = "N??o ser?? mais exibido nenhum capacete, chap??u, bon?? ou outras pe??as"
Localization.Descriptions[languagesShort['pt-br']]['Face'] = "N??o ser?? mais exibido nenhuma m??scara, ??culos e outros acess??rios"
Localization.Descriptions[languagesShort['pt-br']]['OuterChest'] = "N??o ser?? mais exibido nenhuma jaqueta, casaco, colete ou outra roupa externa"
Localization.Descriptions[languagesShort['pt-br']]['InnerChest'] = "N??o ser?? mais exibido nenhuma camisa, regata, trajes ou outra roupa interna"
Localization.Descriptions[languagesShort['pt-br']]['Legs'] = "N??o ser?? mais exibido nenhuma cal??a, bermuda, saia ou outras pe??as de roupa"
Localization.Descriptions[languagesShort['pt-br']]['Feet'] = "N??o ser?? mais exibido nenhum t??nis, sand??lias, botas ou outros cal??ados"
Localization.Descriptions[languagesShort['pt-br']]['Outfit'] = "Deseja ocultar roupas especiais?"
Localization.Descriptions[languagesShort['pt-br']]['Inventory'] = "Experimental: Torna poss??vel alterar a visibilidade dos equipamentos diretamente pela aba de Invent??rio"
Localization.Descriptions[languagesShort['pt-br']]['Breast'] = "Experimental: corrige o tamanho dos seios"

-- Simplified Chinese
Localization.Categories[languagesShort['zh-cn']] = {}
Localization.Categories[languagesShort['zh-cn']]['Visibility'] = "???????????????"
Localization.Categories[languagesShort['zh-cn']]['Preferences'] = "??????"

Localization.Names[languagesShort['zh-cn']] = {}
Localization.Names[languagesShort['zh-cn']]['Head'] = "??????"
Localization.Names[languagesShort['zh-cn']]['Face'] = "??????"
Localization.Names[languagesShort['zh-cn']]['OuterChest'] = "??????"
Localization.Names[languagesShort['zh-cn']]['InnerChest'] = "??????"
Localization.Names[languagesShort['zh-cn']]['Legs'] = "??????"
Localization.Names[languagesShort['zh-cn']]['Feet'] = "??????"
Localization.Names[languagesShort['zh-cn']]['Outfit'] = "????????????"
Localization.Names[languagesShort['zh-cn']]['Inventory'] = "UI??????"
Localization.Names[languagesShort['zh-cn']]['Breast'] = "????????????"

Localization.Descriptions[languagesShort['zh-cn']] = {}
Localization.Descriptions[languagesShort['zh-cn']]['Head'] = "??????????????????????????????"
Localization.Descriptions[languagesShort['zh-cn']]['Face'] = "??????????????????????????????"
Localization.Descriptions[languagesShort['zh-cn']]['OuterChest'] = "??????????????????????????????"
Localization.Descriptions[languagesShort['zh-cn']]['InnerChest'] = "??????????????????????????????"
Localization.Descriptions[languagesShort['zh-cn']]['Legs'] = "??????????????????????????????"
Localization.Descriptions[languagesShort['zh-cn']]['Feet'] = "??????????????????????????????"
Localization.Descriptions[languagesShort['zh-cn']]['Outfit'] = "????????????????????????????????????"
Localization.Descriptions[languagesShort['zh-cn']]['Inventory'] = "???????????????????????????????????????????????????"
Localization.Descriptions[languagesShort['zh-cn']]['Breast'] = "??????????????????????????????"

-- German
Localization.Categories[languagesShort['de-de']] = {}
Localization.Categories[languagesShort['de-de']]['Visibility'] = "Sichtbarkeit der Kleidung"
Localization.Categories[languagesShort['de-de']]['Preferences'] = "Pr??ferenzen"

Localization.Names[languagesShort['de-de']] = {}
Localization.Names[languagesShort['de-de']]['Head'] = "Kopf"
Localization.Names[languagesShort['de-de']]['Face'] = "Gesicht"
Localization.Names[languagesShort['de-de']]['OuterChest'] = "??u??erer Torso"
Localization.Names[languagesShort['de-de']]['InnerChest'] = "Innerer Torso"
Localization.Names[languagesShort['de-de']]['Legs'] = "Beine"
Localization.Names[languagesShort['de-de']]['Feet'] = "F????e"
Localization.Names[languagesShort['de-de']]['Outfit'] = "Outfit"
Localization.Names[languagesShort['de-de']]['Inventory'] = "UI Umschalten"
Localization.Names[languagesShort['de-de']]['Breast'] = "Brust Fehlerbehebung"

Localization.Descriptions[languagesShort['de-de']] = {}
Localization.Descriptions[languagesShort['de-de']]['Head'] = "Kontrolliert die Sichtbarkeit der Kopfbedeckung"
Localization.Descriptions[languagesShort['de-de']]['Face'] = "Kontrolliert die Sichtbarkeit der Gesichtsbedeckung"
Localization.Descriptions[languagesShort['de-de']]['OuterChest'] = "Kontrolliert die Sichtbarkeit der Jacken"
Localization.Descriptions[languagesShort['de-de']]['InnerChest'] = "Kontrolliert die Sichtbarkeit der Hemden"
Localization.Descriptions[languagesShort['de-de']]['Legs'] = "Kontrolliert die Sichtbarkeit der Hosen"
Localization.Descriptions[languagesShort['de-de']]['Feet'] = "Kontrolliert die Sichtbarkeit der Schuhe"
Localization.Descriptions[languagesShort['de-de']]['Outfit'] = "Kontrolliert die Sichtbarkeit des Outfits"
Localization.Descriptions[languagesShort['de-de']]['Inventory'] = "Experimentell: Erm??glicht das Umschalten der Sichtbarkeit im Inventar-UI"
Localization.Descriptions[languagesShort['de-de']]['Breast'] = "Experimentell: Behebt Brustgr????e" 

function Localization.Initialize()
    GameLocale.Initialize()
end

function GetLanguageID(Language)
    if languagesShort[Language] then
        return languagesShort[Language]
    end

    return 2
end

function Localization.GetLanguage()
	local current = GameLocale.GetInterfaceLanguage()
	return GetLanguageID(current)
end

function Localization.GetCategory(Language, Name)
    if Localization.Categories[Language] and Localization.Categories[Language][Name] then
        return Localization.Categories[Language][Name]
    end

    if not Localization.Categories[2][Name] then
        return "_" .. Name .. "_"
    else
        return Localization.Categories[2][Name]
    end
end

function Localization.GetName(Language, Name)
    if Localization.Names[Language] and Localization.Names[Language][Name] then
        return Localization.Names[Language][Name]
    end

    if not Localization.Names[2][Name] then
        return "_" .. Name .. "_"
    else
        return Localization.Names[2][Name]
    end
end

function Localization.GetDescription(Language, Name)
    if Localization.Descriptions[Language] and Localization.Descriptions[Language][Name] then
        return Localization.Descriptions[Language][Name]
    end

    if not Localization.Descriptions[2][Name] then
        return "_" .. Name .. "_"
    else
        return Localization.Descriptions[2][Name]
    end
end

return Localization