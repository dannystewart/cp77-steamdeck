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
Localization.Categories[languagesShort['pl-pl']]['Visibility'] = "Widoczność ubrań"
Localization.Categories[languagesShort['pl-pl']]['Preferences'] = "Preferencje"

Localization.Names[languagesShort['pl-pl']] = {}
Localization.Names[languagesShort['pl-pl']]['Head'] = "Głowa"
Localization.Names[languagesShort['pl-pl']]['Face'] = "Twarz"
Localization.Names[languagesShort['pl-pl']]['OuterChest'] = "Tułów (odzież wierzchnia)"
Localization.Names[languagesShort['pl-pl']]['InnerChest'] = "Tułów (odzież spodnia)"
Localization.Names[languagesShort['pl-pl']]['Legs'] = "Nogi"
Localization.Names[languagesShort['pl-pl']]['Feet'] = "Obuwie"
Localization.Names[languagesShort['pl-pl']]['Outfit'] = "Strój"
Localization.Names[languagesShort['pl-pl']]['Inventory'] = "Przełącznik w UI"
Localization.Names[languagesShort['pl-pl']]['Breast'] = "Poprawka piersi"

Localization.Descriptions[languagesShort['pl-pl']] = {}
Localization.Descriptions[languagesShort['pl-pl']]['Head'] = "Ustawia widoczność nakrycia głowy"
Localization.Descriptions[languagesShort['pl-pl']]['Face'] = "Ustawia widoczność dodatków twarzy"
Localization.Descriptions[languagesShort['pl-pl']]['OuterChest'] = "Ustawia widoczność odzieży wierzchniej"
Localization.Descriptions[languagesShort['pl-pl']]['InnerChest'] = "Ustawia widoczność odzieży spodniej"
Localization.Descriptions[languagesShort['pl-pl']]['Legs'] = "Ustawia widoczność spodni"
Localization.Descriptions[languagesShort['pl-pl']]['Feet'] = "Ustawia widoczność obuwia"
Localization.Descriptions[languagesShort['pl-pl']]['Outfit'] = "Ustawia widoczność stroju"
Localization.Descriptions[languagesShort['pl-pl']]['Inventory'] = "Eksperymentalne: Dodaje przełącznik widoczności w UI ekwipunku"
Localization.Descriptions[languagesShort['pl-pl']]['Breast'] = "Eksperymentalne: Poprawia rozmiar piersi"

-- French
Localization.Categories[languagesShort['fr-fr']] = {}
Localization.Categories[languagesShort['fr-fr']]['Visibility'] = "Visibilité"
Localization.Categories[languagesShort['fr-fr']]['Preferences'] = "Préférences"
 
Localization.Names[languagesShort['fr-fr']] = {}
Localization.Names[languagesShort['fr-fr']]['Head'] = "Tête"
Localization.Names[languagesShort['fr-fr']]['Face'] = "Visage"
Localization.Names[languagesShort['fr-fr']]['OuterChest'] = "Haut"
Localization.Names[languagesShort['fr-fr']]['InnerChest'] = "Haut léger"
Localization.Names[languagesShort['fr-fr']]['Legs'] = "Bas"
Localization.Names[languagesShort['fr-fr']]['Feet'] = "Pieds"
Localization.Names[languagesShort['fr-fr']]['Outfit'] = "Ensembles vestimentaires"
Localization.Names[languagesShort['fr-fr']]['Inventory'] = "Basculer dans l'interface"
Localization.Names[languagesShort['fr-fr']]['Breast'] = "Correction du sein"

 
Localization.Descriptions[languagesShort['fr-fr']] = {}
Localization.Descriptions[languagesShort['fr-fr']]['Head'] = "Contrôle la visibilité du couvre-chef"
Localization.Descriptions[languagesShort['fr-fr']]['Face'] = "Contrôle la visibilité du masque/lunette"
Localization.Descriptions[languagesShort['fr-fr']]['OuterChest'] = "Contrôle la visibilité du manteau"
Localization.Descriptions[languagesShort['fr-fr']]['InnerChest'] = "Contrôle la visibilité du tee-shirt"
Localization.Descriptions[languagesShort['fr-fr']]['Legs'] = "Contrôle la visibilité du pantalon/short"
Localization.Descriptions[languagesShort['fr-fr']]['Feet'] = "Contrôle la visibilité des chaussures/bottes"
Localization.Descriptions[languagesShort['fr-fr']]['Outfit'] = "Contrôle la visibilité du costumes"
Localization.Descriptions[languagesShort['fr-fr']]['Inventory'] = "Expérimental : Active le basculement de la visibilité dans l'interface d'inventaire"
Localization.Descriptions[languagesShort['fr-fr']]['Breast'] = "Expérimental : fixe la taille des seins"

-- Russian
Localization.Categories[languagesShort['ru-ru']] = {}
Localization.Categories[languagesShort['ru-ru']]['Visibility'] = "Видимость"
Localization.Categories[languagesShort['ru-ru']]['Preferences'] = "Настройки"

