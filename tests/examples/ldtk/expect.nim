{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  `TestCustomCommand`* = object
    `command`*: string
    `when`*: `TestTestCustomCommand_when`
  `TestIntGridValueDef`* = object
    `tile`*: Option[`TestTilesetRect`]
    `color`*: string
    `identifier`*: Option[string]
    `groupUid`*: BiggestInt
    `value`*: BiggestInt
  `TestIntGridValueGroupDef`* = object
    `color`*: Option[string]
    `identifier`*: Option[string]
    `uid`*: BiggestInt
  `TestLevel`* = object
    `pxHei`*: BiggestInt
    `useAutoIdentifier`*: bool
    `bgColor`*: string
    `bgColor`*: Option[string]
    `externalRelPath`*: Option[string]
    `worldY`*: BiggestInt
    `bgRelPath`*: Option[string]
    `identifier`*: string
    `pxWid`*: BiggestInt
    `worldDepth`*: BiggestInt
    `bgPivotX`*: BiggestFloat
    `neighbours`*: seq[`TestNeighbourLevel`]
    `uid`*: BiggestInt
    `bgPos`*: Option[`TestTestLevel_bgPos`]
    `layerInstances`*: Option[seq[`TestLayerInstance`]]
    `fieldInstances`*: seq[`TestFieldInstance`]
    `bgPos`*: Option[`TestLevelBgPosInfos`]
    `worldX`*: BiggestInt
    `iid`*: string
    `bgPivotY`*: BiggestFloat
    `smartColor`*: string
  `TestTestCustomCommand_when`* = enum
    `AfterLoad`, `BeforeSave`, `AfterSave`, `Manual`
  `TestTestLdtkJsonRoot_imageExportMode`* = enum
    `LayersAndLevels`, `OneImagePerLayer`, `None`, `OneImagePerLevel`
  `TestTestLayerDef_type`* = enum
    `Tiles`, `Entities`, `AutoLayer`, `IntGrid`
  `TestTestTilesetDef_embedAtlas`* = enum
    `LdtkIcons`
  `TestLayerDef`* = object
    `type`*: `TestTestLayerDef_type`
    `autoTilesetDefUid`*: Option[BiggestInt]
    `parallaxScaling`*: bool
    `biomeFieldUid`*: Option[BiggestInt]
    `autoTilesKilledByOtherLayerUid`*: Option[BiggestInt]
    `inactiveOpacity`*: BiggestFloat
    `type`*: string
    `autoRuleGroups`*: seq[`TestAutoLayerRuleGroup`]
    `gridSize`*: BiggestInt
    `hideInList`*: bool
    `tilesetDefUid`*: Option[BiggestInt]
    `uiColor`*: Option[string]
    `requiredTags`*: seq[string]
    `tilePivotX`*: BiggestFloat
    `uiFilterTags`*: seq[string]
    `guideGridWid`*: BiggestInt
    `parallaxFactorX`*: BiggestFloat
    `identifier`*: string
    `canSelectWhenInactive`*: bool
    `pxOffsetX`*: BiggestInt
    `tilePivotY`*: BiggestFloat
    `excludedTags`*: seq[string]
    `doc`*: Option[string]
    `uid`*: BiggestInt
    `guideGridHei`*: BiggestInt
    `autoSourceLayerDefUid`*: Option[BiggestInt]
    `displayOpacity`*: BiggestFloat
    `intGridValuesGroups`*: seq[`TestIntGridValueGroupDef`]
    `hideFieldsWhenInactive`*: bool
    `useAsyncRender`*: bool
    `pxOffsetY`*: BiggestInt
    `parallaxFactorY`*: BiggestFloat
    `intGridValues`*: seq[`TestIntGridValueDef`]
    `renderInWorldView`*: bool
  `TestTileCustomMetadata`* = object
    `data`*: string
    `tileId`*: BiggestInt
  `TestTestEntityDef_limitBehavior`* = enum
    `PreventAdding`, `MoveLastOne`, `DiscardOldOnes`
  `TestTestFieldDef_allowedRefs`* = enum
    `Any`, `OnlyTags`, `OnlySame`, `OnlySpecificEntity`
  `TestTilesetRect`* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  `TestTestEntityDef_tileRenderMode`* = enum
    `FullSizeCropped`, `FullSizeUncropped`, `Repeat`, `FitInside`, `NineSlice`,
    `Cover`, `Stretch`
  `TestEnumDefValues`* = object
    `tileSrcRect`*: Option[seq[BiggestInt]]
    `color`*: BiggestInt
    `id`*: string
    `tileId`*: Option[BiggestInt]
    `tileRect`*: Option[`TestTilesetRect`]
  `TestLevelBgPosInfos`* = object
    `scale`*: seq[BiggestFloat]
    `cropRect`*: seq[BiggestFloat]
    `topLeftPx`*: seq[BiggestInt]
  `TestTestWorld_worldLayout`* = enum
    `LinearHorizontal`, `LinearVertical`, `GridVania`, `Free`
  `TestAutoRuleDef`* = object
    `checker`*: `TestTestAutoRuleDef_checker`
    `pivotY`*: BiggestFloat
    `breakOnMatch`*: bool
    `perlinOctaves`*: BiggestFloat
    `yModulo`*: BiggestInt
    `size`*: BiggestInt
    `tileMode`*: `TestTestAutoRuleDef_tileMode`
    `tileRandomXMax`*: BiggestInt
    `tileRandomXMin`*: BiggestInt
    `xModulo`*: BiggestInt
    `yOffset`*: BiggestInt
    `flipX`*: bool
    `tileYOffset`*: BiggestInt
    `chance`*: BiggestFloat
    `tileRandomYMax`*: BiggestInt
    `perlinActive`*: bool
    `perlinScale`*: BiggestFloat
    `outOfBoundsValue`*: Option[BiggestInt]
    `pivotX`*: BiggestFloat
    `flipY`*: bool
    `active`*: bool
    `uid`*: BiggestInt
    `tileIds`*: Option[seq[BiggestInt]]
    `invalidated`*: bool
    `pattern`*: seq[BiggestInt]
    `alpha`*: BiggestFloat
    `tileRectsIds`*: seq[seq[BiggestInt]]
    `tileXOffset`*: BiggestInt
    `xOffset`*: BiggestInt
    `tileRandomYMin`*: BiggestInt
    `perlinSeed`*: BiggestFloat
  `TestTilesetDef`* = object
    `pxHei`*: BiggestInt
    `savedSelections`*: seq[Table[string, JsonNode]]
    `padding`*: BiggestInt
    `spacing`*: BiggestInt
    `tagsSourceEnumUid`*: Option[BiggestInt]
    `embedAtlas`*: Option[`TestTestTilesetDef_embedAtlas`]
    `identifier`*: string
    `cachedPixelData`*: Option[Table[string, JsonNode]]
    `enumTags`*: seq[`TestEnumTagValue`]
    `pxWid`*: BiggestInt
    `tileGridSize`*: BiggestInt
    `customData`*: seq[`TestTileCustomMetadata`]
    `uid`*: BiggestInt
    `cHei`*: BiggestInt
    `cWid`*: BiggestInt
    `relPath`*: Option[string]
    `tags`*: seq[string]
  `TestNeighbourLevel`* = object
    `levelUid`*: Option[BiggestInt]
    `levelIid`*: string
    `dir`*: string
  `TestTestLdtkJsonRoot_worldLayout`* = enum
    `LinearHorizontal`, `LinearVertical`, `GridVania`, `Free`
  `TestLayerInstance`* = object
    `opacity`*: BiggestFloat
    `optionalRules`*: seq[BiggestInt]
    `gridSize`*: BiggestInt
    `pxTotalOffsetX`*: BiggestInt
    `gridTiles`*: seq[`TestTile`]
    `type`*: string
    `identifier`*: string
    `overrideTilesetUid`*: Option[BiggestInt]
    `levelId`*: BiggestInt
    `intGrid`*: Option[seq[`TestIntGridValueInstance`]]
    `autoLayerTiles`*: seq[`TestTile`]
    `layerDefUid`*: BiggestInt
    `entityInstances`*: seq[`TestEntityInstance`]
    `intGridCsv`*: seq[BiggestInt]
    `pxOffsetX`*: BiggestInt
    `tilesetRelPath`*: Option[string]
    `tilesetDefUid`*: Option[BiggestInt]
    `cHei`*: BiggestInt
    `seed`*: BiggestInt
    `visible`*: bool
    `pxOffsetY`*: BiggestInt
    `iid`*: string
    `pxTotalOffsetY`*: BiggestInt
    `cWid`*: BiggestInt
  `TestFieldInstance`* = object
    `realEditorValues`*: seq[JsonNode]
    `value`*: JsonNode
    `tile`*: Option[`TestTilesetRect`]
    `type`*: string
    `identifier`*: string
    `defUid`*: BiggestInt
  `TestTestEntityDef_renderMode`* = enum
    `Tile`, `Cross`, `Ellipse`, `Rectangle`
  `TestTestAutoRuleDef_tileMode`* = enum
    `Single`, `Stamp`
  `TestTestFieldDef_editorLinkStyle`* = enum
    `DashedLine`, `CurvedArrow`, `ArrowsLine`, `ZigZag`, `StraightArrow`
  `TestEntityReferenceInfos`* = object
    `layerIid`*: string
    `levelIid`*: string
    `entityIid`*: string
    `worldIid`*: string
  `TestIntGridValueInstance`* = object
    `coordId`*: BiggestInt
    `v`*: BiggestInt
  `TestEntityDef`* = object
    `allowOutOfBounds`*: bool
    `pivotY`*: BiggestFloat
    `tileOpacity`*: BiggestFloat
    `color`*: string
    `limitScope`*: `TestTestEntityDef_limitScope`
    `limitBehavior`*: `TestTestEntityDef_limitBehavior`
    `hollow`*: bool
    `height`*: BiggestInt
    `renderMode`*: `TestTestEntityDef_renderMode`
    `tilesetId`*: Option[BiggestInt]
    `keepAspectRatio`*: bool
    `minWidth`*: Option[BiggestInt]
    `showName`*: bool
    `resizableX`*: bool
    `identifier`*: string
    `maxCount`*: BiggestInt
    `tileId`*: Option[BiggestInt]
    `pivotX`*: BiggestFloat
    `doc`*: Option[string]
    `fieldDefs`*: seq[`TestFieldDef`]
    `uid`*: BiggestInt
    `tileRenderMode`*: `TestTestEntityDef_tileRenderMode`
    `uiTileRect`*: Option[`TestTilesetRect`]
    `resizableY`*: bool
    `lineOpacity`*: BiggestFloat
    `minHeight`*: Option[BiggestInt]
    `tileRect`*: Option[`TestTilesetRect`]
    `nineSliceBorders`*: seq[BiggestInt]
    `maxWidth`*: Option[BiggestInt]
    `width`*: BiggestInt
    `tags`*: seq[string]
    `maxHeight`*: Option[BiggestInt]
    `exportToToc`*: bool
    `fillOpacity`*: BiggestFloat
  `TestWorld`* = object
    `worldGridWidth`*: BiggestInt
    `defaultLevelHeight`*: BiggestInt
    `identifier`*: string
    `worldLayout`*: Option[`TestTestWorld_worldLayout`]
    `iid`*: string
    `defaultLevelWidth`*: BiggestInt
    `worldGridHeight`*: BiggestInt
    `levels`*: seq[`TestLevel`]
  `TestTestLdtkJsonRoot_FORCED_REFS`* = object
    `CustomCommand`*: Option[`TestCustomCommand`]
    `IntGridValueDef`*: Option[`TestIntGridValueDef`]
    `Level`*: Option[`TestLevel`]
    `Definitions`*: Option[`TestDefinitions`]
    `EnumDef`*: Option[`TestEnumDef`]
    `FieldDef`*: Option[`TestFieldDef`]
    `AutoLayerRuleGroup`*: Option[`TestAutoLayerRuleGroup`]
    `TilesetDef`*: Option[`TestTilesetDef`]
    `TableOfContentEntry`*: Option[`TestTableOfContentEntry`]
    `EntityDef`*: Option[`TestEntityDef`]
    `FieldInstance`*: Option[`TestFieldInstance`]
    `EntityReferenceInfos`*: Option[`TestEntityReferenceInfos`]
    `LevelBgPosInfos`*: Option[`TestLevelBgPosInfos`]
    `TileCustomMetadata`*: Option[`TestTileCustomMetadata`]
    `Tile`*: Option[`TestTile`]
    `AutoRuleDef`*: Option[`TestAutoRuleDef`]
    `NeighbourLevel`*: Option[`TestNeighbourLevel`]
    `GridPoint`*: Option[`TestGridPoint`]
    `EntityInstance`*: Option[`TestEntityInstance`]
    `TilesetRect`*: Option[`TestTilesetRect`]
    `EnumTagValue`*: Option[`TestEnumTagValue`]
    `LayerInstance`*: Option[`TestLayerInstance`]
    `IntGridValueInstance`*: Option[`TestIntGridValueInstance`]
    `World`*: Option[`TestWorld`]
    `LayerDef`*: Option[`TestLayerDef`]
    `IntGridValueGroupDef`*: Option[`TestIntGridValueGroupDef`]
    `TocInstanceData`*: Option[`TestTocInstanceData`]
    `EnumDefValues`*: Option[`TestEnumDefValues`]
  `TestAutoLayerRuleGroup`* = object
    `isOptional`*: bool
    `color`*: Option[string]
    `collapsed`*: Option[bool]
    `usesWizard`*: bool
    `biomeRequirementMode`*: BiggestInt
    `rules`*: seq[`TestAutoRuleDef`]
    `icon`*: Option[`TestTilesetRect`]
    `active`*: bool
    `uid`*: BiggestInt
    `name`*: string
    `requiredBiomeValues`*: seq[string]
  `TestTestLdtkJsonRoot_identifierStyle`* = enum
    `Lowercase`, `Free`, `Capitalize`, `Uppercase`
  `TestTestFieldDef_textLanguageMode`* = enum
    `LangMarkdown`, `LangPython`, `LangLog`, `LangC`, `LangLua`, `LangHaxe`,
    `LangJS`, `LangRuby`, `LangJson`, `LangXml`
  `TestEnumTagValue`* = object
    `tileIds`*: seq[BiggestInt]
    `enumValueId`*: string
  `TestTableOfContentEntry`* = object
    `instancesData`*: seq[`TestTocInstanceData`]
    `identifier`*: string
    `instances`*: Option[seq[`TestEntityReferenceInfos`]]
  `TestTestFieldDef_editorDisplayMode`* = enum
    `PointPath`, `PointStar`, `ValueOnly`, `Hidden`, `Points`, `NameAndValue`,
    `ArrayCountNoLabel`, `EntityTile`, `PointPathLoop`, `RadiusPx`, `LevelTile`,
    `RadiusGrid`, `RefLinkBetweenCenters`, `RefLinkBetweenPivots`,
    `ArrayCountWithLabel`
  `TestTestLevel_bgPos`* = enum
    `CoverDirty`, `Repeat`, `Contain`, `Cover`, `Unscaled`
  `TestTile`* = object
    `px`*: seq[BiggestInt]
    `t`*: BiggestInt
    `d`*: seq[BiggestInt]
    `a`*: BiggestFloat
    `src`*: seq[BiggestInt]
    `f`*: BiggestInt
  `TestTestFieldDef_editorDisplayPos`* = enum
    `Beneath`, `Above`, `Center`
  `TestTocInstanceData`* = object
    `worldY`*: BiggestInt
    `fields`*: JsonNode
    `widPx`*: BiggestInt
    `iids`*: `TestEntityReferenceInfos`
    `heiPx`*: BiggestInt
    `worldX`*: BiggestInt
  `TestEnumDef`* = object
    `values`*: seq[`TestEnumDefValues`]
    `externalRelPath`*: Option[string]
    `identifier`*: string
    `externalFileChecksum`*: Option[string]
    `iconTilesetUid`*: Option[BiggestInt]
    `uid`*: BiggestInt
    `tags`*: seq[string]
  `TestFieldDef`* = object
    `type`*: string
    `editorDisplayScale`*: BiggestFloat
    `type`*: string
    `allowedRefsEntityUid`*: Option[BiggestInt]
    `textLanguageMode`*: Option[`TestTestFieldDef_textLanguageMode`]
    `editorAlwaysShow`*: bool
    `defaultOverride`*: Option[JsonNode]
    `autoChainRef`*: bool
    `editorDisplayPos`*: `TestTestFieldDef_editorDisplayPos`
    `editorDisplayMode`*: `TestTestFieldDef_editorDisplayMode`
    `identifier`*: string
    `regex`*: Option[string]
    `isArray`*: bool
    `editorLinkStyle`*: `TestTestFieldDef_editorLinkStyle`
    `allowedRefs`*: `TestTestFieldDef_allowedRefs`
    `useForSmartColor`*: bool
    `editorTextSuffix`*: Option[string]
    `doc`*: Option[string]
    `editorTextPrefix`*: Option[string]
    `editorCutLongValues`*: bool
    `canBeNull`*: bool
    `allowedRefTags`*: seq[string]
    `uid`*: BiggestInt
    `symmetricalRef`*: bool
    `editorDisplayColor`*: Option[string]
    `allowOutOfLevelRef`*: bool
    `acceptFileTypes`*: Option[seq[string]]
    `editorShowInWorld`*: bool
    `tilesetUid`*: Option[BiggestInt]
    `arrayMaxLength`*: Option[BiggestInt]
    `arrayMinLength`*: Option[BiggestInt]
    `searchable`*: bool
    `min`*: Option[BiggestFloat]
    `exportToToc`*: bool
    `max`*: Option[BiggestFloat]
  `TestDefinitions`* = object
    `levelFields`*: seq[`TestFieldDef`]
    `tilesets`*: seq[`TestTilesetDef`]
    `entities`*: seq[`TestEntityDef`]
    `enums`*: seq[`TestEnumDef`]
    `layers`*: seq[`TestLayerDef`]
    `externalEnums`*: seq[`TestEnumDef`]
  `TestTestLdtkJsonRoot_flags`* = enum
    `ExportPreCsvIntGridFormat`, `DiscardPreCsvIntGrid`,
    `ExportOldTableOfContentData`, `PrependIndexToLevelFileNames`,
    `MultiWorlds`, `UseMultilinesType`, `IgnoreBackupSuggest`
  `TestGridPoint`* = object
    `cx`*: BiggestInt
    `cy`*: BiggestInt
  `TestEntityInstance`* = object
    `worldY`*: Option[BiggestInt]
    `tile`*: Option[`TestTilesetRect`]
    `identifier`*: string
    `tags`*: seq[string]
    `height`*: BiggestInt
    `px`*: seq[BiggestInt]
    `defUid`*: BiggestInt
    `pivot`*: seq[BiggestFloat]
    `fieldInstances`*: seq[`TestFieldInstance`]
    `iid`*: string
    `width`*: BiggestInt
    `worldX`*: Option[BiggestInt]
    `grid`*: seq[BiggestInt]
    `smartColor`*: string
  `TestTestAutoRuleDef_checker`* = enum
    `Horizontal`, `Vertical`, `None`
  `TestLdtkJsonRoot`* = object
    `backupLimit`*: BiggestInt
    `simplifiedExport`*: bool
    `externalLevels`*: bool
    `backupRelPath`*: Option[string]
    `jsonVersion`*: string
    `bgColor`*: string
    `appBuildId`*: BiggestFloat
    `defaultEntityHeight`*: BiggestInt
    `pngFilePattern`*: Option[string]
    `customCommands`*: seq[`TestCustomCommand`]
    `exportTiled`*: bool
    `exportPng`*: Option[bool]
    `worldGridWidth`*: Option[BiggestInt]
    `defaultLevelHeight`*: Option[BiggestInt]
    `toc`*: seq[`TestTableOfContentEntry`]
    `worlds`*: seq[`TestWorld`]
    `imageExportMode`*: `TestTestLdtkJsonRoot_imageExportMode`
    `dummyWorldIid`*: string
    `FORCED_REFS`*: Option[`TestTestLdtkJsonRoot_FORCED_REFS`]
    `defaultPivotY`*: BiggestFloat
    `exportLevelBg`*: bool
    `nextUid`*: BiggestInt
    `levelNamePattern`*: string
    `defs`*: `TestDefinitions`
    `defaultPivotX`*: BiggestFloat
    `tutorialDesc`*: Option[string]
    `worldLayout`*: Option[`TestTestLdtkJsonRoot_worldLayout`]
    `defaultEntityWidth`*: BiggestInt
    `iid`*: string
    `defaultGridSize`*: BiggestInt
    `defaultLevelWidth`*: Option[BiggestInt]
    `minifyJson`*: bool
    `backupOnSave`*: bool
    `flags`*: seq[`TestTestLdtkJsonRoot_flags`]
    `defaultLevelBgColor`*: string
    `identifierStyle`*: `TestTestLdtkJsonRoot_identifierStyle`
    `worldGridHeight`*: Option[BiggestInt]
    `levels`*: seq[`TestLevel`]
  `TestTestEntityDef_limitScope`* = enum
    `PerLayer`, `PerWorld`, `PerLevel`
proc toJsonHook*(source: `TestTestCustomCommand_when`): JsonNode =
  case source
  of `TestTestCustomCommand_when`.`AfterLoad`:
    return newJString("AfterLoad")
  of `TestTestCustomCommand_when`.`BeforeSave`:
    return newJString("BeforeSave")
  of `TestTestCustomCommand_when`.`AfterSave`:
    return newJString("AfterSave")
  of `TestTestCustomCommand_when`.`Manual`:
    return newJString("Manual")
  
proc toJsonHook*(source: `TestTestWorld_worldLayout`): JsonNode =
  case source
  of `TestTestWorld_worldLayout`.`LinearHorizontal`:
    return newJString("LinearHorizontal")
  of `TestTestWorld_worldLayout`.`LinearVertical`:
    return newJString("LinearVertical")
  of `TestTestWorld_worldLayout`.`GridVania`:
    return newJString("GridVania")
  of `TestTestWorld_worldLayout`.`Free`:
    return newJString("Free")
  
proc toJsonHook*(source: `TestTestLevel_bgPos`): JsonNode =
  case source
  of `TestTestLevel_bgPos`.`CoverDirty`:
    return newJString("CoverDirty")
  of `TestTestLevel_bgPos`.`Repeat`:
    return newJString("Repeat")
  of `TestTestLevel_bgPos`.`Contain`:
    return newJString("Contain")
  of `TestTestLevel_bgPos`.`Cover`:
    return newJString("Cover")
  of `TestTestLevel_bgPos`.`Unscaled`:
    return newJString("Unscaled")
  
proc toJsonHook*(source: `TestTestLdtkJsonRoot_imageExportMode`): JsonNode =
  case source
  of `TestTestLdtkJsonRoot_imageExportMode`.`LayersAndLevels`:
    return newJString("LayersAndLevels")
  of `TestTestLdtkJsonRoot_imageExportMode`.`OneImagePerLayer`:
    return newJString("OneImagePerLayer")
  of `TestTestLdtkJsonRoot_imageExportMode`.`None`:
    return newJString("None")
  of `TestTestLdtkJsonRoot_imageExportMode`.`OneImagePerLevel`:
    return newJString("OneImagePerLevel")
  
proc toJsonHook*(source: `TestTestFieldDef_textLanguageMode`): JsonNode =
  case source
  of `TestTestFieldDef_textLanguageMode`.`LangMarkdown`:
    return newJString("LangMarkdown")
  of `TestTestFieldDef_textLanguageMode`.`LangPython`:
    return newJString("LangPython")
  of `TestTestFieldDef_textLanguageMode`.`LangLog`:
    return newJString("LangLog")
  of `TestTestFieldDef_textLanguageMode`.`LangC`:
    return newJString("LangC")
  of `TestTestFieldDef_textLanguageMode`.`LangLua`:
    return newJString("LangLua")
  of `TestTestFieldDef_textLanguageMode`.`LangHaxe`:
    return newJString("LangHaxe")
  of `TestTestFieldDef_textLanguageMode`.`LangJS`:
    return newJString("LangJS")
  of `TestTestFieldDef_textLanguageMode`.`LangRuby`:
    return newJString("LangRuby")
  of `TestTestFieldDef_textLanguageMode`.`LangJson`:
    return newJString("LangJson")
  of `TestTestFieldDef_textLanguageMode`.`LangXml`:
    return newJString("LangXml")
  
proc toJsonHook*(source: `TestTestFieldDef_editorDisplayPos`): JsonNode =
  case source
  of `TestTestFieldDef_editorDisplayPos`.`Beneath`:
    return newJString("Beneath")
  of `TestTestFieldDef_editorDisplayPos`.`Above`:
    return newJString("Above")
  of `TestTestFieldDef_editorDisplayPos`.`Center`:
    return newJString("Center")
  
proc toJsonHook*(source: `TestTestFieldDef_editorDisplayMode`): JsonNode =
  case source
  of `TestTestFieldDef_editorDisplayMode`.`PointPath`:
    return newJString("PointPath")
  of `TestTestFieldDef_editorDisplayMode`.`PointStar`:
    return newJString("PointStar")
  of `TestTestFieldDef_editorDisplayMode`.`ValueOnly`:
    return newJString("ValueOnly")
  of `TestTestFieldDef_editorDisplayMode`.`Hidden`:
    return newJString("Hidden")
  of `TestTestFieldDef_editorDisplayMode`.`Points`:
    return newJString("Points")
  of `TestTestFieldDef_editorDisplayMode`.`NameAndValue`:
    return newJString("NameAndValue")
  of `TestTestFieldDef_editorDisplayMode`.`ArrayCountNoLabel`:
    return newJString("ArrayCountNoLabel")
  of `TestTestFieldDef_editorDisplayMode`.`EntityTile`:
    return newJString("EntityTile")
  of `TestTestFieldDef_editorDisplayMode`.`PointPathLoop`:
    return newJString("PointPathLoop")
  of `TestTestFieldDef_editorDisplayMode`.`RadiusPx`:
    return newJString("RadiusPx")
  of `TestTestFieldDef_editorDisplayMode`.`LevelTile`:
    return newJString("LevelTile")
  of `TestTestFieldDef_editorDisplayMode`.`RadiusGrid`:
    return newJString("RadiusGrid")
  of `TestTestFieldDef_editorDisplayMode`.`RefLinkBetweenCenters`:
    return newJString("RefLinkBetweenCenters")
  of `TestTestFieldDef_editorDisplayMode`.`RefLinkBetweenPivots`:
    return newJString("RefLinkBetweenPivots")
  of `TestTestFieldDef_editorDisplayMode`.`ArrayCountWithLabel`:
    return newJString("ArrayCountWithLabel")
  
proc toJsonHook*(source: `TestTestFieldDef_editorLinkStyle`): JsonNode =
  case source
  of `TestTestFieldDef_editorLinkStyle`.`DashedLine`:
    return newJString("DashedLine")
  of `TestTestFieldDef_editorLinkStyle`.`CurvedArrow`:
    return newJString("CurvedArrow")
  of `TestTestFieldDef_editorLinkStyle`.`ArrowsLine`:
    return newJString("ArrowsLine")
  of `TestTestFieldDef_editorLinkStyle`.`ZigZag`:
    return newJString("ZigZag")
  of `TestTestFieldDef_editorLinkStyle`.`StraightArrow`:
    return newJString("StraightArrow")
  
proc toJsonHook*(source: `TestTestFieldDef_allowedRefs`): JsonNode =
  case source
  of `TestTestFieldDef_allowedRefs`.`Any`:
    return newJString("Any")
  of `TestTestFieldDef_allowedRefs`.`OnlyTags`:
    return newJString("OnlyTags")
  of `TestTestFieldDef_allowedRefs`.`OnlySame`:
    return newJString("OnlySame")
  of `TestTestFieldDef_allowedRefs`.`OnlySpecificEntity`:
    return newJString("OnlySpecificEntity")
  
proc toJsonHook*(source: `TestTestTilesetDef_embedAtlas`): JsonNode =
  case source
  of `TestTestTilesetDef_embedAtlas`.`LdtkIcons`:
    return newJString("LdtkIcons")
  
proc toJsonHook*(source: `TestTestEntityDef_limitScope`): JsonNode =
  case source
  of `TestTestEntityDef_limitScope`.`PerLayer`:
    return newJString("PerLayer")
  of `TestTestEntityDef_limitScope`.`PerWorld`:
    return newJString("PerWorld")
  of `TestTestEntityDef_limitScope`.`PerLevel`:
    return newJString("PerLevel")
  
proc toJsonHook*(source: `TestTestEntityDef_limitBehavior`): JsonNode =
  case source
  of `TestTestEntityDef_limitBehavior`.`PreventAdding`:
    return newJString("PreventAdding")
  of `TestTestEntityDef_limitBehavior`.`MoveLastOne`:
    return newJString("MoveLastOne")
  of `TestTestEntityDef_limitBehavior`.`DiscardOldOnes`:
    return newJString("DiscardOldOnes")
  
proc toJsonHook*(source: `TestTestEntityDef_renderMode`): JsonNode =
  case source
  of `TestTestEntityDef_renderMode`.`Tile`:
    return newJString("Tile")
  of `TestTestEntityDef_renderMode`.`Cross`:
    return newJString("Cross")
  of `TestTestEntityDef_renderMode`.`Ellipse`:
    return newJString("Ellipse")
  of `TestTestEntityDef_renderMode`.`Rectangle`:
    return newJString("Rectangle")
  
proc toJsonHook*(source: `TestTestEntityDef_tileRenderMode`): JsonNode =
  case source
  of `TestTestEntityDef_tileRenderMode`.`FullSizeCropped`:
    return newJString("FullSizeCropped")
  of `TestTestEntityDef_tileRenderMode`.`FullSizeUncropped`:
    return newJString("FullSizeUncropped")
  of `TestTestEntityDef_tileRenderMode`.`Repeat`:
    return newJString("Repeat")
  of `TestTestEntityDef_tileRenderMode`.`FitInside`:
    return newJString("FitInside")
  of `TestTestEntityDef_tileRenderMode`.`NineSlice`:
    return newJString("NineSlice")
  of `TestTestEntityDef_tileRenderMode`.`Cover`:
    return newJString("Cover")
  of `TestTestEntityDef_tileRenderMode`.`Stretch`:
    return newJString("Stretch")
  
proc toJsonHook*(source: `TestTestLayerDef_type`): JsonNode =
  case source
  of `TestTestLayerDef_type`.`Tiles`:
    return newJString("Tiles")
  of `TestTestLayerDef_type`.`Entities`:
    return newJString("Entities")
  of `TestTestLayerDef_type`.`AutoLayer`:
    return newJString("AutoLayer")
  of `TestTestLayerDef_type`.`IntGrid`:
    return newJString("IntGrid")
  
proc toJsonHook*(source: `TestTestAutoRuleDef_checker`): JsonNode =
  case source
  of `TestTestAutoRuleDef_checker`.`Horizontal`:
    return newJString("Horizontal")
  of `TestTestAutoRuleDef_checker`.`Vertical`:
    return newJString("Vertical")
  of `TestTestAutoRuleDef_checker`.`None`:
    return newJString("None")
  
proc toJsonHook*(source: `TestTestAutoRuleDef_tileMode`): JsonNode =
  case source
  of `TestTestAutoRuleDef_tileMode`.`Single`:
    return newJString("Single")
  of `TestTestAutoRuleDef_tileMode`.`Stamp`:
    return newJString("Stamp")
  
proc toJsonHook*(source: `TestTestLdtkJsonRoot_worldLayout`): JsonNode =
  case source
  of `TestTestLdtkJsonRoot_worldLayout`.`LinearHorizontal`:
    return newJString("LinearHorizontal")
  of `TestTestLdtkJsonRoot_worldLayout`.`LinearVertical`:
    return newJString("LinearVertical")
  of `TestTestLdtkJsonRoot_worldLayout`.`GridVania`:
    return newJString("GridVania")
  of `TestTestLdtkJsonRoot_worldLayout`.`Free`:
    return newJString("Free")
  
proc toJsonHook*(source: `TestTestLdtkJsonRoot_flags`): JsonNode =
  case source
  of `TestTestLdtkJsonRoot_flags`.`ExportPreCsvIntGridFormat`:
    return newJString("ExportPreCsvIntGridFormat")
  of `TestTestLdtkJsonRoot_flags`.`DiscardPreCsvIntGrid`:
    return newJString("DiscardPreCsvIntGrid")
  of `TestTestLdtkJsonRoot_flags`.`ExportOldTableOfContentData`:
    return newJString("ExportOldTableOfContentData")
  of `TestTestLdtkJsonRoot_flags`.`PrependIndexToLevelFileNames`:
    return newJString("PrependIndexToLevelFileNames")
  of `TestTestLdtkJsonRoot_flags`.`MultiWorlds`:
    return newJString("MultiWorlds")
  of `TestTestLdtkJsonRoot_flags`.`UseMultilinesType`:
    return newJString("UseMultilinesType")
  of `TestTestLdtkJsonRoot_flags`.`IgnoreBackupSuggest`:
    return newJString("IgnoreBackupSuggest")
  
proc toJsonHook*(source: `TestTestLdtkJsonRoot_identifierStyle`): JsonNode =
  case source
  of `TestTestLdtkJsonRoot_identifierStyle`.`Lowercase`:
    return newJString("Lowercase")
  of `TestTestLdtkJsonRoot_identifierStyle`.`Free`:
    return newJString("Free")
  of `TestTestLdtkJsonRoot_identifierStyle`.`Capitalize`:
    return newJString("Capitalize")
  of `TestTestLdtkJsonRoot_identifierStyle`.`Uppercase`:
    return newJString("Uppercase")
  