{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  LdtkWorldLayout* = enum
    Free, GridVania, LinearHorizontal, LinearVertical
  LdtkNeighbourLevel* = object
    levelIid*: string
    levelUid*: Option[BiggestInt]
    dir*: string
  LdtkBgPos* = enum
    Unscaled, Contain, Cover, CoverDirty, Repeat
  LdtkLevelBgPosInfos* = object
    cropRect*: seq[BiggestFloat]
    scale*: seq[BiggestFloat]
    topLeftPx*: seq[BiggestInt]
  LdtkTilesetRect* = object
    tilesetUid*: BiggestInt
    h*: BiggestInt
    x*: BiggestInt
    y*: BiggestInt
    w*: BiggestInt
  LdtkFieldInstance* = object
    `type`*: string
    defUid*: BiggestInt
    identifier*: string
    tile*: Option[LdtkTilesetRect]
    realEditorValues*: seq[JsonNode]
    value*: JsonNode
  LdtkTile* = object
    t*: BiggestInt
    d*: seq[BiggestInt]
    px*: seq[BiggestInt]
    a*: BiggestFloat
    f*: BiggestInt
    src*: seq[BiggestInt]
  LdtkEntityInstance* = object
    iid*: string
    defUid*: BiggestInt
    identifier*: string
    tile*: Option[LdtkTilesetRect]
    px*: seq[BiggestInt]
    worldX*: Option[BiggestInt]
    worldY*: Option[BiggestInt]
    smartColor*: string
    grid*: seq[BiggestInt]
    pivot*: seq[BiggestFloat]
    fieldInstances*: seq[LdtkFieldInstance]
    height*: BiggestInt
    tags*: seq[string]
    width*: BiggestInt
  LdtkIntGridValueInstance* = object
    v*: BiggestInt
    coordId*: BiggestInt
  LdtkLayerInstance* = object
    cHei*: BiggestInt
    pxOffsetX*: BiggestInt
    tilesetRelPath*: Option[string]
    iid*: string
    levelId*: BiggestInt
    `type`*: string
    autoLayerTiles*: seq[LdtkTile]
    optionalRules*: seq[BiggestInt]
    identifier*: string
    gridSize*: BiggestInt
    pxTotalOffsetY*: BiggestInt
    intGridCsv*: seq[BiggestInt]
    overrideTilesetUid*: Option[BiggestInt]
    visible*: bool
    entityInstances*: seq[LdtkEntityInstance]
    opacity*: BiggestFloat
    seed*: BiggestInt
    layerDefUid*: BiggestInt
    pxTotalOffsetX*: BiggestInt
    cWid*: BiggestInt
    pxOffsetY*: BiggestInt
    tilesetDefUid*: Option[BiggestInt]
    gridTiles*: seq[LdtkTile]
    intGrid*: Option[seq[LdtkIntGridValueInstance]]
  LdtkLevel* = object
    neighbours*: seq[LdtkNeighbourLevel]
    bgColor*: string
    worldX*: BiggestInt
    externalRelPath*: Option[string]
    useAutoIdentifier*: bool
    iid*: string
    bgColor1*: Option[string]
    bgPos*: Option[LdtkBgPos]
    pxHei*: BiggestInt
    worldY*: BiggestInt
    bgPos1*: Option[LdtkLevelBgPosInfos]
    uid*: BiggestInt
    smartColor*: string
    fieldInstances*: seq[LdtkFieldInstance]
    pxWid*: BiggestInt
    identifier*: string
    bgPivotY*: BiggestFloat
    bgPivotX*: BiggestFloat
    layerInstances*: Option[seq[LdtkLayerInstance]]
    bgRelPath*: Option[string]
    worldDepth*: BiggestInt
  LdtkWorld* = object
    worldGridWidth*: BiggestInt
    iid*: string
    worldGridHeight*: BiggestInt
    worldLayout*: Option[LdtkWorldLayout]
    defaultLevelWidth*: BiggestInt
    levels*: seq[LdtkLevel]
    defaultLevelHeight*: BiggestInt
    identifier*: string
  LdtkEntityReferenceInfos* = object
    worldIid*: string
    entityIid*: string
    layerIid*: string
    levelIid*: string
  LdtkTocInstanceData* = object
    worldX*: BiggestInt
    widPx*: BiggestInt
    worldY*: BiggestInt
    heiPx*: BiggestInt
    fields*: JsonNode
    iids*: LdtkEntityReferenceInfos
  LdtkTableOfContentEntry* = object
    identifier*: string
    instancesData*: seq[LdtkTocInstanceData]
    instances*: Option[seq[LdtkEntityReferenceInfos]]
  LdtkImageExportMode* = enum
    None, OneImagePerLayer, OneImagePerLevel, LayersAndLevels
  LdtkIdentifierStyle* = enum
    Capitalize, Uppercase, Lowercase, Free
  LdtkWhen* = enum
    Manual, AfterLoad, BeforeSave, AfterSave
  LdtkCustomCommand* = object
    `when`*: LdtkWhen
    command*: string
  LdtkldtkWorldLayout* = enum
    Free, GridVania, LinearHorizontal, LinearVertical
  LdtkFlags* = enum
    DiscardPreCsvIntGrid, ExportOldTableOfContentData,
    ExportPreCsvIntGridFormat, IgnoreBackupSuggest,
    PrependIndexToLevelFileNames, MultiWorlds, UseMultilinesType
  LdtkTileCustomMetadata* = object
    tileId*: BiggestInt
    data*: string
  LdtkEnumTagValue* = object
    tileIds*: seq[BiggestInt]
    enumValueId*: string
  LdtkEmbedAtlas* = enum
    LdtkIcons
  LdtkTilesetDef* = object
    cachedPixelData*: Option[OrderedTable[string, JsonNode]]
    cHei*: BiggestInt
    pxHei*: BiggestInt
    customData*: seq[LdtkTileCustomMetadata]
    tagsSourceEnumUid*: Option[BiggestInt]
    uid*: BiggestInt
    padding*: BiggestInt
    enumTags*: seq[LdtkEnumTagValue]
    pxWid*: BiggestInt
    cWid*: BiggestInt
    spacing*: BiggestInt
    identifier*: string
    savedSelections*: seq[OrderedTable[string, JsonNode]]
    tags*: seq[string]
    embedAtlas*: Option[LdtkEmbedAtlas]
    relPath*: Option[string]
    tileGridSize*: BiggestInt
  LdtkIntGridValueGroupDef* = object
    color*: Option[string]
    uid*: BiggestInt
    identifier*: Option[string]
  LdtkIntGridValueDef* = object
    tile*: Option[LdtkTilesetRect]
    color*: string
    identifier*: Option[string]
    value*: BiggestInt
    groupUid*: BiggestInt
  LdtkChecker* = enum
    None, Horizontal, Vertical
  LdtkTileMode* = enum
    Single, Stamp
  LdtkAutoRuleDef* = object
    flipX*: bool
    pivotX*: BiggestFloat
    perlinActive*: bool
    tileRectsIds*: seq[seq[BiggestInt]]
    perlinScale*: BiggestFloat
    outOfBoundsValue*: Option[BiggestInt]
    pattern*: seq[BiggestInt]
    tileRandomXMin*: BiggestInt
    checker*: LdtkChecker
    perlinOctaves*: BiggestFloat
    tileIds*: Option[seq[BiggestInt]]
    alpha*: BiggestFloat
    tileXOffset*: BiggestInt
    invalidated*: bool
    xModulo*: BiggestInt
    size*: BiggestInt
    chance*: BiggestFloat
    breakOnMatch*: bool
    tileYOffset*: BiggestInt
    uid*: BiggestInt
    perlinSeed*: BiggestFloat
    yOffset*: BiggestInt
    tileRandomYMax*: BiggestInt
    tileRandomYMin*: BiggestInt
    tileMode*: LdtkTileMode
    flipY*: bool
    tileRandomXMax*: BiggestInt
    pivotY*: BiggestFloat
    yModulo*: BiggestInt
    active*: bool
    xOffset*: BiggestInt
  LdtkAutoLayerRuleGroup* = object
    name*: string
    collapsed*: Option[bool]
    biomeRequirementMode*: BiggestInt
    color*: Option[string]
    isOptional*: bool
    icon*: Option[LdtkTilesetRect]
    usesWizard*: bool
    uid*: BiggestInt
    requiredBiomeValues*: seq[string]
    active*: bool
    rules*: seq[LdtkAutoRuleDef]
  LdtkType* = enum
    IntGrid, Entities, Tiles, AutoLayer
  LdtkLayerDef* = object
    pxOffsetX*: BiggestInt
    tilePivotX*: BiggestFloat
    uiFilterTags*: seq[string]
    displayOpacity*: BiggestFloat
    parallaxFactorY*: BiggestFloat
    hideInList*: bool
    `type`*: string
    guideGridHei*: BiggestInt
    uiColor*: Option[string]
    doc*: Option[string]
    tilesetDefUid*: Option[BiggestInt]
    canSelectWhenInactive*: bool
    useAsyncRender*: bool
    autoSourceLayerDefUid*: Option[BiggestInt]
    autoTilesetDefUid*: Option[BiggestInt]
    parallaxScaling*: bool
    renderInWorldView*: bool
    intGridValuesGroups*: seq[LdtkIntGridValueGroupDef]
    inactiveOpacity*: BiggestFloat
    uid*: BiggestInt
    excludedTags*: seq[string]
    hideFieldsWhenInactive*: bool
    intGridValues*: seq[LdtkIntGridValueDef]
    autoRuleGroups*: seq[LdtkAutoLayerRuleGroup]
    type1*: LdtkType
    identifier*: string
    guideGridWid*: BiggestInt
    requiredTags*: seq[string]
    pxOffsetY*: BiggestInt
    tilePivotY*: BiggestFloat
    biomeFieldUid*: Option[BiggestInt]
    gridSize*: BiggestInt
    parallaxFactorX*: BiggestFloat
    autoTilesKilledByOtherLayerUid*: Option[BiggestInt]
  LdtkAllowedRefs* = enum
    Any, OnlySame, OnlyTags, OnlySpecificEntity
  LdtkEditorDisplayMode* = enum
    Hidden, ValueOnly, NameAndValue, EntityTile, LevelTile, Points, PointStar,
    PointPath, PointPathLoop, RadiusPx, RadiusGrid, ArrayCountWithLabel,
    ArrayCountNoLabel, RefLinkBetweenPivots, RefLinkBetweenCenters
  LdtkEditorDisplayPos* = enum
    Above, Center, Beneath
  LdtkTextLanguageMode* = enum
    LangPython, LangRuby, LangJS, LangLua, LangC, LangHaxe, LangMarkdown,
    LangJson, LangXml, LangLog
  LdtkEditorLinkStyle* = enum
    ZigZag, StraightArrow, CurvedArrow, ArrowsLine, DashedLine
  LdtkFieldDef* = object
    acceptFileTypes*: Option[seq[string]]
    editorDisplayScale*: BiggestFloat
    searchable*: bool
    useForSmartColor*: bool
    editorShowInWorld*: bool
    allowedRefs*: LdtkAllowedRefs
    editorAlwaysShow*: bool
    arrayMinLength*: Option[BiggestInt]
    editorTextSuffix*: Option[string]
    min*: Option[BiggestFloat]
    `type`*: string
    editorDisplayMode*: LdtkEditorDisplayMode
    editorDisplayColor*: Option[string]
    canBeNull*: bool
    autoChainRef*: bool
    doc*: Option[string]
    allowedRefsEntityUid*: Option[BiggestInt]
    tilesetUid*: Option[BiggestInt]
    allowedRefTags*: seq[string]
    symmetricalRef*: bool
    uid*: BiggestInt
    editorTextPrefix*: Option[string]
    isArray*: bool
    exportToToc*: bool
    editorDisplayPos*: LdtkEditorDisplayPos
    textLanguageMode*: Option[LdtkTextLanguageMode]
    max*: Option[BiggestFloat]
    allowOutOfLevelRef*: bool
    editorCutLongValues*: bool
    defaultOverride*: Option[JsonNode]
    editorLinkStyle*: LdtkEditorLinkStyle
    regex*: Option[string]
    type1*: string
    identifier*: string
    arrayMaxLength*: Option[BiggestInt]
  LdtkEnumDefValues* = object
    tileId*: Option[BiggestInt]
    color*: BiggestInt
    tileRect*: Option[LdtkTilesetRect]
    id*: string
    tileSrcRect*: Option[seq[BiggestInt]]
  LdtkEnumDef* = object
    externalFileChecksum*: Option[string]
    externalRelPath*: Option[string]
    uid*: BiggestInt
    values*: seq[LdtkEnumDefValues]
    iconTilesetUid*: Option[BiggestInt]
    identifier*: string
    tags*: seq[string]
  LdtkLimitScope* = enum
    PerLayer, PerLevel, PerWorld
  LdtkTileRenderMode* = enum
    Cover, FitInside, Repeat, Stretch, FullSizeCropped, FullSizeUncropped,
    NineSlice
  LdtkLimitBehavior* = enum
    DiscardOldOnes, PreventAdding, MoveLastOne
  LdtkRenderMode* = enum
    Rectangle, Ellipse, Tile, Cross
  LdtkEntityDef* = object
    tileId*: Option[BiggestInt]
    showName*: bool
    tilesetId*: Option[BiggestInt]
    maxHeight*: Option[BiggestInt]
    limitScope*: LdtkLimitScope
    pivotX*: BiggestFloat
    maxCount*: BiggestInt
    allowOutOfBounds*: bool
    hollow*: bool
    minHeight*: Option[BiggestInt]
    keepAspectRatio*: bool
    color*: string
    minWidth*: Option[BiggestInt]
    tileRect*: Option[LdtkTilesetRect]
    doc*: Option[string]
    fieldDefs*: seq[LdtkFieldDef]
    tileRenderMode*: LdtkTileRenderMode
    limitBehavior*: LdtkLimitBehavior
    tileOpacity*: BiggestFloat
    nineSliceBorders*: seq[BiggestInt]
    resizableX*: bool
    uiTileRect*: Option[LdtkTilesetRect]
    uid*: BiggestInt
    lineOpacity*: BiggestFloat
    maxWidth*: Option[BiggestInt]
    resizableY*: bool
    exportToToc*: bool
    fillOpacity*: BiggestFloat
    height*: BiggestInt
    identifier*: string
    pivotY*: BiggestFloat
    renderMode*: LdtkRenderMode
    tags*: seq[string]
    width*: BiggestInt
  LdtkDefinitions* = object
    tilesets*: seq[LdtkTilesetDef]
    layers*: seq[LdtkLayerDef]
    levelFields*: seq[LdtkFieldDef]
    enums*: seq[LdtkEnumDef]
    entities*: seq[LdtkEntityDef]
    externalEnums*: seq[LdtkEnumDef]
  LdtkGridPoint* = object
    cy*: BiggestInt
    cx*: BiggestInt
  Ldtk_FORCED_REFS* = object
    TilesetRect*: Option[LdtkTilesetRect]
    FieldInstance*: Option[LdtkFieldInstance]
    EntityInstance*: Option[LdtkEntityInstance]
    Definitions*: Option[LdtkDefinitions]
    EnumTagValue*: Option[LdtkEnumTagValue]
    AutoRuleDef*: Option[LdtkAutoRuleDef]
    FieldDef*: Option[LdtkFieldDef]
    CustomCommand*: Option[LdtkCustomCommand]
    EntityDef*: Option[LdtkEntityDef]
    AutoLayerRuleGroup*: Option[LdtkAutoLayerRuleGroup]
    IntGridValueGroupDef*: Option[LdtkIntGridValueGroupDef]
    IntGridValueInstance*: Option[LdtkIntGridValueInstance]
    TocInstanceData*: Option[LdtkTocInstanceData]
    NeighbourLevel*: Option[LdtkNeighbourLevel]
    LayerInstance*: Option[LdtkLayerInstance]
    World*: Option[LdtkWorld]
    EntityReferenceInfos*: Option[LdtkEntityReferenceInfos]
    TileCustomMetadata*: Option[LdtkTileCustomMetadata]
    TilesetDef*: Option[LdtkTilesetDef]
    EnumDefValues*: Option[LdtkEnumDefValues]
    Tile*: Option[LdtkTile]
    LayerDef*: Option[LdtkLayerDef]
    LevelBgPosInfos*: Option[LdtkLevelBgPosInfos]
    Level*: Option[LdtkLevel]
    TableOfContentEntry*: Option[LdtkTableOfContentEntry]
    EnumDef*: Option[LdtkEnumDef]
    GridPoint*: Option[LdtkGridPoint]
    IntGridValueDef*: Option[LdtkIntGridValueDef]
  LdtkLdtkJsonRoot* = object
    backupLimit*: BiggestInt
    defaultEntityWidth*: BiggestInt
    backupOnSave*: bool
    worldGridWidth*: Option[BiggestInt]
    iid*: string
    defaultLevelBgColor*: string
    bgColor*: string
    worlds*: seq[LdtkWorld]
    toc*: seq[LdtkTableOfContentEntry]
    nextUid*: BiggestInt
    imageExportMode*: LdtkImageExportMode
    identifierStyle*: LdtkIdentifierStyle
    defaultPivotY*: BiggestFloat
    dummyWorldIid*: string
    customCommands*: seq[LdtkCustomCommand]
    worldGridHeight*: Option[BiggestInt]
    appBuildId*: BiggestFloat
    defaultGridSize*: BiggestInt
    worldLayout*: Option[LdtkldtkWorldLayout]
    flags*: seq[LdtkFlags]
    levelNamePattern*: string
    exportPng*: Option[bool]
    defaultLevelWidth*: Option[BiggestInt]
    pngFilePattern*: Option[string]
    FORCED_REFS*: Option[Ldtk_FORCED_REFS]
    exportTiled*: bool
    defs*: LdtkDefinitions
    levels*: seq[LdtkLevel]
    jsonVersion*: string
    defaultEntityHeight*: BiggestInt
    defaultPivotX*: BiggestFloat
    defaultLevelHeight*: Option[BiggestInt]
    simplifiedExport*: bool
    externalLevels*: bool
    tutorialDesc*: Option[string]
    minifyJson*: bool
    exportLevelBg*: bool
    backupRelPath*: Option[string]
proc toJsonHook*(source: LdtkWorldLayout): JsonNode
proc toJsonHook*(source: LdtkNeighbourLevel): JsonNode
proc toJsonHook*(source: LdtkBgPos): JsonNode
proc toJsonHook*(source: LdtkLevelBgPosInfos): JsonNode
proc toJsonHook*(source: LdtkTilesetRect): JsonNode
proc toJsonHook*(source: LdtkFieldInstance): JsonNode
proc toJsonHook*(source: LdtkTile): JsonNode
proc toJsonHook*(source: LdtkEntityInstance): JsonNode
proc toJsonHook*(source: LdtkIntGridValueInstance): JsonNode
proc toJsonHook*(source: LdtkLayerInstance): JsonNode
proc toJsonHook*(source: LdtkLevel): JsonNode
proc toJsonHook*(source: LdtkWorld): JsonNode
proc toJsonHook*(source: LdtkEntityReferenceInfos): JsonNode
proc toJsonHook*(source: LdtkTocInstanceData): JsonNode
proc toJsonHook*(source: LdtkTableOfContentEntry): JsonNode
proc toJsonHook*(source: LdtkImageExportMode): JsonNode
proc toJsonHook*(source: LdtkIdentifierStyle): JsonNode
proc toJsonHook*(source: LdtkWhen): JsonNode
proc toJsonHook*(source: LdtkCustomCommand): JsonNode
proc toJsonHook*(source: LdtkldtkWorldLayout): JsonNode
proc toJsonHook*(source: LdtkFlags): JsonNode
proc toJsonHook*(source: LdtkTileCustomMetadata): JsonNode
proc toJsonHook*(source: LdtkEnumTagValue): JsonNode
proc toJsonHook*(source: LdtkEmbedAtlas): JsonNode
proc toJsonHook*(source: LdtkTilesetDef): JsonNode
proc toJsonHook*(source: LdtkIntGridValueGroupDef): JsonNode
proc toJsonHook*(source: LdtkIntGridValueDef): JsonNode
proc toJsonHook*(source: LdtkChecker): JsonNode
proc toJsonHook*(source: LdtkTileMode): JsonNode
proc toJsonHook*(source: LdtkAutoRuleDef): JsonNode
proc toJsonHook*(source: LdtkAutoLayerRuleGroup): JsonNode
proc toJsonHook*(source: LdtkType): JsonNode
proc toJsonHook*(source: LdtkLayerDef): JsonNode
proc toJsonHook*(source: LdtkAllowedRefs): JsonNode
proc toJsonHook*(source: LdtkEditorDisplayMode): JsonNode
proc toJsonHook*(source: LdtkEditorDisplayPos): JsonNode
proc toJsonHook*(source: LdtkTextLanguageMode): JsonNode
proc toJsonHook*(source: LdtkEditorLinkStyle): JsonNode
proc toJsonHook*(source: LdtkFieldDef): JsonNode
proc toJsonHook*(source: LdtkEnumDefValues): JsonNode
proc toJsonHook*(source: LdtkEnumDef): JsonNode
proc toJsonHook*(source: LdtkLimitScope): JsonNode
proc toJsonHook*(source: LdtkTileRenderMode): JsonNode
proc toJsonHook*(source: LdtkLimitBehavior): JsonNode
proc toJsonHook*(source: LdtkRenderMode): JsonNode
proc toJsonHook*(source: LdtkEntityDef): JsonNode
proc toJsonHook*(source: LdtkDefinitions): JsonNode
proc toJsonHook*(source: LdtkGridPoint): JsonNode
proc toJsonHook*(source: Ldtk_FORCED_REFS): JsonNode
proc toJsonHook*(source: LdtkLdtkJsonRoot): JsonNode
proc toJsonHook*(source: LdtkWorldLayout): JsonNode =
  case source
  of LdtkWorldLayout.Free:
    return newJString("Free")
  of LdtkWorldLayout.GridVania:
    return newJString("GridVania")
  of LdtkWorldLayout.LinearHorizontal:
    return newJString("LinearHorizontal")
  of LdtkWorldLayout.LinearVertical:
    return newJString("LinearVertical")
  
proc fromJsonHook*(target: var LdtkWorldLayout; source: JsonNode) =
  target = case getStr(source)
  of "Free":
    LdtkWorldLayout.Free
  of "GridVania":
    LdtkWorldLayout.GridVania
  of "LinearHorizontal":
    LdtkWorldLayout.LinearHorizontal
  of "LinearVertical":
    LdtkWorldLayout.LinearVertical
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc fromJsonHook*(target: var LdtkNeighbourLevel; source: JsonNode) =
  assert(hasKey(source, "levelIid"),
         "levelIid" & " is missing while decoding " & "LdtkNeighbourLevel")
  target.levelIid = jsonTo(source{"levelIid"}, typeof(target.levelIid))
  if hasKey(source, "levelUid") and source{"levelUid"}.kind != JNull:
    target.levelUid = some(jsonTo(source{"levelUid"},
                                  typeof(unsafeGet(target.levelUid))))
  assert(hasKey(source, "dir"),
         "dir" & " is missing while decoding " & "LdtkNeighbourLevel")
  target.dir = jsonTo(source{"dir"}, typeof(target.dir))

proc toJsonHook*(source: LdtkNeighbourLevel): JsonNode =
  result = newJObject()
  result{"levelIid"} = newJString(source.levelIid)
  if isSome(source.levelUid):
    result{"levelUid"} = newJInt(unsafeGet(source.levelUid))
  result{"dir"} = newJString(source.dir)

proc toJsonHook*(source: LdtkBgPos): JsonNode =
  case source
  of LdtkBgPos.Unscaled:
    return newJString("Unscaled")
  of LdtkBgPos.Contain:
    return newJString("Contain")
  of LdtkBgPos.Cover:
    return newJString("Cover")
  of LdtkBgPos.CoverDirty:
    return newJString("CoverDirty")
  of LdtkBgPos.Repeat:
    return newJString("Repeat")
  
proc fromJsonHook*(target: var LdtkBgPos; source: JsonNode) =
  target = case getStr(source)
  of "Unscaled":
    LdtkBgPos.Unscaled
  of "Contain":
    LdtkBgPos.Contain
  of "Cover":
    LdtkBgPos.Cover
  of "CoverDirty":
    LdtkBgPos.CoverDirty
  of "Repeat":
    LdtkBgPos.Repeat
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc fromJsonHook*(target: var LdtkLevelBgPosInfos; source: JsonNode) =
  assert(hasKey(source, "cropRect"),
         "cropRect" & " is missing while decoding " & "LdtkLevelBgPosInfos")
  target.cropRect = jsonTo(source{"cropRect"}, typeof(target.cropRect))
  assert(hasKey(source, "scale"),
         "scale" & " is missing while decoding " & "LdtkLevelBgPosInfos")
  target.scale = jsonTo(source{"scale"}, typeof(target.scale))
  assert(hasKey(source, "topLeftPx"),
         "topLeftPx" & " is missing while decoding " & "LdtkLevelBgPosInfos")
  target.topLeftPx = jsonTo(source{"topLeftPx"}, typeof(target.topLeftPx))

proc toJsonHook*(source: LdtkLevelBgPosInfos): JsonNode =
  result = newJObject()
  result{"cropRect"} = block:
    var output = newJArray()
    for entry in source.cropRect:
      output.add(newJFloat(entry))
    output
  result{"scale"} = block:
    var output = newJArray()
    for entry in source.scale:
      output.add(newJFloat(entry))
    output
  result{"topLeftPx"} = block:
    var output = newJArray()
    for entry in source.topLeftPx:
      output.add(newJInt(entry))
    output

proc fromJsonHook*(target: var LdtkTilesetRect; source: JsonNode) =
  assert(hasKey(source, "tilesetUid"),
         "tilesetUid" & " is missing while decoding " & "LdtkTilesetRect")
  target.tilesetUid = jsonTo(source{"tilesetUid"}, typeof(target.tilesetUid))
  assert(hasKey(source, "h"),
         "h" & " is missing while decoding " & "LdtkTilesetRect")
  target.h = jsonTo(source{"h"}, typeof(target.h))
  assert(hasKey(source, "x"),
         "x" & " is missing while decoding " & "LdtkTilesetRect")
  target.x = jsonTo(source{"x"}, typeof(target.x))
  assert(hasKey(source, "y"),
         "y" & " is missing while decoding " & "LdtkTilesetRect")
  target.y = jsonTo(source{"y"}, typeof(target.y))
  assert(hasKey(source, "w"),
         "w" & " is missing while decoding " & "LdtkTilesetRect")
  target.w = jsonTo(source{"w"}, typeof(target.w))

proc toJsonHook*(source: LdtkTilesetRect): JsonNode =
  result = newJObject()
  result{"tilesetUid"} = newJInt(source.tilesetUid)
  result{"h"} = newJInt(source.h)
  result{"x"} = newJInt(source.x)
  result{"y"} = newJInt(source.y)
  result{"w"} = newJInt(source.w)

proc fromJsonHook*(target: var LdtkFieldInstance; source: JsonNode) =
  assert(hasKey(source, "__type"),
         "__type" & " is missing while decoding " & "LdtkFieldInstance")
  target.`type` = jsonTo(source{"__type"}, typeof(target.`type`))
  assert(hasKey(source, "defUid"),
         "defUid" & " is missing while decoding " & "LdtkFieldInstance")
  target.defUid = jsonTo(source{"defUid"}, typeof(target.defUid))
  assert(hasKey(source, "__identifier"),
         "__identifier" & " is missing while decoding " & "LdtkFieldInstance")
  target.identifier = jsonTo(source{"__identifier"}, typeof(target.identifier))
  if hasKey(source, "__tile") and source{"__tile"}.kind != JNull:
    target.tile = some(jsonTo(source{"__tile"}, typeof(unsafeGet(target.tile))))
  assert(hasKey(source, "realEditorValues"), "realEditorValues" &
      " is missing while decoding " &
      "LdtkFieldInstance")
  target.realEditorValues = jsonTo(source{"realEditorValues"},
                                   typeof(target.realEditorValues))
  assert(hasKey(source, "__value"),
         "__value" & " is missing while decoding " & "LdtkFieldInstance")
  target.value = jsonTo(source{"__value"}, typeof(target.value))

proc toJsonHook*(source: LdtkFieldInstance): JsonNode =
  result = newJObject()
  result{"__type"} = newJString(source.`type`)
  result{"defUid"} = newJInt(source.defUid)
  result{"__identifier"} = newJString(source.identifier)
  if isSome(source.tile):
    result{"__tile"} = toJsonHook(unsafeGet(source.tile))
  result{"realEditorValues"} = block:
    var output = newJArray()
    for entry in source.realEditorValues:
      output.add(entry)
    output
  result{"__value"} = source.value

proc fromJsonHook*(target: var LdtkTile; source: JsonNode) =
  assert(hasKey(source, "t"), "t" & " is missing while decoding " & "LdtkTile")
  target.t = jsonTo(source{"t"}, typeof(target.t))
  assert(hasKey(source, "d"), "d" & " is missing while decoding " & "LdtkTile")
  target.d = jsonTo(source{"d"}, typeof(target.d))
  assert(hasKey(source, "px"), "px" & " is missing while decoding " & "LdtkTile")
  target.px = jsonTo(source{"px"}, typeof(target.px))
  assert(hasKey(source, "a"), "a" & " is missing while decoding " & "LdtkTile")
  target.a = jsonTo(source{"a"}, typeof(target.a))
  assert(hasKey(source, "f"), "f" & " is missing while decoding " & "LdtkTile")
  target.f = jsonTo(source{"f"}, typeof(target.f))
  assert(hasKey(source, "src"),
         "src" & " is missing while decoding " & "LdtkTile")
  target.src = jsonTo(source{"src"}, typeof(target.src))

proc toJsonHook*(source: LdtkTile): JsonNode =
  result = newJObject()
  result{"t"} = newJInt(source.t)
  result{"d"} = block:
    var output = newJArray()
    for entry in source.d:
      output.add(newJInt(entry))
    output
  result{"px"} = block:
    var output = newJArray()
    for entry in source.px:
      output.add(newJInt(entry))
    output
  result{"a"} = newJFloat(source.a)
  result{"f"} = newJInt(source.f)
  result{"src"} = block:
    var output = newJArray()
    for entry in source.src:
      output.add(newJInt(entry))
    output

proc fromJsonHook*(target: var LdtkEntityInstance; source: JsonNode) =
  assert(hasKey(source, "iid"),
         "iid" & " is missing while decoding " & "LdtkEntityInstance")
  target.iid = jsonTo(source{"iid"}, typeof(target.iid))
  assert(hasKey(source, "defUid"),
         "defUid" & " is missing while decoding " & "LdtkEntityInstance")
  target.defUid = jsonTo(source{"defUid"}, typeof(target.defUid))
  assert(hasKey(source, "__identifier"),
         "__identifier" & " is missing while decoding " & "LdtkEntityInstance")
  target.identifier = jsonTo(source{"__identifier"}, typeof(target.identifier))
  if hasKey(source, "__tile") and source{"__tile"}.kind != JNull:
    target.tile = some(jsonTo(source{"__tile"}, typeof(unsafeGet(target.tile))))
  assert(hasKey(source, "px"),
         "px" & " is missing while decoding " & "LdtkEntityInstance")
  target.px = jsonTo(source{"px"}, typeof(target.px))
  if hasKey(source, "__worldX") and source{"__worldX"}.kind != JNull:
    target.worldX = some(jsonTo(source{"__worldX"},
                                typeof(unsafeGet(target.worldX))))
  if hasKey(source, "__worldY") and source{"__worldY"}.kind != JNull:
    target.worldY = some(jsonTo(source{"__worldY"},
                                typeof(unsafeGet(target.worldY))))
  assert(hasKey(source, "__smartColor"),
         "__smartColor" & " is missing while decoding " & "LdtkEntityInstance")
  target.smartColor = jsonTo(source{"__smartColor"}, typeof(target.smartColor))
  assert(hasKey(source, "__grid"),
         "__grid" & " is missing while decoding " & "LdtkEntityInstance")
  target.grid = jsonTo(source{"__grid"}, typeof(target.grid))
  assert(hasKey(source, "__pivot"),
         "__pivot" & " is missing while decoding " & "LdtkEntityInstance")
  target.pivot = jsonTo(source{"__pivot"}, typeof(target.pivot))
  assert(hasKey(source, "fieldInstances"), "fieldInstances" &
      " is missing while decoding " &
      "LdtkEntityInstance")
  target.fieldInstances = jsonTo(source{"fieldInstances"},
                                 typeof(target.fieldInstances))
  assert(hasKey(source, "height"),
         "height" & " is missing while decoding " & "LdtkEntityInstance")
  target.height = jsonTo(source{"height"}, typeof(target.height))
  assert(hasKey(source, "__tags"),
         "__tags" & " is missing while decoding " & "LdtkEntityInstance")
  target.tags = jsonTo(source{"__tags"}, typeof(target.tags))
  assert(hasKey(source, "width"),
         "width" & " is missing while decoding " & "LdtkEntityInstance")
  target.width = jsonTo(source{"width"}, typeof(target.width))

proc toJsonHook*(source: LdtkEntityInstance): JsonNode =
  result = newJObject()
  result{"iid"} = newJString(source.iid)
  result{"defUid"} = newJInt(source.defUid)
  result{"__identifier"} = newJString(source.identifier)
  if isSome(source.tile):
    result{"__tile"} = toJsonHook(unsafeGet(source.tile))
  result{"px"} = block:
    var output = newJArray()
    for entry in source.px:
      output.add(newJInt(entry))
    output
  if isSome(source.worldX):
    result{"__worldX"} = newJInt(unsafeGet(source.worldX))
  if isSome(source.worldY):
    result{"__worldY"} = newJInt(unsafeGet(source.worldY))
  result{"__smartColor"} = newJString(source.smartColor)
  result{"__grid"} = block:
    var output = newJArray()
    for entry in source.grid:
      output.add(newJInt(entry))
    output
  result{"__pivot"} = block:
    var output = newJArray()
    for entry in source.pivot:
      output.add(newJFloat(entry))
    output
  result{"fieldInstances"} = block:
    var output = newJArray()
    for entry in source.fieldInstances:
      output.add(toJsonHook(entry))
    output
  result{"height"} = newJInt(source.height)
  result{"__tags"} = block:
    var output = newJArray()
    for entry in source.tags:
      output.add(newJString(entry))
    output
  result{"width"} = newJInt(source.width)

proc fromJsonHook*(target: var LdtkIntGridValueInstance; source: JsonNode) =
  assert(hasKey(source, "v"),
         "v" & " is missing while decoding " & "LdtkIntGridValueInstance")
  target.v = jsonTo(source{"v"}, typeof(target.v))
  assert(hasKey(source, "coordId"),
         "coordId" & " is missing while decoding " & "LdtkIntGridValueInstance")
  target.coordId = jsonTo(source{"coordId"}, typeof(target.coordId))

proc toJsonHook*(source: LdtkIntGridValueInstance): JsonNode =
  result = newJObject()
  result{"v"} = newJInt(source.v)
  result{"coordId"} = newJInt(source.coordId)

proc fromJsonHook*(target: var LdtkLayerInstance; source: JsonNode) =
  assert(hasKey(source, "__cHei"),
         "__cHei" & " is missing while decoding " & "LdtkLayerInstance")
  target.cHei = jsonTo(source{"__cHei"}, typeof(target.cHei))
  assert(hasKey(source, "pxOffsetX"),
         "pxOffsetX" & " is missing while decoding " & "LdtkLayerInstance")
  target.pxOffsetX = jsonTo(source{"pxOffsetX"}, typeof(target.pxOffsetX))
  if hasKey(source, "__tilesetRelPath") and
      source{"__tilesetRelPath"}.kind != JNull:
    target.tilesetRelPath = some(jsonTo(source{"__tilesetRelPath"}, typeof(
        unsafeGet(target.tilesetRelPath))))
  assert(hasKey(source, "iid"),
         "iid" & " is missing while decoding " & "LdtkLayerInstance")
  target.iid = jsonTo(source{"iid"}, typeof(target.iid))
  assert(hasKey(source, "levelId"),
         "levelId" & " is missing while decoding " & "LdtkLayerInstance")
  target.levelId = jsonTo(source{"levelId"}, typeof(target.levelId))
  assert(hasKey(source, "__type"),
         "__type" & " is missing while decoding " & "LdtkLayerInstance")
  target.`type` = jsonTo(source{"__type"}, typeof(target.`type`))
  assert(hasKey(source, "autoLayerTiles"),
         "autoLayerTiles" & " is missing while decoding " & "LdtkLayerInstance")
  target.autoLayerTiles = jsonTo(source{"autoLayerTiles"},
                                 typeof(target.autoLayerTiles))
  assert(hasKey(source, "optionalRules"),
         "optionalRules" & " is missing while decoding " & "LdtkLayerInstance")
  target.optionalRules = jsonTo(source{"optionalRules"},
                                typeof(target.optionalRules))
  assert(hasKey(source, "__identifier"),
         "__identifier" & " is missing while decoding " & "LdtkLayerInstance")
  target.identifier = jsonTo(source{"__identifier"}, typeof(target.identifier))
  assert(hasKey(source, "__gridSize"),
         "__gridSize" & " is missing while decoding " & "LdtkLayerInstance")
  target.gridSize = jsonTo(source{"__gridSize"}, typeof(target.gridSize))
  assert(hasKey(source, "__pxTotalOffsetY"), "__pxTotalOffsetY" &
      " is missing while decoding " &
      "LdtkLayerInstance")
  target.pxTotalOffsetY = jsonTo(source{"__pxTotalOffsetY"},
                                 typeof(target.pxTotalOffsetY))
  assert(hasKey(source, "intGridCsv"),
         "intGridCsv" & " is missing while decoding " & "LdtkLayerInstance")
  target.intGridCsv = jsonTo(source{"intGridCsv"}, typeof(target.intGridCsv))
  if hasKey(source, "overrideTilesetUid") and
      source{"overrideTilesetUid"}.kind != JNull:
    target.overrideTilesetUid = some(jsonTo(source{"overrideTilesetUid"},
        typeof(unsafeGet(target.overrideTilesetUid))))
  assert(hasKey(source, "visible"),
         "visible" & " is missing while decoding " & "LdtkLayerInstance")
  target.visible = jsonTo(source{"visible"}, typeof(target.visible))
  assert(hasKey(source, "entityInstances"), "entityInstances" &
      " is missing while decoding " &
      "LdtkLayerInstance")
  target.entityInstances = jsonTo(source{"entityInstances"},
                                  typeof(target.entityInstances))
  assert(hasKey(source, "__opacity"),
         "__opacity" & " is missing while decoding " & "LdtkLayerInstance")
  target.opacity = jsonTo(source{"__opacity"}, typeof(target.opacity))
  assert(hasKey(source, "seed"),
         "seed" & " is missing while decoding " & "LdtkLayerInstance")
  target.seed = jsonTo(source{"seed"}, typeof(target.seed))
  assert(hasKey(source, "layerDefUid"),
         "layerDefUid" & " is missing while decoding " & "LdtkLayerInstance")
  target.layerDefUid = jsonTo(source{"layerDefUid"}, typeof(target.layerDefUid))
  assert(hasKey(source, "__pxTotalOffsetX"), "__pxTotalOffsetX" &
      " is missing while decoding " &
      "LdtkLayerInstance")
  target.pxTotalOffsetX = jsonTo(source{"__pxTotalOffsetX"},
                                 typeof(target.pxTotalOffsetX))
  assert(hasKey(source, "__cWid"),
         "__cWid" & " is missing while decoding " & "LdtkLayerInstance")
  target.cWid = jsonTo(source{"__cWid"}, typeof(target.cWid))
  assert(hasKey(source, "pxOffsetY"),
         "pxOffsetY" & " is missing while decoding " & "LdtkLayerInstance")
  target.pxOffsetY = jsonTo(source{"pxOffsetY"}, typeof(target.pxOffsetY))
  if hasKey(source, "__tilesetDefUid") and
      source{"__tilesetDefUid"}.kind != JNull:
    target.tilesetDefUid = some(jsonTo(source{"__tilesetDefUid"},
                                       typeof(unsafeGet(target.tilesetDefUid))))
  assert(hasKey(source, "gridTiles"),
         "gridTiles" & " is missing while decoding " & "LdtkLayerInstance")
  target.gridTiles = jsonTo(source{"gridTiles"}, typeof(target.gridTiles))
  if hasKey(source, "intGrid") and source{"intGrid"}.kind != JNull:
    target.intGrid = some(jsonTo(source{"intGrid"},
                                 typeof(unsafeGet(target.intGrid))))

proc toJsonHook*(source: LdtkLayerInstance): JsonNode =
  result = newJObject()
  result{"__cHei"} = newJInt(source.cHei)
  result{"pxOffsetX"} = newJInt(source.pxOffsetX)
  if isSome(source.tilesetRelPath):
    result{"__tilesetRelPath"} = newJString(unsafeGet(source.tilesetRelPath))
  result{"iid"} = newJString(source.iid)
  result{"levelId"} = newJInt(source.levelId)
  result{"__type"} = newJString(source.`type`)
  result{"autoLayerTiles"} = block:
    var output = newJArray()
    for entry in source.autoLayerTiles:
      output.add(toJsonHook(entry))
    output
  result{"optionalRules"} = block:
    var output = newJArray()
    for entry in source.optionalRules:
      output.add(newJInt(entry))
    output
  result{"__identifier"} = newJString(source.identifier)
  result{"__gridSize"} = newJInt(source.gridSize)
  result{"__pxTotalOffsetY"} = newJInt(source.pxTotalOffsetY)
  result{"intGridCsv"} = block:
    var output = newJArray()
    for entry in source.intGridCsv:
      output.add(newJInt(entry))
    output
  if isSome(source.overrideTilesetUid):
    result{"overrideTilesetUid"} = newJInt(unsafeGet(source.overrideTilesetUid))
  result{"visible"} = newJBool(source.visible)
  result{"entityInstances"} = block:
    var output = newJArray()
    for entry in source.entityInstances:
      output.add(toJsonHook(entry))
    output
  result{"__opacity"} = newJFloat(source.opacity)
  result{"seed"} = newJInt(source.seed)
  result{"layerDefUid"} = newJInt(source.layerDefUid)
  result{"__pxTotalOffsetX"} = newJInt(source.pxTotalOffsetX)
  result{"__cWid"} = newJInt(source.cWid)
  result{"pxOffsetY"} = newJInt(source.pxOffsetY)
  if isSome(source.tilesetDefUid):
    result{"__tilesetDefUid"} = newJInt(unsafeGet(source.tilesetDefUid))
  result{"gridTiles"} = block:
    var output = newJArray()
    for entry in source.gridTiles:
      output.add(toJsonHook(entry))
    output
  if isSome(source.intGrid):
    result{"intGrid"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.intGrid):
        output.add(toJsonHook(entry))
      output

proc fromJsonHook*(target: var LdtkLevel; source: JsonNode) =
  assert(hasKey(source, "__neighbours"),
         "__neighbours" & " is missing while decoding " & "LdtkLevel")
  target.neighbours = jsonTo(source{"__neighbours"}, typeof(target.neighbours))
  assert(hasKey(source, "__bgColor"),
         "__bgColor" & " is missing while decoding " & "LdtkLevel")
  target.bgColor = jsonTo(source{"__bgColor"}, typeof(target.bgColor))
  assert(hasKey(source, "worldX"),
         "worldX" & " is missing while decoding " & "LdtkLevel")
  target.worldX = jsonTo(source{"worldX"}, typeof(target.worldX))
  if hasKey(source, "externalRelPath") and
      source{"externalRelPath"}.kind != JNull:
    target.externalRelPath = some(jsonTo(source{"externalRelPath"},
        typeof(unsafeGet(target.externalRelPath))))
  assert(hasKey(source, "useAutoIdentifier"),
         "useAutoIdentifier" & " is missing while decoding " & "LdtkLevel")
  target.useAutoIdentifier = jsonTo(source{"useAutoIdentifier"},
                                    typeof(target.useAutoIdentifier))
  assert(hasKey(source, "iid"),
         "iid" & " is missing while decoding " & "LdtkLevel")
  target.iid = jsonTo(source{"iid"}, typeof(target.iid))
  if hasKey(source, "bgColor") and source{"bgColor"}.kind != JNull:
    target.bgColor1 = some(jsonTo(source{"bgColor"},
                                  typeof(unsafeGet(target.bgColor1))))
  if hasKey(source, "bgPos") and source{"bgPos"}.kind != JNull:
    target.bgPos = some(jsonTo(source{"bgPos"}, typeof(unsafeGet(target.bgPos))))
  assert(hasKey(source, "pxHei"),
         "pxHei" & " is missing while decoding " & "LdtkLevel")
  target.pxHei = jsonTo(source{"pxHei"}, typeof(target.pxHei))
  assert(hasKey(source, "worldY"),
         "worldY" & " is missing while decoding " & "LdtkLevel")
  target.worldY = jsonTo(source{"worldY"}, typeof(target.worldY))
  if hasKey(source, "__bgPos") and source{"__bgPos"}.kind != JNull:
    target.bgPos1 = some(jsonTo(source{"__bgPos"},
                                typeof(unsafeGet(target.bgPos1))))
  assert(hasKey(source, "uid"),
         "uid" & " is missing while decoding " & "LdtkLevel")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  assert(hasKey(source, "__smartColor"),
         "__smartColor" & " is missing while decoding " & "LdtkLevel")
  target.smartColor = jsonTo(source{"__smartColor"}, typeof(target.smartColor))
  assert(hasKey(source, "fieldInstances"),
         "fieldInstances" & " is missing while decoding " & "LdtkLevel")
  target.fieldInstances = jsonTo(source{"fieldInstances"},
                                 typeof(target.fieldInstances))
  assert(hasKey(source, "pxWid"),
         "pxWid" & " is missing while decoding " & "LdtkLevel")
  target.pxWid = jsonTo(source{"pxWid"}, typeof(target.pxWid))
  assert(hasKey(source, "identifier"),
         "identifier" & " is missing while decoding " & "LdtkLevel")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  assert(hasKey(source, "bgPivotY"),
         "bgPivotY" & " is missing while decoding " & "LdtkLevel")
  target.bgPivotY = jsonTo(source{"bgPivotY"}, typeof(target.bgPivotY))
  assert(hasKey(source, "bgPivotX"),
         "bgPivotX" & " is missing while decoding " & "LdtkLevel")
  target.bgPivotX = jsonTo(source{"bgPivotX"}, typeof(target.bgPivotX))
  if hasKey(source, "layerInstances") and
      source{"layerInstances"}.kind != JNull:
    target.layerInstances = some(jsonTo(source{"layerInstances"}, typeof(
        unsafeGet(target.layerInstances))))
  if hasKey(source, "bgRelPath") and source{"bgRelPath"}.kind != JNull:
    target.bgRelPath = some(jsonTo(source{"bgRelPath"},
                                   typeof(unsafeGet(target.bgRelPath))))
  assert(hasKey(source, "worldDepth"),
         "worldDepth" & " is missing while decoding " & "LdtkLevel")
  target.worldDepth = jsonTo(source{"worldDepth"}, typeof(target.worldDepth))

proc toJsonHook*(source: LdtkLevel): JsonNode =
  result = newJObject()
  result{"__neighbours"} = block:
    var output = newJArray()
    for entry in source.neighbours:
      output.add(toJsonHook(entry))
    output
  result{"__bgColor"} = newJString(source.bgColor)
  result{"worldX"} = newJInt(source.worldX)
  if isSome(source.externalRelPath):
    result{"externalRelPath"} = newJString(unsafeGet(source.externalRelPath))
  result{"useAutoIdentifier"} = newJBool(source.useAutoIdentifier)
  result{"iid"} = newJString(source.iid)
  if isSome(source.bgColor1):
    result{"bgColor"} = newJString(unsafeGet(source.bgColor1))
  if isSome(source.bgPos):
    result{"bgPos"} = toJsonHook(unsafeGet(source.bgPos))
  result{"pxHei"} = newJInt(source.pxHei)
  result{"worldY"} = newJInt(source.worldY)
  if isSome(source.bgPos1):
    result{"__bgPos"} = toJsonHook(unsafeGet(source.bgPos1))
  result{"uid"} = newJInt(source.uid)
  result{"__smartColor"} = newJString(source.smartColor)
  result{"fieldInstances"} = block:
    var output = newJArray()
    for entry in source.fieldInstances:
      output.add(toJsonHook(entry))
    output
  result{"pxWid"} = newJInt(source.pxWid)
  result{"identifier"} = newJString(source.identifier)
  result{"bgPivotY"} = newJFloat(source.bgPivotY)
  result{"bgPivotX"} = newJFloat(source.bgPivotX)
  if isSome(source.layerInstances):
    result{"layerInstances"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.layerInstances):
        output.add(toJsonHook(entry))
      output
  if isSome(source.bgRelPath):
    result{"bgRelPath"} = newJString(unsafeGet(source.bgRelPath))
  result{"worldDepth"} = newJInt(source.worldDepth)

proc fromJsonHook*(target: var LdtkWorld; source: JsonNode) =
  assert(hasKey(source, "worldGridWidth"),
         "worldGridWidth" & " is missing while decoding " & "LdtkWorld")
  target.worldGridWidth = jsonTo(source{"worldGridWidth"},
                                 typeof(target.worldGridWidth))
  assert(hasKey(source, "iid"),
         "iid" & " is missing while decoding " & "LdtkWorld")
  target.iid = jsonTo(source{"iid"}, typeof(target.iid))
  assert(hasKey(source, "worldGridHeight"),
         "worldGridHeight" & " is missing while decoding " & "LdtkWorld")
  target.worldGridHeight = jsonTo(source{"worldGridHeight"},
                                  typeof(target.worldGridHeight))
  assert(hasKey(source, "worldLayout"),
         "worldLayout" & " is missing while decoding " & "LdtkWorld")
  target.worldLayout = jsonTo(source{"worldLayout"}, typeof(target.worldLayout))
  assert(hasKey(source, "defaultLevelWidth"),
         "defaultLevelWidth" & " is missing while decoding " & "LdtkWorld")
  target.defaultLevelWidth = jsonTo(source{"defaultLevelWidth"},
                                    typeof(target.defaultLevelWidth))
  assert(hasKey(source, "levels"),
         "levels" & " is missing while decoding " & "LdtkWorld")
  target.levels = jsonTo(source{"levels"}, typeof(target.levels))
  assert(hasKey(source, "defaultLevelHeight"),
         "defaultLevelHeight" & " is missing while decoding " & "LdtkWorld")
  target.defaultLevelHeight = jsonTo(source{"defaultLevelHeight"},
                                     typeof(target.defaultLevelHeight))
  assert(hasKey(source, "identifier"),
         "identifier" & " is missing while decoding " & "LdtkWorld")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))