Localization.Names[languagesShort['ru-ru']] = {}
Localization.Names[languagesShort['ru-ru']]['Head'] = "Голова"
Localization.Names[languagesShort['ru-ru']]['Face'] = "Лицо"
Localization.Names[languagesShort['ru-ru']]['OuterChest'] = "Торс (верх)"
Localization.Names[languagesShort['ru-ru']]['InnerChest'] = "Торс (низ)"
Localization.Names[languagesShort['ru-ru']]['Legs'] = "Ноги"
Localization.Names[languagesShort['ru-ru']]['Feet'] = "Ступни"
Localization.Names[languagesShort['ru-ru']]['Outfit'] = "Наборы одежды"
Localization.Names[languagesShort['ru-ru']]['Inventory'] = "Кнопка в интерфейсе"

Localization.Descriptions[languagesShort['ru-ru']] = {}
Localization.Descriptions[languagesShort['ru-ru']]['Head'] = "Устанавливает видимость предмета в слоте головы"
Localization.Descriptions[languagesShort['ru-ru']]['Face'] = "Устанавливает видимость предмета в слоте лица"
Localization.Descriptions[languagesShort['ru-ru']]['OuterChest'] = "Устанавливает видимость предмета в слоте торса (верх)"
Localization.Descriptions[languagesShort['ru-ru']]['InnerChest'] = "Устанавливает видимость предмета в слоте торса (низ)"
Localization.Descriptions[languagesShort['ru-ru']]['Legs'] = "Устанавливает видимость предмета в слоте ног"
Localization.Descriptions[languagesShort['ru-ru']]['Feet'] = "Устанавливает видимость предмета в слоте ступней"
Localization.Descriptions[languagesShort['ru-ru']]['Outfit'] = "Устанавливает видимость предмета в слоте наборов одежды"
Localization.Descriptions[languagesShort['ru-ru']]['Inventory'] = "Экспериментально: включает переключатель видимости в интерфейсе инвентаря"

-- Traditional Chinese
Localization.Categories[languagesShort['zh-tw']] = {}
Localization.Categories[languagesShort['zh-tw']]['Visibility'] = "顯示部位"
Localization.Categories[languagesShort['zh-tw']]['Preferences'] = "偏好"
 
Localization.Names[languagesShort['zh-tw']] = {}
Localization.Names[languagesShort['zh-tw']]['Head'] = "頭部"
Localization.Names[languagesShort['zh-tw']]['Face'] = "臉部"
Localization.Names[languagesShort['zh-tw']]['OuterChest'] = "上身外衣"
Localization.Names[languagesShort['zh-tw']]['InnerChest'] = "上身內襯"
Localization.Names[languagesShort['zh-tw']]['Legs'] = "腿部"
Localization.Names[languagesShort['zh-tw']]['Feet'] = "腳部"
Localization.Names[languagesShort['zh-tw']]['Outfit'] = "服裝組"
Localization.Names[languagesShort['zh-tw']]['Inventory'] = "在界面切換"
Localization.Names[languagesShort['zh-tw']]['Breast'] = "乳房修復"
 
Localization.Descriptions[languagesShort['zh-tw']] = {}
Localization.Descriptions[languagesShort['zh-tw']]['Head'] = "控制頭部裝備的顯示或隱藏"
Localization.Descriptions[languagesShort['zh-tw']]['Face'] = "控制臉部裝備的顯示或隱藏"
Localization.Descriptions[languagesShort['zh-tw']]['OuterChest'] = "控制上身外衣裝備的顯示或隱藏"
Localization.Descriptions[languagesShort['zh-tw']]['InnerChest'] = "控制上身內襯裝備的顯示或隱藏"
Localization.Descriptions[languagesShort['zh-tw']]['Legs'] = "控制腿部裝備的顯示或隱藏"
Localization.Descriptions[languagesShort['zh-tw']]['Feet'] = "控制腳部裝備的顯示或隱藏"
Localization.Descriptions[languagesShort['zh-tw']]['Outfit'] = "控制服裝組裝備的顯示或隱藏"
Localization.Descriptions[languagesShort['zh-tw']]['Inventory'] = "實驗性：在庫存界面中啟用可見性切換"
Localization.Descriptions[languagesShort['zh-tw']]['Breast'] = "實驗性：固定乳房大小"

-- Brazilian Portuguese
Localization.Categories[languagesShort['pt-br']] = {}
Localization.Categories[languagesShort['pt-br']]['Visibility'] = "Deseja exibir que equipamentos?"
Localization.Categories[languagesShort['pt-br']]['Preferences'] = "Preferências"

Localization.Names[languagesShort['pt-br']] = {}
Localization.Names[languagesShort['pt-br']]['Head'] = "Cabeça"
Localization.Names[languagesShort['pt-br']]['Face'] = "Rosto"
Localization.Names[languagesShort['pt-br']]['OuterChest'] = "Peitoral Externo"
Localization.Names[languagesShort['pt-br']]['InnerChest'] = "Peitoral Interno"
Localization.Names[languagesShort['pt-br']]['Legs'] = "Pernas"
Localization.Names[languagesShort['pt-br']]['Feet'] = "Pés"
Localization.Names[languagesShort['pt-br']]['Outfit'] = "Roupas Especiais"
Localization.Names[languagesShort['pt-br']]['Inventory'] = "Mudar pelo Inventário?"
Localization.Names[languagesShort['pt-br']]['Breast'] = "Correção de mama"

Localization.Descriptions[languagesShort['pt-br']] = {}
Localization.Descriptions[languagesShort['pt-br']]['Head'] = "Não será mais exibido nenhum capacete, chapéu, boné ou outras peças"
Localization.Descriptions[languagesShort['pt-br']]['Face'] = "Não será mais exibido nenhuma máscara, óculos e outros acessórios"
Localization.Descriptions[languagesShort['pt-br']]['OuterChest'] = "Não será mais exibido nenhuma jaqueta, casaco, colete ou outra roupa externa"
Localization.Descriptions[languagesShort['pt-br']]['InnerChest'] = "Não será mais exibido nenhuma camisa, regata, trajes ou outra roupa interna"
Localization.Descriptions[languagesShort['pt-br']]['Legs'] = "Não será mais exibido nenhuma calça, bermuda, saia ou outras peças de roupa"
Localization.Descriptions[languagesShort['pt-br']]['Feet'] = "Não será mais exibido nenhum tênis, sandálias, botas ou outros calçados"
Localization.Descriptions[languagesShort['pt-br']]['Outfit'] = "Deseja ocultar roupas especiais?"
Localization.Descriptions[languagesShort['pt-br']]['Inventory'] = "Experimental: Torna possível alterar a visibilidade dos equipamentos diretamente pela aba de Inventário"
Localization.Descriptions[languagesShort['pt-br']]['Breast'] = "Experimental: corrige o tamanho dos seios"

-- Simplified Chinese
Localization.Categories[languagesShort['zh-cn']] = {}
Localization.Categories[languagesShort['zh-cn']]['Visibility'] = "服装可见性"
Localization.Categories[languagesShort['zh-cn']]['Preferences'] = "偏好"

Localization.Names[languagesShort['zh-cn']] = {}
Localization.Names[languagesShort['zh-cn']]['Head'] = "头部"
Localization.Names[languagesShort['zh-cn']]['Face'] = "面部"
Localization.Names[languagesShort['zh-cn']]['OuterChest'] = "外搭"
Localization.Names[languagesShort['zh-cn']]['InnerChest'] = "内搭"
Localization.Names[languagesShort['zh-cn']]['Legs'] = "腿部"
Localization.Names[languagesShort['zh-cn']]['Feet'] = "足部"
Localization.Names[languagesShort['zh-cn']]['Outfit'] = "全套服装"
Localization.Names[languagesShort['zh-cn']]['Inventory'] = "UI切换"
Localization.Names[languagesShort['zh-cn']]['Breast'] = "乳房修复"

Localization.Descriptions[languagesShort['zh-cn']] = {}
Localization.Descriptions[languagesShort['zh-cn']]['Head'] = "控制头部装备的可见性"
Localization.Descriptions[languagesShort['zh-cn']]['Face'] = "控制面部装备的可见性"
Localization.Descriptions[languagesShort['zh-cn']]['OuterChest'] = "控制外搭装备的可见性"
Localization.Descriptions[languagesShort['zh-cn']]['InnerChest'] = "控制内搭装备的可见性"
Localization.Descriptions[languagesShort['zh-cn']]['Legs'] = "控制腿部装备的可见性"
Localization.Descriptions[languagesShort['zh-cn']]['Feet'] = "控制足部装备的可见性"
Localization.Descriptions[languagesShort['zh-cn']]['Outfit'] = "控制全套服装装备的可见性"
Localization.Descriptions[languagesShort['zh-cn']]['Inventory'] = "实验性：在物品栏界面启用可见性切换"
Localization.Descriptions[languagesShort['zh-cn']]['Breast'] = "实验性：修复乳房尺寸"

-- German
Localization.Categories[languagesShort['de-de']] = {}
Localization.Categories[languagesShort['de-de']]['Visibility'] = "Sichtbarkeit der Kleidung"
Localization.Categories[languagesShort['de-de']]['Preferences'] = "Präferenzen"

Localization.Names[languagesShort['de-de']] = {}
Localization.Names[languagesShort['de-de']]['Head'] = "Kopf"
Localization.Names[languagesShort['de-de']]['Face'] = "Gesicht"
Localization.Names[languagesShort['de-de']]['OuterChest'] = "Äußerer Torso"
Localization.Names[languagesShort['de-de']]['InnerChest'] = "Innerer Torso"
Localization.Names[languagesShort['de-de']]['Legs'] = "Beine"
Localization.Names[languagesShort['de-de']]['Feet'] = "Füße"
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
Localization.Descriptions[languagesShort['de-de']]['Inventory'] = "Experimentell: Ermöglicht das Umschalten der Sichtbarkeit im Inventar-UI"
Localization.Descriptions[languagesShort['de-de']]['Breast'] = "Experimentell: Behebt Brustgröße" 

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