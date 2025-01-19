import std/[json, tables, options]
type
  `LdtkMinWidthUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkCollapsedUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: bool
    of 1:
      key1: pointer
  `LdtkTileMode`* = enum
    Single, Stamp
  `LdtkDocUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkRelPathUnion`* = object
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
  `LdtkWorldYUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkEditorDisplayColorUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkFlags`* = enum
    ExportPreCsvIntGridFormat, DiscardPreCsvIntGrid,
    ExportOldTableOfContentData, PrependIndexToLevelFileNames, MultiWorlds,
    UseMultilinesType, IgnoreBackupSuggest
  `LdtkDefaultLevelWidthUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkFieldInstance`* = object
    `realEditorValues`*: seq[JsonNode]
    `value`*: JsonNode
    `tile`*: Option[`LdtkTileUnion`]
    `type`*: string
    `identifier`*: string
    `defUid`*: BiggestInt
  `LdtkEditorTextSuffixUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkOutOfBoundsValueUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkAutoTilesetDefUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkIconUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: `LdtkTilesetRect`
  `LdtkEntityInstance`* = object
    `worldY`*: Option[`LdtkWorldYUnion`]
    `tile`*: Option[`LdtkTileUnion`]
    `identifier`*: string
    `tags`*: seq[string]
    `height`*: BiggestInt
    `px`*: seq[BiggestInt]
    `defUid`*: BiggestInt
    `pivot`*: seq[BiggestFloat]
    `fieldInstances`*: seq[`LdtkFieldInstance`]
    `iid`*: string
    `width`*: BiggestInt
    `worldX`*: Option[`LdtkWorldXUnion`]
    `grid`*: seq[BiggestInt]
    `smartColor`*: string
  `LdtkOverrideTilesetUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkChecker`* = enum
    Horizontal, Vertical, None
  `LdtkArrayMinLengthUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkPngFilePatternUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkEntityReferenceInfos`* = object
    `layerIid`*: string
    `levelIid`*: string
    `entityIid`*: string
    `worldIid`*: string
  `LdtkLimitBehavior`* = enum
    PreventAdding, MoveLastOne, DiscardOldOnes
  `LdtkLayerInstance`* = object
    `opacity`*: BiggestFloat
    `optionalRules`*: seq[BiggestInt]
    `gridSize`*: BiggestInt
    `pxTotalOffsetX`*: BiggestInt
    `gridTiles`*: seq[`LdtkTile`]
    `type`*: string
    `identifier`*: string
    `overrideTilesetUid`*: Option[`LdtkOverrideTilesetUidUnion`]
    `levelId`*: BiggestInt
    `intGrid`*: Option[seq[`LdtkIntGridValueInstance`]]
    `autoLayerTiles`*: seq[`LdtkTile`]
    `layerDefUid`*: BiggestInt
    `entityInstances`*: seq[`LdtkEntityInstance`]
    `intGridCsv`*: seq[BiggestInt]
    `pxOffsetX`*: BiggestInt
    `tilesetRelPath`*: Option[`LdtkTilesetRelPathUnion`]
    `tilesetDefUid`*: Option[`LdtkTilesetDefUidUnion`]
    `cHei`*: BiggestInt
    `seed`*: BiggestInt
    `visible`*: bool
    `pxOffsetY`*: BiggestInt
    `iid`*: string
    `pxTotalOffsetY`*: BiggestInt
    `cWid`*: BiggestInt
  `LdtkImageExportMode`* = enum
    LayersAndLevels, OneImagePerLayer, None, OneImagePerLevel
  `LdtkAllowedRefsEntityUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkCustomCommand`* = object
    `command`*: string
    `when`*: `LdtkWhen`
  `LdtkBgRelPathUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkTilesetUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkAutoLayerRuleGroup`* = object
    `isOptional`*: bool
    `color`*: Option[`LdtkColorUnion`]
    `collapsed`*: Option[`LdtkCollapsedUnion`]
    `usesWizard`*: bool
    `biomeRequirementMode`*: BiggestInt
    `rules`*: seq[`LdtkAutoRuleDef`]
    `icon`*: Option[`LdtkIconUnion`]
    `active`*: bool
    `uid`*: BiggestInt
    `name`*: string
    `requiredBiomeValues`*: seq[string]
  `LdtkExternalFileChecksumUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkUiTileRectUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: `LdtkTilesetRect`
  `LdtkTileIdUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkColorUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkTutorialDescUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkMaxWidthUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkDefinitions`* = object
    `levelFields`*: seq[`LdtkFieldDef`]
    `tilesets`*: seq[`LdtkTilesetDef`]
    `entities`*: seq[`LdtkEntityDef`]
    `enums`*: seq[`LdtkEnumDef`]
    `layers`*: seq[`LdtkLayerDef`]
    `externalEnums`*: seq[`LdtkEnumDef`]
  `LdtkTilesetRect`* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  `LdtkBackupRelPathUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkTagsSourceEnumUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkBiomeFieldUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkIdentifierStyle`* = enum
    Lowercase, Free, Capitalize, Uppercase
  `LdtkEnumDefValues`* = object
    `tileSrcRect`*: Option[seq[BiggestInt]]
    `color`*: BiggestInt
    `id`*: string
    `tileId`*: Option[`LdtkTileIdUnion`]
    `tileRect`*: Option[`LdtkTileRectUnion`]
  `LdtkRegexUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkBgColorUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkUiColorUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkTilesetDefUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkEntityDef`* = object
    `allowOutOfBounds`*: bool
    `pivotY`*: BiggestFloat
    `tileOpacity`*: BiggestFloat
    `color`*: string
    `limitScope`*: `LdtkLimitScope`
    `limitBehavior`*: `LdtkLimitBehavior`
    `hollow`*: bool
    `height`*: BiggestInt
    `renderMode`*: `LdtkRenderMode`
    `tilesetId`*: Option[`LdtkTilesetIdUnion`]
    `keepAspectRatio`*: bool
    `minWidth`*: Option[`LdtkMinWidthUnion`]
    `showName`*: bool
    `resizableX`*: bool
    `identifier`*: string
    `maxCount`*: BiggestInt
    `tileId`*: Option[`LdtkTileIdUnion`]
    `pivotX`*: BiggestFloat
    `doc`*: Option[`LdtkDocUnion`]
    `fieldDefs`*: seq[`LdtkFieldDef`]
    `uid`*: BiggestInt
    `tileRenderMode`*: `LdtkTileRenderMode`
    `uiTileRect`*: Option[`LdtkUiTileRectUnion`]
    `resizableY`*: bool
    `lineOpacity`*: BiggestFloat
    `minHeight`*: Option[`LdtkMinHeightUnion`]
    `tileRect`*: Option[`LdtkTileRectUnion`]
    `nineSliceBorders`*: seq[BiggestInt]
    `maxWidth`*: Option[`LdtkMaxWidthUnion`]
    `width`*: BiggestInt
    `tags`*: seq[string]
    `maxHeight`*: Option[`LdtkMaxHeightUnion`]
    `exportToToc`*: bool
    `fillOpacity`*: BiggestFloat
  `LdtkCachedPixelDataUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: Table[string, JsonNode]
    of 1:
      key1: pointer
  `LdtkIntGridValueGroupDef`* = object
    `color`*: Option[`LdtkColorUnion`]
    `identifier`*: Option[`LdtkIdentifierUnion`]
    `uid`*: BiggestInt
  `LdtkBgPosUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: `LdtkLevelBgPosInfos`
  `LdtkIconTilesetUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkBgPos`* = enum
    CoverDirty, Repeat, Contain, Cover, Unscaled
  `LdtkTilesetRelPathUnion`* = object
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
    `tagsSourceEnumUid`*: Option[`LdtkTagsSourceEnumUidUnion`]
    `embedAtlas`*: Option[Option[`LdtkEmbedAtlas`]]
    `identifier`*: string
    `cachedPixelData`*: Option[`LdtkCachedPixelDataUnion`]
    `enumTags`*: seq[`LdtkEnumTagValue`]
    `pxWid`*: BiggestInt
    `tileGridSize`*: BiggestInt
    `customData`*: seq[`LdtkTileCustomMetadata`]
    `uid`*: BiggestInt
    `cHei`*: BiggestInt
    `cWid`*: BiggestInt
    `relPath`*: Option[`LdtkRelPathUnion`]
    `tags`*: seq[string]
  `LdtkLimitScope`* = enum
    PerLayer, PerWorld, PerLevel
  `LdtkTileCustomMetadata`* = object
    `data`*: string
    `tileId`*: BiggestInt
  `LdtkIntGridValueInstance`* = object
    `coordId`*: BiggestInt
    `v`*: BiggestInt
  `LdtkType`* = enum
    Tiles, Entities, AutoLayer, IntGrid
  `LdtkAllowedRefs`* = enum
    Any, OnlyTags, OnlySame, OnlySpecificEntity
  `LdtkEditorDisplayPos`* = enum
    Beneath, Above, Center
  `LdtkTileRenderMode`* = enum
    FullSizeCropped, FullSizeUncropped, Repeat, FitInside, NineSlice, Cover,
    Stretch
  `LdtkLayerDef`* = object
    `type`*: `LdtkType`
    `autoTilesetDefUid`*: Option[`LdtkAutoTilesetDefUidUnion`]
    `parallaxScaling`*: bool
    `biomeFieldUid`*: Option[`LdtkBiomeFieldUidUnion`]
    `autoTilesKilledByOtherLayerUid`*: Option[
        `LdtkAutoTilesKilledByOtherLayerUidUnion`]
    `inactiveOpacity`*: BiggestFloat
    `type`*: string
    `autoRuleGroups`*: seq[`LdtkAutoLayerRuleGroup`]
    `gridSize`*: BiggestInt
    `hideInList`*: bool
    `tilesetDefUid`*: Option[`LdtkTilesetDefUidUnion`]
    `uiColor`*: Option[`LdtkUiColorUnion`]
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
    `doc`*: Option[`LdtkDocUnion`]
    `uid`*: BiggestInt
    `guideGridHei`*: BiggestInt
    `autoSourceLayerDefUid`*: Option[`LdtkAutoSourceLayerDefUidUnion`]
    `displayOpacity`*: BiggestFloat
    `intGridValuesGroups`*: seq[`LdtkIntGridValueGroupDef`]
    `hideFieldsWhenInactive`*: bool
    `useAsyncRender`*: bool
    `pxOffsetY`*: BiggestInt
    `parallaxFactorY`*: BiggestFloat
    `intGridValues`*: seq[`LdtkIntGridValueDef`]
    `renderInWorldView`*: bool
  `LdtkEnumTagValue`* = object
    `tileIds`*: seq[BiggestInt]
    `enumValueId`*: string
  `LdtkLevelUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkTileRectUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: `LdtkTilesetRect`
  `LdtkLdtkJsonRoot`* = object
    `backupLimit`*: BiggestInt
    `simplifiedExport`*: bool
    `externalLevels`*: bool
    `backupRelPath`*: Option[`LdtkBackupRelPathUnion`]
    `jsonVersion`*: string
    `bgColor`*: string
    `appBuildId`*: BiggestFloat
    `defaultEntityHeight`*: BiggestInt
    `pngFilePattern`*: Option[`LdtkPngFilePatternUnion`]
    `customCommands`*: seq[`LdtkCustomCommand`]
    `exportTiled`*: bool
    `exportPng`*: Option[`LdtkExportPngUnion`]
    `worldGridWidth`*: Option[`LdtkWorldGridWidthUnion`]
    `defaultLevelHeight`*: Option[`LdtkDefaultLevelHeightUnion`]
    `toc`*: seq[`LdtkTableOfContentEntry`]
    `worlds`*: seq[`LdtkWorld`]
    `imageExportMode`*: `LdtkImageExportMode`
    `dummyWorldIid`*: string
    `FORCED_REFS`*: Option[`LdtkFORCED_REFS`]
    `defaultPivotY`*: BiggestFloat
    `exportLevelBg`*: bool
    `nextUid`*: BiggestInt
    `levelNamePattern`*: string
    `defs`*: `LdtkDefinitions`
    `defaultPivotX`*: BiggestFloat
    `tutorialDesc`*: Option[`LdtkTutorialDescUnion`]
    `worldLayout`*: Option[Option[`LdtkWorldLayout`]]
    `defaultEntityWidth`*: BiggestInt
    `iid`*: string
    `defaultGridSize`*: BiggestInt
    `defaultLevelWidth`*: Option[`LdtkDefaultLevelWidthUnion`]
    `minifyJson`*: bool
    `backupOnSave`*: bool
    `flags`*: seq[`LdtkFlags`]
    `defaultLevelBgColor`*: string
    `identifierStyle`*: `LdtkIdentifierStyle`
    `worldGridHeight`*: Option[`LdtkWorldGridHeightUnion`]
    `levels`*: seq[`LdtkLevel`]
  `LdtkWorldLayout`* = enum
    LinearHorizontal, LinearVertical, GridVania, Free
  `LdtkTileUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: `LdtkTilesetRect`
  `LdtkArrayMaxLengthUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkNeighbourLevel`* = object
    `levelUid`*: Option[`LdtkLevelUidUnion`]
    `levelIid`*: string
    `dir`*: string
  `LdtkWhen`* = enum
    AfterLoad, BeforeSave, AfterSave, Manual
  `LdtkTextLanguageMode`* = enum
    LangMarkdown, LangPython, LangLog, LangC, LangLua, LangHaxe, LangJS,
    LangRuby, LangJson, LangXml
  `LdtkAutoTilesKilledByOtherLayerUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkIntGridValueDef`* = object
    `tile`*: Option[`LdtkTileUnion`]
    `color`*: string
    `identifier`*: Option[`LdtkIdentifierUnion`]
    `groupUid`*: BiggestInt
    `value`*: BiggestInt
  `LdtkWorldXUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkEditorDisplayMode`* = enum
    PointPath, PointStar, ValueOnly, Hidden, Points, NameAndValue,
    ArrayCountNoLabel, EntityTile, PointPathLoop, RadiusPx, LevelTile,
    RadiusGrid, RefLinkBetweenCenters, RefLinkBetweenPivots, ArrayCountWithLabel
  `LdtkMinHeightUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkFieldDef`* = object
    `type`*: string
    `editorDisplayScale`*: BiggestFloat
    `type`*: string
    `allowedRefsEntityUid`*: Option[`LdtkAllowedRefsEntityUidUnion`]
    `textLanguageMode`*: Option[Option[`LdtkTextLanguageMode`]]
    `editorAlwaysShow`*: bool
    `defaultOverride`*: Option[JsonNode]
    `autoChainRef`*: bool
    `editorDisplayPos`*: `LdtkEditorDisplayPos`
    `editorDisplayMode`*: `LdtkEditorDisplayMode`
    `identifier`*: string
    `regex`*: Option[`LdtkRegexUnion`]
    `isArray`*: bool
    `editorLinkStyle`*: `LdtkEditorLinkStyle`
    `allowedRefs`*: `LdtkAllowedRefs`
    `useForSmartColor`*: bool
    `editorTextSuffix`*: Option[`LdtkEditorTextSuffixUnion`]
    `doc`*: Option[`LdtkDocUnion`]
    `editorTextPrefix`*: Option[`LdtkEditorTextPrefixUnion`]
    `editorCutLongValues`*: bool
    `canBeNull`*: bool
    `allowedRefTags`*: seq[string]
    `uid`*: BiggestInt
    `symmetricalRef`*: bool
    `editorDisplayColor`*: Option[`LdtkEditorDisplayColorUnion`]
    `allowOutOfLevelRef`*: bool
    `acceptFileTypes`*: Option[seq[string]]
    `editorShowInWorld`*: bool
    `tilesetUid`*: Option[`LdtkTilesetUidUnion`]
    `arrayMaxLength`*: Option[`LdtkArrayMaxLengthUnion`]
    `arrayMinLength`*: Option[`LdtkArrayMinLengthUnion`]
    `searchable`*: bool
    `min`*: Option[`LdtkMinUnion`]
    `exportToToc`*: bool
    `max`*: Option[`LdtkMaxUnion`]
  `LdtkMaxHeightUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkExportPngUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: bool
    of 1:
      key1: pointer
  `LdtkEmbedAtlas`* = enum
    LdtkIcons
  `LdtkAutoSourceLayerDefUidUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkMinUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  `LdtkTableOfContentEntry`* = object
    `instancesData`*: seq[`LdtkTocInstanceData`]
    `identifier`*: string
    `instances`*: Option[seq[`LdtkEntityReferenceInfos`]]
  `LdtkMaxUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  `LdtkWorldGridWidthUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkTilesetIdUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkExternalRelPathUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkIdentifierUnion`* = object
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
  `LdtkDefaultLevelHeightUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkWorldGridHeightUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkEditorTextPrefixUnion`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkEditorLinkStyle`* = enum
    DashedLine, CurvedArrow, ArrowsLine, ZigZag, StraightArrow
  `LdtkEnumDef`* = object
    `values`*: seq[`LdtkEnumDefValues`]
    `externalRelPath`*: Option[`LdtkExternalRelPathUnion`]
    `identifier`*: string
    `externalFileChecksum`*: Option[`LdtkExternalFileChecksumUnion`]
    `iconTilesetUid`*: Option[`LdtkIconTilesetUidUnion`]
    `uid`*: BiggestInt
    `tags`*: seq[string]
  `LdtkFORCED_REFS`* = object
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
  `LdtkLevelBgPosInfos`* = object
    `scale`*: seq[BiggestFloat]
    `cropRect`*: seq[BiggestFloat]
    `topLeftPx`*: seq[BiggestInt]
  `LdtkAutoRuleDef`* = object
    `checker`*: `LdtkChecker`
    `pivotY`*: BiggestFloat
    `breakOnMatch`*: bool
    `perlinOctaves`*: BiggestFloat
    `yModulo`*: BiggestInt
    `size`*: BiggestInt
    `tileMode`*: `LdtkTileMode`
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
    `outOfBoundsValue`*: Option[`LdtkOutOfBoundsValueUnion`]
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
  `LdtkGridPoint`* = object
    `cx`*: BiggestInt
    `cy`*: BiggestInt
  `LdtkRenderMode`* = enum
    Tile, Cross, Ellipse, Rectangle
  `LdtkLevel`* = object
    `pxHei`*: BiggestInt
    `useAutoIdentifier`*: bool
    `bgColor`*: string
    `bgColor`*: Option[`LdtkBgColorUnion`]
    `externalRelPath`*: Option[`LdtkExternalRelPathUnion`]
    `worldY`*: BiggestInt
    `bgRelPath`*: Option[`LdtkBgRelPathUnion`]
    `identifier`*: string
    `pxWid`*: BiggestInt
    `worldDepth`*: BiggestInt
    `bgPivotX`*: BiggestFloat
    `neighbours`*: seq[`LdtkNeighbourLevel`]
    `uid`*: BiggestInt
    `bgPos`*: Option[Option[`LdtkBgPos`]]
    `layerInstances`*: Option[seq[`LdtkLayerInstance`]]
    `fieldInstances`*: seq[`LdtkFieldInstance`]
    `bgPos`*: Option[`LdtkBgPosUnion`]
    `worldX`*: BiggestInt
    `iid`*: string
    `bgPivotY`*: BiggestFloat
    `smartColor`*: string
  `LdtkWorld`* = object
    `worldGridWidth`*: BiggestInt
    `defaultLevelHeight`*: BiggestInt
    `identifier`*: string
    `worldLayout`*: Option[`LdtkWorldLayout`]
    `iid`*: string
    `defaultLevelWidth`*: BiggestInt
    `worldGridHeight`*: BiggestInt
    `levels`*: seq[`LdtkLevel`]