proc toJsonHook*(source: LdtkWorld): JsonNode =
  result = newJObject()
  result{"worldGridWidth"} = newJInt(source.worldGridWidth)
  result{"iid"} = newJString(source.iid)
  result{"worldGridHeight"} = newJInt(source.worldGridHeight)
  result{"worldLayout"} = if isSome(source.worldLayout):
    toJsonHook(unsafeGet(source.worldLayout))
  else:
    newJNull()
  result{"defaultLevelWidth"} = newJInt(source.defaultLevelWidth)
  result{"levels"} = block:
    var output = newJArray()
    for entry in source.levels:
      output.add(toJsonHook(entry))
    output
  result{"defaultLevelHeight"} = newJInt(source.defaultLevelHeight)
  result{"identifier"} = newJString(source.identifier)

proc fromJsonHook*(target: var LdtkEntityReferenceInfos; source: JsonNode) =
  assert(hasKey(source, "worldIid"), "worldIid" & " is missing while decoding " &
      "LdtkEntityReferenceInfos")
  target.worldIid = jsonTo(source{"worldIid"}, typeof(target.worldIid))
  assert(hasKey(source, "entityIid"), "entityIid" &
      " is missing while decoding " &
      "LdtkEntityReferenceInfos")
  target.entityIid = jsonTo(source{"entityIid"}, typeof(target.entityIid))
  assert(hasKey(source, "layerIid"), "layerIid" & " is missing while decoding " &
      "LdtkEntityReferenceInfos")
  target.layerIid = jsonTo(source{"layerIid"}, typeof(target.layerIid))
  assert(hasKey(source, "levelIid"), "levelIid" & " is missing while decoding " &
      "LdtkEntityReferenceInfos")
  target.levelIid = jsonTo(source{"levelIid"}, typeof(target.levelIid))

proc toJsonHook*(source: LdtkEntityReferenceInfos): JsonNode =
  result = newJObject()
  result{"worldIid"} = newJString(source.worldIid)
  result{"entityIid"} = newJString(source.entityIid)
  result{"layerIid"} = newJString(source.layerIid)
  result{"levelIid"} = newJString(source.levelIid)

proc fromJsonHook*(target: var LdtkTocInstanceData; source: JsonNode) =
  assert(hasKey(source, "worldX"),
         "worldX" & " is missing while decoding " & "LdtkTocInstanceData")
  target.worldX = jsonTo(source{"worldX"}, typeof(target.worldX))
  assert(hasKey(source, "widPx"),
         "widPx" & " is missing while decoding " & "LdtkTocInstanceData")
  target.widPx = jsonTo(source{"widPx"}, typeof(target.widPx))
  assert(hasKey(source, "worldY"),
         "worldY" & " is missing while decoding " & "LdtkTocInstanceData")
  target.worldY = jsonTo(source{"worldY"}, typeof(target.worldY))
  assert(hasKey(source, "heiPx"),
         "heiPx" & " is missing while decoding " & "LdtkTocInstanceData")
  target.heiPx = jsonTo(source{"heiPx"}, typeof(target.heiPx))
  assert(hasKey(source, "fields"),
         "fields" & " is missing while decoding " & "LdtkTocInstanceData")
  target.fields = jsonTo(source{"fields"}, typeof(target.fields))
  assert(hasKey(source, "iids"),
         "iids" & " is missing while decoding " & "LdtkTocInstanceData")
  target.iids = jsonTo(source{"iids"}, typeof(target.iids))

proc toJsonHook*(source: LdtkTocInstanceData): JsonNode =
  result = newJObject()
  result{"worldX"} = newJInt(source.worldX)
  result{"widPx"} = newJInt(source.widPx)
  result{"worldY"} = newJInt(source.worldY)
  result{"heiPx"} = newJInt(source.heiPx)
  result{"fields"} = source.fields
  result{"iids"} = toJsonHook(source.iids)

proc fromJsonHook*(target: var LdtkTableOfContentEntry; source: JsonNode) =
  assert(hasKey(source, "identifier"), "identifier" &
      " is missing while decoding " &
      "LdtkTableOfContentEntry")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  assert(hasKey(source, "instancesData"), "instancesData" &
      " is missing while decoding " &
      "LdtkTableOfContentEntry")
  target.instancesData = jsonTo(source{"instancesData"},
                                typeof(target.instancesData))
  if hasKey(source, "instances") and source{"instances"}.kind != JNull:
    target.instances = some(jsonTo(source{"instances"},
                                   typeof(unsafeGet(target.instances))))

proc toJsonHook*(source: LdtkTableOfContentEntry): JsonNode =
  result = newJObject()
  result{"identifier"} = newJString(source.identifier)
  result{"instancesData"} = block:
    var output = newJArray()
    for entry in source.instancesData:
      output.add(toJsonHook(entry))
    output
  if isSome(source.instances):
    result{"instances"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.instances):
        output.add(toJsonHook(entry))
      output

proc toJsonHook*(source: LdtkImageExportMode): JsonNode =
  case source
  of LdtkImageExportMode.None:
    return newJString("None")
  of LdtkImageExportMode.OneImagePerLayer:
    return newJString("OneImagePerLayer")
  of LdtkImageExportMode.OneImagePerLevel:
    return newJString("OneImagePerLevel")
  of LdtkImageExportMode.LayersAndLevels:
    return newJString("LayersAndLevels")
  
proc fromJsonHook*(target: var LdtkImageExportMode; source: JsonNode) =
  target = case getStr(source)
  of "None":
    LdtkImageExportMode.None
  of "OneImagePerLayer":
    LdtkImageExportMode.OneImagePerLayer
  of "OneImagePerLevel":
    LdtkImageExportMode.OneImagePerLevel
  of "LayersAndLevels":
    LdtkImageExportMode.LayersAndLevels
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc toJsonHook*(source: LdtkIdentifierStyle): JsonNode =
  case source
  of LdtkIdentifierStyle.Capitalize:
    return newJString("Capitalize")
  of LdtkIdentifierStyle.Uppercase:
    return newJString("Uppercase")
  of LdtkIdentifierStyle.Lowercase:
    return newJString("Lowercase")
  of LdtkIdentifierStyle.Free:
    return newJString("Free")
  
proc fromJsonHook*(target: var LdtkIdentifierStyle; source: JsonNode) =
  target = case getStr(source)
  of "Capitalize":
    LdtkIdentifierStyle.Capitalize
  of "Uppercase":
    LdtkIdentifierStyle.Uppercase
  of "Lowercase":
    LdtkIdentifierStyle.Lowercase
  of "Free":
    LdtkIdentifierStyle.Free
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc toJsonHook*(source: LdtkWhen): JsonNode =
  case source
  of LdtkWhen.Manual:
    return newJString("Manual")
  of LdtkWhen.AfterLoad:
    return newJString("AfterLoad")
  of LdtkWhen.BeforeSave:
    return newJString("BeforeSave")
  of LdtkWhen.AfterSave:
    return newJString("AfterSave")
  
proc fromJsonHook*(target: var LdtkWhen; source: JsonNode) =
  target = case getStr(source)
  of "Manual":
    LdtkWhen.Manual
  of "AfterLoad":
    LdtkWhen.AfterLoad
  of "BeforeSave":
    LdtkWhen.BeforeSave
  of "AfterSave":
    LdtkWhen.AfterSave
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc fromJsonHook*(target: var LdtkCustomCommand; source: JsonNode) =
  assert(hasKey(source, "when"),
         "when" & " is missing while decoding " & "LdtkCustomCommand")
  target.`when` = jsonTo(source{"when"}, typeof(target.`when`))
  assert(hasKey(source, "command"),
         "command" & " is missing while decoding " & "LdtkCustomCommand")
  target.command = jsonTo(source{"command"}, typeof(target.command))

