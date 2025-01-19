import std/[json, tables, options]
type
  `LdtkMaxHeight`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkTileMode`* = enum
    Single, Stamp
  `LdtkMinWidth`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkBiomeFieldUid`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkMaxWidth`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkDefaultLevelWidth`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkTocInstanceData`* = object
    `worldY`*: BiggestInt
    `fields`*: JsonNode
    `widPx`*: BiggestInt
    `iids`*: `LdtkEntityReferenceInfos`
    `heiPx`*: BiggestInt
    `worldX`*: BiggestInt
  `LdtkFlags`* = enum
    ExportPreCsvIntGridFormat, DiscardPreCsvIntGrid,
    ExportOldTableOfContentData, PrependIndexToLevelFileNames, MultiWorlds,
    UseMultilinesType, IgnoreBackupSuggest
  `LdtkLdtkJsonRoot`* = object
    `backupLimit`*: BiggestInt
    `simplifiedExport`*: bool
    `externalLevels`*: bool
    `backupRelPath`*: Option[`LdtkBackupRelPath`]
    `jsonVersion`*: string
    `bgColor`*: string
    `appBuildId`*: BiggestFloat
    `defaultEntityHeight`*: BiggestInt
    `pngFilePattern`*: Option[`LdtkPngFilePattern`]
    `customCommands`*: seq[`LdtkCustomCommand`]
    `exportTiled`*: bool
    `exportPng`*: Option[`LdtkExportPng`]
    `worldGridWidth`*: Option[`LdtkWorldGridWidth`]
    `defaultLevelHeight`*: Option[`LdtkDefaultLevelHeight`]
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
    `tutorialDesc`*: Option[`LdtkTutorialDesc`]
    `worldLayout`*: Option[Option[`LdtkWorldLayout`]]
    `defaultEntityWidth`*: BiggestInt
    `iid`*: string
    `defaultGridSize`*: BiggestInt
    `defaultLevelWidth`*: Option[`LdtkDefaultLevelWidth`]
    `minifyJson`*: bool
    `backupOnSave`*: bool
    `flags`*: seq[`LdtkFlags`]
    `defaultLevelBgColor`*: string
    `identifierStyle`*: `LdtkIdentifierStyle`
    `worldGridHeight`*: Option[`LdtkWorldGridHeight`]
    `levels`*: seq[`LdtkLevel`]
  `LdtkExternalRelPath`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
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
    `outOfBoundsValue`*: Option[`LdtkOutOfBoundsValue`]
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
  `LdtkExternalFileChecksum`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkTutorialDesc`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkChecker`* = enum
    Horizontal, Vertical, None
  `LdtkEditorTextPrefix`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkTilesetUid`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkCollapsed`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: bool
    of 1:
      key1: pointer
  `LdtkTilesetDefUid`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkEntityReferenceInfos`* = object
    `layerIid`*: string
    `levelIid`*: string
    `entityIid`*: string
    `worldIid`*: string
  `LdtkLimitBehavior`* = enum
    PreventAdding, MoveLastOne, DiscardOldOnes
  `LdtkColor`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkImageExportMode`* = enum
    LayersAndLevels, OneImagePerLayer, None, OneImagePerLevel
  `LdtkNeighbourLevel`* = object
    `levelUid`*: Option[`LdtkLevelUid`]
    `levelIid`*: string
    `dir`*: string
  `LdtkTilesetRelPath`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkCustomCommand`* = object
    `command`*: string
    `when`*: `LdtkWhen`
  `LdtkBackupRelPath`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkLayerInstance`* = object
    `opacity`*: BiggestFloat
    `optionalRules`*: seq[BiggestInt]
    `gridSize`*: BiggestInt
    `pxTotalOffsetX`*: BiggestInt
    `gridTiles`*: seq[`LdtkTile`]
    `type`*: string
    `identifier`*: string
    `overrideTilesetUid`*: Option[`LdtkOverrideTilesetUid`]
    `levelId`*: BiggestInt
    `intGrid`*: Option[seq[`LdtkIntGridValueInstance`]]
    `autoLayerTiles`*: seq[`LdtkTile`]
    `layerDefUid`*: BiggestInt
    `entityInstances`*: seq[`LdtkEntityInstance`]
    `intGridCsv`*: seq[BiggestInt]
    `pxOffsetX`*: BiggestInt
    `tilesetRelPath`*: Option[`LdtkTilesetRelPath`]
    `tilesetDefUid`*: Option[`LdtkTilesetDefUid`]
    `cHei`*: BiggestInt
    `seed`*: BiggestInt
    `visible`*: bool
    `pxOffsetY`*: BiggestInt
    `iid`*: string
    `pxTotalOffsetY`*: BiggestInt
    `cWid`*: BiggestInt
  `LdtkBgPos`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: `LdtkLevelBgPosInfos`
  `LdtkFieldInstance`* = object
    `realEditorValues`*: seq[JsonNode]
    `value`*: JsonNode
    `tile`*: Option[`LdtkTile`]
    `type`*: string
    `identifier`*: string
    `defUid`*: BiggestInt
  `LdtkMax`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  `LdtkAllowedRefsEntityUid`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkRelPath`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkTileRect`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: `LdtkTilesetRect`
  `LdtkLayerDef`* = object
    `type`*: `LdtkType`
    `autoTilesetDefUid`*: Option[`LdtkAutoTilesetDefUid`]
    `parallaxScaling`*: bool
    `biomeFieldUid`*: Option[`LdtkBiomeFieldUid`]
    `autoTilesKilledByOtherLayerUid`*: Option[
        `LdtkAutoTilesKilledByOtherLayerUid`]
    `inactiveOpacity`*: BiggestFloat
    `type`*: string
    `autoRuleGroups`*: seq[`LdtkAutoLayerRuleGroup`]
    `gridSize`*: BiggestInt
    `hideInList`*: bool
    `tilesetDefUid`*: Option[`LdtkTilesetDefUid`]
    `uiColor`*: Option[`LdtkUiColor`]
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
    `doc`*: Option[`LdtkDoc`]
    `uid`*: BiggestInt
    `guideGridHei`*: BiggestInt
    `autoSourceLayerDefUid`*: Option[`LdtkAutoSourceLayerDefUid`]
    `displayOpacity`*: BiggestFloat
    `intGridValuesGroups`*: seq[`LdtkIntGridValueGroupDef`]
    `hideFieldsWhenInactive`*: bool
    `useAsyncRender`*: bool
    `pxOffsetY`*: BiggestInt
    `parallaxFactorY`*: BiggestFloat
    `intGridValues`*: seq[`LdtkIntGridValueDef`]
    `renderInWorldView`*: bool
  `LdtkDefaultLevelHeight`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkMinHeight`* = object
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
  `LdtkIcon`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: `LdtkTilesetRect`
  `LdtkWorldGridHeight`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkEnumDefValues`* = object
    `tileSrcRect`*: Option[seq[BiggestInt]]
    `color`*: BiggestInt
    `id`*: string
    `tileId`*: Option[`LdtkTileId`]
    `tileRect`*: Option[`LdtkTileRect`]
  `LdtkEntityInstance`* = object
    `worldY`*: Option[`LdtkWorldY`]
    `tile`*: Option[`LdtkTile`]
    `identifier`*: string
    `tags`*: seq[string]
    `height`*: BiggestInt
    `px`*: seq[BiggestInt]
    `defUid`*: BiggestInt
    `pivot`*: seq[BiggestFloat]
    `fieldInstances`*: seq[`LdtkFieldInstance`]
    `iid`*: string
    `width`*: BiggestInt
    `worldX`*: Option[`LdtkWorldX`]
    `grid`*: seq[BiggestInt]
    `smartColor`*: string
  `LdtkDoc`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkWorldX`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkIdentifierStyle`* = enum
    Lowercase, Free, Capitalize, Uppercase
  `LdtkUiColor`* = object
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
    `tagsSourceEnumUid`*: Option[`LdtkTagsSourceEnumUid`]
    `embedAtlas`*: Option[Option[`LdtkEmbedAtlas`]]
    `identifier`*: string
    `cachedPixelData`*: Option[`LdtkCachedPixelData`]
    `enumTags`*: seq[`LdtkEnumTagValue`]
    `pxWid`*: BiggestInt
    `tileGridSize`*: BiggestInt
    `customData`*: seq[`LdtkTileCustomMetadata`]
    `uid`*: BiggestInt
    `cHei`*: BiggestInt
    `cWid`*: BiggestInt
    `relPath`*: Option[`LdtkRelPath`]
    `tags`*: seq[string]
  `LdtkFieldDef`* = object
    `type`*: string
    `editorDisplayScale`*: BiggestFloat
    `type`*: string
    `allowedRefsEntityUid`*: Option[`LdtkAllowedRefsEntityUid`]
    `textLanguageMode`*: Option[Option[`LdtkTextLanguageMode`]]
    `editorAlwaysShow`*: bool
    `defaultOverride`*: Option[JsonNode]
    `autoChainRef`*: bool
    `editorDisplayPos`*: `LdtkEditorDisplayPos`
    `editorDisplayMode`*: `LdtkEditorDisplayMode`
    `identifier`*: string
    `regex`*: Option[`LdtkRegex`]
    `isArray`*: bool
    `editorLinkStyle`*: `LdtkEditorLinkStyle`
    `allowedRefs`*: `LdtkAllowedRefs`
    `useForSmartColor`*: bool
    `editorTextSuffix`*: Option[`LdtkEditorTextSuffix`]
    `doc`*: Option[`LdtkDoc`]
    `editorTextPrefix`*: Option[`LdtkEditorTextPrefix`]
    `editorCutLongValues`*: bool
    `canBeNull`*: bool
    `allowedRefTags`*: seq[string]
    `uid`*: BiggestInt
    `symmetricalRef`*: bool
    `editorDisplayColor`*: Option[`LdtkEditorDisplayColor`]
    `allowOutOfLevelRef`*: bool
    `acceptFileTypes`*: Option[seq[string]]
    `editorShowInWorld`*: bool
    `tilesetUid`*: Option[`LdtkTilesetUid`]
    `arrayMaxLength`*: Option[`LdtkArrayMaxLength`]
    `arrayMinLength`*: Option[`LdtkArrayMinLength`]
    `searchable`*: bool
    `min`*: Option[`LdtkMin`]
    `exportToToc`*: bool
    `max`*: Option[`LdtkMax`]
  `LdtkExportPng`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: bool
    of 1:
      key1: pointer
  `LdtkWorldGridWidth`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkBgPos`* = enum
    CoverDirty, Repeat, Contain, Cover, Unscaled
  `LdtkLevelUid`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkAutoTilesetDefUid`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLimitScope`* = enum
    PerLayer, PerWorld, PerLevel
  `LdtkAutoTilesKilledByOtherLayerUid`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkArrayMaxLength`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkEditorDisplayColor`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkTileCustomMetadata`* = object
    `data`*: string
    `tileId`*: BiggestInt
  `LdtkIntGridValueGroupDef`* = object
    `color`*: Option[`LdtkColor`]
    `identifier`*: Option[`LdtkIdentifier`]
    `uid`*: BiggestInt
  `LdtkMin`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  `LdtkIntGridValueInstance`* = object
    `coordId`*: BiggestInt
    `v`*: BiggestInt
  `LdtkType`* = enum
    Tiles, Entities, AutoLayer, IntGrid
  `LdtkAllowedRefs`* = enum
    Any, OnlyTags, OnlySame, OnlySpecificEntity
  `LdtkEditorDisplayPos`* = enum
    Beneath, Above, Center
  `LdtkOverrideTilesetUid`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkLevel`* = object
    `pxHei`*: BiggestInt
    `useAutoIdentifier`*: bool
    `bgColor`*: string
    `bgColor`*: Option[`LdtkBgColor`]
    `externalRelPath`*: Option[`LdtkExternalRelPath`]
    `worldY`*: BiggestInt
    `bgRelPath`*: Option[`LdtkBgRelPath`]
    `identifier`*: string
    `pxWid`*: BiggestInt
    `worldDepth`*: BiggestInt
    `bgPivotX`*: BiggestFloat
    `neighbours`*: seq[`LdtkNeighbourLevel`]
    `uid`*: BiggestInt
    `bgPos`*: Option[Option[`LdtkBgPos`]]
    `layerInstances`*: Option[seq[`LdtkLayerInstance`]]
    `fieldInstances`*: seq[`LdtkFieldInstance`]
    `bgPos`*: Option[`LdtkBgPos`]
    `worldX`*: BiggestInt
    `iid`*: string
    `bgPivotY`*: BiggestFloat
    `smartColor`*: string
  `LdtkTileRenderMode`* = enum
    FullSizeCropped, FullSizeUncropped, Repeat, FitInside, NineSlice, Cover,
    Stretch
  `LdtkWorldY`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkPngFilePattern`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkEnumTagValue`* = object
    `tileIds`*: seq[BiggestInt]
    `enumValueId`*: string
  `LdtkCachedPixelData`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: Table[string, JsonNode]
    of 1:
      key1: pointer
  `LdtkTileId`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkWorldLayout`* = enum
    LinearHorizontal, LinearVertical, GridVania, Free
  `LdtkWhen`* = enum
    AfterLoad, BeforeSave, AfterSave, Manual
  `LdtkTextLanguageMode`* = enum
    LangMarkdown, LangPython, LangLog, LangC, LangLua, LangHaxe, LangJS,
    LangRuby, LangJson, LangXml
  `LdtkEditorDisplayMode`* = enum
    PointPath, PointStar, ValueOnly, Hidden, Points, NameAndValue,
    ArrayCountNoLabel, EntityTile, PointPathLoop, RadiusPx, LevelTile,
    RadiusGrid, RefLinkBetweenCenters, RefLinkBetweenPivots, ArrayCountWithLabel
  `LdtkArrayMinLength`* = object
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
    `tilesetId`*: Option[`LdtkTilesetId`]
    `keepAspectRatio`*: bool
    `minWidth`*: Option[`LdtkMinWidth`]
    `showName`*: bool
    `resizableX`*: bool
    `identifier`*: string
    `maxCount`*: BiggestInt
    `tileId`*: Option[`LdtkTileId`]
    `pivotX`*: BiggestFloat
    `doc`*: Option[`LdtkDoc`]
    `fieldDefs`*: seq[`LdtkFieldDef`]
    `uid`*: BiggestInt
    `tileRenderMode`*: `LdtkTileRenderMode`
    `uiTileRect`*: Option[`LdtkUiTileRect`]
    `resizableY`*: bool
    `lineOpacity`*: BiggestFloat
    `minHeight`*: Option[`LdtkMinHeight`]
    `tileRect`*: Option[`LdtkTileRect`]
    `nineSliceBorders`*: seq[BiggestInt]
    `maxWidth`*: Option[`LdtkMaxWidth`]
    `width`*: BiggestInt
    `tags`*: seq[string]
    `maxHeight`*: Option[`LdtkMaxHeight`]
    `exportToToc`*: bool
    `fillOpacity`*: BiggestFloat
  `LdtkAutoSourceLayerDefUid`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkBgRelPath`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkEmbedAtlas`* = enum
    LdtkIcons
  `LdtkRegex`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkOutOfBoundsValue`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkTableOfContentEntry`* = object
    `instancesData`*: seq[`LdtkTocInstanceData`]
    `identifier`*: string
    `instances`*: Option[seq[`LdtkEntityReferenceInfos`]]
  `LdtkTile`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: `LdtkTilesetRect`
  `LdtkEditorTextSuffix`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkIdentifier`* = object
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
  `LdtkTagsSourceEnumUid`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkEnumDef`* = object
    `values`*: seq[`LdtkEnumDefValues`]
    `externalRelPath`*: Option[`LdtkExternalRelPath`]
    `identifier`*: string
    `externalFileChecksum`*: Option[`LdtkExternalFileChecksum`]
    `iconTilesetUid`*: Option[`LdtkIconTilesetUid`]
    `uid`*: BiggestInt
    `tags`*: seq[string]
  `LdtkIntGridValueDef`* = object
    `tile`*: Option[`LdtkTile`]
    `color`*: string
    `identifier`*: Option[`LdtkIdentifier`]
    `groupUid`*: BiggestInt
    `value`*: BiggestInt
  `LdtkEditorLinkStyle`* = enum
    DashedLine, CurvedArrow, ArrowsLine, ZigZag, StraightArrow
  `LdtkTilesetId`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
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
  `LdtkAutoLayerRuleGroup`* = object
    `isOptional`*: bool
    `color`*: Option[`LdtkColor`]
    `collapsed`*: Option[`LdtkCollapsed`]
    `usesWizard`*: bool
    `biomeRequirementMode`*: BiggestInt
    `rules`*: seq[`LdtkAutoRuleDef`]
    `icon`*: Option[`LdtkIcon`]
    `active`*: bool
    `uid`*: BiggestInt
    `name`*: string
    `requiredBiomeValues`*: seq[string]
  `LdtkLevelBgPosInfos`* = object
    `scale`*: seq[BiggestFloat]
    `cropRect`*: seq[BiggestFloat]
    `topLeftPx`*: seq[BiggestInt]
  `LdtkGridPoint`* = object
    `cx`*: BiggestInt
    `cy`*: BiggestInt
  `LdtkUiTileRect`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: `LdtkTilesetRect`
  `LdtkIconTilesetUid`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  `LdtkBgColor`* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  `LdtkRenderMode`* = enum
    Tile, Cross, Ellipse, Rectangle
  `LdtkWorld`* = object
    `worldGridWidth`*: BiggestInt
    `defaultLevelHeight`*: BiggestInt
    `identifier`*: string
    `worldLayout`*: Option[`LdtkWorldLayout`]
    `iid`*: string
    `defaultLevelWidth`*: BiggestInt
    `worldGridHeight`*: BiggestInt
    `levels`*: seq[`LdtkLevel`]