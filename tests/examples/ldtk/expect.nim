import std/[json, tables, options]
type
  `TestTestLevel_BgPos`* = enum
    CoverDirty, Repeat, Contain, Cover, Unscaled
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
  `TestAutoRuleDef`* = object
    `checker`*: `TestTestAutoRuleDef_Checker`
    `pivotY`*: BiggestFloat
    `breakOnMatch`*: bool
    `perlinOctaves`*: BiggestFloat
    `yModulo`*: BiggestInt
    `size`*: BiggestInt
    `tileMode`*: `TestTestAutoRuleDef_TileMode`
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
  `TestTestFieldDef_EditorDisplayMode`* = enum
    PointPath, PointStar, ValueOnly, Hidden, Points, NameAndValue,
    ArrayCountNoLabel, EntityTile, PointPathLoop, RadiusPx, LevelTile,
    RadiusGrid, RefLinkBetweenCenters, RefLinkBetweenPivots, ArrayCountWithLabel
  `TestTestFieldDef_TextLanguageMode`* = enum
    LangMarkdown, LangPython, LangLog, LangC, LangLua, LangHaxe, LangJS,
    LangRuby, LangJson, LangXml
  `TestTileCustomMetadata`* = object
    `data`*: string
    `tileId`*: BiggestInt
  `TestTestLayerDef_Type`* = enum
    Tiles, Entities, AutoLayer, IntGrid
  `TestTestEntityDef_LimitScope`* = enum
    PerLayer, PerWorld, PerLevel
  `TestTestFieldDef_EditorDisplayPos`* = enum
    Beneath, Above, Center
  `TestTestAutoRuleDef_Checker`* = enum
    Horizontal, Vertical, None
  `TestTilesetRect`* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  `TestFieldDef`* = object
    `type`*: string
    `editorDisplayScale`*: BiggestFloat
    `type`*: string
    `allowedRefsEntityUid`*: Option[BiggestInt]
    `textLanguageMode`*: Option[`TestTestFieldDef_TextLanguageMode`]
    `editorAlwaysShow`*: bool
    `defaultOverride`*: Option[JsonNode]
    `autoChainRef`*: bool
    `editorDisplayPos`*: `TestTestFieldDef_EditorDisplayPos`
    `editorDisplayMode`*: `TestTestFieldDef_EditorDisplayMode`
    `identifier`*: string
    `regex`*: Option[string]
    `isArray`*: bool
    `editorLinkStyle`*: `TestTestFieldDef_EditorLinkStyle`
    `allowedRefs`*: `TestTestFieldDef_AllowedRefs`
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
  `TestTilesetDef`* = object
    `pxHei`*: BiggestInt
    `savedSelections`*: seq[Table[string, JsonNode]]
    `padding`*: BiggestInt
    `spacing`*: BiggestInt
    `tagsSourceEnumUid`*: Option[BiggestInt]
    `embedAtlas`*: Option[`TestTestTilesetDef_EmbedAtlas`]
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
    `bgPos`*: Option[`TestTestLevel_BgPos`]
    `layerInstances`*: Option[seq[`TestLayerInstance`]]
    `fieldInstances`*: seq[`TestFieldInstance`]
    `bgPos`*: Option[`TestLevelBgPosInfos`]
    `worldX`*: BiggestInt
    `iid`*: string
    `bgPivotY`*: BiggestFloat
    `smartColor`*: string
  `TestTestFieldDef_AllowedRefs`* = enum
    Any, OnlyTags, OnlySame, OnlySpecificEntity
  `TestNeighbourLevel`* = object
    `levelUid`*: Option[BiggestInt]
    `levelIid`*: string
    `dir`*: string
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
  `TestWorld`* = object
    `worldGridWidth`*: BiggestInt
    `defaultLevelHeight`*: BiggestInt
    `identifier`*: string
    `worldLayout`*: Option[`TestTestWorld_WorldLayout`]
    `iid`*: string
    `defaultLevelWidth`*: BiggestInt
    `worldGridHeight`*: BiggestInt
    `levels`*: seq[`TestLevel`]
  `TestTestFieldDef_EditorLinkStyle`* = enum
    DashedLine, CurvedArrow, ArrowsLine, ZigZag, StraightArrow
  `TestTestLdtkJsonRoot_Flags`* = enum
    ExportPreCsvIntGridFormat, DiscardPreCsvIntGrid,
    ExportOldTableOfContentData, PrependIndexToLevelFileNames, MultiWorlds,
    UseMultilinesType, IgnoreBackupSuggest
  `TestEntityReferenceInfos`* = object
    `layerIid`*: string
    `levelIid`*: string
    `entityIid`*: string
    `worldIid`*: string
  `TestIntGridValueInstance`* = object
    `coordId`*: BiggestInt
    `v`*: BiggestInt
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
    `imageExportMode`*: `TestTestLdtkJsonRoot_ImageExportMode`
    `dummyWorldIid`*: string
    `FORCED_REFS`*: Option[`TestTestLdtkJsonRoot_FORCED_REFS`]
    `defaultPivotY`*: BiggestFloat
    `exportLevelBg`*: bool
    `nextUid`*: BiggestInt
    `levelNamePattern`*: string
    `defs`*: `TestDefinitions`
    `defaultPivotX`*: BiggestFloat
    `tutorialDesc`*: Option[string]
    `worldLayout`*: Option[`TestTestLdtkJsonRoot_WorldLayout`]
    `defaultEntityWidth`*: BiggestInt
    `iid`*: string
    `defaultGridSize`*: BiggestInt
    `defaultLevelWidth`*: Option[BiggestInt]
    `minifyJson`*: bool
    `backupOnSave`*: bool
    `flags`*: seq[`TestTestLdtkJsonRoot_Flags`]
    `defaultLevelBgColor`*: string
    `identifierStyle`*: `TestTestLdtkJsonRoot_IdentifierStyle`
    `worldGridHeight`*: Option[BiggestInt]
    `levels`*: seq[`TestLevel`]
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
  `TestTestLdtkJsonRoot_IdentifierStyle`* = enum
    Lowercase, Free, Capitalize, Uppercase
  `TestEnumTagValue`* = object
    `tileIds`*: seq[BiggestInt]
    `enumValueId`*: string
  `TestTestCustomCommand_When`* = enum
    AfterLoad, BeforeSave, AfterSave, Manual
  `TestTableOfContentEntry`* = object
    `instancesData`*: seq[`TestTocInstanceData`]
    `identifier`*: string
    `instances`*: Option[seq[`TestEntityReferenceInfos`]]
  `TestTestLdtkJsonRoot_ImageExportMode`* = enum
    LayersAndLevels, OneImagePerLayer, None, OneImagePerLevel
  `TestTestLdtkJsonRoot_WorldLayout`* = enum
    LinearHorizontal, LinearVertical, GridVania, Free
  `TestLayerDef`* = object
    `type`*: `TestTestLayerDef_Type`
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
  `TestTestEntityDef_LimitBehavior`* = enum
    PreventAdding, MoveLastOne, DiscardOldOnes
  `TestTestTilesetDef_EmbedAtlas`* = enum
    LdtkIcons
  `TestTile`* = object
    `px`*: seq[BiggestInt]
    `t`*: BiggestInt
    `d`*: seq[BiggestInt]
    `a`*: BiggestFloat
    `src`*: seq[BiggestInt]
    `f`*: BiggestInt
  `TestEntityDef`* = object
    `allowOutOfBounds`*: bool
    `pivotY`*: BiggestFloat
    `tileOpacity`*: BiggestFloat
    `color`*: string
    `limitScope`*: `TestTestEntityDef_LimitScope`
    `limitBehavior`*: `TestTestEntityDef_LimitBehavior`
    `hollow`*: bool
    `height`*: BiggestInt
    `renderMode`*: `TestTestEntityDef_RenderMode`
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
    `tileRenderMode`*: `TestTestEntityDef_TileRenderMode`
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
  `TestCustomCommand`* = object
    `command`*: string
    `when`*: `TestTestCustomCommand_When`
  `TestTestEntityDef_TileRenderMode`* = enum
    FullSizeCropped, FullSizeUncropped, Repeat, FitInside, NineSlice, Cover,
    Stretch
  `TestTestAutoRuleDef_TileMode`* = enum
    Single, Stamp
  `TestTestEntityDef_RenderMode`* = enum
    Tile, Cross, Ellipse, Rectangle
  `TestTestWorld_WorldLayout`* = enum
    LinearHorizontal, LinearVertical, GridVania, Free
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
  `TestDefinitions`* = object
    `levelFields`*: seq[`TestFieldDef`]
    `tilesets`*: seq[`TestTilesetDef`]
    `entities`*: seq[`TestEntityDef`]
    `enums`*: seq[`TestEnumDef`]
    `layers`*: seq[`TestLayerDef`]
    `externalEnums`*: seq[`TestEnumDef`]
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