proc toJsonHook*(source: LdtkCustomCommand): JsonNode =
  result = newJObject()
  result{"when"} = toJsonHook(source.`when`)
  result{"command"} = newJString(source.command)

proc toJsonHook*(source: LdtkldtkWorldLayout): JsonNode =
  case source
  of LdtkldtkWorldLayout.Free:
    return newJString("Free")
  of LdtkldtkWorldLayout.GridVania:
    return newJString("GridVania")
  of LdtkldtkWorldLayout.LinearHorizontal:
    return newJString("LinearHorizontal")
  of LdtkldtkWorldLayout.LinearVertical:
    return newJString("LinearVertical")
  
proc fromJsonHook*(target: var LdtkldtkWorldLayout; source: JsonNode) =
  target = case getStr(source)
  of "Free":
    LdtkldtkWorldLayout.Free
  of "GridVania":
    LdtkldtkWorldLayout.GridVania
  of "LinearHorizontal":
    LdtkldtkWorldLayout.LinearHorizontal
  of "LinearVertical":
    LdtkldtkWorldLayout.LinearVertical
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc toJsonHook*(source: LdtkFlags): JsonNode =
  case source
  of LdtkFlags.DiscardPreCsvIntGrid:
    return newJString("DiscardPreCsvIntGrid")
  of LdtkFlags.ExportOldTableOfContentData:
    return newJString("ExportOldTableOfContentData")
  of LdtkFlags.ExportPreCsvIntGridFormat:
    return newJString("ExportPreCsvIntGridFormat")
  of LdtkFlags.IgnoreBackupSuggest:
    return newJString("IgnoreBackupSuggest")
  of LdtkFlags.PrependIndexToLevelFileNames:
    return newJString("PrependIndexToLevelFileNames")
  of LdtkFlags.MultiWorlds:
    return newJString("MultiWorlds")
  of LdtkFlags.UseMultilinesType:
    return newJString("UseMultilinesType")
  
proc fromJsonHook*(target: var LdtkFlags; source: JsonNode) =
  target = case getStr(source)
  of "DiscardPreCsvIntGrid":
    LdtkFlags.DiscardPreCsvIntGrid
  of "ExportOldTableOfContentData":
    LdtkFlags.ExportOldTableOfContentData
  of "ExportPreCsvIntGridFormat":
    LdtkFlags.ExportPreCsvIntGridFormat
  of "IgnoreBackupSuggest":
    LdtkFlags.IgnoreBackupSuggest
  of "PrependIndexToLevelFileNames":
    LdtkFlags.PrependIndexToLevelFileNames
  of "MultiWorlds":
    LdtkFlags.MultiWorlds
  of "UseMultilinesType":
    LdtkFlags.UseMultilinesType
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc fromJsonHook*(target: var LdtkTileCustomMetadata; source: JsonNode) =
  assert(hasKey(source, "tileId"),
         "tileId" & " is missing while decoding " & "LdtkTileCustomMetadata")
  target.tileId = jsonTo(source{"tileId"}, typeof(target.tileId))
  assert(hasKey(source, "data"),
         "data" & " is missing while decoding " & "LdtkTileCustomMetadata")
  target.data = jsonTo(source{"data"}, typeof(target.data))

proc toJsonHook*(source: LdtkTileCustomMetadata): JsonNode =
  result = newJObject()
  result{"tileId"} = newJInt(source.tileId)
  result{"data"} = newJString(source.data)

proc fromJsonHook*(target: var LdtkEnumTagValue; source: JsonNode) =
  assert(hasKey(source, "tileIds"),
         "tileIds" & " is missing while decoding " & "LdtkEnumTagValue")
  target.tileIds = jsonTo(source{"tileIds"}, typeof(target.tileIds))
  assert(hasKey(source, "enumValueId"),
         "enumValueId" & " is missing while decoding " & "LdtkEnumTagValue")
  target.enumValueId = jsonTo(source{"enumValueId"}, typeof(target.enumValueId))

proc toJsonHook*(source: LdtkEnumTagValue): JsonNode =
  result = newJObject()
  result{"tileIds"} = block:
    var output = newJArray()
    for entry in source.tileIds:
      output.add(newJInt(entry))
    output
  result{"enumValueId"} = newJString(source.enumValueId)

proc toJsonHook*(source: LdtkEmbedAtlas): JsonNode =
  case source
  of LdtkEmbedAtlas.LdtkIcons:
    return newJString("LdtkIcons")
  
proc fromJsonHook*(target: var LdtkEmbedAtlas; source: JsonNode) =
  target = case getStr(source)
  of "LdtkIcons":
    LdtkEmbedAtlas.LdtkIcons
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc fromJsonHook*(target: var LdtkTilesetDef; source: JsonNode) =
  if hasKey(source, "cachedPixelData") and
      source{"cachedPixelData"}.kind != JNull:
    target.cachedPixelData = some(jsonTo(source{"cachedPixelData"},
        typeof(unsafeGet(target.cachedPixelData))))
  assert(hasKey(source, "__cHei"),
         "__cHei" & " is missing while decoding " & "LdtkTilesetDef")
  target.cHei = jsonTo(source{"__cHei"}, typeof(target.cHei))
  assert(hasKey(source, "pxHei"),
         "pxHei" & " is missing while decoding " & "LdtkTilesetDef")
  target.pxHei = jsonTo(source{"pxHei"}, typeof(target.pxHei))
  assert(hasKey(source, "customData"),
         "customData" & " is missing while decoding " & "LdtkTilesetDef")
  target.customData = jsonTo(source{"customData"}, typeof(target.customData))
  if hasKey(source, "tagsSourceEnumUid") and
      source{"tagsSourceEnumUid"}.kind != JNull:
    target.tagsSourceEnumUid = some(jsonTo(source{"tagsSourceEnumUid"},
        typeof(unsafeGet(target.tagsSourceEnumUid))))
  assert(hasKey(source, "uid"),
         "uid" & " is missing while decoding " & "LdtkTilesetDef")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  assert(hasKey(source, "padding"),
         "padding" & " is missing while decoding " & "LdtkTilesetDef")
  target.padding = jsonTo(source{"padding"}, typeof(target.padding))
  assert(hasKey(source, "enumTags"),
         "enumTags" & " is missing while decoding " & "LdtkTilesetDef")
  target.enumTags = jsonTo(source{"enumTags"}, typeof(target.enumTags))
  assert(hasKey(source, "pxWid"),
         "pxWid" & " is missing while decoding " & "LdtkTilesetDef")
  target.pxWid = jsonTo(source{"pxWid"}, typeof(target.pxWid))
  assert(hasKey(source, "__cWid"),
         "__cWid" & " is missing while decoding " & "LdtkTilesetDef")
  target.cWid = jsonTo(source{"__cWid"}, typeof(target.cWid))
  assert(hasKey(source, "spacing"),
         "spacing" & " is missing while decoding " & "LdtkTilesetDef")
  target.spacing = jsonTo(source{"spacing"}, typeof(target.spacing))
  assert(hasKey(source, "identifier"),
         "identifier" & " is missing while decoding " & "LdtkTilesetDef")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  assert(hasKey(source, "savedSelections"),
         "savedSelections" & " is missing while decoding " & "LdtkTilesetDef")
  target.savedSelections = jsonTo(source{"savedSelections"},
                                  typeof(target.savedSelections))
  assert(hasKey(source, "tags"),
         "tags" & " is missing while decoding " & "LdtkTilesetDef")
  target.tags = jsonTo(source{"tags"}, typeof(target.tags))
  if hasKey(source, "embedAtlas") and source{"embedAtlas"}.kind != JNull:
    target.embedAtlas = some(jsonTo(source{"embedAtlas"},
                                    typeof(unsafeGet(target.embedAtlas))))
  if hasKey(source, "relPath") and source{"relPath"}.kind != JNull:
    target.relPath = some(jsonTo(source{"relPath"},
                                 typeof(unsafeGet(target.relPath))))
  assert(hasKey(source, "tileGridSize"),
         "tileGridSize" & " is missing while decoding " & "LdtkTilesetDef")
  target.tileGridSize = jsonTo(source{"tileGridSize"},
                               typeof(target.tileGridSize))

proc toJsonHook*(source: LdtkTilesetDef): JsonNode =
  result = newJObject()
  if isSome(source.cachedPixelData):
    result{"cachedPixelData"} = block:
      var output = newJObject()
      for key, entry in pairs(
          unsafeGet(source.cachedPixelData)):
        output[key] = entry
      output
  result{"__cHei"} = newJInt(source.cHei)
  result{"pxHei"} = newJInt(source.pxHei)
  result{"customData"} = block:
    var output = newJArray()
    for entry in source.customData:
      output.add(toJsonHook(entry))
    output
  if isSome(source.tagsSourceEnumUid):
    result{"tagsSourceEnumUid"} = newJInt(unsafeGet(source.tagsSourceEnumUid))
  result{"uid"} = newJInt(source.uid)
  result{"padding"} = newJInt(source.padding)
  result{"enumTags"} = block:
    var output = newJArray()
    for entry in source.enumTags:
      output.add(toJsonHook(entry))
    output
  result{"pxWid"} = newJInt(source.pxWid)
  result{"__cWid"} = newJInt(source.cWid)
  result{"spacing"} = newJInt(source.spacing)
  result{"identifier"} = newJString(source.identifier)
  result{"savedSelections"} = block:
    var output = newJArray()
    for entry in source.savedSelections:
      output.add(block:
        var output = newJObject()
        for key, entry in pairs(entry):
          output[key] = entry
        output)
    output
  result{"tags"} = block:
    var output = newJArray()
    for entry in source.tags:
      output.add(newJString(entry))
    output
  if isSome(source.embedAtlas):
    result{"embedAtlas"} = toJsonHook(unsafeGet(source.embedAtlas))
  if isSome(source.relPath):
    result{"relPath"} = newJString(unsafeGet(source.relPath))
  result{"tileGridSize"} = newJInt(source.tileGridSize)

proc fromJsonHook*(target: var LdtkIntGridValueGroupDef; source: JsonNode) =
  if hasKey(source, "color") and source{"color"}.kind != JNull:
    target.color = some(jsonTo(source{"color"}, typeof(unsafeGet(target.color))))
  assert(hasKey(source, "uid"),
         "uid" & " is missing while decoding " & "LdtkIntGridValueGroupDef")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  if hasKey(source, "identifier") and source{"identifier"}.kind != JNull:
    target.identifier = some(jsonTo(source{"identifier"},
                                    typeof(unsafeGet(target.identifier))))

proc toJsonHook*(source: LdtkIntGridValueGroupDef): JsonNode =
  result = newJObject()
  if isSome(source.color):
    result{"color"} = newJString(unsafeGet(source.color))
  result{"uid"} = newJInt(source.uid)
  if isSome(source.identifier):
    result{"identifier"} = newJString(unsafeGet(source.identifier))

proc fromJsonHook*(target: var LdtkIntGridValueDef; source: JsonNode) =
  if hasKey(source, "tile") and source{"tile"}.kind != JNull:
    target.tile = some(jsonTo(source{"tile"}, typeof(unsafeGet(target.tile))))
  assert(hasKey(source, "color"),
         "color" & " is missing while decoding " & "LdtkIntGridValueDef")
  target.color = jsonTo(source{"color"}, typeof(target.color))
  if hasKey(source, "identifier") and source{"identifier"}.kind != JNull:
    target.identifier = some(jsonTo(source{"identifier"},
                                    typeof(unsafeGet(target.identifier))))
  assert(hasKey(source, "value"),
         "value" & " is missing while decoding " & "LdtkIntGridValueDef")
  target.value = jsonTo(source{"value"}, typeof(target.value))
  assert(hasKey(source, "groupUid"),
         "groupUid" & " is missing while decoding " & "LdtkIntGridValueDef")
  target.groupUid = jsonTo(source{"groupUid"}, typeof(target.groupUid))

proc toJsonHook*(source: LdtkIntGridValueDef): JsonNode =
  result = newJObject()
  if isSome(source.tile):
    result{"tile"} = toJsonHook(unsafeGet(source.tile))
  result{"color"} = newJString(source.color)
  if isSome(source.identifier):
    result{"identifier"} = newJString(unsafeGet(source.identifier))
  result{"value"} = newJInt(source.value)
  result{"groupUid"} = newJInt(source.groupUid)

proc toJsonHook*(source: LdtkChecker): JsonNode =
  case source
  of LdtkChecker.None:
    return newJString("None")
  of LdtkChecker.Horizontal:
    return newJString("Horizontal")
  of LdtkChecker.Vertical:
    return newJString("Vertical")
  
proc fromJsonHook*(target: var LdtkChecker; source: JsonNode) =
  target = case getStr(source)
  of "None":
    LdtkChecker.None
  of "Horizontal":
    LdtkChecker.Horizontal
  of "Vertical":
    LdtkChecker.Vertical
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc toJsonHook*(source: LdtkTileMode): JsonNode =
  case source
  of LdtkTileMode.Single:
    return newJString("Single")
  of LdtkTileMode.Stamp:
    return newJString("Stamp")
  
