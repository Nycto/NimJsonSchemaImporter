import std/[json, tables, options]
type
  `LdtkLdtkEnumDefValues_TileIdUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkFieldDef_EditorTextPrefixUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkLdtkLdtkJsonRoot_PngFilePatternUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkTocInstanceData`* = object
    `worldY`*: BiggestInt
    `fields`*: JsonNode
    `widPx`*: BiggestInt
    `iids`*: `LdtkEntityReferenceInfos`
    `heiPx`*: BiggestInt
    `worldX`*: BiggestInt
  `LdtkEnumDef`* = object
    `values`*: seq[`LdtkEnumDefValues`]
    `externalRelPath`*: Option[`LdtkLdtkEnumDef_ExternalRelPathUnion`]
    `identifier`*: string
    `externalFileChecksum`*: Option[`LdtkLdtkEnumDef_ExternalFileChecksumUnion`]
    `iconTilesetUid`*: Option[`LdtkLdtkEnumDef_IconTilesetUidUnion`]
    `uid`*: BiggestInt
    `tags`*: seq[string]
  `LdtkLdtkLdtkJsonRoot_WorldLayout`* = enum
    LinearHorizontal, LinearVertical, GridVania, Free
  `LdtkLayerInstance`* = object
    `opacity`*: BiggestFloat
    `optionalRules`*: seq[BiggestInt]
    `gridSize`*: BiggestInt
    `pxTotalOffsetX`*: BiggestInt
    `gridTiles`*: seq[`LdtkTile`]
    `type`*: string
    `identifier`*: string
    `overrideTilesetUid`*: Option[`LdtkLdtkLayerInstance_OverrideTilesetUidUnion`]
    `levelId`*: BiggestInt
    `intGrid`*: Option[seq[`LdtkIntGridValueInstance`]]
    `autoLayerTiles`*: seq[`LdtkTile`]
    `layerDefUid`*: BiggestInt
    `entityInstances`*: seq[`LdtkEntityInstance`]
    `intGridCsv`*: seq[BiggestInt]
    `pxOffsetX`*: BiggestInt
    `tilesetRelPath`*: Option[`LdtkLdtkLayerInstance_TilesetRelPathUnion`]
    `tilesetDefUid`*: Option[`LdtkLdtkLayerInstance_TilesetDefUidUnion`]
    `cHei`*: BiggestInt
    `seed`*: BiggestInt
    `visible`*: bool
    `pxOffsetY`*: BiggestInt
    `iid`*: string
    `pxTotalOffsetY`*: BiggestInt
    `cWid`*: BiggestInt
  `LdtkLdtkEntityInstance_TileUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: `LdtkTilesetRect`
  `LdtkLdtkFieldInstance_TileUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: `LdtkTilesetRect`
  `LdtkNeighbourLevel`* = object
    `levelUid`*: Option[`LdtkLdtkNeighbourLevel_LevelUidUnion`]
    `levelIid`*: string
    `dir`*: string
  `LdtkFieldInstance`* = object
    `realEditorValues`*: seq[JsonNode]
    `value`*: JsonNode
    `tile`*: Option[`LdtkLdtkFieldInstance_TileUnion`]
    `type`*: string
    `identifier`*: string
    `defUid`*: BiggestInt
  `LdtkLdtkLevel_BgPosUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: `LdtkLevelBgPosInfos`
  `LdtkLdtkAutoRuleDef_TileMode`* = enum
    Single, Stamp
  `LdtkLdtkEnumDef_ExternalRelPathUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkLdtkLevel_BgColorUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkLdtkAutoLayerRuleGroup_CollapsedUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: bool
    of 1:
      key1: pointer
  `LdtkLdtkEntityDef_MinHeightUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkLayerDef_BiomeFieldUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkEntityDef_TileRectUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: `LdtkTilesetRect`
  `LdtkLdtkAutoLayerRuleGroup_IconUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: `LdtkTilesetRect`
  `LdtkLdtkLdtkJsonRoot_ImageExportMode`* = enum
    LayersAndLevels, OneImagePerLayer, None, OneImagePerLevel
  `LdtkLdtkEntityDef_TilesetIdUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkLayerInstance_TilesetRelPathUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkLdtkTilesetDef_EmbedAtlas`* = enum
    LdtkIcons
  `LdtkLdtkLayerDef_Type`* = enum
    Tiles, Entities, AutoLayer, IntGrid
  `LdtkEntityReferenceInfos`* = object
    `layerIid`*: string
    `levelIid`*: string
    `entityIid`*: string
    `worldIid`*: string
  `LdtkIntGridValueDef`* = object
    `tile`*: Option[`LdtkLdtkIntGridValueDef_TileUnion`]
    `color`*: string
    `identifier`*: Option[`LdtkLdtkIntGridValueDef_IdentifierUnion`]
    `groupUid`*: BiggestInt
    `value`*: BiggestInt
  `LdtkLdtkFieldDef_MaxUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  `LdtkLdtkFieldDef_EditorDisplayPos`* = enum
    Beneath, Above, Center
  `LdtkLdtkLayerDef_UiColorUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkLdtkEnumDef_ExternalFileChecksumUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkLdtkJsonRoot`* = object
    `backupLimit`*: BiggestInt
    `simplifiedExport`*: bool
    `externalLevels`*: bool
    `backupRelPath`*: Option[`LdtkLdtkLdtkJsonRoot_BackupRelPathUnion`]
    `jsonVersion`*: string
    `bgColor`*: string
    `appBuildId`*: BiggestFloat
    `defaultEntityHeight`*: BiggestInt
    `pngFilePattern`*: Option[`LdtkLdtkLdtkJsonRoot_PngFilePatternUnion`]
    `customCommands`*: seq[`LdtkCustomCommand`]
    `exportTiled`*: bool
    `exportPng`*: Option[`LdtkLdtkLdtkJsonRoot_ExportPngUnion`]
    `worldGridWidth`*: Option[`LdtkLdtkLdtkJsonRoot_WorldGridWidthUnion`]
    `defaultLevelHeight`*: Option[`LdtkLdtkLdtkJsonRoot_DefaultLevelHeightUnion`]
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
    `tutorialDesc`*: Option[`LdtkLdtkLdtkJsonRoot_TutorialDescUnion`]
    `worldLayout`*: Option[Option[`LdtkLdtkLdtkJsonRoot_WorldLayout`]]
    `defaultEntityWidth`*: BiggestInt
    `iid`*: string
    `defaultGridSize`*: BiggestInt
    `defaultLevelWidth`*: Option[`LdtkLdtkLdtkJsonRoot_DefaultLevelWidthUnion`]
    `minifyJson`*: bool
    `backupOnSave`*: bool
    `flags`*: seq[`LdtkLdtkLdtkJsonRoot_Flags`]
    `defaultLevelBgColor`*: string
    `identifierStyle`*: `LdtkLdtkLdtkJsonRoot_IdentifierStyle`
    `worldGridHeight`*: Option[`LdtkLdtkLdtkJsonRoot_WorldGridHeightUnion`]
    `levels`*: seq[`LdtkLevel`]
  `LdtkLdtkLayerDef_TilesetDefUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkLdtkJsonRoot_DefaultLevelHeightUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkLayerDef_DocUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkLdtkEntityDef_LimitBehavior`* = enum
    PreventAdding, MoveLastOne, DiscardOldOnes
  `LdtkLdtkTilesetDef_TagsSourceEnumUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkEnumDef_IconTilesetUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkFieldDef_ArrayMinLengthUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkFieldDef_MinUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
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
  `LdtkLdtkEntityDef_MaxWidthUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkLevel_BgPos`* = enum
    CoverDirty, Repeat, Contain, Cover, Unscaled
  `LdtkLdtkTilesetDef_RelPathUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkTilesetDef`* = object
    `pxHei`*: BiggestInt
    `savedSelections`*: seq[Table[string, JsonNode]]
    `padding`*: BiggestInt
    `spacing`*: BiggestInt
    `tagsSourceEnumUid`*: Option[`LdtkLdtkTilesetDef_TagsSourceEnumUidUnion`]
    `embedAtlas`*: Option[Option[`LdtkLdtkTilesetDef_EmbedAtlas`]]
    `identifier`*: string
    `cachedPixelData`*: Option[`LdtkLdtkTilesetDef_CachedPixelDataUnion`]
    `enumTags`*: seq[`LdtkEnumTagValue`]
    `pxWid`*: BiggestInt
    `tileGridSize`*: BiggestInt
    `customData`*: seq[`LdtkTileCustomMetadata`]
    `uid`*: BiggestInt
    `cHei`*: BiggestInt
    `cWid`*: BiggestInt
    `relPath`*: Option[`LdtkLdtkTilesetDef_RelPathUnion`]
    `tags`*: seq[string]
  `LdtkLdtkLdtkJsonRoot_WorldGridWidthUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkFieldDef_TextLanguageMode`* = enum
    LangMarkdown, LangPython, LangLog, LangC, LangLua, LangHaxe, LangJS,
    LangRuby, LangJson, LangXml
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
    `outOfBoundsValue`*: Option[`LdtkLdtkAutoRuleDef_OutOfBoundsValueUnion`]
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
  `LdtkWorld`* = object
    `worldGridWidth`*: BiggestInt
    `defaultLevelHeight`*: BiggestInt
    `identifier`*: string
    `worldLayout`*: Option[`LdtkLdtkWorld_WorldLayout`]
    `iid`*: string
    `defaultLevelWidth`*: BiggestInt
    `worldGridHeight`*: BiggestInt
    `levels`*: seq[`LdtkLevel`]
  `LdtkLdtkIntGridValueDef_IdentifierUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkLdtkFieldDef_EditorTextSuffixUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkEnumDefValues`* = object
    `tileSrcRect`*: Option[seq[BiggestInt]]
    `color`*: BiggestInt
    `id`*: string
    `tileId`*: Option[`LdtkLdtkEnumDefValues_TileIdUnion`]
    `tileRect`*: Option[`LdtkLdtkEnumDefValues_TileRectUnion`]
  `LdtkIntGridValueGroupDef`* = object
    `color`*: Option[`LdtkLdtkIntGridValueGroupDef_ColorUnion`]
    `identifier`*: Option[`LdtkLdtkIntGridValueGroupDef_IdentifierUnion`]
    `uid`*: BiggestInt
  `LdtkLdtkWorld_WorldLayout`* = enum
    LinearHorizontal, LinearVertical, GridVania, Free
  `LdtkCustomCommand`* = object
    `command`*: string
    `when`*: `LdtkLdtkCustomCommand_When`
  `LdtkLdtkLdtkJsonRoot_TutorialDescUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkLdtkLdtkJsonRoot_DefaultLevelWidthUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkEntityInstance_WorldXUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkAutoLayerRuleGroup`* = object
    `isOptional`*: bool
    `color`*: Option[`LdtkLdtkAutoLayerRuleGroup_ColorUnion`]
    `collapsed`*: Option[`LdtkLdtkAutoLayerRuleGroup_CollapsedUnion`]
    `usesWizard`*: bool
    `biomeRequirementMode`*: BiggestInt
    `rules`*: seq[`LdtkAutoRuleDef`]
    `icon`*: Option[`LdtkLdtkAutoLayerRuleGroup_IconUnion`]
    `active`*: bool
    `uid`*: BiggestInt
    `name`*: string
    `requiredBiomeValues`*: seq[string]
  `LdtkLdtkLdtkJsonRoot_ExportPngUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: bool
    of 1:
      key1: pointer
  `LdtkLdtkFieldDef_DocUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkLdtkNeighbourLevel_LevelUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkFieldDef_EditorDisplayColorUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkTileCustomMetadata`* = object
    `data`*: string
    `tileId`*: BiggestInt
  `LdtkLdtkEntityDef_MaxHeightUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkIntGridValueInstance`* = object
    `coordId`*: BiggestInt
    `v`*: BiggestInt
  `LdtkLdtkFieldDef_TilesetUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkLayerInstance_TilesetDefUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkCustomCommand_When`* = enum
    AfterLoad, BeforeSave, AfterSave, Manual
  `LdtkLdtkFieldDef_AllowedRefs`* = enum
    Any, OnlyTags, OnlySame, OnlySpecificEntity
  `LdtkEnumTagValue`* = object
    `tileIds`*: seq[BiggestInt]
    `enumValueId`*: string
  `LdtkLdtkIntGridValueGroupDef_ColorUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkLdtkEntityInstance_WorldYUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkEntityDef_UiTileRectUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: `LdtkTilesetRect`
  `LdtkLdtkEnumDefValues_TileRectUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: `LdtkTilesetRect`
  `LdtkLevel`* = object
    `pxHei`*: BiggestInt
    `useAutoIdentifier`*: bool
    `bgColor`*: string
    `bgColor`*: Option[`LdtkLdtkLevel_BgColorUnion`]
    `externalRelPath`*: Option[`LdtkLdtkLevel_ExternalRelPathUnion`]
    `worldY`*: BiggestInt
    `bgRelPath`*: Option[`LdtkLdtkLevel_BgRelPathUnion`]
    `identifier`*: string
    `pxWid`*: BiggestInt
    `worldDepth`*: BiggestInt
    `bgPivotX`*: BiggestFloat
    `neighbours`*: seq[`LdtkNeighbourLevel`]
    `uid`*: BiggestInt
    `bgPos`*: Option[Option[`LdtkLdtkLevel_BgPos`]]
    `layerInstances`*: Option[seq[`LdtkLayerInstance`]]
    `fieldInstances`*: seq[`LdtkFieldInstance`]
    `bgPos`*: Option[`LdtkLdtkLevel_BgPosUnion`]
    `worldX`*: BiggestInt
    `iid`*: string
    `bgPivotY`*: BiggestFloat
    `smartColor`*: string
  `LdtkLdtkEntityDef_LimitScope`* = enum
    PerLayer, PerWorld, PerLevel
  `LdtkLayerDef`* = object
    `type`*: `LdtkLdtkLayerDef_Type`
    `autoTilesetDefUid`*: Option[`LdtkLdtkLayerDef_AutoTilesetDefUidUnion`]
    `parallaxScaling`*: bool
    `biomeFieldUid`*: Option[`LdtkLdtkLayerDef_BiomeFieldUidUnion`]
    `autoTilesKilledByOtherLayerUid`*: Option[
        `LdtkLdtkLayerDef_AutoTilesKilledByOtherLayerUidUnion`]
    `inactiveOpacity`*: BiggestFloat
    `type`*: string
    `autoRuleGroups`*: seq[`LdtkAutoLayerRuleGroup`]
    `gridSize`*: BiggestInt
    `hideInList`*: bool
    `tilesetDefUid`*: Option[`LdtkLdtkLayerDef_TilesetDefUidUnion`]
    `uiColor`*: Option[`LdtkLdtkLayerDef_UiColorUnion`]
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
    `doc`*: Option[`LdtkLdtkLayerDef_DocUnion`]
    `uid`*: BiggestInt
    `guideGridHei`*: BiggestInt
    `autoSourceLayerDefUid`*: Option[`LdtkLdtkLayerDef_AutoSourceLayerDefUidUnion`]
    `displayOpacity`*: BiggestFloat
    `intGridValuesGroups`*: seq[`LdtkIntGridValueGroupDef`]
    `hideFieldsWhenInactive`*: bool
    `useAsyncRender`*: bool
    `pxOffsetY`*: BiggestInt
    `parallaxFactorY`*: BiggestFloat
    `intGridValues`*: seq[`LdtkIntGridValueDef`]
    `renderInWorldView`*: bool
  `LdtkLdtkAutoRuleDef_OutOfBoundsValueUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkLayerDef_AutoTilesetDefUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkLevel_ExternalRelPathUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkLdtkIntGridValueDef_TileUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: `LdtkTilesetRect`
  `LdtkLdtkTilesetDef_CachedPixelDataUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: Table[string, JsonNode]
    of 1:
      key1: pointer
  `LdtkLdtkFieldDef_AllowedRefsEntityUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkFieldDef_EditorLinkStyle`* = enum
    DashedLine, CurvedArrow, ArrowsLine, ZigZag, StraightArrow
  `LdtkLdtkEntityDef_MinWidthUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkIntGridValueGroupDef_IdentifierUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkLdtkEntityDef_DocUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkLdtkEntityDef_RenderMode`* = enum
    Tile, Cross, Ellipse, Rectangle
  `LdtkTableOfContentEntry`* = object
    `instancesData`*: seq[`LdtkTocInstanceData`]
    `identifier`*: string
    `instances`*: Option[seq[`LdtkEntityReferenceInfos`]]
  `LdtkEntityInstance`* = object
    `worldY`*: Option[`LdtkLdtkEntityInstance_WorldYUnion`]
    `tile`*: Option[`LdtkLdtkEntityInstance_TileUnion`]
    `identifier`*: string
    `tags`*: seq[string]
    `height`*: BiggestInt
    `px`*: seq[BiggestInt]
    `defUid`*: BiggestInt
    `pivot`*: seq[BiggestFloat]
    `fieldInstances`*: seq[`LdtkFieldInstance`]
    `iid`*: string
    `width`*: BiggestInt
    `worldX`*: Option[`LdtkLdtkEntityInstance_WorldXUnion`]
    `grid`*: seq[BiggestInt]
    `smartColor`*: string
  `LdtkLdtkLayerDef_AutoTilesKilledByOtherLayerUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkLdtkJsonRoot_IdentifierStyle`* = enum
    Lowercase, Free, Capitalize, Uppercase
  `LdtkLdtkFieldDef_ArrayMaxLengthUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkLdtkJsonRoot_BackupRelPathUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkTile`* = object
    `px`*: seq[BiggestInt]
    `t`*: BiggestInt
    `d`*: seq[BiggestInt]
    `a`*: BiggestFloat
    `src`*: seq[BiggestInt]
    `f`*: BiggestInt
  `LdtkLdtkFieldDef_EditorDisplayMode`* = enum
    PointPath, PointStar, ValueOnly, Hidden, Points, NameAndValue,
    ArrayCountNoLabel, EntityTile, PointPathLoop, RadiusPx, LevelTile,
    RadiusGrid, RefLinkBetweenCenters, RefLinkBetweenPivots, ArrayCountWithLabel
  `LdtkLdtkAutoLayerRuleGroup_ColorUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
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
  `LdtkLdtkEntityDef_TileRenderMode`* = enum
    FullSizeCropped, FullSizeUncropped, Repeat, FitInside, NineSlice, Cover,
    Stretch
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
    `tilesetId`*: Option[`LdtkLdtkEntityDef_TilesetIdUnion`]
    `keepAspectRatio`*: bool
    `minWidth`*: Option[`LdtkLdtkEntityDef_MinWidthUnion`]
    `showName`*: bool
    `resizableX`*: bool
    `identifier`*: string
    `maxCount`*: BiggestInt
    `tileId`*: Option[`LdtkLdtkEntityDef_TileIdUnion`]
    `pivotX`*: BiggestFloat
    `doc`*: Option[`LdtkLdtkEntityDef_DocUnion`]
    `fieldDefs`*: seq[`LdtkFieldDef`]
    `uid`*: BiggestInt
    `tileRenderMode`*: `LdtkLdtkEntityDef_TileRenderMode`
    `uiTileRect`*: Option[`LdtkLdtkEntityDef_UiTileRectUnion`]
    `resizableY`*: bool
    `lineOpacity`*: BiggestFloat
    `minHeight`*: Option[`LdtkLdtkEntityDef_MinHeightUnion`]
    `tileRect`*: Option[`LdtkLdtkEntityDef_TileRectUnion`]
    `nineSliceBorders`*: seq[BiggestInt]
    `maxWidth`*: Option[`LdtkLdtkEntityDef_MaxWidthUnion`]
    `width`*: BiggestInt
    `tags`*: seq[string]
    `maxHeight`*: Option[`LdtkLdtkEntityDef_MaxHeightUnion`]
    `exportToToc`*: bool
    `fillOpacity`*: BiggestFloat
  `LdtkLdtkAutoRuleDef_Checker`* = enum
    Horizontal, Vertical, None
  `LdtkLevelBgPosInfos`* = object
    `scale`*: seq[BiggestFloat]
    `cropRect`*: seq[BiggestFloat]
    `topLeftPx`*: seq[BiggestInt]
  `LdtkGridPoint`* = object
    `cx`*: BiggestInt
    `cy`*: BiggestInt
  `LdtkFieldDef`* = object
    `type`*: string
    `editorDisplayScale`*: BiggestFloat
    `type`*: string
    `allowedRefsEntityUid`*: Option[`LdtkLdtkFieldDef_AllowedRefsEntityUidUnion`]
    `textLanguageMode`*: Option[Option[`LdtkLdtkFieldDef_TextLanguageMode`]]
    `editorAlwaysShow`*: bool
    `defaultOverride`*: Option[JsonNode]
    `autoChainRef`*: bool
    `editorDisplayPos`*: `LdtkLdtkFieldDef_EditorDisplayPos`
    `editorDisplayMode`*: `LdtkLdtkFieldDef_EditorDisplayMode`
    `identifier`*: string
    `regex`*: Option[`LdtkLdtkFieldDef_RegexUnion`]
    `isArray`*: bool
    `editorLinkStyle`*: `LdtkLdtkFieldDef_EditorLinkStyle`
    `allowedRefs`*: `LdtkLdtkFieldDef_AllowedRefs`
    `useForSmartColor`*: bool
    `editorTextSuffix`*: Option[`LdtkLdtkFieldDef_EditorTextSuffixUnion`]
    `doc`*: Option[`LdtkLdtkFieldDef_DocUnion`]
    `editorTextPrefix`*: Option[`LdtkLdtkFieldDef_EditorTextPrefixUnion`]
    `editorCutLongValues`*: bool
    `canBeNull`*: bool
    `allowedRefTags`*: seq[string]
    `uid`*: BiggestInt
    `symmetricalRef`*: bool
    `editorDisplayColor`*: Option[`LdtkLdtkFieldDef_EditorDisplayColorUnion`]
    `allowOutOfLevelRef`*: bool
    `acceptFileTypes`*: Option[seq[string]]
    `editorShowInWorld`*: bool
    `tilesetUid`*: Option[`LdtkLdtkFieldDef_TilesetUidUnion`]
    `arrayMaxLength`*: Option[`LdtkLdtkFieldDef_ArrayMaxLengthUnion`]
    `arrayMinLength`*: Option[`LdtkLdtkFieldDef_ArrayMinLengthUnion`]
    `searchable`*: bool
    `min`*: Option[`LdtkLdtkFieldDef_MinUnion`]
    `exportToToc`*: bool
    `max`*: Option[`LdtkLdtkFieldDef_MaxUnion`]
  `LdtkLdtkLayerInstance_OverrideTilesetUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkEntityDef_TileIdUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkLdtkJsonRoot_WorldGridHeightUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkLevel_BgRelPathUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkLdtkLayerDef_AutoSourceLayerDefUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLdtkFieldDef_RegexUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer