type
  LdtkBackupRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkPngFilePattern* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkWhen* = enum
    AfterLoad, BeforeSave, AfterSave, Manual
  LdtkCustomCommands* = object
    `command`*: string
    `when`*: LdtkWhen
  LdtkExportPng* = object
    case kind: range[0 .. 1]
    of 0:
      key0: bool
    of 1:
      key1: pointer
  LdtkWorldGridWidth* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkDefaultLevelHeight* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkIids* = object
    `layerIid`*: string
    `levelIid`*: string
    `entityIid`*: string
    `worldIid`*: string
  LdtkInstancesData* = object
    `worldY`*: BiggestInt
    `fields`*: JsonNode
    `widPx`*: BiggestInt
    `iids`*: LdtkIids
    `heiPx`*: BiggestInt
    `worldX`*: BiggestInt
  LdtkInstances* = object
    `layerIid`*: string
    `levelIid`*: string
    `entityIid`*: string
    `worldIid`*: string
  LdtkToc* = object
    `instancesData`*: seq[LdtkInstancesData]
    `identifier`*: string
    `instances`*: seq[LdtkInstances]
  LdtkWorldLayout* = enum
    LinearHorizontal, LinearVertical, , GridVania, Free
  LdtkBgColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkExternalRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkBgRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkLevelUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  Ldtk__neighbours* = object
    `levelUid`*: LdtkLevelUid
    `levelIid`*: string
    `dir`*: string
  LdtkBgPos* = enum
    CoverDirty, Repeat, , Contain, Cover, Unscaled
  LdtkGridTiles* = object
    `px`*: seq[BiggestInt]
    `t`*: BiggestInt
    `d`*: seq[BiggestInt]
    `a`*: BiggestFloat
    `src`*: seq[BiggestInt]
    `f`*: BiggestInt
  LdtkOverrideTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkIntGrid* = object
    `coordId`*: BiggestInt
    `v`*: BiggestInt
  LdtkAutoLayerTiles* = object
    `px`*: seq[BiggestInt]
    `t`*: BiggestInt
    `d`*: seq[BiggestInt]
    `a`*: BiggestFloat
    `src`*: seq[BiggestInt]
    `f`*: BiggestInt
  Ldtk__worldY* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  Ldtk__tile1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  Ldtk__tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: Ldtk__tile1
  Ldtk__tile1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  Ldtk__tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: Ldtk__tile1
  LdtkFieldInstances* = object
    `realEditorValues`*: seq[JsonNode]
    `__value`*: JsonNode
    `__tile`*: Ldtk__tile
    `__type`*: string
    `__identifier`*: string
    `defUid`*: BiggestInt
  Ldtk__worldX* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkEntityInstances* = object
    `__worldY`*: Ldtk__worldY
    `__tile`*: Ldtk__tile
    `__identifier`*: string
    `__tags`*: seq[string]
    `height`*: BiggestInt
    `px`*: seq[BiggestInt]
    `defUid`*: BiggestInt
    `__pivot`*: seq[BiggestFloat]
    `fieldInstances`*: seq[LdtkFieldInstances]
    `iid`*: string
    `width`*: BiggestInt
    `__worldX`*: Ldtk__worldX
    `__grid`*: seq[BiggestInt]
    `__smartColor`*: string
  Ldtk__tilesetRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  Ldtk__tilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkLayerInstances* = object
    `__opacity`*: BiggestFloat
    `optionalRules`*: seq[BiggestInt]
    `__gridSize`*: BiggestInt
    `__pxTotalOffsetX`*: BiggestInt
    `gridTiles`*: seq[LdtkGridTiles]
    `__type`*: string
    `__identifier`*: string
    `overrideTilesetUid`*: LdtkOverrideTilesetUid
    `levelId`*: BiggestInt
    `intGrid`*: seq[LdtkIntGrid]
    `autoLayerTiles`*: seq[LdtkAutoLayerTiles]
    `layerDefUid`*: BiggestInt
    `entityInstances`*: seq[LdtkEntityInstances]
    `intGridCsv`*: seq[BiggestInt]
    `pxOffsetX`*: BiggestInt
    `__tilesetRelPath`*: Ldtk__tilesetRelPath
    `__tilesetDefUid`*: Ldtk__tilesetDefUid
    `__cHei`*: BiggestInt
    `seed`*: BiggestInt
    `visible`*: bool
    `pxOffsetY`*: BiggestInt
    `iid`*: string
    `__pxTotalOffsetY`*: BiggestInt
    `__cWid`*: BiggestInt
  Ldtk__tile1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  Ldtk__tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: Ldtk__tile1
  LdtkFieldInstances* = object
    `realEditorValues`*: seq[JsonNode]
    `__value`*: JsonNode
    `__tile`*: Ldtk__tile
    `__type`*: string
    `__identifier`*: string
    `defUid`*: BiggestInt
  Ldtk__bgPos1* = object
    `scale`*: seq[BiggestFloat]
    `cropRect`*: seq[BiggestFloat]
    `topLeftPx`*: seq[BiggestInt]
  Ldtk__bgPos* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: Ldtk__bgPos1
  LdtkLevels* = object
    `pxHei`*: BiggestInt
    `useAutoIdentifier`*: bool
    `__bgColor`*: string
    `bgColor`*: LdtkBgColor
    `externalRelPath`*: LdtkExternalRelPath
    `worldY`*: BiggestInt
    `bgRelPath`*: LdtkBgRelPath
    `identifier`*: string
    `pxWid`*: BiggestInt
    `worldDepth`*: BiggestInt
    `bgPivotX`*: BiggestFloat
    `__neighbours`*: seq[Ldtk__neighbours]
    `uid`*: BiggestInt
    `bgPos`*: LdtkBgPos
    `layerInstances`*: seq[LdtkLayerInstances]
    `fieldInstances`*: seq[LdtkFieldInstances]
    `__bgPos`*: Ldtk__bgPos
    `worldX`*: BiggestInt
    `iid`*: string
    `bgPivotY`*: BiggestFloat
    `__smartColor`*: string
  LdtkWorlds* = object
    `worldGridWidth`*: BiggestInt
    `defaultLevelHeight`*: BiggestInt
    `identifier`*: string
    `worldLayout`*: LdtkWorldLayout
    `iid`*: string
    `defaultLevelWidth`*: BiggestInt
    `worldGridHeight`*: BiggestInt
    `levels`*: seq[LdtkLevels]
  LdtkImageExportMode* = enum
    LayersAndLevels, OneImagePerLayer, None, OneImagePerLevel
  LdtkWhen* = enum
    AfterLoad, BeforeSave, AfterSave, Manual
  LdtkCustomCommand* = object
    `command`*: string
    `when`*: LdtkWhen
  LdtkTile1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  LdtkTile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: LdtkTile1
  LdtkIdentifier* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkIntGridValueDef* = object
    `tile`*: LdtkTile
    `color`*: string
    `identifier`*: LdtkIdentifier
    `groupUid`*: BiggestInt
    `value`*: BiggestInt
  LdtkBgColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkExternalRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkBgRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkLevelUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  Ldtk__neighbours* = object
    `levelUid`*: LdtkLevelUid
    `levelIid`*: string
    `dir`*: string
  LdtkBgPos* = enum
    CoverDirty, Repeat, , Contain, Cover, Unscaled
  LdtkGridTiles* = object
    `px`*: seq[BiggestInt]
    `t`*: BiggestInt
    `d`*: seq[BiggestInt]
    `a`*: BiggestFloat
    `src`*: seq[BiggestInt]
    `f`*: BiggestInt
  LdtkOverrideTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkIntGrid* = object
    `coordId`*: BiggestInt
    `v`*: BiggestInt
  LdtkAutoLayerTiles* = object
    `px`*: seq[BiggestInt]
    `t`*: BiggestInt
    `d`*: seq[BiggestInt]
    `a`*: BiggestFloat
    `src`*: seq[BiggestInt]
    `f`*: BiggestInt
  Ldtk__worldY* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  Ldtk__tile1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  Ldtk__tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: Ldtk__tile1
  Ldtk__tile1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  Ldtk__tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: Ldtk__tile1
  LdtkFieldInstances* = object
    `realEditorValues`*: seq[JsonNode]
    `__value`*: JsonNode
    `__tile`*: Ldtk__tile
    `__type`*: string
    `__identifier`*: string
    `defUid`*: BiggestInt
  Ldtk__worldX* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkEntityInstances* = object
    `__worldY`*: Ldtk__worldY
    `__tile`*: Ldtk__tile
    `__identifier`*: string
    `__tags`*: seq[string]
    `height`*: BiggestInt
    `px`*: seq[BiggestInt]
    `defUid`*: BiggestInt
    `__pivot`*: seq[BiggestFloat]
    `fieldInstances`*: seq[LdtkFieldInstances]
    `iid`*: string
    `width`*: BiggestInt
    `__worldX`*: Ldtk__worldX
    `__grid`*: seq[BiggestInt]
    `__smartColor`*: string
  Ldtk__tilesetRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  Ldtk__tilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkLayerInstances* = object
    `__opacity`*: BiggestFloat
    `optionalRules`*: seq[BiggestInt]
    `__gridSize`*: BiggestInt
    `__pxTotalOffsetX`*: BiggestInt
    `gridTiles`*: seq[LdtkGridTiles]
    `__type`*: string
    `__identifier`*: string
    `overrideTilesetUid`*: LdtkOverrideTilesetUid
    `levelId`*: BiggestInt
    `intGrid`*: seq[LdtkIntGrid]
    `autoLayerTiles`*: seq[LdtkAutoLayerTiles]
    `layerDefUid`*: BiggestInt
    `entityInstances`*: seq[LdtkEntityInstances]
    `intGridCsv`*: seq[BiggestInt]
    `pxOffsetX`*: BiggestInt
    `__tilesetRelPath`*: Ldtk__tilesetRelPath
    `__tilesetDefUid`*: Ldtk__tilesetDefUid
    `__cHei`*: BiggestInt
    `seed`*: BiggestInt
    `visible`*: bool
    `pxOffsetY`*: BiggestInt
    `iid`*: string
    `__pxTotalOffsetY`*: BiggestInt
    `__cWid`*: BiggestInt
  Ldtk__tile1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  Ldtk__tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: Ldtk__tile1
  LdtkFieldInstances* = object
    `realEditorValues`*: seq[JsonNode]
    `__value`*: JsonNode
    `__tile`*: Ldtk__tile
    `__type`*: string
    `__identifier`*: string
    `defUid`*: BiggestInt
  Ldtk__bgPos1* = object
    `scale`*: seq[BiggestFloat]
    `cropRect`*: seq[BiggestFloat]
    `topLeftPx`*: seq[BiggestInt]
  Ldtk__bgPos* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: Ldtk__bgPos1
  LdtkLevel* = object
    `pxHei`*: BiggestInt
    `useAutoIdentifier`*: bool
    `__bgColor`*: string
    `bgColor`*: LdtkBgColor
    `externalRelPath`*: LdtkExternalRelPath
    `worldY`*: BiggestInt
    `bgRelPath`*: LdtkBgRelPath
    `identifier`*: string
    `pxWid`*: BiggestInt
    `worldDepth`*: BiggestInt
    `bgPivotX`*: BiggestFloat
    `__neighbours`*: seq[Ldtk__neighbours]
    `uid`*: BiggestInt
    `bgPos`*: LdtkBgPos
    `layerInstances`*: seq[LdtkLayerInstances]
    `fieldInstances`*: seq[LdtkFieldInstances]
    `__bgPos`*: Ldtk__bgPos
    `worldX`*: BiggestInt
    `iid`*: string
    `bgPivotY`*: BiggestFloat
    `__smartColor`*: string
  LdtkAllowedRefsEntityUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkTextLanguageMode* = enum
    LangMarkdown, LangPython, LangLog, LangC, LangLua, LangHaxe, LangJS,
    LangRuby, , LangJson, LangXml
  LdtkEditorDisplayPos* = enum
    Beneath, Above, Center
  LdtkEditorDisplayMode* = enum
    PointPath, PointStar, ValueOnly, Hidden, Points, NameAndValue,
    ArrayCountNoLabel, EntityTile, PointPathLoop, RadiusPx, LevelTile,
    RadiusGrid, RefLinkBetweenCenters, RefLinkBetweenPivots, ArrayCountWithLabel
  LdtkRegex* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkEditorLinkStyle* = enum
    DashedLine, CurvedArrow, ArrowsLine, ZigZag, StraightArrow
  LdtkAllowedRefs* = enum
    Any, OnlyTags, OnlySame, OnlySpecificEntity
  LdtkEditorTextSuffix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkDoc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkEditorTextPrefix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkEditorDisplayColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkArrayMaxLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkArrayMinLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkMin* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  LdtkMax* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  LdtkLevelFields* = object
    `type`*: string
    `editorDisplayScale`*: BiggestFloat
    `__type`*: string
    `allowedRefsEntityUid`*: LdtkAllowedRefsEntityUid
    `textLanguageMode`*: LdtkTextLanguageMode
    `editorAlwaysShow`*: bool
    `defaultOverride`*: JsonNode
    `autoChainRef`*: bool
    `editorDisplayPos`*: LdtkEditorDisplayPos
    `editorDisplayMode`*: LdtkEditorDisplayMode
    `identifier`*: string
    `regex`*: LdtkRegex
    `isArray`*: bool
    `editorLinkStyle`*: LdtkEditorLinkStyle
    `allowedRefs`*: LdtkAllowedRefs
    `useForSmartColor`*: bool
    `editorTextSuffix`*: LdtkEditorTextSuffix
    `doc`*: LdtkDoc
    `editorTextPrefix`*: LdtkEditorTextPrefix
    `editorCutLongValues`*: bool
    `canBeNull`*: bool
    `allowedRefTags`*: seq[string]
    `uid`*: BiggestInt
    `symmetricalRef`*: bool
    `editorDisplayColor`*: LdtkEditorDisplayColor
    `allowOutOfLevelRef`*: bool
    `acceptFileTypes`*: seq[string]
    `editorShowInWorld`*: bool
    `tilesetUid`*: LdtkTilesetUid
    `arrayMaxLength`*: LdtkArrayMaxLength
    `arrayMinLength`*: LdtkArrayMinLength
    `searchable`*: bool
    `min`*: LdtkMin
    `exportToToc`*: bool
    `max`*: LdtkMax
  LdtkTagsSourceEnumUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkEmbedAtlas* = enum
    LdtkIcons, 
  LdtkCachedPixelData* = object
    case kind: range[0 .. 1]
    of 0:
      key0: Table[string, JsonNode]
    of 1:
      key1: pointer
  LdtkEnumTags* = object
    `tileIds`*: seq[BiggestInt]
    `enumValueId`*: string
  LdtkCustomData* = object
    `data`*: string
    `tileId`*: BiggestInt
  LdtkRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkTilesets* = object
    `pxHei`*: BiggestInt
    `savedSelections`*: seq[Table[string, JsonNode]]
    `padding`*: BiggestInt
    `spacing`*: BiggestInt
    `tagsSourceEnumUid`*: LdtkTagsSourceEnumUid
    `embedAtlas`*: LdtkEmbedAtlas
    `identifier`*: string
    `cachedPixelData`*: LdtkCachedPixelData
    `enumTags`*: seq[LdtkEnumTags]
    `pxWid`*: BiggestInt
    `tileGridSize`*: BiggestInt
    `customData`*: seq[LdtkCustomData]
    `uid`*: BiggestInt
    `__cHei`*: BiggestInt
    `__cWid`*: BiggestInt
    `relPath`*: LdtkRelPath
    `tags`*: seq[string]
  LdtkLimitScope* = enum
    PerLayer, PerWorld, PerLevel
  LdtkLimitBehavior* = enum
    PreventAdding, MoveLastOne, DiscardOldOnes
  LdtkRenderMode* = enum
    Tile, Cross, Ellipse, Rectangle
  LdtkTilesetId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkMinWidth* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkTileId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkDoc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkAllowedRefsEntityUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkTextLanguageMode* = enum
    LangMarkdown, LangPython, LangLog, LangC, LangLua, LangHaxe, LangJS,
    LangRuby, , LangJson, LangXml
  LdtkEditorDisplayPos* = enum
    Beneath, Above, Center
  LdtkEditorDisplayMode* = enum
    PointPath, PointStar, ValueOnly, Hidden, Points, NameAndValue,
    ArrayCountNoLabel, EntityTile, PointPathLoop, RadiusPx, LevelTile,
    RadiusGrid, RefLinkBetweenCenters, RefLinkBetweenPivots, ArrayCountWithLabel
  LdtkRegex* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkEditorLinkStyle* = enum
    DashedLine, CurvedArrow, ArrowsLine, ZigZag, StraightArrow
  LdtkAllowedRefs* = enum
    Any, OnlyTags, OnlySame, OnlySpecificEntity
  LdtkEditorTextSuffix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkDoc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkEditorTextPrefix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkEditorDisplayColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkArrayMaxLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkArrayMinLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkMin* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  LdtkMax* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  LdtkFieldDefs* = object
    `type`*: string
    `editorDisplayScale`*: BiggestFloat
    `__type`*: string
    `allowedRefsEntityUid`*: LdtkAllowedRefsEntityUid
    `textLanguageMode`*: LdtkTextLanguageMode
    `editorAlwaysShow`*: bool
    `defaultOverride`*: JsonNode
    `autoChainRef`*: bool
    `editorDisplayPos`*: LdtkEditorDisplayPos
    `editorDisplayMode`*: LdtkEditorDisplayMode
    `identifier`*: string
    `regex`*: LdtkRegex
    `isArray`*: bool
    `editorLinkStyle`*: LdtkEditorLinkStyle
    `allowedRefs`*: LdtkAllowedRefs
    `useForSmartColor`*: bool
    `editorTextSuffix`*: LdtkEditorTextSuffix
    `doc`*: LdtkDoc
    `editorTextPrefix`*: LdtkEditorTextPrefix
    `editorCutLongValues`*: bool
    `canBeNull`*: bool
    `allowedRefTags`*: seq[string]
    `uid`*: BiggestInt
    `symmetricalRef`*: bool
    `editorDisplayColor`*: LdtkEditorDisplayColor
    `allowOutOfLevelRef`*: bool
    `acceptFileTypes`*: seq[string]
    `editorShowInWorld`*: bool
    `tilesetUid`*: LdtkTilesetUid
    `arrayMaxLength`*: LdtkArrayMaxLength
    `arrayMinLength`*: LdtkArrayMinLength
    `searchable`*: bool
    `min`*: LdtkMin
    `exportToToc`*: bool
    `max`*: LdtkMax
  LdtkTileRenderMode* = enum
    FullSizeCropped, FullSizeUncropped, Repeat, FitInside, NineSlice, Cover,
    Stretch
  LdtkUiTileRect1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  LdtkUiTileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: LdtkUiTileRect1
  LdtkMinHeight* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkTileRect1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  LdtkTileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: LdtkTileRect1
  LdtkMaxWidth* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkMaxHeight* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkEntities* = object
    `allowOutOfBounds`*: bool
    `pivotY`*: BiggestFloat
    `tileOpacity`*: BiggestFloat
    `color`*: string
    `limitScope`*: LdtkLimitScope
    `limitBehavior`*: LdtkLimitBehavior
    `hollow`*: bool
    `height`*: BiggestInt
    `renderMode`*: LdtkRenderMode
    `tilesetId`*: LdtkTilesetId
    `keepAspectRatio`*: bool
    `minWidth`*: LdtkMinWidth
    `showName`*: bool
    `resizableX`*: bool
    `identifier`*: string
    `maxCount`*: BiggestInt
    `tileId`*: LdtkTileId
    `pivotX`*: BiggestFloat
    `doc`*: LdtkDoc
    `fieldDefs`*: seq[LdtkFieldDefs]
    `uid`*: BiggestInt
    `tileRenderMode`*: LdtkTileRenderMode
    `uiTileRect`*: LdtkUiTileRect
    `resizableY`*: bool
    `lineOpacity`*: BiggestFloat
    `minHeight`*: LdtkMinHeight
    `tileRect`*: LdtkTileRect
    `nineSliceBorders`*: seq[BiggestInt]
    `maxWidth`*: LdtkMaxWidth
    `width`*: BiggestInt
    `tags`*: seq[string]
    `maxHeight`*: LdtkMaxHeight
    `exportToToc`*: bool
    `fillOpacity`*: BiggestFloat
  LdtkTileId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkTileRect1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  LdtkTileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: LdtkTileRect1
  LdtkValues* = object
    `__tileSrcRect`*: seq[BiggestInt]
    `color`*: BiggestInt
    `id`*: string
    `tileId`*: LdtkTileId
    `tileRect`*: LdtkTileRect
  LdtkExternalRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkExternalFileChecksum* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkIconTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkEnums* = object
    `values`*: seq[LdtkValues]
    `externalRelPath`*: LdtkExternalRelPath
    `identifier`*: string
    `externalFileChecksum`*: LdtkExternalFileChecksum
    `iconTilesetUid`*: LdtkIconTilesetUid
    `uid`*: BiggestInt
    `tags`*: seq[string]
  LdtkType* = enum
    Tiles, Entities, AutoLayer, IntGrid
  LdtkAutoTilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkBiomeFieldUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkAutoTilesKilledByOtherLayerUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkCollapsed* = object
    case kind: range[0 .. 1]
    of 0:
      key0: bool
    of 1:
      key1: pointer
  LdtkChecker* = enum
    Horizontal, Vertical, None
  LdtkTileMode* = enum
    Single, Stamp
  LdtkOutOfBoundsValue* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkRules* = object
    `checker`*: LdtkChecker
    `pivotY`*: BiggestFloat
    `breakOnMatch`*: bool
    `perlinOctaves`*: BiggestFloat
    `yModulo`*: BiggestInt
    `size`*: BiggestInt
    `tileMode`*: LdtkTileMode
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
    `outOfBoundsValue`*: LdtkOutOfBoundsValue
    `pivotX`*: BiggestFloat
    `flipY`*: bool
    `active`*: bool
    `uid`*: BiggestInt
    `tileIds`*: seq[BiggestInt]
    `invalidated`*: bool
    `pattern`*: seq[BiggestInt]
    `alpha`*: BiggestFloat
    `tileRectsIds`*: seq[seq[BiggestInt]]
    `tileXOffset`*: BiggestInt
    `xOffset`*: BiggestInt
    `tileRandomYMin`*: BiggestInt
    `perlinSeed`*: BiggestFloat
  LdtkIcon1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  LdtkIcon* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: LdtkIcon1
  LdtkAutoRuleGroups* = object
    `isOptional`*: bool
    `color`*: LdtkColor
    `collapsed`*: LdtkCollapsed
    `usesWizard`*: bool
    `biomeRequirementMode`*: BiggestInt
    `rules`*: seq[LdtkRules]
    `icon`*: LdtkIcon
    `active`*: bool
    `uid`*: BiggestInt
    `name`*: string
    `requiredBiomeValues`*: seq[string]
  LdtkTilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkUiColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkDoc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkAutoSourceLayerDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkIdentifier* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkIntGridValuesGroups* = object
    `color`*: LdtkColor
    `identifier`*: LdtkIdentifier
    `uid`*: BiggestInt
  LdtkTile1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  LdtkTile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: LdtkTile1
  LdtkIdentifier* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkIntGridValues* = object
    `tile`*: LdtkTile
    `color`*: string
    `identifier`*: LdtkIdentifier
    `groupUid`*: BiggestInt
    `value`*: BiggestInt
  LdtkLayers* = object
    `type`*: LdtkType
    `autoTilesetDefUid`*: LdtkAutoTilesetDefUid
    `parallaxScaling`*: bool
    `biomeFieldUid`*: LdtkBiomeFieldUid
    `autoTilesKilledByOtherLayerUid`*: LdtkAutoTilesKilledByOtherLayerUid
    `inactiveOpacity`*: BiggestFloat
    `__type`*: string
    `autoRuleGroups`*: seq[LdtkAutoRuleGroups]
    `gridSize`*: BiggestInt
    `hideInList`*: bool
    `tilesetDefUid`*: LdtkTilesetDefUid
    `uiColor`*: LdtkUiColor
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
    `doc`*: LdtkDoc
    `uid`*: BiggestInt
    `guideGridHei`*: BiggestInt
    `autoSourceLayerDefUid`*: LdtkAutoSourceLayerDefUid
    `displayOpacity`*: BiggestFloat
    `intGridValuesGroups`*: seq[LdtkIntGridValuesGroups]
    `hideFieldsWhenInactive`*: bool
    `useAsyncRender`*: bool
    `pxOffsetY`*: BiggestInt
    `parallaxFactorY`*: BiggestFloat
    `intGridValues`*: seq[LdtkIntGridValues]
    `renderInWorldView`*: bool
  LdtkTileId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkTileRect1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  LdtkTileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: LdtkTileRect1
  LdtkValues* = object
    `__tileSrcRect`*: seq[BiggestInt]
    `color`*: BiggestInt
    `id`*: string
    `tileId`*: LdtkTileId
    `tileRect`*: LdtkTileRect
  LdtkExternalRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkExternalFileChecksum* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkIconTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkExternalEnums* = object
    `values`*: seq[LdtkValues]
    `externalRelPath`*: LdtkExternalRelPath
    `identifier`*: string
    `externalFileChecksum`*: LdtkExternalFileChecksum
    `iconTilesetUid`*: LdtkIconTilesetUid
    `uid`*: BiggestInt
    `tags`*: seq[string]
  LdtkDefinitions* = object
    `levelFields`*: seq[LdtkLevelFields]
    `tilesets`*: seq[LdtkTilesets]
    `entities`*: seq[LdtkEntities]
    `enums`*: seq[LdtkEnums]
    `layers`*: seq[LdtkLayers]
    `externalEnums`*: seq[LdtkExternalEnums]
  LdtkTileId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkTileRect1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  LdtkTileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: LdtkTileRect1
  LdtkValues* = object
    `__tileSrcRect`*: seq[BiggestInt]
    `color`*: BiggestInt
    `id`*: string
    `tileId`*: LdtkTileId
    `tileRect`*: LdtkTileRect
  LdtkExternalRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkExternalFileChecksum* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkIconTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkEnumDef* = object
    `values`*: seq[LdtkValues]
    `externalRelPath`*: LdtkExternalRelPath
    `identifier`*: string
    `externalFileChecksum`*: LdtkExternalFileChecksum
    `iconTilesetUid`*: LdtkIconTilesetUid
    `uid`*: BiggestInt
    `tags`*: seq[string]
  LdtkAllowedRefsEntityUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkTextLanguageMode* = enum
    LangMarkdown, LangPython, LangLog, LangC, LangLua, LangHaxe, LangJS,
    LangRuby, , LangJson, LangXml
  LdtkEditorDisplayPos* = enum
    Beneath, Above, Center
  LdtkEditorDisplayMode* = enum
    PointPath, PointStar, ValueOnly, Hidden, Points, NameAndValue,
    ArrayCountNoLabel, EntityTile, PointPathLoop, RadiusPx, LevelTile,
    RadiusGrid, RefLinkBetweenCenters, RefLinkBetweenPivots, ArrayCountWithLabel
  LdtkRegex* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkEditorLinkStyle* = enum
    DashedLine, CurvedArrow, ArrowsLine, ZigZag, StraightArrow
  LdtkAllowedRefs* = enum
    Any, OnlyTags, OnlySame, OnlySpecificEntity
  LdtkEditorTextSuffix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkDoc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkEditorTextPrefix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkEditorDisplayColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkArrayMaxLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkArrayMinLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkMin* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  LdtkMax* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  LdtkFieldDef* = object
    `type`*: string
    `editorDisplayScale`*: BiggestFloat
    `__type`*: string
    `allowedRefsEntityUid`*: LdtkAllowedRefsEntityUid
    `textLanguageMode`*: LdtkTextLanguageMode
    `editorAlwaysShow`*: bool
    `defaultOverride`*: JsonNode
    `autoChainRef`*: bool
    `editorDisplayPos`*: LdtkEditorDisplayPos
    `editorDisplayMode`*: LdtkEditorDisplayMode
    `identifier`*: string
    `regex`*: LdtkRegex
    `isArray`*: bool
    `editorLinkStyle`*: LdtkEditorLinkStyle
    `allowedRefs`*: LdtkAllowedRefs
    `useForSmartColor`*: bool
    `editorTextSuffix`*: LdtkEditorTextSuffix
    `doc`*: LdtkDoc
    `editorTextPrefix`*: LdtkEditorTextPrefix
    `editorCutLongValues`*: bool
    `canBeNull`*: bool
    `allowedRefTags`*: seq[string]
    `uid`*: BiggestInt
    `symmetricalRef`*: bool
    `editorDisplayColor`*: LdtkEditorDisplayColor
    `allowOutOfLevelRef`*: bool
    `acceptFileTypes`*: seq[string]
    `editorShowInWorld`*: bool
    `tilesetUid`*: LdtkTilesetUid
    `arrayMaxLength`*: LdtkArrayMaxLength
    `arrayMinLength`*: LdtkArrayMinLength
    `searchable`*: bool
    `min`*: LdtkMin
    `exportToToc`*: bool
    `max`*: LdtkMax
  LdtkColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkCollapsed* = object
    case kind: range[0 .. 1]
    of 0:
      key0: bool
    of 1:
      key1: pointer
  LdtkChecker* = enum
    Horizontal, Vertical, None
  LdtkTileMode* = enum
    Single, Stamp
  LdtkOutOfBoundsValue* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkRules* = object
    `checker`*: LdtkChecker
    `pivotY`*: BiggestFloat
    `breakOnMatch`*: bool
    `perlinOctaves`*: BiggestFloat
    `yModulo`*: BiggestInt
    `size`*: BiggestInt
    `tileMode`*: LdtkTileMode
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
    `outOfBoundsValue`*: LdtkOutOfBoundsValue
    `pivotX`*: BiggestFloat
    `flipY`*: bool
    `active`*: bool
    `uid`*: BiggestInt
    `tileIds`*: seq[BiggestInt]
    `invalidated`*: bool
    `pattern`*: seq[BiggestInt]
    `alpha`*: BiggestFloat
    `tileRectsIds`*: seq[seq[BiggestInt]]
    `tileXOffset`*: BiggestInt
    `xOffset`*: BiggestInt
    `tileRandomYMin`*: BiggestInt
    `perlinSeed`*: BiggestFloat
  LdtkIcon1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  LdtkIcon* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: LdtkIcon1
  LdtkAutoLayerRuleGroup* = object
    `isOptional`*: bool
    `color`*: LdtkColor
    `collapsed`*: LdtkCollapsed
    `usesWizard`*: bool
    `biomeRequirementMode`*: BiggestInt
    `rules`*: seq[LdtkRules]
    `icon`*: LdtkIcon
    `active`*: bool
    `uid`*: BiggestInt
    `name`*: string
    `requiredBiomeValues`*: seq[string]
  LdtkTagsSourceEnumUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkEmbedAtlas* = enum
    LdtkIcons, 
  LdtkCachedPixelData* = object
    case kind: range[0 .. 1]
    of 0:
      key0: Table[string, JsonNode]
    of 1:
      key1: pointer
  LdtkEnumTags* = object
    `tileIds`*: seq[BiggestInt]
    `enumValueId`*: string
  LdtkCustomData* = object
    `data`*: string
    `tileId`*: BiggestInt
  LdtkRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkTilesetDef* = object
    `pxHei`*: BiggestInt
    `savedSelections`*: seq[Table[string, JsonNode]]
    `padding`*: BiggestInt
    `spacing`*: BiggestInt
    `tagsSourceEnumUid`*: LdtkTagsSourceEnumUid
    `embedAtlas`*: LdtkEmbedAtlas
    `identifier`*: string
    `cachedPixelData`*: LdtkCachedPixelData
    `enumTags`*: seq[LdtkEnumTags]
    `pxWid`*: BiggestInt
    `tileGridSize`*: BiggestInt
    `customData`*: seq[LdtkCustomData]
    `uid`*: BiggestInt
    `__cHei`*: BiggestInt
    `__cWid`*: BiggestInt
    `relPath`*: LdtkRelPath
    `tags`*: seq[string]
  LdtkIids* = object
    `layerIid`*: string
    `levelIid`*: string
    `entityIid`*: string
    `worldIid`*: string
  LdtkInstancesData* = object
    `worldY`*: BiggestInt
    `fields`*: JsonNode
    `widPx`*: BiggestInt
    `iids`*: LdtkIids
    `heiPx`*: BiggestInt
    `worldX`*: BiggestInt
  LdtkInstances* = object
    `layerIid`*: string
    `levelIid`*: string
    `entityIid`*: string
    `worldIid`*: string
  LdtkTableOfContentEntry* = object
    `instancesData`*: seq[LdtkInstancesData]
    `identifier`*: string
    `instances`*: seq[LdtkInstances]
  LdtkLimitScope* = enum
    PerLayer, PerWorld, PerLevel
  LdtkLimitBehavior* = enum
    PreventAdding, MoveLastOne, DiscardOldOnes
  LdtkRenderMode* = enum
    Tile, Cross, Ellipse, Rectangle
  LdtkTilesetId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkMinWidth* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkTileId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkDoc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkAllowedRefsEntityUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkTextLanguageMode* = enum
    LangMarkdown, LangPython, LangLog, LangC, LangLua, LangHaxe, LangJS,
    LangRuby, , LangJson, LangXml
  LdtkEditorDisplayPos* = enum
    Beneath, Above, Center
  LdtkEditorDisplayMode* = enum
    PointPath, PointStar, ValueOnly, Hidden, Points, NameAndValue,
    ArrayCountNoLabel, EntityTile, PointPathLoop, RadiusPx, LevelTile,
    RadiusGrid, RefLinkBetweenCenters, RefLinkBetweenPivots, ArrayCountWithLabel
  LdtkRegex* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkEditorLinkStyle* = enum
    DashedLine, CurvedArrow, ArrowsLine, ZigZag, StraightArrow
  LdtkAllowedRefs* = enum
    Any, OnlyTags, OnlySame, OnlySpecificEntity
  LdtkEditorTextSuffix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkDoc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkEditorTextPrefix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkEditorDisplayColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkArrayMaxLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkArrayMinLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkMin* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  LdtkMax* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  LdtkFieldDefs* = object
    `type`*: string
    `editorDisplayScale`*: BiggestFloat
    `__type`*: string
    `allowedRefsEntityUid`*: LdtkAllowedRefsEntityUid
    `textLanguageMode`*: LdtkTextLanguageMode
    `editorAlwaysShow`*: bool
    `defaultOverride`*: JsonNode
    `autoChainRef`*: bool
    `editorDisplayPos`*: LdtkEditorDisplayPos
    `editorDisplayMode`*: LdtkEditorDisplayMode
    `identifier`*: string
    `regex`*: LdtkRegex
    `isArray`*: bool
    `editorLinkStyle`*: LdtkEditorLinkStyle
    `allowedRefs`*: LdtkAllowedRefs
    `useForSmartColor`*: bool
    `editorTextSuffix`*: LdtkEditorTextSuffix
    `doc`*: LdtkDoc
    `editorTextPrefix`*: LdtkEditorTextPrefix
    `editorCutLongValues`*: bool
    `canBeNull`*: bool
    `allowedRefTags`*: seq[string]
    `uid`*: BiggestInt
    `symmetricalRef`*: bool
    `editorDisplayColor`*: LdtkEditorDisplayColor
    `allowOutOfLevelRef`*: bool
    `acceptFileTypes`*: seq[string]
    `editorShowInWorld`*: bool
    `tilesetUid`*: LdtkTilesetUid
    `arrayMaxLength`*: LdtkArrayMaxLength
    `arrayMinLength`*: LdtkArrayMinLength
    `searchable`*: bool
    `min`*: LdtkMin
    `exportToToc`*: bool
    `max`*: LdtkMax
  LdtkTileRenderMode* = enum
    FullSizeCropped, FullSizeUncropped, Repeat, FitInside, NineSlice, Cover,
    Stretch
  LdtkUiTileRect1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  LdtkUiTileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: LdtkUiTileRect1
  LdtkMinHeight* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkTileRect1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  LdtkTileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: LdtkTileRect1
  LdtkMaxWidth* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkMaxHeight* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkEntityDef* = object
    `allowOutOfBounds`*: bool
    `pivotY`*: BiggestFloat
    `tileOpacity`*: BiggestFloat
    `color`*: string
    `limitScope`*: LdtkLimitScope
    `limitBehavior`*: LdtkLimitBehavior
    `hollow`*: bool
    `height`*: BiggestInt
    `renderMode`*: LdtkRenderMode
    `tilesetId`*: LdtkTilesetId
    `keepAspectRatio`*: bool
    `minWidth`*: LdtkMinWidth
    `showName`*: bool
    `resizableX`*: bool
    `identifier`*: string
    `maxCount`*: BiggestInt
    `tileId`*: LdtkTileId
    `pivotX`*: BiggestFloat
    `doc`*: LdtkDoc
    `fieldDefs`*: seq[LdtkFieldDefs]
    `uid`*: BiggestInt
    `tileRenderMode`*: LdtkTileRenderMode
    `uiTileRect`*: LdtkUiTileRect
    `resizableY`*: bool
    `lineOpacity`*: BiggestFloat
    `minHeight`*: LdtkMinHeight
    `tileRect`*: LdtkTileRect
    `nineSliceBorders`*: seq[BiggestInt]
    `maxWidth`*: LdtkMaxWidth
    `width`*: BiggestInt
    `tags`*: seq[string]
    `maxHeight`*: LdtkMaxHeight
    `exportToToc`*: bool
    `fillOpacity`*: BiggestFloat
  Ldtk__tile1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  Ldtk__tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: Ldtk__tile1
  LdtkFieldInstance* = object
    `realEditorValues`*: seq[JsonNode]
    `__value`*: JsonNode
    `__tile`*: Ldtk__tile
    `__type`*: string
    `__identifier`*: string
    `defUid`*: BiggestInt
  LdtkEntityReferenceInfos* = object
    `layerIid`*: string
    `levelIid`*: string
    `entityIid`*: string
    `worldIid`*: string
  LdtkLevelBgPosInfos* = object
    `scale`*: seq[BiggestFloat]
    `cropRect`*: seq[BiggestFloat]
    `topLeftPx`*: seq[BiggestInt]
  LdtkTileCustomMetadata* = object
    `data`*: string
    `tileId`*: BiggestInt
  LdtkTile* = object
    `px`*: seq[BiggestInt]
    `t`*: BiggestInt
    `d`*: seq[BiggestInt]
    `a`*: BiggestFloat
    `src`*: seq[BiggestInt]
    `f`*: BiggestInt
  LdtkChecker* = enum
    Horizontal, Vertical, None
  LdtkTileMode* = enum
    Single, Stamp
  LdtkOutOfBoundsValue* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkAutoRuleDef* = object
    `checker`*: LdtkChecker
    `pivotY`*: BiggestFloat
    `breakOnMatch`*: bool
    `perlinOctaves`*: BiggestFloat
    `yModulo`*: BiggestInt
    `size`*: BiggestInt
    `tileMode`*: LdtkTileMode
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
    `outOfBoundsValue`*: LdtkOutOfBoundsValue
    `pivotX`*: BiggestFloat
    `flipY`*: bool
    `active`*: bool
    `uid`*: BiggestInt
    `tileIds`*: seq[BiggestInt]
    `invalidated`*: bool
    `pattern`*: seq[BiggestInt]
    `alpha`*: BiggestFloat
    `tileRectsIds`*: seq[seq[BiggestInt]]
    `tileXOffset`*: BiggestInt
    `xOffset`*: BiggestInt
    `tileRandomYMin`*: BiggestInt
    `perlinSeed`*: BiggestFloat
  LdtkLevelUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkNeighbourLevel* = object
    `levelUid`*: LdtkLevelUid
    `levelIid`*: string
    `dir`*: string
  LdtkGridPoint* = object
    `cx`*: BiggestInt
    `cy`*: BiggestInt
  Ldtk__worldY* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  Ldtk__tile1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  Ldtk__tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: Ldtk__tile1
  Ldtk__tile1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  Ldtk__tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: Ldtk__tile1
  LdtkFieldInstances* = object
    `realEditorValues`*: seq[JsonNode]
    `__value`*: JsonNode
    `__tile`*: Ldtk__tile
    `__type`*: string
    `__identifier`*: string
    `defUid`*: BiggestInt
  Ldtk__worldX* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkEntityInstance* = object
    `__worldY`*: Ldtk__worldY
    `__tile`*: Ldtk__tile
    `__identifier`*: string
    `__tags`*: seq[string]
    `height`*: BiggestInt
    `px`*: seq[BiggestInt]
    `defUid`*: BiggestInt
    `__pivot`*: seq[BiggestFloat]
    `fieldInstances`*: seq[LdtkFieldInstances]
    `iid`*: string
    `width`*: BiggestInt
    `__worldX`*: Ldtk__worldX
    `__grid`*: seq[BiggestInt]
    `__smartColor`*: string
  LdtkTilesetRect* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  LdtkEnumTagValue* = object
    `tileIds`*: seq[BiggestInt]
    `enumValueId`*: string
  LdtkGridTiles* = object
    `px`*: seq[BiggestInt]
    `t`*: BiggestInt
    `d`*: seq[BiggestInt]
    `a`*: BiggestFloat
    `src`*: seq[BiggestInt]
    `f`*: BiggestInt
  LdtkOverrideTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkIntGrid* = object
    `coordId`*: BiggestInt
    `v`*: BiggestInt
  LdtkAutoLayerTiles* = object
    `px`*: seq[BiggestInt]
    `t`*: BiggestInt
    `d`*: seq[BiggestInt]
    `a`*: BiggestFloat
    `src`*: seq[BiggestInt]
    `f`*: BiggestInt
  Ldtk__worldY* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  Ldtk__tile1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  Ldtk__tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: Ldtk__tile1
  Ldtk__tile1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  Ldtk__tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: Ldtk__tile1
  LdtkFieldInstances* = object
    `realEditorValues`*: seq[JsonNode]
    `__value`*: JsonNode
    `__tile`*: Ldtk__tile
    `__type`*: string
    `__identifier`*: string
    `defUid`*: BiggestInt
  Ldtk__worldX* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkEntityInstances* = object
    `__worldY`*: Ldtk__worldY
    `__tile`*: Ldtk__tile
    `__identifier`*: string
    `__tags`*: seq[string]
    `height`*: BiggestInt
    `px`*: seq[BiggestInt]
    `defUid`*: BiggestInt
    `__pivot`*: seq[BiggestFloat]
    `fieldInstances`*: seq[LdtkFieldInstances]
    `iid`*: string
    `width`*: BiggestInt
    `__worldX`*: Ldtk__worldX
    `__grid`*: seq[BiggestInt]
    `__smartColor`*: string
  Ldtk__tilesetRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  Ldtk__tilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkLayerInstance* = object
    `__opacity`*: BiggestFloat
    `optionalRules`*: seq[BiggestInt]
    `__gridSize`*: BiggestInt
    `__pxTotalOffsetX`*: BiggestInt
    `gridTiles`*: seq[LdtkGridTiles]
    `__type`*: string
    `__identifier`*: string
    `overrideTilesetUid`*: LdtkOverrideTilesetUid
    `levelId`*: BiggestInt
    `intGrid`*: seq[LdtkIntGrid]
    `autoLayerTiles`*: seq[LdtkAutoLayerTiles]
    `layerDefUid`*: BiggestInt
    `entityInstances`*: seq[LdtkEntityInstances]
    `intGridCsv`*: seq[BiggestInt]
    `pxOffsetX`*: BiggestInt
    `__tilesetRelPath`*: Ldtk__tilesetRelPath
    `__tilesetDefUid`*: Ldtk__tilesetDefUid
    `__cHei`*: BiggestInt
    `seed`*: BiggestInt
    `visible`*: bool
    `pxOffsetY`*: BiggestInt
    `iid`*: string
    `__pxTotalOffsetY`*: BiggestInt
    `__cWid`*: BiggestInt
  LdtkIntGridValueInstance* = object
    `coordId`*: BiggestInt
    `v`*: BiggestInt
  LdtkWorldLayout* = enum
    LinearHorizontal, LinearVertical, , GridVania, Free
  LdtkBgColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkExternalRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkBgRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkLevelUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  Ldtk__neighbours* = object
    `levelUid`*: LdtkLevelUid
    `levelIid`*: string
    `dir`*: string
  LdtkBgPos* = enum
    CoverDirty, Repeat, , Contain, Cover, Unscaled
  LdtkGridTiles* = object
    `px`*: seq[BiggestInt]
    `t`*: BiggestInt
    `d`*: seq[BiggestInt]
    `a`*: BiggestFloat
    `src`*: seq[BiggestInt]
    `f`*: BiggestInt
  LdtkOverrideTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkIntGrid* = object
    `coordId`*: BiggestInt
    `v`*: BiggestInt
  LdtkAutoLayerTiles* = object
    `px`*: seq[BiggestInt]
    `t`*: BiggestInt
    `d`*: seq[BiggestInt]
    `a`*: BiggestFloat
    `src`*: seq[BiggestInt]
    `f`*: BiggestInt
  Ldtk__worldY* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  Ldtk__tile1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  Ldtk__tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: Ldtk__tile1
  Ldtk__tile1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  Ldtk__tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: Ldtk__tile1
  LdtkFieldInstances* = object
    `realEditorValues`*: seq[JsonNode]
    `__value`*: JsonNode
    `__tile`*: Ldtk__tile
    `__type`*: string
    `__identifier`*: string
    `defUid`*: BiggestInt
  Ldtk__worldX* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkEntityInstances* = object
    `__worldY`*: Ldtk__worldY
    `__tile`*: Ldtk__tile
    `__identifier`*: string
    `__tags`*: seq[string]
    `height`*: BiggestInt
    `px`*: seq[BiggestInt]
    `defUid`*: BiggestInt
    `__pivot`*: seq[BiggestFloat]
    `fieldInstances`*: seq[LdtkFieldInstances]
    `iid`*: string
    `width`*: BiggestInt
    `__worldX`*: Ldtk__worldX
    `__grid`*: seq[BiggestInt]
    `__smartColor`*: string
  Ldtk__tilesetRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  Ldtk__tilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkLayerInstances* = object
    `__opacity`*: BiggestFloat
    `optionalRules`*: seq[BiggestInt]
    `__gridSize`*: BiggestInt
    `__pxTotalOffsetX`*: BiggestInt
    `gridTiles`*: seq[LdtkGridTiles]
    `__type`*: string
    `__identifier`*: string
    `overrideTilesetUid`*: LdtkOverrideTilesetUid
    `levelId`*: BiggestInt
    `intGrid`*: seq[LdtkIntGrid]
    `autoLayerTiles`*: seq[LdtkAutoLayerTiles]
    `layerDefUid`*: BiggestInt
    `entityInstances`*: seq[LdtkEntityInstances]
    `intGridCsv`*: seq[BiggestInt]
    `pxOffsetX`*: BiggestInt
    `__tilesetRelPath`*: Ldtk__tilesetRelPath
    `__tilesetDefUid`*: Ldtk__tilesetDefUid
    `__cHei`*: BiggestInt
    `seed`*: BiggestInt
    `visible`*: bool
    `pxOffsetY`*: BiggestInt
    `iid`*: string
    `__pxTotalOffsetY`*: BiggestInt
    `__cWid`*: BiggestInt
  Ldtk__tile1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  Ldtk__tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: Ldtk__tile1
  LdtkFieldInstances* = object
    `realEditorValues`*: seq[JsonNode]
    `__value`*: JsonNode
    `__tile`*: Ldtk__tile
    `__type`*: string
    `__identifier`*: string
    `defUid`*: BiggestInt
  Ldtk__bgPos1* = object
    `scale`*: seq[BiggestFloat]
    `cropRect`*: seq[BiggestFloat]
    `topLeftPx`*: seq[BiggestInt]
  Ldtk__bgPos* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: Ldtk__bgPos1
  LdtkLevels* = object
    `pxHei`*: BiggestInt
    `useAutoIdentifier`*: bool
    `__bgColor`*: string
    `bgColor`*: LdtkBgColor
    `externalRelPath`*: LdtkExternalRelPath
    `worldY`*: BiggestInt
    `bgRelPath`*: LdtkBgRelPath
    `identifier`*: string
    `pxWid`*: BiggestInt
    `worldDepth`*: BiggestInt
    `bgPivotX`*: BiggestFloat
    `__neighbours`*: seq[Ldtk__neighbours]
    `uid`*: BiggestInt
    `bgPos`*: LdtkBgPos
    `layerInstances`*: seq[LdtkLayerInstances]
    `fieldInstances`*: seq[LdtkFieldInstances]
    `__bgPos`*: Ldtk__bgPos
    `worldX`*: BiggestInt
    `iid`*: string
    `bgPivotY`*: BiggestFloat
    `__smartColor`*: string
  LdtkWorld* = object
    `worldGridWidth`*: BiggestInt
    `defaultLevelHeight`*: BiggestInt
    `identifier`*: string
    `worldLayout`*: LdtkWorldLayout
    `iid`*: string
    `defaultLevelWidth`*: BiggestInt
    `worldGridHeight`*: BiggestInt
    `levels`*: seq[LdtkLevels]
  LdtkType* = enum
    Tiles, Entities, AutoLayer, IntGrid
  LdtkAutoTilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkBiomeFieldUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkAutoTilesKilledByOtherLayerUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkCollapsed* = object
    case kind: range[0 .. 1]
    of 0:
      key0: bool
    of 1:
      key1: pointer
  LdtkChecker* = enum
    Horizontal, Vertical, None
  LdtkTileMode* = enum
    Single, Stamp
  LdtkOutOfBoundsValue* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkRules* = object
    `checker`*: LdtkChecker
    `pivotY`*: BiggestFloat
    `breakOnMatch`*: bool
    `perlinOctaves`*: BiggestFloat
    `yModulo`*: BiggestInt
    `size`*: BiggestInt
    `tileMode`*: LdtkTileMode
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
    `outOfBoundsValue`*: LdtkOutOfBoundsValue
    `pivotX`*: BiggestFloat
    `flipY`*: bool
    `active`*: bool
    `uid`*: BiggestInt
    `tileIds`*: seq[BiggestInt]
    `invalidated`*: bool
    `pattern`*: seq[BiggestInt]
    `alpha`*: BiggestFloat
    `tileRectsIds`*: seq[seq[BiggestInt]]
    `tileXOffset`*: BiggestInt
    `xOffset`*: BiggestInt
    `tileRandomYMin`*: BiggestInt
    `perlinSeed`*: BiggestFloat
  LdtkIcon1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  LdtkIcon* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: LdtkIcon1
  LdtkAutoRuleGroups* = object
    `isOptional`*: bool
    `color`*: LdtkColor
    `collapsed`*: LdtkCollapsed
    `usesWizard`*: bool
    `biomeRequirementMode`*: BiggestInt
    `rules`*: seq[LdtkRules]
    `icon`*: LdtkIcon
    `active`*: bool
    `uid`*: BiggestInt
    `name`*: string
    `requiredBiomeValues`*: seq[string]
  LdtkTilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkUiColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkDoc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkAutoSourceLayerDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkIdentifier* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkIntGridValuesGroups* = object
    `color`*: LdtkColor
    `identifier`*: LdtkIdentifier
    `uid`*: BiggestInt
  LdtkTile1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  LdtkTile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: LdtkTile1
  LdtkIdentifier* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkIntGridValues* = object
    `tile`*: LdtkTile
    `color`*: string
    `identifier`*: LdtkIdentifier
    `groupUid`*: BiggestInt
    `value`*: BiggestInt
  LdtkLayerDef* = object
    `type`*: LdtkType
    `autoTilesetDefUid`*: LdtkAutoTilesetDefUid
    `parallaxScaling`*: bool
    `biomeFieldUid`*: LdtkBiomeFieldUid
    `autoTilesKilledByOtherLayerUid`*: LdtkAutoTilesKilledByOtherLayerUid
    `inactiveOpacity`*: BiggestFloat
    `__type`*: string
    `autoRuleGroups`*: seq[LdtkAutoRuleGroups]
    `gridSize`*: BiggestInt
    `hideInList`*: bool
    `tilesetDefUid`*: LdtkTilesetDefUid
    `uiColor`*: LdtkUiColor
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
    `doc`*: LdtkDoc
    `uid`*: BiggestInt
    `guideGridHei`*: BiggestInt
    `autoSourceLayerDefUid`*: LdtkAutoSourceLayerDefUid
    `displayOpacity`*: BiggestFloat
    `intGridValuesGroups`*: seq[LdtkIntGridValuesGroups]
    `hideFieldsWhenInactive`*: bool
    `useAsyncRender`*: bool
    `pxOffsetY`*: BiggestInt
    `parallaxFactorY`*: BiggestFloat
    `intGridValues`*: seq[LdtkIntGridValues]
    `renderInWorldView`*: bool
  LdtkColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkIdentifier* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkIntGridValueGroupDef* = object
    `color`*: LdtkColor
    `identifier`*: LdtkIdentifier
    `uid`*: BiggestInt
  LdtkIids* = object
    `layerIid`*: string
    `levelIid`*: string
    `entityIid`*: string
    `worldIid`*: string
  LdtkTocInstanceData* = object
    `worldY`*: BiggestInt
    `fields`*: JsonNode
    `widPx`*: BiggestInt
    `iids`*: LdtkIids
    `heiPx`*: BiggestInt
    `worldX`*: BiggestInt
  LdtkTileId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkTileRect1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  LdtkTileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: LdtkTileRect1
  LdtkEnumDefValues* = object
    `__tileSrcRect`*: seq[BiggestInt]
    `color`*: BiggestInt
    `id`*: string
    `tileId`*: LdtkTileId
    `tileRect`*: LdtkTileRect
  Ldtk__FORCED_REFS* = object
    `CustomCommand`*: LdtkCustomCommand
    `IntGridValueDef`*: LdtkIntGridValueDef
    `Level`*: LdtkLevel
    `Definitions`*: LdtkDefinitions
    `EnumDef`*: LdtkEnumDef
    `FieldDef`*: LdtkFieldDef
    `AutoLayerRuleGroup`*: LdtkAutoLayerRuleGroup
    `TilesetDef`*: LdtkTilesetDef
    `TableOfContentEntry`*: LdtkTableOfContentEntry
    `EntityDef`*: LdtkEntityDef
    `FieldInstance`*: LdtkFieldInstance
    `EntityReferenceInfos`*: LdtkEntityReferenceInfos
    `LevelBgPosInfos`*: LdtkLevelBgPosInfos
    `TileCustomMetadata`*: LdtkTileCustomMetadata
    `Tile`*: LdtkTile
    `AutoRuleDef`*: LdtkAutoRuleDef
    `NeighbourLevel`*: LdtkNeighbourLevel
    `GridPoint`*: LdtkGridPoint
    `EntityInstance`*: LdtkEntityInstance
    `TilesetRect`*: LdtkTilesetRect
    `EnumTagValue`*: LdtkEnumTagValue
    `LayerInstance`*: LdtkLayerInstance
    `IntGridValueInstance`*: LdtkIntGridValueInstance
    `World`*: LdtkWorld
    `LayerDef`*: LdtkLayerDef
    `IntGridValueGroupDef`*: LdtkIntGridValueGroupDef
    `TocInstanceData`*: LdtkTocInstanceData
    `EnumDefValues`*: LdtkEnumDefValues
  LdtkAllowedRefsEntityUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkTextLanguageMode* = enum
    LangMarkdown, LangPython, LangLog, LangC, LangLua, LangHaxe, LangJS,
    LangRuby, , LangJson, LangXml
  LdtkEditorDisplayPos* = enum
    Beneath, Above, Center
  LdtkEditorDisplayMode* = enum
    PointPath, PointStar, ValueOnly, Hidden, Points, NameAndValue,
    ArrayCountNoLabel, EntityTile, PointPathLoop, RadiusPx, LevelTile,
    RadiusGrid, RefLinkBetweenCenters, RefLinkBetweenPivots, ArrayCountWithLabel
  LdtkRegex* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkEditorLinkStyle* = enum
    DashedLine, CurvedArrow, ArrowsLine, ZigZag, StraightArrow
  LdtkAllowedRefs* = enum
    Any, OnlyTags, OnlySame, OnlySpecificEntity
  LdtkEditorTextSuffix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkDoc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkEditorTextPrefix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkEditorDisplayColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkArrayMaxLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkArrayMinLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkMin* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  LdtkMax* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  LdtkLevelFields* = object
    `type`*: string
    `editorDisplayScale`*: BiggestFloat
    `__type`*: string
    `allowedRefsEntityUid`*: LdtkAllowedRefsEntityUid
    `textLanguageMode`*: LdtkTextLanguageMode
    `editorAlwaysShow`*: bool
    `defaultOverride`*: JsonNode
    `autoChainRef`*: bool
    `editorDisplayPos`*: LdtkEditorDisplayPos
    `editorDisplayMode`*: LdtkEditorDisplayMode
    `identifier`*: string
    `regex`*: LdtkRegex
    `isArray`*: bool
    `editorLinkStyle`*: LdtkEditorLinkStyle
    `allowedRefs`*: LdtkAllowedRefs
    `useForSmartColor`*: bool
    `editorTextSuffix`*: LdtkEditorTextSuffix
    `doc`*: LdtkDoc
    `editorTextPrefix`*: LdtkEditorTextPrefix
    `editorCutLongValues`*: bool
    `canBeNull`*: bool
    `allowedRefTags`*: seq[string]
    `uid`*: BiggestInt
    `symmetricalRef`*: bool
    `editorDisplayColor`*: LdtkEditorDisplayColor
    `allowOutOfLevelRef`*: bool
    `acceptFileTypes`*: seq[string]
    `editorShowInWorld`*: bool
    `tilesetUid`*: LdtkTilesetUid
    `arrayMaxLength`*: LdtkArrayMaxLength
    `arrayMinLength`*: LdtkArrayMinLength
    `searchable`*: bool
    `min`*: LdtkMin
    `exportToToc`*: bool
    `max`*: LdtkMax
  LdtkTagsSourceEnumUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkEmbedAtlas* = enum
    LdtkIcons, 
  LdtkCachedPixelData* = object
    case kind: range[0 .. 1]
    of 0:
      key0: Table[string, JsonNode]
    of 1:
      key1: pointer
  LdtkEnumTags* = object
    `tileIds`*: seq[BiggestInt]
    `enumValueId`*: string
  LdtkCustomData* = object
    `data`*: string
    `tileId`*: BiggestInt
  LdtkRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkTilesets* = object
    `pxHei`*: BiggestInt
    `savedSelections`*: seq[Table[string, JsonNode]]
    `padding`*: BiggestInt
    `spacing`*: BiggestInt
    `tagsSourceEnumUid`*: LdtkTagsSourceEnumUid
    `embedAtlas`*: LdtkEmbedAtlas
    `identifier`*: string
    `cachedPixelData`*: LdtkCachedPixelData
    `enumTags`*: seq[LdtkEnumTags]
    `pxWid`*: BiggestInt
    `tileGridSize`*: BiggestInt
    `customData`*: seq[LdtkCustomData]
    `uid`*: BiggestInt
    `__cHei`*: BiggestInt
    `__cWid`*: BiggestInt
    `relPath`*: LdtkRelPath
    `tags`*: seq[string]
  LdtkLimitScope* = enum
    PerLayer, PerWorld, PerLevel
  LdtkLimitBehavior* = enum
    PreventAdding, MoveLastOne, DiscardOldOnes
  LdtkRenderMode* = enum
    Tile, Cross, Ellipse, Rectangle
  LdtkTilesetId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkMinWidth* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkTileId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkDoc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkAllowedRefsEntityUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkTextLanguageMode* = enum
    LangMarkdown, LangPython, LangLog, LangC, LangLua, LangHaxe, LangJS,
    LangRuby, , LangJson, LangXml
  LdtkEditorDisplayPos* = enum
    Beneath, Above, Center
  LdtkEditorDisplayMode* = enum
    PointPath, PointStar, ValueOnly, Hidden, Points, NameAndValue,
    ArrayCountNoLabel, EntityTile, PointPathLoop, RadiusPx, LevelTile,
    RadiusGrid, RefLinkBetweenCenters, RefLinkBetweenPivots, ArrayCountWithLabel
  LdtkRegex* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkEditorLinkStyle* = enum
    DashedLine, CurvedArrow, ArrowsLine, ZigZag, StraightArrow
  LdtkAllowedRefs* = enum
    Any, OnlyTags, OnlySame, OnlySpecificEntity
  LdtkEditorTextSuffix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkDoc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkEditorTextPrefix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkEditorDisplayColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkArrayMaxLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkArrayMinLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkMin* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  LdtkMax* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  LdtkFieldDefs* = object
    `type`*: string
    `editorDisplayScale`*: BiggestFloat
    `__type`*: string
    `allowedRefsEntityUid`*: LdtkAllowedRefsEntityUid
    `textLanguageMode`*: LdtkTextLanguageMode
    `editorAlwaysShow`*: bool
    `defaultOverride`*: JsonNode
    `autoChainRef`*: bool
    `editorDisplayPos`*: LdtkEditorDisplayPos
    `editorDisplayMode`*: LdtkEditorDisplayMode
    `identifier`*: string
    `regex`*: LdtkRegex
    `isArray`*: bool
    `editorLinkStyle`*: LdtkEditorLinkStyle
    `allowedRefs`*: LdtkAllowedRefs
    `useForSmartColor`*: bool
    `editorTextSuffix`*: LdtkEditorTextSuffix
    `doc`*: LdtkDoc
    `editorTextPrefix`*: LdtkEditorTextPrefix
    `editorCutLongValues`*: bool
    `canBeNull`*: bool
    `allowedRefTags`*: seq[string]
    `uid`*: BiggestInt
    `symmetricalRef`*: bool
    `editorDisplayColor`*: LdtkEditorDisplayColor
    `allowOutOfLevelRef`*: bool
    `acceptFileTypes`*: seq[string]
    `editorShowInWorld`*: bool
    `tilesetUid`*: LdtkTilesetUid
    `arrayMaxLength`*: LdtkArrayMaxLength
    `arrayMinLength`*: LdtkArrayMinLength
    `searchable`*: bool
    `min`*: LdtkMin
    `exportToToc`*: bool
    `max`*: LdtkMax
  LdtkTileRenderMode* = enum
    FullSizeCropped, FullSizeUncropped, Repeat, FitInside, NineSlice, Cover,
    Stretch
  LdtkUiTileRect1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  LdtkUiTileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: LdtkUiTileRect1
  LdtkMinHeight* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkTileRect1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  LdtkTileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: LdtkTileRect1
  LdtkMaxWidth* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkMaxHeight* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkEntities* = object
    `allowOutOfBounds`*: bool
    `pivotY`*: BiggestFloat
    `tileOpacity`*: BiggestFloat
    `color`*: string
    `limitScope`*: LdtkLimitScope
    `limitBehavior`*: LdtkLimitBehavior
    `hollow`*: bool
    `height`*: BiggestInt
    `renderMode`*: LdtkRenderMode
    `tilesetId`*: LdtkTilesetId
    `keepAspectRatio`*: bool
    `minWidth`*: LdtkMinWidth
    `showName`*: bool
    `resizableX`*: bool
    `identifier`*: string
    `maxCount`*: BiggestInt
    `tileId`*: LdtkTileId
    `pivotX`*: BiggestFloat
    `doc`*: LdtkDoc
    `fieldDefs`*: seq[LdtkFieldDefs]
    `uid`*: BiggestInt
    `tileRenderMode`*: LdtkTileRenderMode
    `uiTileRect`*: LdtkUiTileRect
    `resizableY`*: bool
    `lineOpacity`*: BiggestFloat
    `minHeight`*: LdtkMinHeight
    `tileRect`*: LdtkTileRect
    `nineSliceBorders`*: seq[BiggestInt]
    `maxWidth`*: LdtkMaxWidth
    `width`*: BiggestInt
    `tags`*: seq[string]
    `maxHeight`*: LdtkMaxHeight
    `exportToToc`*: bool
    `fillOpacity`*: BiggestFloat
  LdtkTileId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkTileRect1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  LdtkTileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: LdtkTileRect1
  LdtkValues* = object
    `__tileSrcRect`*: seq[BiggestInt]
    `color`*: BiggestInt
    `id`*: string
    `tileId`*: LdtkTileId
    `tileRect`*: LdtkTileRect
  LdtkExternalRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkExternalFileChecksum* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkIconTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkEnums* = object
    `values`*: seq[LdtkValues]
    `externalRelPath`*: LdtkExternalRelPath
    `identifier`*: string
    `externalFileChecksum`*: LdtkExternalFileChecksum
    `iconTilesetUid`*: LdtkIconTilesetUid
    `uid`*: BiggestInt
    `tags`*: seq[string]
  LdtkType* = enum
    Tiles, Entities, AutoLayer, IntGrid
  LdtkAutoTilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkBiomeFieldUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkAutoTilesKilledByOtherLayerUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkCollapsed* = object
    case kind: range[0 .. 1]
    of 0:
      key0: bool
    of 1:
      key1: pointer
  LdtkChecker* = enum
    Horizontal, Vertical, None
  LdtkTileMode* = enum
    Single, Stamp
  LdtkOutOfBoundsValue* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkRules* = object
    `checker`*: LdtkChecker
    `pivotY`*: BiggestFloat
    `breakOnMatch`*: bool
    `perlinOctaves`*: BiggestFloat
    `yModulo`*: BiggestInt
    `size`*: BiggestInt
    `tileMode`*: LdtkTileMode
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
    `outOfBoundsValue`*: LdtkOutOfBoundsValue
    `pivotX`*: BiggestFloat
    `flipY`*: bool
    `active`*: bool
    `uid`*: BiggestInt
    `tileIds`*: seq[BiggestInt]
    `invalidated`*: bool
    `pattern`*: seq[BiggestInt]
    `alpha`*: BiggestFloat
    `tileRectsIds`*: seq[seq[BiggestInt]]
    `tileXOffset`*: BiggestInt
    `xOffset`*: BiggestInt
    `tileRandomYMin`*: BiggestInt
    `perlinSeed`*: BiggestFloat
  LdtkIcon1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  LdtkIcon* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: LdtkIcon1
  LdtkAutoRuleGroups* = object
    `isOptional`*: bool
    `color`*: LdtkColor
    `collapsed`*: LdtkCollapsed
    `usesWizard`*: bool
    `biomeRequirementMode`*: BiggestInt
    `rules`*: seq[LdtkRules]
    `icon`*: LdtkIcon
    `active`*: bool
    `uid`*: BiggestInt
    `name`*: string
    `requiredBiomeValues`*: seq[string]
  LdtkTilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkUiColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkDoc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkAutoSourceLayerDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkIdentifier* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkIntGridValuesGroups* = object
    `color`*: LdtkColor
    `identifier`*: LdtkIdentifier
    `uid`*: BiggestInt
  LdtkTile1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  LdtkTile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: LdtkTile1
  LdtkIdentifier* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkIntGridValues* = object
    `tile`*: LdtkTile
    `color`*: string
    `identifier`*: LdtkIdentifier
    `groupUid`*: BiggestInt
    `value`*: BiggestInt
  LdtkLayers* = object
    `type`*: LdtkType
    `autoTilesetDefUid`*: LdtkAutoTilesetDefUid
    `parallaxScaling`*: bool
    `biomeFieldUid`*: LdtkBiomeFieldUid
    `autoTilesKilledByOtherLayerUid`*: LdtkAutoTilesKilledByOtherLayerUid
    `inactiveOpacity`*: BiggestFloat
    `__type`*: string
    `autoRuleGroups`*: seq[LdtkAutoRuleGroups]
    `gridSize`*: BiggestInt
    `hideInList`*: bool
    `tilesetDefUid`*: LdtkTilesetDefUid
    `uiColor`*: LdtkUiColor
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
    `doc`*: LdtkDoc
    `uid`*: BiggestInt
    `guideGridHei`*: BiggestInt
    `autoSourceLayerDefUid`*: LdtkAutoSourceLayerDefUid
    `displayOpacity`*: BiggestFloat
    `intGridValuesGroups`*: seq[LdtkIntGridValuesGroups]
    `hideFieldsWhenInactive`*: bool
    `useAsyncRender`*: bool
    `pxOffsetY`*: BiggestInt
    `parallaxFactorY`*: BiggestFloat
    `intGridValues`*: seq[LdtkIntGridValues]
    `renderInWorldView`*: bool
  LdtkTileId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkTileRect1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  LdtkTileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: LdtkTileRect1
  LdtkValues* = object
    `__tileSrcRect`*: seq[BiggestInt]
    `color`*: BiggestInt
    `id`*: string
    `tileId`*: LdtkTileId
    `tileRect`*: LdtkTileRect
  LdtkExternalRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkExternalFileChecksum* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkIconTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkExternalEnums* = object
    `values`*: seq[LdtkValues]
    `externalRelPath`*: LdtkExternalRelPath
    `identifier`*: string
    `externalFileChecksum`*: LdtkExternalFileChecksum
    `iconTilesetUid`*: LdtkIconTilesetUid
    `uid`*: BiggestInt
    `tags`*: seq[string]
  LdtkDefs* = object
    `levelFields`*: seq[LdtkLevelFields]
    `tilesets`*: seq[LdtkTilesets]
    `entities`*: seq[LdtkEntities]
    `enums`*: seq[LdtkEnums]
    `layers`*: seq[LdtkLayers]
    `externalEnums`*: seq[LdtkExternalEnums]
  LdtkTutorialDesc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkWorldLayout* = enum
    LinearHorizontal, LinearVertical, , GridVania, Free
  LdtkDefaultLevelWidth* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkFlags* = enum
    ExportPreCsvIntGridFormat, DiscardPreCsvIntGrid,
    ExportOldTableOfContentData, PrependIndexToLevelFileNames, MultiWorlds,
    UseMultilinesType, IgnoreBackupSuggest
  LdtkIdentifierStyle* = enum
    Lowercase, Free, Capitalize, Uppercase
  LdtkWorldGridHeight* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkBgColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkExternalRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkBgRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  LdtkLevelUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  Ldtk__neighbours* = object
    `levelUid`*: LdtkLevelUid
    `levelIid`*: string
    `dir`*: string
  LdtkBgPos* = enum
    CoverDirty, Repeat, , Contain, Cover, Unscaled
  LdtkGridTiles* = object
    `px`*: seq[BiggestInt]
    `t`*: BiggestInt
    `d`*: seq[BiggestInt]
    `a`*: BiggestFloat
    `src`*: seq[BiggestInt]
    `f`*: BiggestInt
  LdtkOverrideTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkIntGrid* = object
    `coordId`*: BiggestInt
    `v`*: BiggestInt
  LdtkAutoLayerTiles* = object
    `px`*: seq[BiggestInt]
    `t`*: BiggestInt
    `d`*: seq[BiggestInt]
    `a`*: BiggestFloat
    `src`*: seq[BiggestInt]
    `f`*: BiggestInt
  Ldtk__worldY* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  Ldtk__tile1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  Ldtk__tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: Ldtk__tile1
  Ldtk__tile1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  Ldtk__tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: Ldtk__tile1
  LdtkFieldInstances* = object
    `realEditorValues`*: seq[JsonNode]
    `__value`*: JsonNode
    `__tile`*: Ldtk__tile
    `__type`*: string
    `__identifier`*: string
    `defUid`*: BiggestInt
  Ldtk__worldX* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkEntityInstances* = object
    `__worldY`*: Ldtk__worldY
    `__tile`*: Ldtk__tile
    `__identifier`*: string
    `__tags`*: seq[string]
    `height`*: BiggestInt
    `px`*: seq[BiggestInt]
    `defUid`*: BiggestInt
    `__pivot`*: seq[BiggestFloat]
    `fieldInstances`*: seq[LdtkFieldInstances]
    `iid`*: string
    `width`*: BiggestInt
    `__worldX`*: Ldtk__worldX
    `__grid`*: seq[BiggestInt]
    `__smartColor`*: string
  Ldtk__tilesetRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  Ldtk__tilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LdtkLayerInstances* = object
    `__opacity`*: BiggestFloat
    `optionalRules`*: seq[BiggestInt]
    `__gridSize`*: BiggestInt
    `__pxTotalOffsetX`*: BiggestInt
    `gridTiles`*: seq[LdtkGridTiles]
    `__type`*: string
    `__identifier`*: string
    `overrideTilesetUid`*: LdtkOverrideTilesetUid
    `levelId`*: BiggestInt
    `intGrid`*: seq[LdtkIntGrid]
    `autoLayerTiles`*: seq[LdtkAutoLayerTiles]
    `layerDefUid`*: BiggestInt
    `entityInstances`*: seq[LdtkEntityInstances]
    `intGridCsv`*: seq[BiggestInt]
    `pxOffsetX`*: BiggestInt
    `__tilesetRelPath`*: Ldtk__tilesetRelPath
    `__tilesetDefUid`*: Ldtk__tilesetDefUid
    `__cHei`*: BiggestInt
    `seed`*: BiggestInt
    `visible`*: bool
    `pxOffsetY`*: BiggestInt
    `iid`*: string
    `__pxTotalOffsetY`*: BiggestInt
    `__cWid`*: BiggestInt
  Ldtk__tile1* = object
    `x`*: BiggestInt
    `w`*: BiggestInt
    `y`*: BiggestInt
    `h`*: BiggestInt
    `tilesetUid`*: BiggestInt
  Ldtk__tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: Ldtk__tile1
  LdtkFieldInstances* = object
    `realEditorValues`*: seq[JsonNode]
    `__value`*: JsonNode
    `__tile`*: Ldtk__tile
    `__type`*: string
    `__identifier`*: string
    `defUid`*: BiggestInt
  Ldtk__bgPos1* = object
    `scale`*: seq[BiggestFloat]
    `cropRect`*: seq[BiggestFloat]
    `topLeftPx`*: seq[BiggestInt]
  Ldtk__bgPos* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: Ldtk__bgPos1
  LdtkLevels* = object
    `pxHei`*: BiggestInt
    `useAutoIdentifier`*: bool
    `__bgColor`*: string
    `bgColor`*: LdtkBgColor
    `externalRelPath`*: LdtkExternalRelPath
    `worldY`*: BiggestInt
    `bgRelPath`*: LdtkBgRelPath
    `identifier`*: string
    `pxWid`*: BiggestInt
    `worldDepth`*: BiggestInt
    `bgPivotX`*: BiggestFloat
    `__neighbours`*: seq[Ldtk__neighbours]
    `uid`*: BiggestInt
    `bgPos`*: LdtkBgPos
    `layerInstances`*: seq[LdtkLayerInstances]
    `fieldInstances`*: seq[LdtkFieldInstances]
    `__bgPos`*: Ldtk__bgPos
    `worldX`*: BiggestInt
    `iid`*: string
    `bgPivotY`*: BiggestFloat
    `__smartColor`*: string
  LdtkLdtk* = object
    `backupLimit`*: BiggestInt
    `simplifiedExport`*: bool
    `externalLevels`*: bool
    `backupRelPath`*: LdtkBackupRelPath
    `jsonVersion`*: string
    `bgColor`*: string
    `appBuildId`*: BiggestFloat
    `defaultEntityHeight`*: BiggestInt
    `pngFilePattern`*: LdtkPngFilePattern
    `customCommands`*: seq[LdtkCustomCommands]
    `exportTiled`*: bool
    `exportPng`*: LdtkExportPng
    `worldGridWidth`*: LdtkWorldGridWidth
    `defaultLevelHeight`*: LdtkDefaultLevelHeight
    `toc`*: seq[LdtkToc]
    `worlds`*: seq[LdtkWorlds]
    `imageExportMode`*: LdtkImageExportMode
    `dummyWorldIid`*: string
    `__FORCED_REFS`*: Ldtk__FORCED_REFS
    `defaultPivotY`*: BiggestFloat
    `exportLevelBg`*: bool
    `nextUid`*: BiggestInt
    `levelNamePattern`*: string
    `defs`*: LdtkDefs
    `defaultPivotX`*: BiggestFloat
    `tutorialDesc`*: LdtkTutorialDesc
    `worldLayout`*: LdtkWorldLayout
    `defaultEntityWidth`*: BiggestInt
    `iid`*: string
    `defaultGridSize`*: BiggestInt
    `defaultLevelWidth`*: LdtkDefaultLevelWidth
    `minifyJson`*: bool
    `backupOnSave`*: bool
    `flags`*: seq[LdtkFlags]
    `defaultLevelBgColor`*: string
    `identifierStyle`*: LdtkIdentifierStyle
    `worldGridHeight`*: LdtkWorldGridHeight
    `levels`*: seq[LdtkLevels]