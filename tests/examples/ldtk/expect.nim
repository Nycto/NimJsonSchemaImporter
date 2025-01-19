import std/[json, tables, options]
type
  `LdtkLdtkJsonRoot`* = object
    `backupLimit`*: BiggestInt
    `simplifiedExport`*: bool
    `externalLevels`*: bool
    `backupRelPath`*: Option[string]
    `jsonVersion`*: string
    `bgColor`*: string
    `appBuildId`*: BiggestFloat
    `defaultEntityHeight`*: BiggestInt
    `pngFilePattern`*: Option[string]
    `customCommands`*: seq[`LdtkCustomCommand`]
    `exportTiled`*: bool
    `exportPng`*: Option[bool]
    `worldGridWidth`*: Option[BiggestInt]
    `defaultLevelHeight`*: Option[BiggestInt]
    `toc`*: seq[`LdtkTableOfContentEntry`]
    `worlds`*: seq[`LdtkWorld`]
    `imageExportMode`*: `LdtkLdtkLdtkJsonRoot_ImageExportMode`
    `dummyWorldIid`*: string
    `FORCED_REFS`*: Option[`LdtkLdtkLdtkJsonRoot_FORCED_REFS`]
    `defaultPivotY`*: BiggestFloat
    `exportLevelBg`*: bool
    `nextUid`*: BiggestInt
    `levelNamePattern`*: string
    `defs`*: `LdtkDefinitions`
    `defaultPivotX`*: BiggestFloat
    `tutorialDesc`*: Option[string]
    `worldLayout`*: Option[`LdtkLdtkLdtkJsonRoot_WorldLayout`]
    `defaultEntityWidth`*: BiggestInt
    `iid`*: string
    `defaultGridSize`*: BiggestInt
    `defaultLevelWidth`*: Option[BiggestInt]
    `minifyJson`*: bool
    `backupOnSave`*: bool
    `flags`*: seq[`LdtkLdtkLdtkJsonRoot_Flags`]
    `defaultLevelBgColor`*: string
    `identifierStyle`*: `LdtkLdtkLdtkJsonRoot_IdentifierStyle`
    `worldGridHeight`*: Option[BiggestInt]
    `levels`*: seq[`LdtkLevel`]
  `LdtkNeighbourLevel`* = object
    `levelUid`*: Option[BiggestInt]
    `levelIid`*: string
    `dir`*: string
  `LdtkLdtkWorld_WorldLayout`* = enum
    LinearHorizontal, LinearVertical, GridVania, Free
  `LdtkCustomCommand`* = object
    `command`*: string
    `when`*: `LdtkLdtkCustomCommand_When`
  `LdtkFieldDef`* = object
    `type`*: string
    `editorDisplayScale`*: BiggestFloat
    `type`*: string
    `allowedRefsEntityUid`*: Option[BiggestInt]
    `textLanguageMode`*: Option[`LdtkLdtkFieldDef_TextLanguageMode`]
    `editorAlwaysShow`*: bool
    `defaultOverride`*: Option[JsonNode]
    `autoChainRef`*: bool
    `editorDisplayPos`*: `LdtkLdtkFieldDef_EditorDisplayPos`
    `editorDisplayMode`*: `LdtkLdtkFieldDef_EditorDisplayMode`
    `identifier`*: string
    `regex`*: Option[string]
    `isArray`*: bool
    `editorLinkStyle`*: `LdtkLdtkFieldDef_EditorLinkStyle`
    `allowedRefs`*: `LdtkLdtkFieldDef_AllowedRefs`
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
  `LdtkLayerDef`* = object
    `type`*: `LdtkLdtkLayerDef_Type`
    `autoTilesetDefUid`*: Option[BiggestInt]
    `parallaxScaling`*: bool
    `biomeFieldUid`*: Option[BiggestInt]
    `autoTilesKilledByOtherLayerUid`*: Option[BiggestInt]
    `inactiveOpacity`*: BiggestFloat
    `type`*: string
    `autoRuleGroups`*: seq[`LdtkAutoLayerRuleGroup`]
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
    `intGridValuesGroups`*: seq[`LdtkIntGridValueGroupDef`]
    `hideFieldsWhenInactive`*: bool
    `useAsyncRender`*: bool
    `pxOffsetY`*: BiggestInt
    `parallaxFactorY`*: BiggestFloat
    `intGridValues`*: seq[`LdtkIntGridValueDef`]
    `renderInWorldView`*: bool
  `LdtkLevel`* = object
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
    `neighbours`*: seq[`LdtkNeighbourLevel`]
    `uid`*: BiggestInt
    `bgPos`*: Option[`LdtkLdtkLevel_BgPos`]
    `layerInstances`*: Option[seq[`LdtkLayerInstance`]]
    `fieldInstances`*: seq[`LdtkFieldInstance`]
    `bgPos`*: Option[`LdtkLevelBgPosInfos`]
    `worldX`*: BiggestInt
    `iid`*: string
    `bgPivotY`*: BiggestFloat
    `smartColor`*: string
  `LdtkTocInstanceData`* = object
    `worldY`*: BiggestInt
    `fields`*: JsonNode
    `widPx`*: BiggestInt
    `iids`*: `LdtkEntityReferenceInfos`
    `heiPx`*: BiggestInt
    `worldX`*: BiggestInt
  `LdtkAutoRuleDef`* = object
    `checker`*: `LdtkLdtkAutoRuleDef_Checker`
    `pivotY`*: BiggestFloat
    `breakOnMatch`*: bool
    `perlinOctaves`*: BiggestFloat
    `yModulo`*: BiggestInt
    `size`*: BiggestInt
    `tileMode`*: `LdtkLdtkAutoRuleDef_TileMode`
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
  `LdtkTileCustomMetadata`* = object
    `data`*: string
    `tileId`*: BiggestInt
  `LdtkEnumDef`* = object
    `values`*: seq[`LdtkEnumDefValues`]
    `externalRelPath`*: Option[string]
    `identifier`*: string
    `externalFileChecksum`*: Option[string]
    `iconTilesetUid`*: Option[BiggestInt]
    `uid`*: BiggestInt
    `tags`*: seq[string]
  `LdtkLdtkLdtkJsonRoot_WorldLayout`* = enum
    LinearHorizontal, LinearVertical, GridVania, Free
  `LdtkAutoLayerRuleGroup`* = object
    `isOptional`*: bool
    `color`*: Option[string]
    `collapsed`*: Option[bool]
    `usesWizard`*: bool
    `biomeRequirementMode`*: BiggestInt
    `rules`*: seq[`LdtkAutoRuleDef`]
    `icon`*: Option[`LdtkTilesetRect`]
    `active`*: bool
    `uid`*: BiggestInt
    `name`*: string
    `requiredBiomeValues`*: seq[string]
  `LdtkIntGridValueInstance`* = object
    `coordId`*: BiggestInt
    `v`*: BiggestInt
  `LdtkLdtkFieldDef_AllowedRefs`* = enum
    Any, OnlyTags, OnlySame, OnlySpecificEntity
  `LdtkLdtkCustomCommand_When`* = enum
    AfterLoad, BeforeSave, AfterSave, Manual
  `LdtkEnumTagValue`* = object
    `tileIds`*: seq[BiggestInt]
    `enumValueId`*: string
  `LdtkEntityDef`* = object
    `allowOutOfBounds`*: bool
    `pivotY`*: BiggestFloat
    `tileOpacity`*: BiggestFloat
    `color`*: string
    `limitScope`*: `LdtkLdtkEntityDef_LimitScope`
    `limitBehavior`*: `LdtkLdtkEntityDef_LimitBehavior`
    `hollow`*: bool
    `height`*: BiggestInt
    `renderMode`*: `LdtkLdtkEntityDef_RenderMode`
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
    `fieldDefs`*: seq[`LdtkFieldDef`]
    `uid`*: BiggestInt
    `tileRenderMode`*: `LdtkLdtkEntityDef_TileRenderMode`
    `uiTileRect`*: Option[`LdtkTilesetRect`]
    `resizableY`*: bool
    `lineOpacity`*: BiggestFloat
    `minHeight`*: Option[BiggestInt]
    `tileRect`*: Option[`LdtkTilesetRect`]
    `nineSliceBorders`*: seq[BiggestInt]
    `maxWidth`*: Option[BiggestInt]
    `width`*: BiggestInt
    `tags`*: seq[string]
    `maxHeight`*: Option[BiggestInt]
    `exportToToc`*: bool
    `fillOpacity`*: BiggestFloat
  `LdtkLdtkAutoRuleDef_TileMode`* = enum
    Single, Stamp
  `LdtkLdtkEntityDef_LimitScope`* = enum
    PerLayer, PerWorld, PerLevel
  `LdtkLdtkLdtkJsonRoot_ImageExportMode`* = enum
    LayersAndLevels, OneImagePerLayer, None, OneImagePerLevel
  `LdtkLdtkTilesetDef_EmbedAtlas`* = enum
    LdtkIcons
  `LdtkLdtkLayerDef_Type`* = enum
    Tiles, Entities, AutoLayer, IntGrid
  `LdtkEntityReferenceInfos`* = object
    `layerIid`*: string
    `levelIid`*: string
    `entityIid`*: string
    `worldIid`*: string
  `LdtkLdtkFieldDef_EditorDisplayPos`* = enum
    Beneath, Above, Center
  `LdtkLdtkFieldDef_EditorLinkStyle`* = enum
    DashedLine, CurvedArrow, ArrowsLine, ZigZag, StraightArrow
  `LdtkTilesetDef`* = object
    `pxHei`*: BiggestInt
    `savedSelections`*: seq[Table[string, JsonNode]]
    `padding`*: BiggestInt
    `spacing`*: BiggestInt
    `tagsSourceEnumUid`*: Option[BiggestInt]
    `embedAtlas`*: Option[`LdtkLdtkTilesetDef_EmbedAtlas`]
    `identifier`*: string
    `cachedPixelData`*: Option[Table[string, JsonNode]]
    `enumTags`*: seq[`LdtkEnumTagValue`]
    `pxWid`*: BiggestInt
    `tileGridSize`*: BiggestInt
    `customData`*: seq[`LdtkTileCustomMetadata`]
    `uid`*: BiggestInt
    `cHei`*: BiggestInt
    `cWid`*: BiggestInt
    `relPath`*: Option[string]
    `tags`*: seq[string]
  `LdtkEnumDefValues`* = object
    `tileSrcRect`*: Option[seq[BiggestInt]]
    `color`*: BiggestInt
    `id`*: string
    `tileId`*: Option[BiggestInt]
    `tileRect`*: Option[`LdtkTilesetRect`]
  `LdtkFieldInstance`* = object
    `realEditorValues`*: seq[JsonNode]
    `value`*: JsonNode
    `tile`*: Option[`LdtkTilesetRect`]
    `type`*: string
    `identifier`*: string
    `defUid`*: BiggestInt
  `LdtkLdtkEntityDef_RenderMode`* = enum
    Tile, Cross, Ellipse, Rectangle
  `LdtkTableOfContentEntry`* = object
    `instancesData`*: seq[`LdtkTocInstanceData`]
    `identifier`*: string
    `instances`*: Option[seq[`LdtkEntityReferenceInfos`]]
  `LdtkLdtkEntityDef_LimitBehavior`* = enum
    PreventAdding, MoveLastOne, DiscardOldOnes
  `LdtkLdtkLdtkJsonRoot_IdentifierStyle`* = enum
    Lowercase, Free, Capitalize, Uppercase
  `LdtkLdtkFieldDef_EditorDisplayMode`* = enum
    PointPath, PointStar, ValueOnly, Hidden, Points, NameAndValue,
    ArrayCountNoLabel, EntityTile, PointPathLoop, RadiusPx, LevelTile,
    RadiusGrid, RefLinkBetweenCenters, RefLinkBetweenPivots, ArrayCountWithLabel
  `LdtkTile`* = object
    `px`*: seq[BiggestInt]
    `t`*: BiggestInt
    `d`*: seq[BiggestInt]
    `a`*: BiggestFloat
    `src`*: seq[BiggestInt]
    `f`*: BiggestInt
  `LdtkEntityInstance`* = object
    `worldY`*: Option[BiggestInt]
    `tile`*: Option[`LdtkTilesetRect`]
    `identifier`*: string
    `tags`*: seq[string]
    `height`*: BiggestInt
    `px`*: seq[BiggestInt]
    `defUid`*: BiggestInt
    `pivot`*: seq[BiggestFloat]
    `fieldInstances`*: seq[`LdtkFieldInstance`]
    `iid`*: string
    `width`*: BiggestInt
    `worldX`*: Option[BiggestInt]
    `grid`*: seq[BiggestInt]
    `smartColor`*: string
  `LdtkTilesetRect`* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  `LdtkDefinitions`* = object
    `levelFields`*: seq[`LdtkFieldDef`]
    `tilesets`*: seq[`LdtkTilesetDef`]
    `entities`*: seq[`LdtkEntityDef`]
    `enums`*: seq[`LdtkEnumDef`]
    `layers`*: seq[`LdtkLayerDef`]
    `externalEnums`*: seq[`LdtkEnumDef`]
  `LdtkLdtkLdtkJsonRoot_Flags`* = enum
    ExportPreCsvIntGridFormat, DiscardPreCsvIntGrid,
    ExportOldTableOfContentData, PrependIndexToLevelFileNames, MultiWorlds,
    UseMultilinesType, IgnoreBackupSuggest
  `LdtkLdtkLevel_BgPos`* = enum
    CoverDirty, Repeat, Contain, Cover, Unscaled
  `LdtkLdtkLdtkJsonRoot_FORCED_REFS`* = object
    `CustomCommand`*: Option[`LdtkCustomCommand`]
    `IntGridValueDef`*: Option[`LdtkIntGridValueDef`]
    `Level`*: Option[`LdtkLevel`]
    `Definitions`*: Option[`LdtkDefinitions`]
    `EnumDef`*: Option[`LdtkEnumDef`]
    `FieldDef`*: Option[`LdtkFieldDef`]
    `AutoLayerRuleGroup`*: Option[`LdtkAutoLayerRuleGroup`]
    `TilesetDef`*: Option[`LdtkTilesetDef`]
    `TableOfContentEntry`*: Option[`LdtkTableOfContentEntry`]
    `EntityDef`*: Option[`LdtkEntityDef`]
    `FieldInstance`*: Option[`LdtkFieldInstance`]
    `EntityReferenceInfos`*: Option[`LdtkEntityReferenceInfos`]
    `LevelBgPosInfos`*: Option[`LdtkLevelBgPosInfos`]
    `TileCustomMetadata`*: Option[`LdtkTileCustomMetadata`]
    `Tile`*: Option[`LdtkTile`]
    `AutoRuleDef`*: Option[`LdtkAutoRuleDef`]
    `NeighbourLevel`*: Option[`LdtkNeighbourLevel`]
    `GridPoint`*: Option[`LdtkGridPoint`]
    `EntityInstance`*: Option[`LdtkEntityInstance`]
    `TilesetRect`*: Option[`LdtkTilesetRect`]
    `EnumTagValue`*: Option[`LdtkEnumTagValue`]
    `LayerInstance`*: Option[`LdtkLayerInstance`]
    `IntGridValueInstance`*: Option[`LdtkIntGridValueInstance`]
    `World`*: Option[`LdtkWorld`]
    `LayerDef`*: Option[`LdtkLayerDef`]
    `IntGridValueGroupDef`*: Option[`LdtkIntGridValueGroupDef`]
    `TocInstanceData`*: Option[`LdtkTocInstanceData`]
    `EnumDefValues`*: Option[`LdtkEnumDefValues`]
  `LdtkIntGridValueGroupDef`* = object
    `color`*: Option[string]
    `identifier`*: Option[string]
    `uid`*: BiggestInt
  `LdtkIntGridValueDef`* = object
    `tile`*: Option[`LdtkTilesetRect`]
    `color`*: string
    `identifier`*: Option[string]
    `groupUid`*: BiggestInt
    `value`*: BiggestInt
  `LdtkLdtkEntityDef_TileRenderMode`* = enum
    FullSizeCropped, FullSizeUncropped, Repeat, FitInside, NineSlice, Cover,
    Stretch
  `LdtkLdtkAutoRuleDef_Checker`* = enum
    Horizontal, Vertical, None
  `LdtkLevelBgPosInfos`* = object
    `scale`*: seq[BiggestFloat]
    `cropRect`*: seq[BiggestFloat]
    `topLeftPx`*: seq[BiggestInt]
  `LdtkGridPoint`* = object
    `cx`*: BiggestInt
    `cy`*: BiggestInt
  `LdtkLayerInstance`* = object
    `opacity`*: BiggestFloat
    `optionalRules`*: seq[BiggestInt]
    `gridSize`*: BiggestInt
    `pxTotalOffsetX`*: BiggestInt
    `gridTiles`*: seq[`LdtkTile`]
    `type`*: string
    `identifier`*: string
    `overrideTilesetUid`*: Option[BiggestInt]
    `levelId`*: BiggestInt
    `intGrid`*: Option[seq[`LdtkIntGridValueInstance`]]
    `autoLayerTiles`*: seq[`LdtkTile`]
    `layerDefUid`*: BiggestInt
    `entityInstances`*: seq[`LdtkEntityInstance`]
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
  `LdtkLdtkFieldDef_TextLanguageMode`* = enum
    LangMarkdown, LangPython, LangLog, LangC, LangLua, LangHaxe, LangJS,
    LangRuby, LangJson, LangXml
  `LdtkWorld`* = object
    `worldGridWidth`*: BiggestInt
    `defaultLevelHeight`*: BiggestInt
    `identifier`*: string
    `worldLayout`*: Option[`LdtkLdtkWorld_WorldLayout`]
    `iid`*: string
    `defaultLevelWidth`*: BiggestInt
    `worldGridHeight`*: BiggestInt
    `levels`*: seq[`LdtkLevel`]