proc fromJsonHook*(target: var LdtkTileMode; source: JsonNode) =
  target = case getStr(source)
  of "Single":
    LdtkTileMode.Single
  of "Stamp":
    LdtkTileMode.Stamp
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc fromJsonHook*(target: var LdtkAutoRuleDef; source: JsonNode) =
  assert(hasKey(source, "flipX"),
         "flipX" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.flipX = jsonTo(source{"flipX"}, typeof(target.flipX))
  assert(hasKey(source, "pivotX"),
         "pivotX" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.pivotX = jsonTo(source{"pivotX"}, typeof(target.pivotX))
  assert(hasKey(source, "perlinActive"),
         "perlinActive" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.perlinActive = jsonTo(source{"perlinActive"},
                               typeof(target.perlinActive))
  assert(hasKey(source, "tileRectsIds"),
         "tileRectsIds" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.tileRectsIds = jsonTo(source{"tileRectsIds"},
                               typeof(target.tileRectsIds))
  assert(hasKey(source, "perlinScale"),
         "perlinScale" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.perlinScale = jsonTo(source{"perlinScale"}, typeof(target.perlinScale))
  if hasKey(source, "outOfBoundsValue") and
      source{"outOfBoundsValue"}.kind != JNull:
    target.outOfBoundsValue = some(jsonTo(source{"outOfBoundsValue"},
        typeof(unsafeGet(target.outOfBoundsValue))))
  assert(hasKey(source, "pattern"),
         "pattern" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.pattern = jsonTo(source{"pattern"}, typeof(target.pattern))
  assert(hasKey(source, "tileRandomXMin"),
         "tileRandomXMin" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.tileRandomXMin = jsonTo(source{"tileRandomXMin"},
                                 typeof(target.tileRandomXMin))
  assert(hasKey(source, "checker"),
         "checker" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.checker = jsonTo(source{"checker"}, typeof(target.checker))
  assert(hasKey(source, "perlinOctaves"),
         "perlinOctaves" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.perlinOctaves = jsonTo(source{"perlinOctaves"},
                                typeof(target.perlinOctaves))
  if hasKey(source, "tileIds") and source{"tileIds"}.kind != JNull:
    target.tileIds = some(jsonTo(source{"tileIds"},
                                 typeof(unsafeGet(target.tileIds))))
  assert(hasKey(source, "alpha"),
         "alpha" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.alpha = jsonTo(source{"alpha"}, typeof(target.alpha))
  assert(hasKey(source, "tileXOffset"),
         "tileXOffset" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.tileXOffset = jsonTo(source{"tileXOffset"}, typeof(target.tileXOffset))
  assert(hasKey(source, "invalidated"),
         "invalidated" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.invalidated = jsonTo(source{"invalidated"}, typeof(target.invalidated))
  assert(hasKey(source, "xModulo"),
         "xModulo" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.xModulo = jsonTo(source{"xModulo"}, typeof(target.xModulo))
  assert(hasKey(source, "size"),
         "size" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.size = jsonTo(source{"size"}, typeof(target.size))
  assert(hasKey(source, "chance"),
         "chance" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.chance = jsonTo(source{"chance"}, typeof(target.chance))
  assert(hasKey(source, "breakOnMatch"),
         "breakOnMatch" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.breakOnMatch = jsonTo(source{"breakOnMatch"},
                               typeof(target.breakOnMatch))
  assert(hasKey(source, "tileYOffset"),
         "tileYOffset" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.tileYOffset = jsonTo(source{"tileYOffset"}, typeof(target.tileYOffset))
  assert(hasKey(source, "uid"),
         "uid" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  assert(hasKey(source, "perlinSeed"),
         "perlinSeed" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.perlinSeed = jsonTo(source{"perlinSeed"}, typeof(target.perlinSeed))
  assert(hasKey(source, "yOffset"),
         "yOffset" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.yOffset = jsonTo(source{"yOffset"}, typeof(target.yOffset))
  assert(hasKey(source, "tileRandomYMax"),
         "tileRandomYMax" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.tileRandomYMax = jsonTo(source{"tileRandomYMax"},
                                 typeof(target.tileRandomYMax))
  assert(hasKey(source, "tileRandomYMin"),
         "tileRandomYMin" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.tileRandomYMin = jsonTo(source{"tileRandomYMin"},
                                 typeof(target.tileRandomYMin))
  assert(hasKey(source, "tileMode"),
         "tileMode" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.tileMode = jsonTo(source{"tileMode"}, typeof(target.tileMode))
  assert(hasKey(source, "flipY"),
         "flipY" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.flipY = jsonTo(source{"flipY"}, typeof(target.flipY))
  assert(hasKey(source, "tileRandomXMax"),
         "tileRandomXMax" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.tileRandomXMax = jsonTo(source{"tileRandomXMax"},
                                 typeof(target.tileRandomXMax))
  assert(hasKey(source, "pivotY"),
         "pivotY" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.pivotY = jsonTo(source{"pivotY"}, typeof(target.pivotY))
  assert(hasKey(source, "yModulo"),
         "yModulo" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.yModulo = jsonTo(source{"yModulo"}, typeof(target.yModulo))
  assert(hasKey(source, "active"),
         "active" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.active = jsonTo(source{"active"}, typeof(target.active))
  assert(hasKey(source, "xOffset"),
         "xOffset" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.xOffset = jsonTo(source{"xOffset"}, typeof(target.xOffset))

proc toJsonHook*(source: LdtkAutoRuleDef): JsonNode =
  result = newJObject()
  result{"flipX"} = newJBool(source.flipX)
  result{"pivotX"} = newJFloat(source.pivotX)
  result{"perlinActive"} = newJBool(source.perlinActive)
  result{"tileRectsIds"} = block:
    var output = newJArray()
    for entry in source.tileRectsIds:
      output.add(block:
        var output = newJArray()
        for entry in entry:
          output.add(newJInt(entry))
        output)
    output
  result{"perlinScale"} = newJFloat(source.perlinScale)
  if isSome(source.outOfBoundsValue):
    result{"outOfBoundsValue"} = newJInt(unsafeGet(source.outOfBoundsValue))
  result{"pattern"} = block:
    var output = newJArray()
    for entry in source.pattern:
      output.add(newJInt(entry))
    output
  result{"tileRandomXMin"} = newJInt(source.tileRandomXMin)
  result{"checker"} = toJsonHook(source.checker)
  result{"perlinOctaves"} = newJFloat(source.perlinOctaves)
  if isSome(source.tileIds):
    result{"tileIds"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.tileIds):
        output.add(newJInt(entry))
      output
  result{"alpha"} = newJFloat(source.alpha)
  result{"tileXOffset"} = newJInt(source.tileXOffset)
  result{"invalidated"} = newJBool(source.invalidated)
  result{"xModulo"} = newJInt(source.xModulo)
  result{"size"} = newJInt(source.size)
  result{"chance"} = newJFloat(source.chance)
  result{"breakOnMatch"} = newJBool(source.breakOnMatch)
  result{"tileYOffset"} = newJInt(source.tileYOffset)
  result{"uid"} = newJInt(source.uid)
  result{"perlinSeed"} = newJFloat(source.perlinSeed)
  result{"yOffset"} = newJInt(source.yOffset)
  result{"tileRandomYMax"} = newJInt(source.tileRandomYMax)
  result{"tileRandomYMin"} = newJInt(source.tileRandomYMin)
  result{"tileMode"} = toJsonHook(source.tileMode)
  result{"flipY"} = newJBool(source.flipY)
  result{"tileRandomXMax"} = newJInt(source.tileRandomXMax)
  result{"pivotY"} = newJFloat(source.pivotY)
  result{"yModulo"} = newJInt(source.yModulo)
  result{"active"} = newJBool(source.active)
  result{"xOffset"} = newJInt(source.xOffset)

proc fromJsonHook*(target: var LdtkAutoLayerRuleGroup; source: JsonNode) =
  assert(hasKey(source, "name"),
         "name" & " is missing while decoding " & "LdtkAutoLayerRuleGroup")
  target.name = jsonTo(source{"name"}, typeof(target.name))
  if hasKey(source, "collapsed") and source{"collapsed"}.kind != JNull:
    target.collapsed = some(jsonTo(source{"collapsed"},
                                   typeof(unsafeGet(target.collapsed))))
  assert(hasKey(source, "biomeRequirementMode"), "biomeRequirementMode" &
      " is missing while decoding " &
      "LdtkAutoLayerRuleGroup")
  target.biomeRequirementMode = jsonTo(source{"biomeRequirementMode"},
                                       typeof(target.biomeRequirementMode))
  if hasKey(source, "color") and source{"color"}.kind != JNull:
    target.color = some(jsonTo(source{"color"}, typeof(unsafeGet(target.color))))
  assert(hasKey(source, "isOptional"), "isOptional" &
      " is missing while decoding " &
      "LdtkAutoLayerRuleGroup")
  target.isOptional = jsonTo(source{"isOptional"}, typeof(target.isOptional))
  if hasKey(source, "icon") and source{"icon"}.kind != JNull:
    target.icon = some(jsonTo(source{"icon"}, typeof(unsafeGet(target.icon))))
  assert(hasKey(source, "usesWizard"), "usesWizard" &
      " is missing while decoding " &
      "LdtkAutoLayerRuleGroup")
  target.usesWizard = jsonTo(source{"usesWizard"}, typeof(target.usesWizard))
  assert(hasKey(source, "uid"),
         "uid" & " is missing while decoding " & "LdtkAutoLayerRuleGroup")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  assert(hasKey(source, "requiredBiomeValues"), "requiredBiomeValues" &
      " is missing while decoding " &
      "LdtkAutoLayerRuleGroup")
  target.requiredBiomeValues = jsonTo(source{"requiredBiomeValues"},
                                      typeof(target.requiredBiomeValues))
  assert(hasKey(source, "active"),
         "active" & " is missing while decoding " & "LdtkAutoLayerRuleGroup")
  target.active = jsonTo(source{"active"}, typeof(target.active))
  assert(hasKey(source, "rules"),
         "rules" & " is missing while decoding " & "LdtkAutoLayerRuleGroup")
  target.rules = jsonTo(source{"rules"}, typeof(target.rules))

proc toJsonHook*(source: LdtkAutoLayerRuleGroup): JsonNode =
  result = newJObject()
  result{"name"} = newJString(source.name)
  if isSome(source.collapsed):
    result{"collapsed"} = newJBool(unsafeGet(source.collapsed))
  result{"biomeRequirementMode"} = newJInt(source.biomeRequirementMode)
  if isSome(source.color):
    result{"color"} = newJString(unsafeGet(source.color))
  result{"isOptional"} = newJBool(source.isOptional)
  if isSome(source.icon):
    result{"icon"} = toJsonHook(unsafeGet(source.icon))
  result{"usesWizard"} = newJBool(source.usesWizard)
  result{"uid"} = newJInt(source.uid)
  result{"requiredBiomeValues"} = block:
    var output = newJArray()
    for entry in source.requiredBiomeValues:
      output.add(newJString(entry))
    output
  result{"active"} = newJBool(source.active)
  result{"rules"} = block:
    var output = newJArray()
    for entry in source.rules:
      output.add(toJsonHook(entry))
    output

proc toJsonHook*(source: LdtkType): JsonNode =
  case source
  of LdtkType.IntGrid:
    return newJString("IntGrid")
  of LdtkType.Entities:
    return newJString("Entities")
  of LdtkType.Tiles:
    return newJString("Tiles")
  of LdtkType.AutoLayer:
    return newJString("AutoLayer")
  
proc fromJsonHook*(target: var LdtkType; source: JsonNode) =
  target = case getStr(source)
  of "IntGrid":
    LdtkType.IntGrid
  of "Entities":
    LdtkType.Entities
  of "Tiles":
    LdtkType.Tiles
  of "AutoLayer":
    LdtkType.AutoLayer
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc fromJsonHook*(target: var LdtkLayerDef; source: JsonNode) =
  assert(hasKey(source, "pxOffsetX"),
         "pxOffsetX" & " is missing while decoding " & "LdtkLayerDef")
  target.pxOffsetX = jsonTo(source{"pxOffsetX"}, typeof(target.pxOffsetX))
  assert(hasKey(source, "tilePivotX"),
         "tilePivotX" & " is missing while decoding " & "LdtkLayerDef")
  target.tilePivotX = jsonTo(source{"tilePivotX"}, typeof(target.tilePivotX))
  assert(hasKey(source, "uiFilterTags"),
         "uiFilterTags" & " is missing while decoding " & "LdtkLayerDef")
  target.uiFilterTags = jsonTo(source{"uiFilterTags"},
                               typeof(target.uiFilterTags))
  assert(hasKey(source, "displayOpacity"),
         "displayOpacity" & " is missing while decoding " & "LdtkLayerDef")
  target.displayOpacity = jsonTo(source{"displayOpacity"},
                                 typeof(target.displayOpacity))
  assert(hasKey(source, "parallaxFactorY"),
         "parallaxFactorY" & " is missing while decoding " & "LdtkLayerDef")
  target.parallaxFactorY = jsonTo(source{"parallaxFactorY"},
                                  typeof(target.parallaxFactorY))
  assert(hasKey(source, "hideInList"),
         "hideInList" & " is missing while decoding " & "LdtkLayerDef")
  target.hideInList = jsonTo(source{"hideInList"}, typeof(target.hideInList))
  assert(hasKey(source, "__type"),
         "__type" & " is missing while decoding " & "LdtkLayerDef")
  target.`type` = jsonTo(source{"__type"}, typeof(target.`type`))
  assert(hasKey(source, "guideGridHei"),
         "guideGridHei" & " is missing while decoding " & "LdtkLayerDef")
  target.guideGridHei = jsonTo(source{"guideGridHei"},
                               typeof(target.guideGridHei))
  if hasKey(source, "uiColor") and source{"uiColor"}.kind != JNull:
    target.uiColor = some(jsonTo(source{"uiColor"},
                                 typeof(unsafeGet(target.uiColor))))
  if hasKey(source, "doc") and source{"doc"}.kind != JNull:
    target.doc = some(jsonTo(source{"doc"}, typeof(unsafeGet(target.doc))))
  if hasKey(source, "tilesetDefUid") and
      source{"tilesetDefUid"}.kind != JNull:
    target.tilesetDefUid = some(jsonTo(source{"tilesetDefUid"},
                                       typeof(unsafeGet(target.tilesetDefUid))))
  assert(hasKey(source, "canSelectWhenInactive"), "canSelectWhenInactive" &
      " is missing while decoding " &
      "LdtkLayerDef")
  target.canSelectWhenInactive = jsonTo(source{"canSelectWhenInactive"},
                                        typeof(target.canSelectWhenInactive))
  assert(hasKey(source, "useAsyncRender"),
         "useAsyncRender" & " is missing while decoding " & "LdtkLayerDef")
  target.useAsyncRender = jsonTo(source{"useAsyncRender"},
                                 typeof(target.useAsyncRender))
  if hasKey(source, "autoSourceLayerDefUid") and
      source{"autoSourceLayerDefUid"}.kind != JNull:
    target.autoSourceLayerDefUid = some(jsonTo(
        source{"autoSourceLayerDefUid"},
        typeof(unsafeGet(target.autoSourceLayerDefUid))))
  if hasKey(source, "autoTilesetDefUid") and
      source{"autoTilesetDefUid"}.kind != JNull:
    target.autoTilesetDefUid = some(jsonTo(source{"autoTilesetDefUid"},
        typeof(unsafeGet(target.autoTilesetDefUid))))
  assert(hasKey(source, "parallaxScaling"),
         "parallaxScaling" & " is missing while decoding " & "LdtkLayerDef")
  target.parallaxScaling = jsonTo(source{"parallaxScaling"},
                                  typeof(target.parallaxScaling))
  assert(hasKey(source, "renderInWorldView"),
         "renderInWorldView" & " is missing while decoding " & "LdtkLayerDef")
  target.renderInWorldView = jsonTo(source{"renderInWorldView"},
                                    typeof(target.renderInWorldView))
  assert(hasKey(source, "intGridValuesGroups"),
         "intGridValuesGroups" & " is missing while decoding " & "LdtkLayerDef")
  target.intGridValuesGroups = jsonTo(source{"intGridValuesGroups"},
                                      typeof(target.intGridValuesGroups))
  assert(hasKey(source, "inactiveOpacity"),
         "inactiveOpacity" & " is missing while decoding " & "LdtkLayerDef")
  target.inactiveOpacity = jsonTo(source{"inactiveOpacity"},
                                  typeof(target.inactiveOpacity))
  assert(hasKey(source, "uid"),
         "uid" & " is missing while decoding " & "LdtkLayerDef")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  assert(hasKey(source, "excludedTags"),
         "excludedTags" & " is missing while decoding " & "LdtkLayerDef")
  target.excludedTags = jsonTo(source{"excludedTags"},
                               typeof(target.excludedTags))
  assert(hasKey(source, "hideFieldsWhenInactive"), "hideFieldsWhenInactive" &
      " is missing while decoding " &
      "LdtkLayerDef")
  target.hideFieldsWhenInactive = jsonTo(source{"hideFieldsWhenInactive"},
      typeof(target.hideFieldsWhenInactive))
  assert(hasKey(source, "intGridValues"),
         "intGridValues" & " is missing while decoding " & "LdtkLayerDef")
  target.intGridValues = jsonTo(source{"intGridValues"},
                                typeof(target.intGridValues))
  assert(hasKey(source, "autoRuleGroups"),
         "autoRuleGroups" & " is missing while decoding " & "LdtkLayerDef")
  target.autoRuleGroups = jsonTo(source{"autoRuleGroups"},
                                 typeof(target.autoRuleGroups))
  assert(hasKey(source, "type"),
         "type" & " is missing while decoding " & "LdtkLayerDef")
  target.type1 = jsonTo(source{"type"}, typeof(target.type1))
  assert(hasKey(source, "identifier"),
         "identifier" & " is missing while decoding " & "LdtkLayerDef")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  assert(hasKey(source, "guideGridWid"),
         "guideGridWid" & " is missing while decoding " & "LdtkLayerDef")
  target.guideGridWid = jsonTo(source{"guideGridWid"},
                               typeof(target.guideGridWid))
  assert(hasKey(source, "requiredTags"),
         "requiredTags" & " is missing while decoding " & "LdtkLayerDef")
  target.requiredTags = jsonTo(source{"requiredTags"},
                               typeof(target.requiredTags))
  assert(hasKey(source, "pxOffsetY"),
         "pxOffsetY" & " is missing while decoding " & "LdtkLayerDef")
  target.pxOffsetY = jsonTo(source{"pxOffsetY"}, typeof(target.pxOffsetY))
  assert(hasKey(source, "tilePivotY"),
         "tilePivotY" & " is missing while decoding " & "LdtkLayerDef")
  target.tilePivotY = jsonTo(source{"tilePivotY"}, typeof(target.tilePivotY))
  if hasKey(source, "biomeFieldUid") and
      source{"biomeFieldUid"}.kind != JNull:
    target.biomeFieldUid = some(jsonTo(source{"biomeFieldUid"},
                                       typeof(unsafeGet(target.biomeFieldUid))))
  assert(hasKey(source, "gridSize"),
         "gridSize" & " is missing while decoding " & "LdtkLayerDef")
  target.gridSize = jsonTo(source{"gridSize"}, typeof(target.gridSize))
  assert(hasKey(source, "parallaxFactorX"),
         "parallaxFactorX" & " is missing while decoding " & "LdtkLayerDef")
  target.parallaxFactorX = jsonTo(source{"parallaxFactorX"},
                                  typeof(target.parallaxFactorX))
  if hasKey(source, "autoTilesKilledByOtherLayerUid") and
      source{"autoTilesKilledByOtherLayerUid"}.kind != JNull:
    target.autoTilesKilledByOtherLayerUid = some(jsonTo(
        source{"autoTilesKilledByOtherLayerUid"},
        typeof(unsafeGet(target.autoTilesKilledByOtherLayerUid))))

proc toJsonHook*(source: LdtkLayerDef): JsonNode =
  result = newJObject()
  result{"pxOffsetX"} = newJInt(source.pxOffsetX)
  result{"tilePivotX"} = newJFloat(source.tilePivotX)
  result{"uiFilterTags"} = block:
    var output = newJArray()
    for entry in source.uiFilterTags:
      output.add(newJString(entry))
    output
  result{"displayOpacity"} = newJFloat(source.displayOpacity)
  result{"parallaxFactorY"} = newJFloat(source.parallaxFactorY)
  result{"hideInList"} = newJBool(source.hideInList)
  result{"__type"} = newJString(source.`type`)
  result{"guideGridHei"} = newJInt(source.guideGridHei)
  if isSome(source.uiColor):
    result{"uiColor"} = newJString(unsafeGet(source.uiColor))
  if isSome(source.doc):
    result{"doc"} = newJString(unsafeGet(source.doc))
  if isSome(source.tilesetDefUid):
    result{"tilesetDefUid"} = newJInt(unsafeGet(source.tilesetDefUid))
  result{"canSelectWhenInactive"} = newJBool(source.canSelectWhenInactive)
  result{"useAsyncRender"} = newJBool(source.useAsyncRender)
  if isSome(source.autoSourceLayerDefUid):
    result{"autoSourceLayerDefUid"} = newJInt(
        unsafeGet(source.autoSourceLayerDefUid))
  if isSome(source.autoTilesetDefUid):
    result{"autoTilesetDefUid"} = newJInt(unsafeGet(source.autoTilesetDefUid))
  result{"parallaxScaling"} = newJBool(source.parallaxScaling)
  result{"renderInWorldView"} = newJBool(source.renderInWorldView)
  result{"intGridValuesGroups"} = block:
    var output = newJArray()
    for entry in source.intGridValuesGroups:
      output.add(toJsonHook(entry))
    output
  result{"inactiveOpacity"} = newJFloat(source.inactiveOpacity)
  result{"uid"} = newJInt(source.uid)
  result{"excludedTags"} = block:
    var output = newJArray()
    for entry in source.excludedTags:
      output.add(newJString(entry))
    output
  result{"hideFieldsWhenInactive"} = newJBool(source.hideFieldsWhenInactive)
  result{"intGridValues"} = block:
    var output = newJArray()
    for entry in source.intGridValues:
      output.add(toJsonHook(entry))
    output
  result{"autoRuleGroups"} = block:
    var output = newJArray()
    for entry in source.autoRuleGroups:
      output.add(toJsonHook(entry))
    output
  result{"type"} = toJsonHook(source.type1)
  result{"identifier"} = newJString(source.identifier)
  result{"guideGridWid"} = newJInt(source.guideGridWid)
  result{"requiredTags"} = block:
    var output = newJArray()
    for entry in source.requiredTags:
      output.add(newJString(entry))
    output
  result{"pxOffsetY"} = newJInt(source.pxOffsetY)
  result{"tilePivotY"} = newJFloat(source.tilePivotY)
  if isSome(source.biomeFieldUid):
    result{"biomeFieldUid"} = newJInt(unsafeGet(source.biomeFieldUid))
  result{"gridSize"} = newJInt(source.gridSize)
  result{"parallaxFactorX"} = newJFloat(source.parallaxFactorX)
  if isSome(source.autoTilesKilledByOtherLayerUid):
    result{"autoTilesKilledByOtherLayerUid"} = newJInt(
        unsafeGet(source.autoTilesKilledByOtherLayerUid))

proc toJsonHook*(source: LdtkAllowedRefs): JsonNode =
  case source
  of LdtkAllowedRefs.Any:
    return newJString("Any")
  of LdtkAllowedRefs.OnlySame:
    return newJString("OnlySame")
  of LdtkAllowedRefs.OnlyTags:
    return newJString("OnlyTags")
  of LdtkAllowedRefs.OnlySpecificEntity:
    return newJString("OnlySpecificEntity")
  
proc fromJsonHook*(target: var LdtkAllowedRefs; source: JsonNode) =
  target = case getStr(source)
  of "Any":
    LdtkAllowedRefs.Any
  of "OnlySame":
    LdtkAllowedRefs.OnlySame
  of "OnlyTags":
    LdtkAllowedRefs.OnlyTags
  of "OnlySpecificEntity":
    LdtkAllowedRefs.OnlySpecificEntity
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc toJsonHook*(source: LdtkEditorDisplayMode): JsonNode =
  case source
  of LdtkEditorDisplayMode.Hidden:
    return newJString("Hidden")
  of LdtkEditorDisplayMode.ValueOnly:
    return newJString("ValueOnly")
  of LdtkEditorDisplayMode.NameAndValue:
    return newJString("NameAndValue")
  of LdtkEditorDisplayMode.EntityTile:
    return newJString("EntityTile")
  of LdtkEditorDisplayMode.LevelTile:
    return newJString("LevelTile")
  of LdtkEditorDisplayMode.Points:
    return newJString("Points")
  of LdtkEditorDisplayMode.PointStar:
    return newJString("PointStar")
  of LdtkEditorDisplayMode.PointPath:
    return newJString("PointPath")
  of LdtkEditorDisplayMode.PointPathLoop:
    return newJString("PointPathLoop")
  of LdtkEditorDisplayMode.RadiusPx:
    return newJString("RadiusPx")
  of LdtkEditorDisplayMode.RadiusGrid:
    return newJString("RadiusGrid")
  of LdtkEditorDisplayMode.ArrayCountWithLabel:
    return newJString("ArrayCountWithLabel")
  of LdtkEditorDisplayMode.ArrayCountNoLabel:
    return newJString("ArrayCountNoLabel")
  of LdtkEditorDisplayMode.RefLinkBetweenPivots:
    return newJString("RefLinkBetweenPivots")
  of LdtkEditorDisplayMode.RefLinkBetweenCenters:
    return newJString("RefLinkBetweenCenters")
  
proc fromJsonHook*(target: var LdtkEditorDisplayMode; source: JsonNode) =
  target = case getStr(source)
  of "Hidden":
    LdtkEditorDisplayMode.Hidden
  of "ValueOnly":
    LdtkEditorDisplayMode.ValueOnly
  of "NameAndValue":
    LdtkEditorDisplayMode.NameAndValue
  of "EntityTile":
    LdtkEditorDisplayMode.EntityTile
  of "LevelTile":
    LdtkEditorDisplayMode.LevelTile
  of "Points":
    LdtkEditorDisplayMode.Points
  of "PointStar":
    LdtkEditorDisplayMode.PointStar
  of "PointPath":
    LdtkEditorDisplayMode.PointPath
  of "PointPathLoop":
    LdtkEditorDisplayMode.PointPathLoop
  of "RadiusPx":
    LdtkEditorDisplayMode.RadiusPx
  of "RadiusGrid":
    LdtkEditorDisplayMode.RadiusGrid
  of "ArrayCountWithLabel":
    LdtkEditorDisplayMode.ArrayCountWithLabel
  of "ArrayCountNoLabel":
    LdtkEditorDisplayMode.ArrayCountNoLabel
  of "RefLinkBetweenPivots":
    LdtkEditorDisplayMode.RefLinkBetweenPivots
  of "RefLinkBetweenCenters":
    LdtkEditorDisplayMode.RefLinkBetweenCenters
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc toJsonHook*(source: LdtkEditorDisplayPos): JsonNode =
  case source
  of LdtkEditorDisplayPos.Above:
    return newJString("Above")
  of LdtkEditorDisplayPos.Center:
    return newJString("Center")
  of LdtkEditorDisplayPos.Beneath:
    return newJString("Beneath")
  
proc fromJsonHook*(target: var LdtkEditorDisplayPos; source: JsonNode) =
  target = case getStr(source)
  of "Above":
    LdtkEditorDisplayPos.Above
  of "Center":
    LdtkEditorDisplayPos.Center
  of "Beneath":
    LdtkEditorDisplayPos.Beneath
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc toJsonHook*(source: LdtkTextLanguageMode): JsonNode =
  case source
  of LdtkTextLanguageMode.LangPython:
    return newJString("LangPython")
  of LdtkTextLanguageMode.LangRuby:
    return newJString("LangRuby")
  of LdtkTextLanguageMode.LangJS:
    return newJString("LangJS")
  of LdtkTextLanguageMode.LangLua:
    return newJString("LangLua")
  of LdtkTextLanguageMode.LangC:
    return newJString("LangC")
  of LdtkTextLanguageMode.LangHaxe:
    return newJString("LangHaxe")
  of LdtkTextLanguageMode.LangMarkdown:
    return newJString("LangMarkdown")
  of LdtkTextLanguageMode.LangJson:
    return newJString("LangJson")
  of LdtkTextLanguageMode.LangXml:
    return newJString("LangXml")
  of LdtkTextLanguageMode.LangLog:
    return newJString("LangLog")
  
proc fromJsonHook*(target: var LdtkTextLanguageMode; source: JsonNode) =
  target = case getStr(source)
  of "LangPython":
    LdtkTextLanguageMode.LangPython
  of "LangRuby":
    LdtkTextLanguageMode.LangRuby
  of "LangJS":
    LdtkTextLanguageMode.LangJS
  of "LangLua":
    LdtkTextLanguageMode.LangLua
  of "LangC":
    LdtkTextLanguageMode.LangC
  of "LangHaxe":
    LdtkTextLanguageMode.LangHaxe
  of "LangMarkdown":
    LdtkTextLanguageMode.LangMarkdown
  of "LangJson":
    LdtkTextLanguageMode.LangJson
  of "LangXml":
    LdtkTextLanguageMode.LangXml
  of "LangLog":
    LdtkTextLanguageMode.LangLog
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc toJsonHook*(source: LdtkEditorLinkStyle): JsonNode =
  case source
  of LdtkEditorLinkStyle.ZigZag:
    return newJString("ZigZag")
  of LdtkEditorLinkStyle.StraightArrow:
    return newJString("StraightArrow")
  of LdtkEditorLinkStyle.CurvedArrow:
    return newJString("CurvedArrow")
  of LdtkEditorLinkStyle.ArrowsLine:
    return newJString("ArrowsLine")
  of LdtkEditorLinkStyle.DashedLine:
    return newJString("DashedLine")
  
proc fromJsonHook*(target: var LdtkEditorLinkStyle; source: JsonNode) =
  target = case getStr(source)
  of "ZigZag":
    LdtkEditorLinkStyle.ZigZag
  of "StraightArrow":
    LdtkEditorLinkStyle.StraightArrow
  of "CurvedArrow":
    LdtkEditorLinkStyle.CurvedArrow
  of "ArrowsLine":
    LdtkEditorLinkStyle.ArrowsLine
  of "DashedLine":
    LdtkEditorLinkStyle.DashedLine
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc fromJsonHook*(target: var LdtkFieldDef; source: JsonNode) =
  if hasKey(source, "acceptFileTypes") and
      source{"acceptFileTypes"}.kind != JNull:
    target.acceptFileTypes = some(jsonTo(source{"acceptFileTypes"},
        typeof(unsafeGet(target.acceptFileTypes))))
  assert(hasKey(source, "editorDisplayScale"),
         "editorDisplayScale" & " is missing while decoding " & "LdtkFieldDef")
  target.editorDisplayScale = jsonTo(source{"editorDisplayScale"},
                                     typeof(target.editorDisplayScale))
  assert(hasKey(source, "searchable"),
         "searchable" & " is missing while decoding " & "LdtkFieldDef")
  target.searchable = jsonTo(source{"searchable"}, typeof(target.searchable))
  assert(hasKey(source, "useForSmartColor"),
         "useForSmartColor" & " is missing while decoding " & "LdtkFieldDef")
  target.useForSmartColor = jsonTo(source{"useForSmartColor"},
                                   typeof(target.useForSmartColor))
  assert(hasKey(source, "editorShowInWorld"),
         "editorShowInWorld" & " is missing while decoding " & "LdtkFieldDef")
  target.editorShowInWorld = jsonTo(source{"editorShowInWorld"},
                                    typeof(target.editorShowInWorld))
  assert(hasKey(source, "allowedRefs"),
         "allowedRefs" & " is missing while decoding " & "LdtkFieldDef")
  target.allowedRefs = jsonTo(source{"allowedRefs"}, typeof(target.allowedRefs))
  assert(hasKey(source, "editorAlwaysShow"),
         "editorAlwaysShow" & " is missing while decoding " & "LdtkFieldDef")
  target.editorAlwaysShow = jsonTo(source{"editorAlwaysShow"},
                                   typeof(target.editorAlwaysShow))
  if hasKey(source, "arrayMinLength") and
      source{"arrayMinLength"}.kind != JNull:
    target.arrayMinLength = some(jsonTo(source{"arrayMinLength"}, typeof(
        unsafeGet(target.arrayMinLength))))
  if hasKey(source, "editorTextSuffix") and
      source{"editorTextSuffix"}.kind != JNull:
    target.editorTextSuffix = some(jsonTo(source{"editorTextSuffix"},
        typeof(unsafeGet(target.editorTextSuffix))))
  if hasKey(source, "min") and source{"min"}.kind != JNull:
    target.min = some(jsonTo(source{"min"}, typeof(unsafeGet(target.min))))
  assert(hasKey(source, "__type"),
         "__type" & " is missing while decoding " & "LdtkFieldDef")
  target.`type` = jsonTo(source{"__type"}, typeof(target.`type`))
  assert(hasKey(source, "editorDisplayMode"),
         "editorDisplayMode" & " is missing while decoding " & "LdtkFieldDef")
  target.editorDisplayMode = jsonTo(source{"editorDisplayMode"},
                                    typeof(target.editorDisplayMode))
  if hasKey(source, "editorDisplayColor") and
      source{"editorDisplayColor"}.kind != JNull:
    target.editorDisplayColor = some(jsonTo(source{"editorDisplayColor"},
        typeof(unsafeGet(target.editorDisplayColor))))
  assert(hasKey(source, "canBeNull"),
         "canBeNull" & " is missing while decoding " & "LdtkFieldDef")
  target.canBeNull = jsonTo(source{"canBeNull"}, typeof(target.canBeNull))
  assert(hasKey(source, "autoChainRef"),
         "autoChainRef" & " is missing while decoding " & "LdtkFieldDef")
  target.autoChainRef = jsonTo(source{"autoChainRef"},
                               typeof(target.autoChainRef))
  if hasKey(source, "doc") and source{"doc"}.kind != JNull:
    target.doc = some(jsonTo(source{"doc"}, typeof(unsafeGet(target.doc))))
  if hasKey(source, "allowedRefsEntityUid") and
      source{"allowedRefsEntityUid"}.kind != JNull:
    target.allowedRefsEntityUid = some(jsonTo(
        source{"allowedRefsEntityUid"},
        typeof(unsafeGet(target.allowedRefsEntityUid))))
  if hasKey(source, "tilesetUid") and source{"tilesetUid"}.kind != JNull:
    target.tilesetUid = some(jsonTo(source{"tilesetUid"},
                                    typeof(unsafeGet(target.tilesetUid))))
  assert(hasKey(source, "allowedRefTags"),
         "allowedRefTags" & " is missing while decoding " & "LdtkFieldDef")
  target.allowedRefTags = jsonTo(source{"allowedRefTags"},
                                 typeof(target.allowedRefTags))
  assert(hasKey(source, "symmetricalRef"),
         "symmetricalRef" & " is missing while decoding " & "LdtkFieldDef")
  target.symmetricalRef = jsonTo(source{"symmetricalRef"},
                                 typeof(target.symmetricalRef))
  assert(hasKey(source, "uid"),
         "uid" & " is missing while decoding " & "LdtkFieldDef")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  if hasKey(source, "editorTextPrefix") and
      source{"editorTextPrefix"}.kind != JNull:
    target.editorTextPrefix = some(jsonTo(source{"editorTextPrefix"},
        typeof(unsafeGet(target.editorTextPrefix))))
  assert(hasKey(source, "isArray"),
         "isArray" & " is missing while decoding " & "LdtkFieldDef")
  target.isArray = jsonTo(source{"isArray"}, typeof(target.isArray))
  assert(hasKey(source, "exportToToc"),
         "exportToToc" & " is missing while decoding " & "LdtkFieldDef")
  target.exportToToc = jsonTo(source{"exportToToc"}, typeof(target.exportToToc))
  assert(hasKey(source, "editorDisplayPos"),
         "editorDisplayPos" & " is missing while decoding " & "LdtkFieldDef")
  target.editorDisplayPos = jsonTo(source{"editorDisplayPos"},
                                   typeof(target.editorDisplayPos))
  if hasKey(source, "textLanguageMode") and
      source{"textLanguageMode"}.kind != JNull:
    target.textLanguageMode = some(jsonTo(source{"textLanguageMode"},
        typeof(unsafeGet(target.textLanguageMode))))
  if hasKey(source, "max") and source{"max"}.kind != JNull:
    target.max = some(jsonTo(source{"max"}, typeof(unsafeGet(target.max))))
  assert(hasKey(source, "allowOutOfLevelRef"),
         "allowOutOfLevelRef" & " is missing while decoding " & "LdtkFieldDef")
  target.allowOutOfLevelRef = jsonTo(source{"allowOutOfLevelRef"},
                                     typeof(target.allowOutOfLevelRef))
  assert(hasKey(source, "editorCutLongValues"),
         "editorCutLongValues" & " is missing while decoding " & "LdtkFieldDef")
  target.editorCutLongValues = jsonTo(source{"editorCutLongValues"},
                                      typeof(target.editorCutLongValues))
  if hasKey(source, "defaultOverride") and
      source{"defaultOverride"}.kind != JNull:
    target.defaultOverride = some(jsonTo(source{"defaultOverride"},
        typeof(unsafeGet(target.defaultOverride))))
  assert(hasKey(source, "editorLinkStyle"),
         "editorLinkStyle" & " is missing while decoding " & "LdtkFieldDef")
  target.editorLinkStyle = jsonTo(source{"editorLinkStyle"},
                                  typeof(target.editorLinkStyle))
  if hasKey(source, "regex") and source{"regex"}.kind != JNull:
    target.regex = some(jsonTo(source{"regex"}, typeof(unsafeGet(target.regex))))
  assert(hasKey(source, "type"),
         "type" & " is missing while decoding " & "LdtkFieldDef")
  target.type1 = jsonTo(source{"type"}, typeof(target.type1))
  assert(hasKey(source, "identifier"),
         "identifier" & " is missing while decoding " & "LdtkFieldDef")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  if hasKey(source, "arrayMaxLength") and
      source{"arrayMaxLength"}.kind != JNull:
    target.arrayMaxLength = some(jsonTo(source{"arrayMaxLength"}, typeof(
        unsafeGet(target.arrayMaxLength))))

proc toJsonHook*(source: LdtkFieldDef): JsonNode =
  result = newJObject()
  if isSome(source.acceptFileTypes):
    result{"acceptFileTypes"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.acceptFileTypes):
        output.add(newJString(entry))
      output
  result{"editorDisplayScale"} = newJFloat(source.editorDisplayScale)
  result{"searchable"} = newJBool(source.searchable)
  result{"useForSmartColor"} = newJBool(source.useForSmartColor)
  result{"editorShowInWorld"} = newJBool(source.editorShowInWorld)
  result{"allowedRefs"} = toJsonHook(source.allowedRefs)
  result{"editorAlwaysShow"} = newJBool(source.editorAlwaysShow)
  if isSome(source.arrayMinLength):
    result{"arrayMinLength"} = newJInt(unsafeGet(source.arrayMinLength))
  if isSome(source.editorTextSuffix):
    result{"editorTextSuffix"} = newJString(unsafeGet(source.editorTextSuffix))
  if isSome(source.min):
    result{"min"} = newJFloat(unsafeGet(source.min))
  result{"__type"} = newJString(source.`type`)
  result{"editorDisplayMode"} = toJsonHook(source.editorDisplayMode)
  if isSome(source.editorDisplayColor):
    result{"editorDisplayColor"} = newJString(
        unsafeGet(source.editorDisplayColor))
  result{"canBeNull"} = newJBool(source.canBeNull)
  result{"autoChainRef"} = newJBool(source.autoChainRef)
  if isSome(source.doc):
    result{"doc"} = newJString(unsafeGet(source.doc))
  if isSome(source.allowedRefsEntityUid):
    result{"allowedRefsEntityUid"} = newJInt(
        unsafeGet(source.allowedRefsEntityUid))
  if isSome(source.tilesetUid):
    result{"tilesetUid"} = newJInt(unsafeGet(source.tilesetUid))
  result{"allowedRefTags"} = block:
    var output = newJArray()
    for entry in source.allowedRefTags:
      output.add(newJString(entry))
    output
  result{"symmetricalRef"} = newJBool(source.symmetricalRef)
  result{"uid"} = newJInt(source.uid)
  if isSome(source.editorTextPrefix):
    result{"editorTextPrefix"} = newJString(unsafeGet(source.editorTextPrefix))
  result{"isArray"} = newJBool(source.isArray)
  result{"exportToToc"} = newJBool(source.exportToToc)
  result{"editorDisplayPos"} = toJsonHook(source.editorDisplayPos)
  if isSome(source.textLanguageMode):
    result{"textLanguageMode"} = toJsonHook(unsafeGet(source.textLanguageMode))
  if isSome(source.max):
    result{"max"} = newJFloat(unsafeGet(source.max))
  result{"allowOutOfLevelRef"} = newJBool(source.allowOutOfLevelRef)
  result{"editorCutLongValues"} = newJBool(source.editorCutLongValues)
  if isSome(source.defaultOverride):
    result{"defaultOverride"} = unsafeGet(source.defaultOverride)
  result{"editorLinkStyle"} = toJsonHook(source.editorLinkStyle)
  if isSome(source.regex):
    result{"regex"} = newJString(unsafeGet(source.regex))
  result{"type"} = newJString(source.type1)
  result{"identifier"} = newJString(source.identifier)
  if isSome(source.arrayMaxLength):
    result{"arrayMaxLength"} = newJInt(unsafeGet(source.arrayMaxLength))

proc fromJsonHook*(target: var LdtkEnumDefValues; source: JsonNode) =
  if hasKey(source, "tileId") and source{"tileId"}.kind != JNull:
    target.tileId = some(jsonTo(source{"tileId"},
                                typeof(unsafeGet(target.tileId))))
  assert(hasKey(source, "color"),
         "color" & " is missing while decoding " & "LdtkEnumDefValues")
  target.color = jsonTo(source{"color"}, typeof(target.color))
  if hasKey(source, "tileRect") and source{"tileRect"}.kind != JNull:
    target.tileRect = some(jsonTo(source{"tileRect"},
                                  typeof(unsafeGet(target.tileRect))))
  assert(hasKey(source, "id"),
         "id" & " is missing while decoding " & "LdtkEnumDefValues")
  target.id = jsonTo(source{"id"}, typeof(target.id))
  if hasKey(source, "__tileSrcRect") and
      source{"__tileSrcRect"}.kind != JNull:
    target.tileSrcRect = some(jsonTo(source{"__tileSrcRect"},
                                     typeof(unsafeGet(target.tileSrcRect))))

proc toJsonHook*(source: LdtkEnumDefValues): JsonNode =
  result = newJObject()
  if isSome(source.tileId):
    result{"tileId"} = newJInt(unsafeGet(source.tileId))
  result{"color"} = newJInt(source.color)
  if isSome(source.tileRect):
    result{"tileRect"} = toJsonHook(unsafeGet(source.tileRect))
  result{"id"} = newJString(source.id)
  if isSome(source.tileSrcRect):
    result{"__tileSrcRect"} = block:
      var output = newJArray()
      for entry in unsafeGet(source.tileSrcRect):
        output.add(newJInt(entry))
      output

proc fromJsonHook*(target: var LdtkEnumDef; source: JsonNode) =
  if hasKey(source, "externalFileChecksum") and
      source{"externalFileChecksum"}.kind != JNull:
    target.externalFileChecksum = some(jsonTo(
        source{"externalFileChecksum"},
        typeof(unsafeGet(target.externalFileChecksum))))
  if hasKey(source, "externalRelPath") and
      source{"externalRelPath"}.kind != JNull:
    target.externalRelPath = some(jsonTo(source{"externalRelPath"},
        typeof(unsafeGet(target.externalRelPath))))
  assert(hasKey(source, "uid"),
         "uid" & " is missing while decoding " & "LdtkEnumDef")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  assert(hasKey(source, "values"),
         "values" & " is missing while decoding " & "LdtkEnumDef")
  target.values = jsonTo(source{"values"}, typeof(target.values))
  if hasKey(source, "iconTilesetUid") and
      source{"iconTilesetUid"}.kind != JNull:
    target.iconTilesetUid = some(jsonTo(source{"iconTilesetUid"}, typeof(
        unsafeGet(target.iconTilesetUid))))
  assert(hasKey(source, "identifier"),
         "identifier" & " is missing while decoding " & "LdtkEnumDef")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  assert(hasKey(source, "tags"),
         "tags" & " is missing while decoding " & "LdtkEnumDef")
  target.tags = jsonTo(source{"tags"}, typeof(target.tags))

proc toJsonHook*(source: LdtkEnumDef): JsonNode =
  result = newJObject()
  if isSome(source.externalFileChecksum):
    result{"externalFileChecksum"} = newJString(
        unsafeGet(source.externalFileChecksum))
  if isSome(source.externalRelPath):
    result{"externalRelPath"} = newJString(unsafeGet(source.externalRelPath))
  result{"uid"} = newJInt(source.uid)
  result{"values"} = block:
    var output = newJArray()
    for entry in source.values:
      output.add(toJsonHook(entry))
    output
  if isSome(source.iconTilesetUid):
    result{"iconTilesetUid"} = newJInt(unsafeGet(source.iconTilesetUid))
  result{"identifier"} = newJString(source.identifier)
  result{"tags"} = block:
    var output = newJArray()
    for entry in source.tags:
      output.add(newJString(entry))
    output

proc toJsonHook*(source: LdtkLimitScope): JsonNode =
  case source
  of LdtkLimitScope.PerLayer:
    return newJString("PerLayer")
  of LdtkLimitScope.PerLevel:
    return newJString("PerLevel")
  of LdtkLimitScope.PerWorld:
    return newJString("PerWorld")
  
proc fromJsonHook*(target: var LdtkLimitScope; source: JsonNode) =
  target = case getStr(source)
  of "PerLayer":
    LdtkLimitScope.PerLayer
  of "PerLevel":
    LdtkLimitScope.PerLevel
  of "PerWorld":
    LdtkLimitScope.PerWorld
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc toJsonHook*(source: LdtkTileRenderMode): JsonNode =
  case source
  of LdtkTileRenderMode.Cover:
    return newJString("Cover")
  of LdtkTileRenderMode.FitInside:
    return newJString("FitInside")
  of LdtkTileRenderMode.Repeat:
    return newJString("Repeat")
  of LdtkTileRenderMode.Stretch:
    return newJString("Stretch")
  of LdtkTileRenderMode.FullSizeCropped:
    return newJString("FullSizeCropped")
  of LdtkTileRenderMode.FullSizeUncropped:
    return newJString("FullSizeUncropped")
  of LdtkTileRenderMode.NineSlice:
    return newJString("NineSlice")
  
proc fromJsonHook*(target: var LdtkTileRenderMode; source: JsonNode) =
  target = case getStr(source)
  of "Cover":
    LdtkTileRenderMode.Cover
  of "FitInside":
    LdtkTileRenderMode.FitInside
  of "Repeat":
    LdtkTileRenderMode.Repeat
  of "Stretch":
    LdtkTileRenderMode.Stretch
  of "FullSizeCropped":
    LdtkTileRenderMode.FullSizeCropped
  of "FullSizeUncropped":
    LdtkTileRenderMode.FullSizeUncropped
  of "NineSlice":
    LdtkTileRenderMode.NineSlice
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc toJsonHook*(source: LdtkLimitBehavior): JsonNode =
  case source
  of LdtkLimitBehavior.DiscardOldOnes:
    return newJString("DiscardOldOnes")
  of LdtkLimitBehavior.PreventAdding:
    return newJString("PreventAdding")
  of LdtkLimitBehavior.MoveLastOne:
    return newJString("MoveLastOne")
  
proc fromJsonHook*(target: var LdtkLimitBehavior; source: JsonNode) =
  target = case getStr(source)
  of "DiscardOldOnes":
    LdtkLimitBehavior.DiscardOldOnes
  of "PreventAdding":
    LdtkLimitBehavior.PreventAdding
  of "MoveLastOne":
    LdtkLimitBehavior.MoveLastOne
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc toJsonHook*(source: LdtkRenderMode): JsonNode =
  case source
  of LdtkRenderMode.Rectangle:
    return newJString("Rectangle")
  of LdtkRenderMode.Ellipse:
    return newJString("Ellipse")
  of LdtkRenderMode.Tile:
    return newJString("Tile")
  of LdtkRenderMode.Cross:
    return newJString("Cross")
  
proc fromJsonHook*(target: var LdtkRenderMode; source: JsonNode) =
  target = case getStr(source)
  of "Rectangle":
    LdtkRenderMode.Rectangle
  of "Ellipse":
    LdtkRenderMode.Ellipse
  of "Tile":
    LdtkRenderMode.Tile
  of "Cross":
    LdtkRenderMode.Cross
  else:
    raise newException(ValueError, "Unable to decode enum: " & $source)
  
proc fromJsonHook*(target: var LdtkEntityDef; source: JsonNode) =
  if hasKey(source, "tileId") and source{"tileId"}.kind != JNull:
    target.tileId = some(jsonTo(source{"tileId"},
                                typeof(unsafeGet(target.tileId))))
  assert(hasKey(source, "showName"),
         "showName" & " is missing while decoding " & "LdtkEntityDef")
  target.showName = jsonTo(source{"showName"}, typeof(target.showName))
  if hasKey(source, "tilesetId") and source{"tilesetId"}.kind != JNull:
    target.tilesetId = some(jsonTo(source{"tilesetId"},
                                   typeof(unsafeGet(target.tilesetId))))
  if hasKey(source, "maxHeight") and source{"maxHeight"}.kind != JNull:
    target.maxHeight = some(jsonTo(source{"maxHeight"},
                                   typeof(unsafeGet(target.maxHeight))))
  assert(hasKey(source, "limitScope"),
         "limitScope" & " is missing while decoding " & "LdtkEntityDef")
  target.limitScope = jsonTo(source{"limitScope"}, typeof(target.limitScope))
  assert(hasKey(source, "pivotX"),
         "pivotX" & " is missing while decoding " & "LdtkEntityDef")
  target.pivotX = jsonTo(source{"pivotX"}, typeof(target.pivotX))
  assert(hasKey(source, "maxCount"),
         "maxCount" & " is missing while decoding " & "LdtkEntityDef")
  target.maxCount = jsonTo(source{"maxCount"}, typeof(target.maxCount))
  assert(hasKey(source, "allowOutOfBounds"),
         "allowOutOfBounds" & " is missing while decoding " & "LdtkEntityDef")
  target.allowOutOfBounds = jsonTo(source{"allowOutOfBounds"},
                                   typeof(target.allowOutOfBounds))
  assert(hasKey(source, "hollow"),
         "hollow" & " is missing while decoding " & "LdtkEntityDef")
  target.hollow = jsonTo(source{"hollow"}, typeof(target.hollow))
  if hasKey(source, "minHeight") and source{"minHeight"}.kind != JNull:
    target.minHeight = some(jsonTo(source{"minHeight"},
                                   typeof(unsafeGet(target.minHeight))))
  assert(hasKey(source, "keepAspectRatio"),
         "keepAspectRatio" & " is missing while decoding " & "LdtkEntityDef")
  target.keepAspectRatio = jsonTo(source{"keepAspectRatio"},
                                  typeof(target.keepAspectRatio))
  assert(hasKey(source, "color"),
         "color" & " is missing while decoding " & "LdtkEntityDef")
  target.color = jsonTo(source{"color"}, typeof(target.color))
  if hasKey(source, "minWidth") and source{"minWidth"}.kind != JNull:
    target.minWidth = some(jsonTo(source{"minWidth"},
                                  typeof(unsafeGet(target.minWidth))))
  if hasKey(source, "tileRect") and source{"tileRect"}.kind != JNull:
    target.tileRect = some(jsonTo(source{"tileRect"},
                                  typeof(unsafeGet(target.tileRect))))
  if hasKey(source, "doc") and source{"doc"}.kind != JNull:
    target.doc = some(jsonTo(source{"doc"}, typeof(unsafeGet(target.doc))))
  assert(hasKey(source, "fieldDefs"),
         "fieldDefs" & " is missing while decoding " & "LdtkEntityDef")
  target.fieldDefs = jsonTo(source{"fieldDefs"}, typeof(target.fieldDefs))
  assert(hasKey(source, "tileRenderMode"),
         "tileRenderMode" & " is missing while decoding " & "LdtkEntityDef")
  target.tileRenderMode = jsonTo(source{"tileRenderMode"},
                                 typeof(target.tileRenderMode))
  assert(hasKey(source, "limitBehavior"),
         "limitBehavior" & " is missing while decoding " & "LdtkEntityDef")
  target.limitBehavior = jsonTo(source{"limitBehavior"},
                                typeof(target.limitBehavior))
  assert(hasKey(source, "tileOpacity"),
         "tileOpacity" & " is missing while decoding " & "LdtkEntityDef")
  target.tileOpacity = jsonTo(source{"tileOpacity"}, typeof(target.tileOpacity))
  assert(hasKey(source, "nineSliceBorders"),
         "nineSliceBorders" & " is missing while decoding " & "LdtkEntityDef")
  target.nineSliceBorders = jsonTo(source{"nineSliceBorders"},
                                   typeof(target.nineSliceBorders))
  assert(hasKey(source, "resizableX"),
         "resizableX" & " is missing while decoding " & "LdtkEntityDef")
  target.resizableX = jsonTo(source{"resizableX"}, typeof(target.resizableX))
  if hasKey(source, "uiTileRect") and source{"uiTileRect"}.kind != JNull:
    target.uiTileRect = some(jsonTo(source{"uiTileRect"},
                                    typeof(unsafeGet(target.uiTileRect))))
  assert(hasKey(source, "uid"),
         "uid" & " is missing while decoding " & "LdtkEntityDef")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  assert(hasKey(source, "lineOpacity"),
         "lineOpacity" & " is missing while decoding " & "LdtkEntityDef")
  target.lineOpacity = jsonTo(source{"lineOpacity"}, typeof(target.lineOpacity))
  if hasKey(source, "maxWidth") and source{"maxWidth"}.kind != JNull:
    target.maxWidth = some(jsonTo(source{"maxWidth"},
                                  typeof(unsafeGet(target.maxWidth))))
  assert(hasKey(source, "resizableY"),
         "resizableY" & " is missing while decoding " & "LdtkEntityDef")
  target.resizableY = jsonTo(source{"resizableY"}, typeof(target.resizableY))
  assert(hasKey(source, "exportToToc"),
         "exportToToc" & " is missing while decoding " & "LdtkEntityDef")
  target.exportToToc = jsonTo(source{"exportToToc"}, typeof(target.exportToToc))
  assert(hasKey(source, "fillOpacity"),
         "fillOpacity" & " is missing while decoding " & "LdtkEntityDef")
  target.fillOpacity = jsonTo(source{"fillOpacity"}, typeof(target.fillOpacity))
  assert(hasKey(source, "height"),
         "height" & " is missing while decoding " & "LdtkEntityDef")
  target.height = jsonTo(source{"height"}, typeof(target.height))
  assert(hasKey(source, "identifier"),
         "identifier" & " is missing while decoding " & "LdtkEntityDef")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  assert(hasKey(source, "pivotY"),
         "pivotY" & " is missing while decoding " & "LdtkEntityDef")
  target.pivotY = jsonTo(source{"pivotY"}, typeof(target.pivotY))
  assert(hasKey(source, "renderMode"),
         "renderMode" & " is missing while decoding " & "LdtkEntityDef")
  target.renderMode = jsonTo(source{"renderMode"}, typeof(target.renderMode))
  assert(hasKey(source, "tags"),
         "tags" & " is missing while decoding " & "LdtkEntityDef")
  target.tags = jsonTo(source{"tags"}, typeof(target.tags))
  assert(hasKey(source, "width"),
         "width" & " is missing while decoding " & "LdtkEntityDef")
  target.width = jsonTo(source{"width"}, typeof(target.width))

proc toJsonHook*(source: LdtkEntityDef): JsonNode =
  result = newJObject()
  if isSome(source.tileId):
    result{"tileId"} = newJInt(unsafeGet(source.tileId))
  result{"showName"} = newJBool(source.showName)
  if isSome(source.tilesetId):
    result{"tilesetId"} = newJInt(unsafeGet(source.tilesetId))
  if isSome(source.maxHeight):
    result{"maxHeight"} = newJInt(unsafeGet(source.maxHeight))
  result{"limitScope"} = toJsonHook(source.limitScope)
  result{"pivotX"} = newJFloat(source.pivotX)
  result{"maxCount"} = newJInt(source.maxCount)
  result{"allowOutOfBounds"} = newJBool(source.allowOutOfBounds)
  result{"hollow"} = newJBool(source.hollow)
  if isSome(source.minHeight):
    result{"minHeight"} = newJInt(unsafeGet(source.minHeight))
  result{"keepAspectRatio"} = newJBool(source.keepAspectRatio)
  result{"color"} = newJString(source.color)
  if isSome(source.minWidth):
    result{"minWidth"} = newJInt(unsafeGet(source.minWidth))
  if isSome(source.tileRect):
    result{"tileRect"} = toJsonHook(unsafeGet(source.tileRect))
  if isSome(source.doc):
    result{"doc"} = newJString(unsafeGet(source.doc))
  result{"fieldDefs"} = block:
    var output = newJArray()
    for entry in source.fieldDefs:
      output.add(toJsonHook(entry))
    output
  result{"tileRenderMode"} = toJsonHook(source.tileRenderMode)
  result{"limitBehavior"} = toJsonHook(source.limitBehavior)
  result{"tileOpacity"} = newJFloat(source.tileOpacity)
  result{"nineSliceBorders"} = block:
    var output = newJArray()
    for entry in source.nineSliceBorders:
      output.add(newJInt(entry))
    output
  result{"resizableX"} = newJBool(source.resizableX)
  if isSome(source.uiTileRect):
    result{"uiTileRect"} = toJsonHook(unsafeGet(source.uiTileRect))
  result{"uid"} = newJInt(source.uid)
  result{"lineOpacity"} = newJFloat(source.lineOpacity)
  if isSome(source.maxWidth):
    result{"maxWidth"} = newJInt(unsafeGet(source.maxWidth))
  result{"resizableY"} = newJBool(source.resizableY)
  result{"exportToToc"} = newJBool(source.exportToToc)
  result{"fillOpacity"} = newJFloat(source.fillOpacity)
  result{"height"} = newJInt(source.height)
  result{"identifier"} = newJString(source.identifier)
  result{"pivotY"} = newJFloat(source.pivotY)
  result{"renderMode"} = toJsonHook(source.renderMode)
  result{"tags"} = block:
    var output = newJArray()
    for entry in source.tags:
      output.add(newJString(entry))
    output
  result{"width"} = newJInt(source.width)

proc fromJsonHook*(target: var LdtkDefinitions; source: JsonNode) =
  assert(hasKey(source, "tilesets"),
         "tilesets" & " is missing while decoding " & "LdtkDefinitions")
  target.tilesets = jsonTo(source{"tilesets"}, typeof(target.tilesets))
  assert(hasKey(source, "layers"),
         "layers" & " is missing while decoding " & "LdtkDefinitions")
  target.layers = jsonTo(source{"layers"}, typeof(target.layers))
  assert(hasKey(source, "levelFields"),
         "levelFields" & " is missing while decoding " & "LdtkDefinitions")
  target.levelFields = jsonTo(source{"levelFields"}, typeof(target.levelFields))
  assert(hasKey(source, "enums"),
         "enums" & " is missing while decoding " & "LdtkDefinitions")
  target.enums = jsonTo(source{"enums"}, typeof(target.enums))
  assert(hasKey(source, "entities"),
         "entities" & " is missing while decoding " & "LdtkDefinitions")
  target.entities = jsonTo(source{"entities"}, typeof(target.entities))
  assert(hasKey(source, "externalEnums"),
         "externalEnums" & " is missing while decoding " & "LdtkDefinitions")
  target.externalEnums = jsonTo(source{"externalEnums"},
                                typeof(target.externalEnums))

proc toJsonHook*(source: LdtkDefinitions): JsonNode =
  result = newJObject()
  result{"tilesets"} = block:
    var output = newJArray()
    for entry in source.tilesets:
      output.add(toJsonHook(entry))
    output
  result{"layers"} = block:
    var output = newJArray()
    for entry in source.layers:
      output.add(toJsonHook(entry))
    output
  result{"levelFields"} = block:
    var output = newJArray()
    for entry in source.levelFields:
      output.add(toJsonHook(entry))
    output
  result{"enums"} = block:
    var output = newJArray()
    for entry in source.enums:
      output.add(toJsonHook(entry))
    output
  result{"entities"} = block:
    var output = newJArray()
    for entry in source.entities:
      output.add(toJsonHook(entry))
    output
  result{"externalEnums"} = block:
    var output = newJArray()
    for entry in source.externalEnums:
      output.add(toJsonHook(entry))
    output

proc fromJsonHook*(target: var LdtkGridPoint; source: JsonNode) =
  assert(hasKey(source, "cy"),
         "cy" & " is missing while decoding " & "LdtkGridPoint")
  target.cy = jsonTo(source{"cy"}, typeof(target.cy))
  assert(hasKey(source, "cx"),
         "cx" & " is missing while decoding " & "LdtkGridPoint")
  target.cx = jsonTo(source{"cx"}, typeof(target.cx))

proc toJsonHook*(source: LdtkGridPoint): JsonNode =
  result = newJObject()
  result{"cy"} = newJInt(source.cy)
  result{"cx"} = newJInt(source.cx)

proc fromJsonHook*(target: var Ldtk_FORCED_REFS; source: JsonNode) =
  if hasKey(source, "TilesetRect") and source{"TilesetRect"}.kind != JNull:
    target.TilesetRect = some(jsonTo(source{"TilesetRect"},
                                     typeof(unsafeGet(target.TilesetRect))))
  if hasKey(source, "FieldInstance") and
      source{"FieldInstance"}.kind != JNull:
    target.FieldInstance = some(jsonTo(source{"FieldInstance"},
                                       typeof(unsafeGet(target.FieldInstance))))
  if hasKey(source, "EntityInstance") and
      source{"EntityInstance"}.kind != JNull:
    target.EntityInstance = some(jsonTo(source{"EntityInstance"}, typeof(
        unsafeGet(target.EntityInstance))))
  if hasKey(source, "Definitions") and source{"Definitions"}.kind != JNull:
    target.Definitions = some(jsonTo(source{"Definitions"},
                                     typeof(unsafeGet(target.Definitions))))
  if hasKey(source, "EnumTagValue") and source{"EnumTagValue"}.kind != JNull:
    target.EnumTagValue = some(jsonTo(source{"EnumTagValue"},
                                      typeof(unsafeGet(target.EnumTagValue))))
  if hasKey(source, "AutoRuleDef") and source{"AutoRuleDef"}.kind != JNull:
    target.AutoRuleDef = some(jsonTo(source{"AutoRuleDef"},
                                     typeof(unsafeGet(target.AutoRuleDef))))
  if hasKey(source, "FieldDef") and source{"FieldDef"}.kind != JNull:
    target.FieldDef = some(jsonTo(source{"FieldDef"},
                                  typeof(unsafeGet(target.FieldDef))))
  if hasKey(source, "CustomCommand") and
      source{"CustomCommand"}.kind != JNull:
    target.CustomCommand = some(jsonTo(source{"CustomCommand"},
                                       typeof(unsafeGet(target.CustomCommand))))
  if hasKey(source, "EntityDef") and source{"EntityDef"}.kind != JNull:
    target.EntityDef = some(jsonTo(source{"EntityDef"},
                                   typeof(unsafeGet(target.EntityDef))))
  if hasKey(source, "AutoLayerRuleGroup") and
      source{"AutoLayerRuleGroup"}.kind != JNull:
    target.AutoLayerRuleGroup = some(jsonTo(source{"AutoLayerRuleGroup"},
        typeof(unsafeGet(target.AutoLayerRuleGroup))))
  if hasKey(source, "IntGridValueGroupDef") and
      source{"IntGridValueGroupDef"}.kind != JNull:
    target.IntGridValueGroupDef = some(jsonTo(
        source{"IntGridValueGroupDef"},
        typeof(unsafeGet(target.IntGridValueGroupDef))))
  if hasKey(source, "IntGridValueInstance") and
      source{"IntGridValueInstance"}.kind != JNull:
    target.IntGridValueInstance = some(jsonTo(
        source{"IntGridValueInstance"},
        typeof(unsafeGet(target.IntGridValueInstance))))
  if hasKey(source, "TocInstanceData") and
      source{"TocInstanceData"}.kind != JNull:
    target.TocInstanceData = some(jsonTo(source{"TocInstanceData"},
        typeof(unsafeGet(target.TocInstanceData))))
  if hasKey(source, "NeighbourLevel") and
      source{"NeighbourLevel"}.kind != JNull:
    target.NeighbourLevel = some(jsonTo(source{"NeighbourLevel"}, typeof(
        unsafeGet(target.NeighbourLevel))))
  if hasKey(source, "LayerInstance") and
      source{"LayerInstance"}.kind != JNull:
    target.LayerInstance = some(jsonTo(source{"LayerInstance"},
                                       typeof(unsafeGet(target.LayerInstance))))
  if hasKey(source, "World") and source{"World"}.kind != JNull:
    target.World = some(jsonTo(source{"World"}, typeof(unsafeGet(target.World))))
  if hasKey(source, "EntityReferenceInfos") and
      source{"EntityReferenceInfos"}.kind != JNull:
    target.EntityReferenceInfos = some(jsonTo(
        source{"EntityReferenceInfos"},
        typeof(unsafeGet(target.EntityReferenceInfos))))
  if hasKey(source, "TileCustomMetadata") and
      source{"TileCustomMetadata"}.kind != JNull:
    target.TileCustomMetadata = some(jsonTo(source{"TileCustomMetadata"},
        typeof(unsafeGet(target.TileCustomMetadata))))
  if hasKey(source, "TilesetDef") and source{"TilesetDef"}.kind != JNull:
    target.TilesetDef = some(jsonTo(source{"TilesetDef"},
                                    typeof(unsafeGet(target.TilesetDef))))
  if hasKey(source, "EnumDefValues") and
      source{"EnumDefValues"}.kind != JNull:
    target.EnumDefValues = some(jsonTo(source{"EnumDefValues"},
                                       typeof(unsafeGet(target.EnumDefValues))))
  if hasKey(source, "Tile") and source{"Tile"}.kind != JNull:
    target.Tile = some(jsonTo(source{"Tile"}, typeof(unsafeGet(target.Tile))))
  if hasKey(source, "LayerDef") and source{"LayerDef"}.kind != JNull:
    target.LayerDef = some(jsonTo(source{"LayerDef"},
                                  typeof(unsafeGet(target.LayerDef))))
  if hasKey(source, "LevelBgPosInfos") and
      source{"LevelBgPosInfos"}.kind != JNull:
    target.LevelBgPosInfos = some(jsonTo(source{"LevelBgPosInfos"},
        typeof(unsafeGet(target.LevelBgPosInfos))))
  if hasKey(source, "Level") and source{"Level"}.kind != JNull:
    target.Level = some(jsonTo(source{"Level"}, typeof(unsafeGet(target.Level))))
  if hasKey(source, "TableOfContentEntry") and
      source{"TableOfContentEntry"}.kind != JNull:
    target.TableOfContentEntry = some(jsonTo(source{"TableOfContentEntry"},
        typeof(unsafeGet(target.TableOfContentEntry))))
  if hasKey(source, "EnumDef") and source{"EnumDef"}.kind != JNull:
    target.EnumDef = some(jsonTo(source{"EnumDef"},
                                 typeof(unsafeGet(target.EnumDef))))
  if hasKey(source, "GridPoint") and source{"GridPoint"}.kind != JNull:
    target.GridPoint = some(jsonTo(source{"GridPoint"},
                                   typeof(unsafeGet(target.GridPoint))))
  if hasKey(source, "IntGridValueDef") and
      source{"IntGridValueDef"}.kind != JNull:
    target.IntGridValueDef = some(jsonTo(source{"IntGridValueDef"},
        typeof(unsafeGet(target.IntGridValueDef))))

proc toJsonHook*(source: Ldtk_FORCED_REFS): JsonNode =
  result = newJObject()
  if isSome(source.TilesetRect):
    result{"TilesetRect"} = toJsonHook(unsafeGet(source.TilesetRect))
  if isSome(source.FieldInstance):
    result{"FieldInstance"} = toJsonHook(unsafeGet(source.FieldInstance))
  if isSome(source.EntityInstance):
    result{"EntityInstance"} = toJsonHook(unsafeGet(source.EntityInstance))
  if isSome(source.Definitions):
    result{"Definitions"} = toJsonHook(unsafeGet(source.Definitions))
  if isSome(source.EnumTagValue):
    result{"EnumTagValue"} = toJsonHook(unsafeGet(source.EnumTagValue))
  if isSome(source.AutoRuleDef):
    result{"AutoRuleDef"} = toJsonHook(unsafeGet(source.AutoRuleDef))
  if isSome(source.FieldDef):
    result{"FieldDef"} = toJsonHook(unsafeGet(source.FieldDef))
  if isSome(source.CustomCommand):
    result{"CustomCommand"} = toJsonHook(unsafeGet(source.CustomCommand))
  if isSome(source.EntityDef):
    result{"EntityDef"} = toJsonHook(unsafeGet(source.EntityDef))
  if isSome(source.AutoLayerRuleGroup):
    result{"AutoLayerRuleGroup"} = toJsonHook(
        unsafeGet(source.AutoLayerRuleGroup))
  if isSome(source.IntGridValueGroupDef):
    result{"IntGridValueGroupDef"} = toJsonHook(
        unsafeGet(source.IntGridValueGroupDef))
  if isSome(source.IntGridValueInstance):
    result{"IntGridValueInstance"} = toJsonHook(
        unsafeGet(source.IntGridValueInstance))
  if isSome(source.TocInstanceData):
    result{"TocInstanceData"} = toJsonHook(unsafeGet(source.TocInstanceData))
  if isSome(source.NeighbourLevel):
    result{"NeighbourLevel"} = toJsonHook(unsafeGet(source.NeighbourLevel))
  if isSome(source.LayerInstance):
    result{"LayerInstance"} = toJsonHook(unsafeGet(source.LayerInstance))
  if isSome(source.World):
    result{"World"} = toJsonHook(unsafeGet(source.World))
  if isSome(source.EntityReferenceInfos):
    result{"EntityReferenceInfos"} = toJsonHook(
        unsafeGet(source.EntityReferenceInfos))
  if isSome(source.TileCustomMetadata):
    result{"TileCustomMetadata"} = toJsonHook(
        unsafeGet(source.TileCustomMetadata))
  if isSome(source.TilesetDef):
    result{"TilesetDef"} = toJsonHook(unsafeGet(source.TilesetDef))
  if isSome(source.EnumDefValues):
    result{"EnumDefValues"} = toJsonHook(unsafeGet(source.EnumDefValues))
  if isSome(source.Tile):
    result{"Tile"} = toJsonHook(unsafeGet(source.Tile))
  if isSome(source.LayerDef):
    result{"LayerDef"} = toJsonHook(unsafeGet(source.LayerDef))
  if isSome(source.LevelBgPosInfos):
    result{"LevelBgPosInfos"} = toJsonHook(unsafeGet(source.LevelBgPosInfos))
  if isSome(source.Level):
    result{"Level"} = toJsonHook(unsafeGet(source.Level))
  if isSome(source.TableOfContentEntry):
    result{"TableOfContentEntry"} = toJsonHook(
        unsafeGet(source.TableOfContentEntry))
  if isSome(source.EnumDef):
    result{"EnumDef"} = toJsonHook(unsafeGet(source.EnumDef))
  if isSome(source.GridPoint):
    result{"GridPoint"} = toJsonHook(unsafeGet(source.GridPoint))
  if isSome(source.IntGridValueDef):
    result{"IntGridValueDef"} = toJsonHook(unsafeGet(source.IntGridValueDef))

proc fromJsonHook*(target: var LdtkLdtkJsonRoot; source: JsonNode) =
  assert(hasKey(source, "backupLimit"),
         "backupLimit" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.backupLimit = jsonTo(source{"backupLimit"}, typeof(target.backupLimit))
  assert(hasKey(source, "defaultEntityWidth"), "defaultEntityWidth" &
      " is missing while decoding " &
      "LdtkLdtkJsonRoot")
  target.defaultEntityWidth = jsonTo(source{"defaultEntityWidth"},
                                     typeof(target.defaultEntityWidth))
  assert(hasKey(source, "backupOnSave"),
         "backupOnSave" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.backupOnSave = jsonTo(source{"backupOnSave"},
                               typeof(target.backupOnSave))
  if hasKey(source, "worldGridWidth") and
      source{"worldGridWidth"}.kind != JNull:
    target.worldGridWidth = some(jsonTo(source{"worldGridWidth"}, typeof(
        unsafeGet(target.worldGridWidth))))
  assert(hasKey(source, "iid"),
         "iid" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.iid = jsonTo(source{"iid"}, typeof(target.iid))
  assert(hasKey(source, "defaultLevelBgColor"), "defaultLevelBgColor" &
      " is missing while decoding " &
      "LdtkLdtkJsonRoot")
  target.defaultLevelBgColor = jsonTo(source{"defaultLevelBgColor"},
                                      typeof(target.defaultLevelBgColor))
  assert(hasKey(source, "bgColor"),
         "bgColor" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.bgColor = jsonTo(source{"bgColor"}, typeof(target.bgColor))
  assert(hasKey(source, "worlds"),
         "worlds" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.worlds = jsonTo(source{"worlds"}, typeof(target.worlds))
  assert(hasKey(source, "toc"),
         "toc" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.toc = jsonTo(source{"toc"}, typeof(target.toc))
  assert(hasKey(source, "nextUid"),
         "nextUid" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.nextUid = jsonTo(source{"nextUid"}, typeof(target.nextUid))
  assert(hasKey(source, "imageExportMode"),
         "imageExportMode" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.imageExportMode = jsonTo(source{"imageExportMode"},
                                  typeof(target.imageExportMode))
  assert(hasKey(source, "identifierStyle"),
         "identifierStyle" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.identifierStyle = jsonTo(source{"identifierStyle"},
                                  typeof(target.identifierStyle))
  assert(hasKey(source, "defaultPivotY"),
         "defaultPivotY" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.defaultPivotY = jsonTo(source{"defaultPivotY"},
                                typeof(target.defaultPivotY))
  assert(hasKey(source, "dummyWorldIid"),
         "dummyWorldIid" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.dummyWorldIid = jsonTo(source{"dummyWorldIid"},
                                typeof(target.dummyWorldIid))
  assert(hasKey(source, "customCommands"),
         "customCommands" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.customCommands = jsonTo(source{"customCommands"},
                                 typeof(target.customCommands))
  if hasKey(source, "worldGridHeight") and
      source{"worldGridHeight"}.kind != JNull:
    target.worldGridHeight = some(jsonTo(source{"worldGridHeight"},
        typeof(unsafeGet(target.worldGridHeight))))
  assert(hasKey(source, "appBuildId"),
         "appBuildId" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.appBuildId = jsonTo(source{"appBuildId"}, typeof(target.appBuildId))
  assert(hasKey(source, "defaultGridSize"),
         "defaultGridSize" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.defaultGridSize = jsonTo(source{"defaultGridSize"},
                                  typeof(target.defaultGridSize))
  if hasKey(source, "worldLayout") and source{"worldLayout"}.kind != JNull:
    target.worldLayout = some(jsonTo(source{"worldLayout"},
                                     typeof(unsafeGet(target.worldLayout))))
  assert(hasKey(source, "flags"),
         "flags" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.flags = jsonTo(source{"flags"}, typeof(target.flags))
  assert(hasKey(source, "levelNamePattern"), "levelNamePattern" &
      " is missing while decoding " &
      "LdtkLdtkJsonRoot")
  target.levelNamePattern = jsonTo(source{"levelNamePattern"},
                                   typeof(target.levelNamePattern))
  if hasKey(source, "exportPng") and source{"exportPng"}.kind != JNull:
    target.exportPng = some(jsonTo(source{"exportPng"},
                                   typeof(unsafeGet(target.exportPng))))
  if hasKey(source, "defaultLevelWidth") and
      source{"defaultLevelWidth"}.kind != JNull:
    target.defaultLevelWidth = some(jsonTo(source{"defaultLevelWidth"},
        typeof(unsafeGet(target.defaultLevelWidth))))
  if hasKey(source, "pngFilePattern") and
      source{"pngFilePattern"}.kind != JNull:
    target.pngFilePattern = some(jsonTo(source{"pngFilePattern"}, typeof(
        unsafeGet(target.pngFilePattern))))
  if hasKey(source, "__FORCED_REFS") and
      source{"__FORCED_REFS"}.kind != JNull:
    target.FORCED_REFS = some(jsonTo(source{"__FORCED_REFS"},
                                     typeof(unsafeGet(target.FORCED_REFS))))
  assert(hasKey(source, "exportTiled"),
         "exportTiled" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.exportTiled = jsonTo(source{"exportTiled"}, typeof(target.exportTiled))
  assert(hasKey(source, "defs"),
         "defs" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.defs = jsonTo(source{"defs"}, typeof(target.defs))
  assert(hasKey(source, "levels"),
         "levels" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.levels = jsonTo(source{"levels"}, typeof(target.levels))
  assert(hasKey(source, "jsonVersion"),
         "jsonVersion" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.jsonVersion = jsonTo(source{"jsonVersion"}, typeof(target.jsonVersion))
  assert(hasKey(source, "defaultEntityHeight"), "defaultEntityHeight" &
      " is missing while decoding " &
      "LdtkLdtkJsonRoot")
  target.defaultEntityHeight = jsonTo(source{"defaultEntityHeight"},
                                      typeof(target.defaultEntityHeight))
  assert(hasKey(source, "defaultPivotX"),
         "defaultPivotX" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.defaultPivotX = jsonTo(source{"defaultPivotX"},
                                typeof(target.defaultPivotX))
  if hasKey(source, "defaultLevelHeight") and
      source{"defaultLevelHeight"}.kind != JNull:
    target.defaultLevelHeight = some(jsonTo(source{"defaultLevelHeight"},
        typeof(unsafeGet(target.defaultLevelHeight))))
  assert(hasKey(source, "simplifiedExport"), "simplifiedExport" &
      " is missing while decoding " &
      "LdtkLdtkJsonRoot")
  target.simplifiedExport = jsonTo(source{"simplifiedExport"},
                                   typeof(target.simplifiedExport))
  assert(hasKey(source, "externalLevels"),
         "externalLevels" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.externalLevels = jsonTo(source{"externalLevels"},
                                 typeof(target.externalLevels))
  if hasKey(source, "tutorialDesc") and source{"tutorialDesc"}.kind != JNull:
    target.tutorialDesc = some(jsonTo(source{"tutorialDesc"},
                                      typeof(unsafeGet(target.tutorialDesc))))
  assert(hasKey(source, "minifyJson"),
         "minifyJson" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.minifyJson = jsonTo(source{"minifyJson"}, typeof(target.minifyJson))
  assert(hasKey(source, "exportLevelBg"),
         "exportLevelBg" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.exportLevelBg = jsonTo(source{"exportLevelBg"},
                                typeof(target.exportLevelBg))
  if hasKey(source, "backupRelPath") and
      source{"backupRelPath"}.kind != JNull:
    target.backupRelPath = some(jsonTo(source{"backupRelPath"},
                                       typeof(unsafeGet(target.backupRelPath))))

proc toJsonHook*(source: LdtkLdtkJsonRoot): JsonNode =
  result = newJObject()
  result{"backupLimit"} = newJInt(source.backupLimit)
  result{"defaultEntityWidth"} = newJInt(source.defaultEntityWidth)
  result{"backupOnSave"} = newJBool(source.backupOnSave)
  if isSome(source.worldGridWidth):
    result{"worldGridWidth"} = newJInt(unsafeGet(source.worldGridWidth))
  result{"iid"} = newJString(source.iid)
  result{"defaultLevelBgColor"} = newJString(source.defaultLevelBgColor)
  result{"bgColor"} = newJString(source.bgColor)
  result{"worlds"} = block:
    var output = newJArray()
    for entry in source.worlds:
      output.add(toJsonHook(entry))
    output
  result{"toc"} = block:
    var output = newJArray()
    for entry in source.toc:
      output.add(toJsonHook(entry))
    output
  result{"nextUid"} = newJInt(source.nextUid)
  result{"imageExportMode"} = toJsonHook(source.imageExportMode)
  result{"identifierStyle"} = toJsonHook(source.identifierStyle)
  result{"defaultPivotY"} = newJFloat(source.defaultPivotY)
  result{"dummyWorldIid"} = newJString(source.dummyWorldIid)
  result{"customCommands"} = block:
    var output = newJArray()
    for entry in source.customCommands:
      output.add(toJsonHook(entry))
    output
  if isSome(source.worldGridHeight):
    result{"worldGridHeight"} = newJInt(unsafeGet(source.worldGridHeight))
  result{"appBuildId"} = newJFloat(source.appBuildId)
  result{"defaultGridSize"} = newJInt(source.defaultGridSize)
  if isSome(source.worldLayout):
    result{"worldLayout"} = toJsonHook(unsafeGet(source.worldLayout))
  result{"flags"} = block:
    var output = newJArray()
    for entry in source.flags:
      output.add(toJsonHook(entry))
    output
  result{"levelNamePattern"} = newJString(source.levelNamePattern)
  if isSome(source.exportPng):
    result{"exportPng"} = newJBool(unsafeGet(source.exportPng))
  if isSome(source.defaultLevelWidth):
    result{"defaultLevelWidth"} = newJInt(unsafeGet(source.defaultLevelWidth))
  if isSome(source.pngFilePattern):
    result{"pngFilePattern"} = newJString(unsafeGet(source.pngFilePattern))
  if isSome(source.FORCED_REFS):
    result{"__FORCED_REFS"} = toJsonHook(unsafeGet(source.FORCED_REFS))
  result{"exportTiled"} = newJBool(source.exportTiled)
  result{"defs"} = toJsonHook(source.defs)
  result{"levels"} = block:
    var output = newJArray()
    for entry in source.levels:
      output.add(toJsonHook(entry))
    output
  result{"jsonVersion"} = newJString(source.jsonVersion)
  result{"defaultEntityHeight"} = newJInt(source.defaultEntityHeight)
  result{"defaultPivotX"} = newJFloat(source.defaultPivotX)
  if isSome(source.defaultLevelHeight):
    result{"defaultLevelHeight"} = newJInt(unsafeGet(source.defaultLevelHeight))
  result{"simplifiedExport"} = newJBool(source.simplifiedExport)
  result{"externalLevels"} = newJBool(source.externalLevels)
  if isSome(source.tutorialDesc):
    result{"tutorialDesc"} = newJString(unsafeGet(source.tutorialDesc))
  result{"minifyJson"} = newJBool(source.minifyJson)
  result{"exportLevelBg"} = newJBool(source.exportLevelBg)
  if isSome(source.backupRelPath):
    result{"backupRelPath"} = newJString(unsafeGet(source.backupRelPath))
{.pop.}
