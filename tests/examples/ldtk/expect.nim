{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]
import json_schema_import/private/[stringify, equality, bin]

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
  
proc equals(_: typedesc[LdtkNeighbourLevel]; a, b: LdtkNeighbourLevel): bool =
  equals(typeof(a.levelIid), a.levelIid, b.levelIid) and
      equals(typeof(a.levelUid), a.levelUid, b.levelUid) and
      equals(typeof(a.dir), a.dir, b.dir)

proc `==`*(a, b: LdtkNeighbourLevel): bool =
  return equals(LdtkNeighbourLevel, a, b)

proc stringify(_: typedesc[LdtkNeighbourLevel]; value: LdtkNeighbourLevel): string =
  stringifyObj("LdtkNeighbourLevel", ("levelIid", stringify(
      typeof(value.levelIid), value.levelIid)), ("levelUid",
      stringify(typeof(value.levelUid), value.levelUid)),
               ("dir", stringify(typeof(value.dir), value.dir)))

proc `$`*(value: LdtkNeighbourLevel): string =
  stringify(LdtkNeighbourLevel, value)

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

proc toBinary*(target: var string; source: LdtkNeighbourLevel) =
  toBinary(target, source.levelIid)
  toBinary(target, source.levelUid)
  toBinary(target, source.dir)

proc toBinary*(source: LdtkNeighbourLevel): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkNeighbourLevel]; source: string; idx: var int): LdtkNeighbourLevel =
  result.levelIid = fromBinary(typeof(result.levelIid), source, idx)
  result.levelUid = fromBinary(typeof(result.levelUid), source, idx)
  result.dir = fromBinary(typeof(result.dir), source, idx)

proc fromBinary*(_: typedesc[LdtkNeighbourLevel]; source: string): LdtkNeighbourLevel =
  var idx = 0
  return fromBinary(LdtkNeighbourLevel, source, idx)

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
  
proc equals(_: typedesc[LdtkLevelBgPosInfos]; a, b: LdtkLevelBgPosInfos): bool =
  equals(typeof(a.cropRect), a.cropRect, b.cropRect) and
      equals(typeof(a.scale), a.scale, b.scale) and
      equals(typeof(a.topLeftPx), a.topLeftPx, b.topLeftPx)

proc `==`*(a, b: LdtkLevelBgPosInfos): bool =
  return equals(LdtkLevelBgPosInfos, a, b)

proc stringify(_: typedesc[LdtkLevelBgPosInfos]; value: LdtkLevelBgPosInfos): string =
  stringifyObj("LdtkLevelBgPosInfos", ("cropRect", stringify(
      typeof(value.cropRect), value.cropRect)),
               ("scale", stringify(typeof(value.scale), value.scale)), (
      "topLeftPx", stringify(typeof(value.topLeftPx), value.topLeftPx)))

proc `$`*(value: LdtkLevelBgPosInfos): string =
  stringify(LdtkLevelBgPosInfos, value)

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

proc toBinary*(target: var string; source: LdtkLevelBgPosInfos) =
  toBinary(target, source.cropRect)
  toBinary(target, source.scale)
  toBinary(target, source.topLeftPx)

proc toBinary*(source: LdtkLevelBgPosInfos): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkLevelBgPosInfos]; source: string; idx: var int): LdtkLevelBgPosInfos =
  result.cropRect = fromBinary(typeof(result.cropRect), source, idx)
  result.scale = fromBinary(typeof(result.scale), source, idx)
  result.topLeftPx = fromBinary(typeof(result.topLeftPx), source, idx)

proc fromBinary*(_: typedesc[LdtkLevelBgPosInfos]; source: string): LdtkLevelBgPosInfos =
  var idx = 0
  return fromBinary(LdtkLevelBgPosInfos, source, idx)

proc equals(_: typedesc[LdtkTilesetRect]; a, b: LdtkTilesetRect): bool =
  equals(typeof(a.tilesetUid), a.tilesetUid, b.tilesetUid) and
      equals(typeof(a.h), a.h, b.h) and
      equals(typeof(a.x), a.x, b.x) and
      equals(typeof(a.y), a.y, b.y) and
      equals(typeof(a.w), a.w, b.w)

proc `==`*(a, b: LdtkTilesetRect): bool =
  return equals(LdtkTilesetRect, a, b)

proc stringify(_: typedesc[LdtkTilesetRect]; value: LdtkTilesetRect): string =
  stringifyObj("LdtkTilesetRect", ("tilesetUid", stringify(
      typeof(value.tilesetUid), value.tilesetUid)),
               ("h", stringify(typeof(value.h), value.h)),
               ("x", stringify(typeof(value.x), value.x)),
               ("y", stringify(typeof(value.y), value.y)),
               ("w", stringify(typeof(value.w), value.w)))

proc `$`*(value: LdtkTilesetRect): string =
  stringify(LdtkTilesetRect, value)

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

proc toBinary*(target: var string; source: LdtkTilesetRect) =
  toBinary(target, source.tilesetUid)
  toBinary(target, source.h)
  toBinary(target, source.x)
  toBinary(target, source.y)
  toBinary(target, source.w)

proc toBinary*(source: LdtkTilesetRect): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkTilesetRect]; source: string; idx: var int): LdtkTilesetRect =
  result.tilesetUid = fromBinary(typeof(result.tilesetUid), source, idx)
  result.h = fromBinary(typeof(result.h), source, idx)
  result.x = fromBinary(typeof(result.x), source, idx)
  result.y = fromBinary(typeof(result.y), source, idx)
  result.w = fromBinary(typeof(result.w), source, idx)

proc fromBinary*(_: typedesc[LdtkTilesetRect]; source: string): LdtkTilesetRect =
  var idx = 0
  return fromBinary(LdtkTilesetRect, source, idx)

proc equals(_: typedesc[LdtkFieldInstance]; a, b: LdtkFieldInstance): bool =
  equals(typeof(a.`type`), a.`type`, b.`type`) and
      equals(typeof(a.defUid), a.defUid, b.defUid) and
      equals(typeof(a.identifier), a.identifier, b.identifier) and
      equals(typeof(a.tile), a.tile, b.tile) and
      equals(typeof(a.realEditorValues), a.realEditorValues, b.realEditorValues) and
      equals(typeof(a.value), a.value, b.value)

proc `==`*(a, b: LdtkFieldInstance): bool =
  return equals(LdtkFieldInstance, a, b)

proc stringify(_: typedesc[LdtkFieldInstance]; value: LdtkFieldInstance): string =
  stringifyObj("LdtkFieldInstance",
               ("type", stringify(typeof(value.`type`), value.`type`)),
               ("defUid", stringify(typeof(value.defUid), value.defUid)), (
      "identifier", stringify(typeof(value.identifier), value.identifier)),
               ("tile", stringify(typeof(value.tile), value.tile)), (
      "realEditorValues",
      stringify(typeof(value.realEditorValues), value.realEditorValues)),
               ("value", stringify(typeof(value.value), value.value)))

proc `$`*(value: LdtkFieldInstance): string =
  stringify(LdtkFieldInstance, value)

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

proc toBinary*(target: var string; source: LdtkFieldInstance) =
  toBinary(target, source.`type`)
  toBinary(target, source.defUid)
  toBinary(target, source.identifier)
  toBinary(target, source.tile)
  toBinary(target, source.realEditorValues)
  toBinary(target, source.value)

proc toBinary*(source: LdtkFieldInstance): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkFieldInstance]; source: string; idx: var int): LdtkFieldInstance =
  result.`type` = fromBinary(typeof(result.`type`), source, idx)
  result.defUid = fromBinary(typeof(result.defUid), source, idx)
  result.identifier = fromBinary(typeof(result.identifier), source, idx)
  result.tile = fromBinary(typeof(result.tile), source, idx)
  result.realEditorValues = fromBinary(typeof(result.realEditorValues), source,
                                       idx)
  result.value = fromBinary(typeof(result.value), source, idx)

proc fromBinary*(_: typedesc[LdtkFieldInstance]; source: string): LdtkFieldInstance =
  var idx = 0
  return fromBinary(LdtkFieldInstance, source, idx)

proc equals(_: typedesc[LdtkTile]; a, b: LdtkTile): bool =
  equals(typeof(a.t), a.t, b.t) and equals(typeof(a.d), a.d, b.d) and
      equals(typeof(a.px), a.px, b.px) and
      equals(typeof(a.a), a.a, b.a) and
      equals(typeof(a.f), a.f, b.f) and
      equals(typeof(a.src), a.src, b.src)

proc `==`*(a, b: LdtkTile): bool =
  return equals(LdtkTile, a, b)

proc stringify(_: typedesc[LdtkTile]; value: LdtkTile): string =
  stringifyObj("LdtkTile", ("t", stringify(typeof(value.t), value.t)),
               ("d", stringify(typeof(value.d), value.d)),
               ("px", stringify(typeof(value.px), value.px)),
               ("a", stringify(typeof(value.a), value.a)),
               ("f", stringify(typeof(value.f), value.f)),
               ("src", stringify(typeof(value.src), value.src)))

proc `$`*(value: LdtkTile): string =
  stringify(LdtkTile, value)

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

proc toBinary*(target: var string; source: LdtkTile) =
  toBinary(target, source.t)
  toBinary(target, source.d)
  toBinary(target, source.px)
  toBinary(target, source.a)
  toBinary(target, source.f)
  toBinary(target, source.src)

proc toBinary*(source: LdtkTile): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkTile]; source: string; idx: var int): LdtkTile =
  result.t = fromBinary(typeof(result.t), source, idx)
  result.d = fromBinary(typeof(result.d), source, idx)
  result.px = fromBinary(typeof(result.px), source, idx)
  result.a = fromBinary(typeof(result.a), source, idx)
  result.f = fromBinary(typeof(result.f), source, idx)
  result.src = fromBinary(typeof(result.src), source, idx)

proc fromBinary*(_: typedesc[LdtkTile]; source: string): LdtkTile =
  var idx = 0
  return fromBinary(LdtkTile, source, idx)

proc equals(_: typedesc[LdtkEntityInstance]; a, b: LdtkEntityInstance): bool =
  equals(typeof(a.iid), a.iid, b.iid) and
      equals(typeof(a.defUid), a.defUid, b.defUid) and
      equals(typeof(a.identifier), a.identifier, b.identifier) and
      equals(typeof(a.tile), a.tile, b.tile) and
      equals(typeof(a.px), a.px, b.px) and
      equals(typeof(a.worldX), a.worldX, b.worldX) and
      equals(typeof(a.worldY), a.worldY, b.worldY) and
      equals(typeof(a.smartColor), a.smartColor, b.smartColor) and
      equals(typeof(a.grid), a.grid, b.grid) and
      equals(typeof(a.pivot), a.pivot, b.pivot) and
      equals(typeof(a.fieldInstances), a.fieldInstances, b.fieldInstances) and
      equals(typeof(a.height), a.height, b.height) and
      equals(typeof(a.tags), a.tags, b.tags) and
      equals(typeof(a.width), a.width, b.width)

proc `==`*(a, b: LdtkEntityInstance): bool =
  return equals(LdtkEntityInstance, a, b)

proc stringify(_: typedesc[LdtkEntityInstance]; value: LdtkEntityInstance): string =
  stringifyObj("LdtkEntityInstance",
               ("iid", stringify(typeof(value.iid), value.iid)),
               ("defUid", stringify(typeof(value.defUid), value.defUid)), (
      "identifier", stringify(typeof(value.identifier), value.identifier)),
               ("tile", stringify(typeof(value.tile), value.tile)),
               ("px", stringify(typeof(value.px), value.px)),
               ("worldX", stringify(typeof(value.worldX), value.worldX)),
               ("worldY", stringify(typeof(value.worldY), value.worldY)), (
      "smartColor", stringify(typeof(value.smartColor), value.smartColor)),
               ("grid", stringify(typeof(value.grid), value.grid)),
               ("pivot", stringify(typeof(value.pivot), value.pivot)), (
      "fieldInstances",
      stringify(typeof(value.fieldInstances), value.fieldInstances)),
               ("height", stringify(typeof(value.height), value.height)),
               ("tags", stringify(typeof(value.tags), value.tags)),
               ("width", stringify(typeof(value.width), value.width)))

proc `$`*(value: LdtkEntityInstance): string =
  stringify(LdtkEntityInstance, value)

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

proc toBinary*(target: var string; source: LdtkEntityInstance) =
  toBinary(target, source.iid)
  toBinary(target, source.defUid)
  toBinary(target, source.identifier)
  toBinary(target, source.tile)
  toBinary(target, source.px)
  toBinary(target, source.worldX)
  toBinary(target, source.worldY)
  toBinary(target, source.smartColor)
  toBinary(target, source.grid)
  toBinary(target, source.pivot)
  toBinary(target, source.fieldInstances)
  toBinary(target, source.height)
  toBinary(target, source.tags)
  toBinary(target, source.width)

proc toBinary*(source: LdtkEntityInstance): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkEntityInstance]; source: string; idx: var int): LdtkEntityInstance =
  result.iid = fromBinary(typeof(result.iid), source, idx)
  result.defUid = fromBinary(typeof(result.defUid), source, idx)
  result.identifier = fromBinary(typeof(result.identifier), source, idx)
  result.tile = fromBinary(typeof(result.tile), source, idx)
  result.px = fromBinary(typeof(result.px), source, idx)
  result.worldX = fromBinary(typeof(result.worldX), source, idx)
  result.worldY = fromBinary(typeof(result.worldY), source, idx)
  result.smartColor = fromBinary(typeof(result.smartColor), source, idx)
  result.grid = fromBinary(typeof(result.grid), source, idx)
  result.pivot = fromBinary(typeof(result.pivot), source, idx)
  result.fieldInstances = fromBinary(typeof(result.fieldInstances), source, idx)
  result.height = fromBinary(typeof(result.height), source, idx)
  result.tags = fromBinary(typeof(result.tags), source, idx)
  result.width = fromBinary(typeof(result.width), source, idx)

proc fromBinary*(_: typedesc[LdtkEntityInstance]; source: string): LdtkEntityInstance =
  var idx = 0
  return fromBinary(LdtkEntityInstance, source, idx)

proc equals(_: typedesc[LdtkIntGridValueInstance];
            a, b: LdtkIntGridValueInstance): bool =
  equals(typeof(a.v), a.v, b.v) and
      equals(typeof(a.coordId), a.coordId, b.coordId)

proc `==`*(a, b: LdtkIntGridValueInstance): bool =
  return equals(LdtkIntGridValueInstance, a, b)

proc stringify(_: typedesc[LdtkIntGridValueInstance];
               value: LdtkIntGridValueInstance): string =
  stringifyObj("LdtkIntGridValueInstance",
               ("v", stringify(typeof(value.v), value.v)),
               ("coordId", stringify(typeof(value.coordId), value.coordId)))

proc `$`*(value: LdtkIntGridValueInstance): string =
  stringify(LdtkIntGridValueInstance, value)

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

proc toBinary*(target: var string; source: LdtkIntGridValueInstance) =
  toBinary(target, source.v)
  toBinary(target, source.coordId)

proc toBinary*(source: LdtkIntGridValueInstance): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkIntGridValueInstance]; source: string;
                idx: var int): LdtkIntGridValueInstance =
  result.v = fromBinary(typeof(result.v), source, idx)
  result.coordId = fromBinary(typeof(result.coordId), source, idx)

proc fromBinary*(_: typedesc[LdtkIntGridValueInstance]; source: string): LdtkIntGridValueInstance =
  var idx = 0
  return fromBinary(LdtkIntGridValueInstance, source, idx)

proc equals(_: typedesc[LdtkLayerInstance]; a, b: LdtkLayerInstance): bool =
  equals(typeof(a.cHei), a.cHei, b.cHei) and
      equals(typeof(a.pxOffsetX), a.pxOffsetX, b.pxOffsetX) and
      equals(typeof(a.tilesetRelPath), a.tilesetRelPath, b.tilesetRelPath) and
      equals(typeof(a.iid), a.iid, b.iid) and
      equals(typeof(a.levelId), a.levelId, b.levelId) and
      equals(typeof(a.`type`), a.`type`, b.`type`) and
      equals(typeof(a.autoLayerTiles), a.autoLayerTiles, b.autoLayerTiles) and
      equals(typeof(a.optionalRules), a.optionalRules, b.optionalRules) and
      equals(typeof(a.identifier), a.identifier, b.identifier) and
      equals(typeof(a.gridSize), a.gridSize, b.gridSize) and
      equals(typeof(a.pxTotalOffsetY), a.pxTotalOffsetY, b.pxTotalOffsetY) and
      equals(typeof(a.intGridCsv), a.intGridCsv, b.intGridCsv) and
      equals(typeof(a.overrideTilesetUid), a.overrideTilesetUid,
             b.overrideTilesetUid) and
      equals(typeof(a.visible), a.visible, b.visible) and
      equals(typeof(a.entityInstances), a.entityInstances, b.entityInstances) and
      equals(typeof(a.opacity), a.opacity, b.opacity) and
      equals(typeof(a.seed), a.seed, b.seed) and
      equals(typeof(a.layerDefUid), a.layerDefUid, b.layerDefUid) and
      equals(typeof(a.pxTotalOffsetX), a.pxTotalOffsetX, b.pxTotalOffsetX) and
      equals(typeof(a.cWid), a.cWid, b.cWid) and
      equals(typeof(a.pxOffsetY), a.pxOffsetY, b.pxOffsetY) and
      equals(typeof(a.tilesetDefUid), a.tilesetDefUid, b.tilesetDefUid) and
      equals(typeof(a.gridTiles), a.gridTiles, b.gridTiles) and
      equals(typeof(a.intGrid), a.intGrid, b.intGrid)

proc `==`*(a, b: LdtkLayerInstance): bool =
  return equals(LdtkLayerInstance, a, b)

proc stringify(_: typedesc[LdtkLayerInstance]; value: LdtkLayerInstance): string =
  stringifyObj("LdtkLayerInstance",
               ("cHei", stringify(typeof(value.cHei), value.cHei)), (
      "pxOffsetX", stringify(typeof(value.pxOffsetX), value.pxOffsetX)), (
      "tilesetRelPath",
      stringify(typeof(value.tilesetRelPath), value.tilesetRelPath)),
               ("iid", stringify(typeof(value.iid), value.iid)),
               ("levelId", stringify(typeof(value.levelId), value.levelId)),
               ("type", stringify(typeof(value.`type`), value.`type`)), (
      "autoLayerTiles",
      stringify(typeof(value.autoLayerTiles), value.autoLayerTiles)), (
      "optionalRules",
      stringify(typeof(value.optionalRules), value.optionalRules)), (
      "identifier", stringify(typeof(value.identifier), value.identifier)), (
      "gridSize", stringify(typeof(value.gridSize), value.gridSize)), (
      "pxTotalOffsetY",
      stringify(typeof(value.pxTotalOffsetY), value.pxTotalOffsetY)), (
      "intGridCsv", stringify(typeof(value.intGridCsv), value.intGridCsv)), (
      "overrideTilesetUid",
      stringify(typeof(value.overrideTilesetUid), value.overrideTilesetUid)),
               ("visible", stringify(typeof(value.visible), value.visible)), (
      "entityInstances",
      stringify(typeof(value.entityInstances), value.entityInstances)),
               ("opacity", stringify(typeof(value.opacity), value.opacity)),
               ("seed", stringify(typeof(value.seed), value.seed)), (
      "layerDefUid", stringify(typeof(value.layerDefUid), value.layerDefUid)), (
      "pxTotalOffsetX",
      stringify(typeof(value.pxTotalOffsetX), value.pxTotalOffsetX)),
               ("cWid", stringify(typeof(value.cWid), value.cWid)), (
      "pxOffsetY", stringify(typeof(value.pxOffsetY), value.pxOffsetY)), (
      "tilesetDefUid",
      stringify(typeof(value.tilesetDefUid), value.tilesetDefUid)), (
      "gridTiles", stringify(typeof(value.gridTiles), value.gridTiles)),
               ("intGrid", stringify(typeof(value.intGrid), value.intGrid)))

proc `$`*(value: LdtkLayerInstance): string =
  stringify(LdtkLayerInstance, value)

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

proc toBinary*(target: var string; source: LdtkLayerInstance) =
  toBinary(target, source.cHei)
  toBinary(target, source.pxOffsetX)
  toBinary(target, source.tilesetRelPath)
  toBinary(target, source.iid)
  toBinary(target, source.levelId)
  toBinary(target, source.`type`)
  toBinary(target, source.autoLayerTiles)
  toBinary(target, source.optionalRules)
  toBinary(target, source.identifier)
  toBinary(target, source.gridSize)
  toBinary(target, source.pxTotalOffsetY)
  toBinary(target, source.intGridCsv)
  toBinary(target, source.overrideTilesetUid)
  toBinary(target, source.visible)
  toBinary(target, source.entityInstances)
  toBinary(target, source.opacity)
  toBinary(target, source.seed)
  toBinary(target, source.layerDefUid)
  toBinary(target, source.pxTotalOffsetX)
  toBinary(target, source.cWid)
  toBinary(target, source.pxOffsetY)
  toBinary(target, source.tilesetDefUid)
  toBinary(target, source.gridTiles)
  toBinary(target, source.intGrid)

proc toBinary*(source: LdtkLayerInstance): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkLayerInstance]; source: string; idx: var int): LdtkLayerInstance =
  result.cHei = fromBinary(typeof(result.cHei), source, idx)
  result.pxOffsetX = fromBinary(typeof(result.pxOffsetX), source, idx)
  result.tilesetRelPath = fromBinary(typeof(result.tilesetRelPath), source, idx)
  result.iid = fromBinary(typeof(result.iid), source, idx)
  result.levelId = fromBinary(typeof(result.levelId), source, idx)
  result.`type` = fromBinary(typeof(result.`type`), source, idx)
  result.autoLayerTiles = fromBinary(typeof(result.autoLayerTiles), source, idx)
  result.optionalRules = fromBinary(typeof(result.optionalRules), source, idx)
  result.identifier = fromBinary(typeof(result.identifier), source, idx)
  result.gridSize = fromBinary(typeof(result.gridSize), source, idx)
  result.pxTotalOffsetY = fromBinary(typeof(result.pxTotalOffsetY), source, idx)
  result.intGridCsv = fromBinary(typeof(result.intGridCsv), source, idx)
  result.overrideTilesetUid = fromBinary(typeof(result.overrideTilesetUid),
      source, idx)
  result.visible = fromBinary(typeof(result.visible), source, idx)
  result.entityInstances = fromBinary(typeof(result.entityInstances), source,
                                      idx)
  result.opacity = fromBinary(typeof(result.opacity), source, idx)
  result.seed = fromBinary(typeof(result.seed), source, idx)
  result.layerDefUid = fromBinary(typeof(result.layerDefUid), source, idx)
  result.pxTotalOffsetX = fromBinary(typeof(result.pxTotalOffsetX), source, idx)
  result.cWid = fromBinary(typeof(result.cWid), source, idx)
  result.pxOffsetY = fromBinary(typeof(result.pxOffsetY), source, idx)
  result.tilesetDefUid = fromBinary(typeof(result.tilesetDefUid), source, idx)
  result.gridTiles = fromBinary(typeof(result.gridTiles), source, idx)
  result.intGrid = fromBinary(typeof(result.intGrid), source, idx)

proc fromBinary*(_: typedesc[LdtkLayerInstance]; source: string): LdtkLayerInstance =
  var idx = 0
  return fromBinary(LdtkLayerInstance, source, idx)

proc equals(_: typedesc[LdtkLevel]; a, b: LdtkLevel): bool =
  equals(typeof(a.neighbours), a.neighbours, b.neighbours) and
      equals(typeof(a.bgColor), a.bgColor, b.bgColor) and
      equals(typeof(a.worldX), a.worldX, b.worldX) and
      equals(typeof(a.externalRelPath), a.externalRelPath, b.externalRelPath) and
      equals(typeof(a.useAutoIdentifier), a.useAutoIdentifier,
             b.useAutoIdentifier) and
      equals(typeof(a.iid), a.iid, b.iid) and
      equals(typeof(a.bgColor1), a.bgColor1, b.bgColor1) and
      equals(typeof(a.bgPos), a.bgPos, b.bgPos) and
      equals(typeof(a.pxHei), a.pxHei, b.pxHei) and
      equals(typeof(a.worldY), a.worldY, b.worldY) and
      equals(typeof(a.bgPos1), a.bgPos1, b.bgPos1) and
      equals(typeof(a.uid), a.uid, b.uid) and
      equals(typeof(a.smartColor), a.smartColor, b.smartColor) and
      equals(typeof(a.fieldInstances), a.fieldInstances, b.fieldInstances) and
      equals(typeof(a.pxWid), a.pxWid, b.pxWid) and
      equals(typeof(a.identifier), a.identifier, b.identifier) and
      equals(typeof(a.bgPivotY), a.bgPivotY, b.bgPivotY) and
      equals(typeof(a.bgPivotX), a.bgPivotX, b.bgPivotX) and
      equals(typeof(a.layerInstances), a.layerInstances, b.layerInstances) and
      equals(typeof(a.bgRelPath), a.bgRelPath, b.bgRelPath) and
      equals(typeof(a.worldDepth), a.worldDepth, b.worldDepth)

proc `==`*(a, b: LdtkLevel): bool =
  return equals(LdtkLevel, a, b)

proc stringify(_: typedesc[LdtkLevel]; value: LdtkLevel): string =
  stringifyObj("LdtkLevel", ("neighbours", stringify(typeof(value.neighbours),
      value.neighbours)),
               ("bgColor", stringify(typeof(value.bgColor), value.bgColor)),
               ("worldX", stringify(typeof(value.worldX), value.worldX)), (
      "externalRelPath",
      stringify(typeof(value.externalRelPath), value.externalRelPath)), (
      "useAutoIdentifier",
      stringify(typeof(value.useAutoIdentifier), value.useAutoIdentifier)),
               ("iid", stringify(typeof(value.iid), value.iid)), ("bgColor1",
      stringify(typeof(value.bgColor1), value.bgColor1)),
               ("bgPos", stringify(typeof(value.bgPos), value.bgPos)),
               ("pxHei", stringify(typeof(value.pxHei), value.pxHei)),
               ("worldY", stringify(typeof(value.worldY), value.worldY)),
               ("bgPos1", stringify(typeof(value.bgPos1), value.bgPos1)),
               ("uid", stringify(typeof(value.uid), value.uid)), ("smartColor",
      stringify(typeof(value.smartColor), value.smartColor)), ("fieldInstances",
      stringify(typeof(value.fieldInstances), value.fieldInstances)),
               ("pxWid", stringify(typeof(value.pxWid), value.pxWid)), (
      "identifier", stringify(typeof(value.identifier), value.identifier)), (
      "bgPivotY", stringify(typeof(value.bgPivotY), value.bgPivotY)), (
      "bgPivotX", stringify(typeof(value.bgPivotX), value.bgPivotX)), (
      "layerInstances",
      stringify(typeof(value.layerInstances), value.layerInstances)), (
      "bgRelPath", stringify(typeof(value.bgRelPath), value.bgRelPath)), (
      "worldDepth", stringify(typeof(value.worldDepth), value.worldDepth)))

proc `$`*(value: LdtkLevel): string =
  stringify(LdtkLevel, value)

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

proc toBinary*(target: var string; source: LdtkLevel) =
  toBinary(target, source.neighbours)
  toBinary(target, source.bgColor)
  toBinary(target, source.worldX)
  toBinary(target, source.externalRelPath)
  toBinary(target, source.useAutoIdentifier)
  toBinary(target, source.iid)
  toBinary(target, source.bgColor1)
  toBinary(target, source.bgPos)
  toBinary(target, source.pxHei)
  toBinary(target, source.worldY)
  toBinary(target, source.bgPos1)
  toBinary(target, source.uid)
  toBinary(target, source.smartColor)
  toBinary(target, source.fieldInstances)
  toBinary(target, source.pxWid)
  toBinary(target, source.identifier)
  toBinary(target, source.bgPivotY)
  toBinary(target, source.bgPivotX)
  toBinary(target, source.layerInstances)
  toBinary(target, source.bgRelPath)
  toBinary(target, source.worldDepth)

proc toBinary*(source: LdtkLevel): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkLevel]; source: string; idx: var int): LdtkLevel =
  result.neighbours = fromBinary(typeof(result.neighbours), source, idx)
  result.bgColor = fromBinary(typeof(result.bgColor), source, idx)
  result.worldX = fromBinary(typeof(result.worldX), source, idx)
  result.externalRelPath = fromBinary(typeof(result.externalRelPath), source,
                                      idx)
  result.useAutoIdentifier = fromBinary(typeof(result.useAutoIdentifier),
                                        source, idx)
  result.iid = fromBinary(typeof(result.iid), source, idx)
  result.bgColor1 = fromBinary(typeof(result.bgColor1), source, idx)
  result.bgPos = fromBinary(typeof(result.bgPos), source, idx)
  result.pxHei = fromBinary(typeof(result.pxHei), source, idx)
  result.worldY = fromBinary(typeof(result.worldY), source, idx)
  result.bgPos1 = fromBinary(typeof(result.bgPos1), source, idx)
  result.uid = fromBinary(typeof(result.uid), source, idx)
  result.smartColor = fromBinary(typeof(result.smartColor), source, idx)
  result.fieldInstances = fromBinary(typeof(result.fieldInstances), source, idx)
  result.pxWid = fromBinary(typeof(result.pxWid), source, idx)
  result.identifier = fromBinary(typeof(result.identifier), source, idx)
  result.bgPivotY = fromBinary(typeof(result.bgPivotY), source, idx)
  result.bgPivotX = fromBinary(typeof(result.bgPivotX), source, idx)
  result.layerInstances = fromBinary(typeof(result.layerInstances), source, idx)
  result.bgRelPath = fromBinary(typeof(result.bgRelPath), source, idx)
  result.worldDepth = fromBinary(typeof(result.worldDepth), source, idx)

proc fromBinary*(_: typedesc[LdtkLevel]; source: string): LdtkLevel =
  var idx = 0
  return fromBinary(LdtkLevel, source, idx)

proc equals(_: typedesc[LdtkWorld]; a, b: LdtkWorld): bool =
  equals(typeof(a.worldGridWidth), a.worldGridWidth, b.worldGridWidth) and
      equals(typeof(a.iid), a.iid, b.iid) and
      equals(typeof(a.worldGridHeight), a.worldGridHeight, b.worldGridHeight) and
      equals(typeof(a.worldLayout), a.worldLayout, b.worldLayout) and
      equals(typeof(a.defaultLevelWidth), a.defaultLevelWidth,
             b.defaultLevelWidth) and
      equals(typeof(a.levels), a.levels, b.levels) and
      equals(typeof(a.defaultLevelHeight), a.defaultLevelHeight,
             b.defaultLevelHeight) and
      equals(typeof(a.identifier), a.identifier, b.identifier)

proc `==`*(a, b: LdtkWorld): bool =
  return equals(LdtkWorld, a, b)

proc stringify(_: typedesc[LdtkWorld]; value: LdtkWorld): string =
  stringifyObj("LdtkWorld", ("worldGridWidth", stringify(
      typeof(value.worldGridWidth), value.worldGridWidth)),
               ("iid", stringify(typeof(value.iid), value.iid)), (
      "worldGridHeight",
      stringify(typeof(value.worldGridHeight), value.worldGridHeight)), (
      "worldLayout", stringify(typeof(value.worldLayout), value.worldLayout)), (
      "defaultLevelWidth",
      stringify(typeof(value.defaultLevelWidth), value.defaultLevelWidth)),
               ("levels", stringify(typeof(value.levels), value.levels)), (
      "defaultLevelHeight",
      stringify(typeof(value.defaultLevelHeight), value.defaultLevelHeight)), (
      "identifier", stringify(typeof(value.identifier), value.identifier)))

proc `$`*(value: LdtkWorld): string =
  stringify(LdtkWorld, value)

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

proc toBinary*(target: var string; source: LdtkWorld) =
  toBinary(target, source.worldGridWidth)
  toBinary(target, source.iid)
  toBinary(target, source.worldGridHeight)
  toBinary(target, source.worldLayout)
  toBinary(target, source.defaultLevelWidth)
  toBinary(target, source.levels)
  toBinary(target, source.defaultLevelHeight)
  toBinary(target, source.identifier)

proc toBinary*(source: LdtkWorld): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkWorld]; source: string; idx: var int): LdtkWorld =
  result.worldGridWidth = fromBinary(typeof(result.worldGridWidth), source, idx)
  result.iid = fromBinary(typeof(result.iid), source, idx)
  result.worldGridHeight = fromBinary(typeof(result.worldGridHeight), source,
                                      idx)
  result.worldLayout = fromBinary(typeof(result.worldLayout), source, idx)
  result.defaultLevelWidth = fromBinary(typeof(result.defaultLevelWidth),
                                        source, idx)
  result.levels = fromBinary(typeof(result.levels), source, idx)
  result.defaultLevelHeight = fromBinary(typeof(result.defaultLevelHeight),
      source, idx)
  result.identifier = fromBinary(typeof(result.identifier), source, idx)

proc fromBinary*(_: typedesc[LdtkWorld]; source: string): LdtkWorld =
  var idx = 0
  return fromBinary(LdtkWorld, source, idx)

proc equals(_: typedesc[LdtkEntityReferenceInfos];
            a, b: LdtkEntityReferenceInfos): bool =
  equals(typeof(a.worldIid), a.worldIid, b.worldIid) and
      equals(typeof(a.entityIid), a.entityIid, b.entityIid) and
      equals(typeof(a.layerIid), a.layerIid, b.layerIid) and
      equals(typeof(a.levelIid), a.levelIid, b.levelIid)

proc `==`*(a, b: LdtkEntityReferenceInfos): bool =
  return equals(LdtkEntityReferenceInfos, a, b)

proc stringify(_: typedesc[LdtkEntityReferenceInfos];
               value: LdtkEntityReferenceInfos): string =
  stringifyObj("LdtkEntityReferenceInfos", ("worldIid",
      stringify(typeof(value.worldIid), value.worldIid)), ("entityIid",
      stringify(typeof(value.entityIid), value.entityIid)), ("layerIid",
      stringify(typeof(value.layerIid), value.layerIid)),
               ("levelIid", stringify(typeof(value.levelIid), value.levelIid)))

proc `$`*(value: LdtkEntityReferenceInfos): string =
  stringify(LdtkEntityReferenceInfos, value)

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

proc toBinary*(target: var string; source: LdtkEntityReferenceInfos) =
  toBinary(target, source.worldIid)
  toBinary(target, source.entityIid)
  toBinary(target, source.layerIid)
  toBinary(target, source.levelIid)

proc toBinary*(source: LdtkEntityReferenceInfos): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkEntityReferenceInfos]; source: string;
                idx: var int): LdtkEntityReferenceInfos =
  result.worldIid = fromBinary(typeof(result.worldIid), source, idx)
  result.entityIid = fromBinary(typeof(result.entityIid), source, idx)
  result.layerIid = fromBinary(typeof(result.layerIid), source, idx)
  result.levelIid = fromBinary(typeof(result.levelIid), source, idx)

proc fromBinary*(_: typedesc[LdtkEntityReferenceInfos]; source: string): LdtkEntityReferenceInfos =
  var idx = 0
  return fromBinary(LdtkEntityReferenceInfos, source, idx)

proc equals(_: typedesc[LdtkTocInstanceData]; a, b: LdtkTocInstanceData): bool =
  equals(typeof(a.worldX), a.worldX, b.worldX) and
      equals(typeof(a.widPx), a.widPx, b.widPx) and
      equals(typeof(a.worldY), a.worldY, b.worldY) and
      equals(typeof(a.heiPx), a.heiPx, b.heiPx) and
      equals(typeof(a.fields), a.fields, b.fields) and
      equals(typeof(a.iids), a.iids, b.iids)

proc `==`*(a, b: LdtkTocInstanceData): bool =
  return equals(LdtkTocInstanceData, a, b)

proc stringify(_: typedesc[LdtkTocInstanceData]; value: LdtkTocInstanceData): string =
  stringifyObj("LdtkTocInstanceData",
               ("worldX", stringify(typeof(value.worldX), value.worldX)),
               ("widPx", stringify(typeof(value.widPx), value.widPx)),
               ("worldY", stringify(typeof(value.worldY), value.worldY)),
               ("heiPx", stringify(typeof(value.heiPx), value.heiPx)),
               ("fields", stringify(typeof(value.fields), value.fields)),
               ("iids", stringify(typeof(value.iids), value.iids)))

proc `$`*(value: LdtkTocInstanceData): string =
  stringify(LdtkTocInstanceData, value)

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

proc toBinary*(target: var string; source: LdtkTocInstanceData) =
  toBinary(target, source.worldX)
  toBinary(target, source.widPx)
  toBinary(target, source.worldY)
  toBinary(target, source.heiPx)
  toBinary(target, source.fields)
  toBinary(target, source.iids)

proc toBinary*(source: LdtkTocInstanceData): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkTocInstanceData]; source: string; idx: var int): LdtkTocInstanceData =
  result.worldX = fromBinary(typeof(result.worldX), source, idx)
  result.widPx = fromBinary(typeof(result.widPx), source, idx)
  result.worldY = fromBinary(typeof(result.worldY), source, idx)
  result.heiPx = fromBinary(typeof(result.heiPx), source, idx)
  result.fields = fromBinary(typeof(result.fields), source, idx)
  result.iids = fromBinary(typeof(result.iids), source, idx)

proc fromBinary*(_: typedesc[LdtkTocInstanceData]; source: string): LdtkTocInstanceData =
  var idx = 0
  return fromBinary(LdtkTocInstanceData, source, idx)

proc equals(_: typedesc[LdtkTableOfContentEntry]; a, b: LdtkTableOfContentEntry): bool =
  equals(typeof(a.identifier), a.identifier, b.identifier) and
      equals(typeof(a.instancesData), a.instancesData, b.instancesData) and
      equals(typeof(a.instances), a.instances, b.instances)

proc `==`*(a, b: LdtkTableOfContentEntry): bool =
  return equals(LdtkTableOfContentEntry, a, b)

proc stringify(_: typedesc[LdtkTableOfContentEntry];
               value: LdtkTableOfContentEntry): string =
  stringifyObj("LdtkTableOfContentEntry", ("identifier",
      stringify(typeof(value.identifier), value.identifier)), ("instancesData",
      stringify(typeof(value.instancesData), value.instancesData)), (
      "instances", stringify(typeof(value.instances), value.instances)))

proc `$`*(value: LdtkTableOfContentEntry): string =
  stringify(LdtkTableOfContentEntry, value)

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

proc toBinary*(target: var string; source: LdtkTableOfContentEntry) =
  toBinary(target, source.identifier)
  toBinary(target, source.instancesData)
  toBinary(target, source.instances)

proc toBinary*(source: LdtkTableOfContentEntry): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkTableOfContentEntry]; source: string;
                idx: var int): LdtkTableOfContentEntry =
  result.identifier = fromBinary(typeof(result.identifier), source, idx)
  result.instancesData = fromBinary(typeof(result.instancesData), source, idx)
  result.instances = fromBinary(typeof(result.instances), source, idx)

proc fromBinary*(_: typedesc[LdtkTableOfContentEntry]; source: string): LdtkTableOfContentEntry =
  var idx = 0
  return fromBinary(LdtkTableOfContentEntry, source, idx)

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
  
proc equals(_: typedesc[LdtkCustomCommand]; a, b: LdtkCustomCommand): bool =
  equals(typeof(a.`when`), a.`when`, b.`when`) and
      equals(typeof(a.command), a.command, b.command)

proc `==`*(a, b: LdtkCustomCommand): bool =
  return equals(LdtkCustomCommand, a, b)

proc stringify(_: typedesc[LdtkCustomCommand]; value: LdtkCustomCommand): string =
  stringifyObj("LdtkCustomCommand",
               ("when", stringify(typeof(value.`when`), value.`when`)),
               ("command", stringify(typeof(value.command), value.command)))

proc `$`*(value: LdtkCustomCommand): string =
  stringify(LdtkCustomCommand, value)

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

proc toBinary*(target: var string; source: LdtkCustomCommand) =
  toBinary(target, source.`when`)
  toBinary(target, source.command)

proc toBinary*(source: LdtkCustomCommand): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkCustomCommand]; source: string; idx: var int): LdtkCustomCommand =
  result.`when` = fromBinary(typeof(result.`when`), source, idx)
  result.command = fromBinary(typeof(result.command), source, idx)

proc fromBinary*(_: typedesc[LdtkCustomCommand]; source: string): LdtkCustomCommand =
  var idx = 0
  return fromBinary(LdtkCustomCommand, source, idx)

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
  
proc equals(_: typedesc[LdtkTileCustomMetadata]; a, b: LdtkTileCustomMetadata): bool =
  equals(typeof(a.tileId), a.tileId, b.tileId) and
      equals(typeof(a.data), a.data, b.data)

proc `==`*(a, b: LdtkTileCustomMetadata): bool =
  return equals(LdtkTileCustomMetadata, a, b)

proc stringify(_: typedesc[LdtkTileCustomMetadata];
               value: LdtkTileCustomMetadata): string =
  stringifyObj("LdtkTileCustomMetadata",
               ("tileId", stringify(typeof(value.tileId), value.tileId)),
               ("data", stringify(typeof(value.data), value.data)))

proc `$`*(value: LdtkTileCustomMetadata): string =
  stringify(LdtkTileCustomMetadata, value)

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

proc toBinary*(target: var string; source: LdtkTileCustomMetadata) =
  toBinary(target, source.tileId)
  toBinary(target, source.data)

proc toBinary*(source: LdtkTileCustomMetadata): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkTileCustomMetadata]; source: string;
                idx: var int): LdtkTileCustomMetadata =
  result.tileId = fromBinary(typeof(result.tileId), source, idx)
  result.data = fromBinary(typeof(result.data), source, idx)

proc fromBinary*(_: typedesc[LdtkTileCustomMetadata]; source: string): LdtkTileCustomMetadata =
  var idx = 0
  return fromBinary(LdtkTileCustomMetadata, source, idx)

proc equals(_: typedesc[LdtkEnumTagValue]; a, b: LdtkEnumTagValue): bool =
  equals(typeof(a.tileIds), a.tileIds, b.tileIds) and
      equals(typeof(a.enumValueId), a.enumValueId, b.enumValueId)

proc `==`*(a, b: LdtkEnumTagValue): bool =
  return equals(LdtkEnumTagValue, a, b)

proc stringify(_: typedesc[LdtkEnumTagValue]; value: LdtkEnumTagValue): string =
  stringifyObj("LdtkEnumTagValue",
               ("tileIds", stringify(typeof(value.tileIds), value.tileIds)), (
      "enumValueId", stringify(typeof(value.enumValueId), value.enumValueId)))

proc `$`*(value: LdtkEnumTagValue): string =
  stringify(LdtkEnumTagValue, value)

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

proc toBinary*(target: var string; source: LdtkEnumTagValue) =
  toBinary(target, source.tileIds)
  toBinary(target, source.enumValueId)

proc toBinary*(source: LdtkEnumTagValue): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkEnumTagValue]; source: string; idx: var int): LdtkEnumTagValue =
  result.tileIds = fromBinary(typeof(result.tileIds), source, idx)
  result.enumValueId = fromBinary(typeof(result.enumValueId), source, idx)

proc fromBinary*(_: typedesc[LdtkEnumTagValue]; source: string): LdtkEnumTagValue =
  var idx = 0
  return fromBinary(LdtkEnumTagValue, source, idx)

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
  
proc equals(_: typedesc[LdtkTilesetDef]; a, b: LdtkTilesetDef): bool =
  equals(typeof(a.cachedPixelData), a.cachedPixelData, b.cachedPixelData) and
      equals(typeof(a.cHei), a.cHei, b.cHei) and
      equals(typeof(a.pxHei), a.pxHei, b.pxHei) and
      equals(typeof(a.customData), a.customData, b.customData) and
      equals(typeof(a.tagsSourceEnumUid), a.tagsSourceEnumUid,
             b.tagsSourceEnumUid) and
      equals(typeof(a.uid), a.uid, b.uid) and
      equals(typeof(a.padding), a.padding, b.padding) and
      equals(typeof(a.enumTags), a.enumTags, b.enumTags) and
      equals(typeof(a.pxWid), a.pxWid, b.pxWid) and
      equals(typeof(a.cWid), a.cWid, b.cWid) and
      equals(typeof(a.spacing), a.spacing, b.spacing) and
      equals(typeof(a.identifier), a.identifier, b.identifier) and
      equals(typeof(a.savedSelections), a.savedSelections, b.savedSelections) and
      equals(typeof(a.tags), a.tags, b.tags) and
      equals(typeof(a.embedAtlas), a.embedAtlas, b.embedAtlas) and
      equals(typeof(a.relPath), a.relPath, b.relPath) and
      equals(typeof(a.tileGridSize), a.tileGridSize, b.tileGridSize)

proc `==`*(a, b: LdtkTilesetDef): bool =
  return equals(LdtkTilesetDef, a, b)

proc stringify(_: typedesc[LdtkTilesetDef]; value: LdtkTilesetDef): string =
  stringifyObj("LdtkTilesetDef", ("cachedPixelData", stringify(
      typeof(value.cachedPixelData), value.cachedPixelData)),
               ("cHei", stringify(typeof(value.cHei), value.cHei)),
               ("pxHei", stringify(typeof(value.pxHei), value.pxHei)), (
      "customData", stringify(typeof(value.customData), value.customData)), (
      "tagsSourceEnumUid",
      stringify(typeof(value.tagsSourceEnumUid), value.tagsSourceEnumUid)),
               ("uid", stringify(typeof(value.uid), value.uid)),
               ("padding", stringify(typeof(value.padding), value.padding)), (
      "enumTags", stringify(typeof(value.enumTags), value.enumTags)),
               ("pxWid", stringify(typeof(value.pxWid), value.pxWid)),
               ("cWid", stringify(typeof(value.cWid), value.cWid)),
               ("spacing", stringify(typeof(value.spacing), value.spacing)), (
      "identifier", stringify(typeof(value.identifier), value.identifier)), (
      "savedSelections",
      stringify(typeof(value.savedSelections), value.savedSelections)),
               ("tags", stringify(typeof(value.tags), value.tags)), (
      "embedAtlas", stringify(typeof(value.embedAtlas), value.embedAtlas)),
               ("relPath", stringify(typeof(value.relPath), value.relPath)), (
      "tileGridSize", stringify(typeof(value.tileGridSize), value.tileGridSize)))

proc `$`*(value: LdtkTilesetDef): string =
  stringify(LdtkTilesetDef, value)

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

proc toBinary*(target: var string; source: LdtkTilesetDef) =
  toBinary(target, source.cachedPixelData)
  toBinary(target, source.cHei)
  toBinary(target, source.pxHei)
  toBinary(target, source.customData)
  toBinary(target, source.tagsSourceEnumUid)
  toBinary(target, source.uid)
  toBinary(target, source.padding)
  toBinary(target, source.enumTags)
  toBinary(target, source.pxWid)
  toBinary(target, source.cWid)
  toBinary(target, source.spacing)
  toBinary(target, source.identifier)
  toBinary(target, source.savedSelections)
  toBinary(target, source.tags)
  toBinary(target, source.embedAtlas)
  toBinary(target, source.relPath)
  toBinary(target, source.tileGridSize)

proc toBinary*(source: LdtkTilesetDef): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkTilesetDef]; source: string; idx: var int): LdtkTilesetDef =
  result.cachedPixelData = fromBinary(typeof(result.cachedPixelData), source,
                                      idx)
  result.cHei = fromBinary(typeof(result.cHei), source, idx)
  result.pxHei = fromBinary(typeof(result.pxHei), source, idx)
  result.customData = fromBinary(typeof(result.customData), source, idx)
  result.tagsSourceEnumUid = fromBinary(typeof(result.tagsSourceEnumUid),
                                        source, idx)
  result.uid = fromBinary(typeof(result.uid), source, idx)
  result.padding = fromBinary(typeof(result.padding), source, idx)
  result.enumTags = fromBinary(typeof(result.enumTags), source, idx)
  result.pxWid = fromBinary(typeof(result.pxWid), source, idx)
  result.cWid = fromBinary(typeof(result.cWid), source, idx)
  result.spacing = fromBinary(typeof(result.spacing), source, idx)
  result.identifier = fromBinary(typeof(result.identifier), source, idx)
  result.savedSelections = fromBinary(typeof(result.savedSelections), source,
                                      idx)
  result.tags = fromBinary(typeof(result.tags), source, idx)
  result.embedAtlas = fromBinary(typeof(result.embedAtlas), source, idx)
  result.relPath = fromBinary(typeof(result.relPath), source, idx)
  result.tileGridSize = fromBinary(typeof(result.tileGridSize), source, idx)

proc fromBinary*(_: typedesc[LdtkTilesetDef]; source: string): LdtkTilesetDef =
  var idx = 0
  return fromBinary(LdtkTilesetDef, source, idx)

proc equals(_: typedesc[LdtkIntGridValueGroupDef];
            a, b: LdtkIntGridValueGroupDef): bool =
  equals(typeof(a.color), a.color, b.color) and
      equals(typeof(a.uid), a.uid, b.uid) and
      equals(typeof(a.identifier), a.identifier, b.identifier)

proc `==`*(a, b: LdtkIntGridValueGroupDef): bool =
  return equals(LdtkIntGridValueGroupDef, a, b)

proc stringify(_: typedesc[LdtkIntGridValueGroupDef];
               value: LdtkIntGridValueGroupDef): string =
  stringifyObj("LdtkIntGridValueGroupDef",
               ("color", stringify(typeof(value.color), value.color)),
               ("uid", stringify(typeof(value.uid), value.uid)), ("identifier",
      stringify(typeof(value.identifier), value.identifier)))

proc `$`*(value: LdtkIntGridValueGroupDef): string =
  stringify(LdtkIntGridValueGroupDef, value)

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

proc toBinary*(target: var string; source: LdtkIntGridValueGroupDef) =
  toBinary(target, source.color)
  toBinary(target, source.uid)
  toBinary(target, source.identifier)

proc toBinary*(source: LdtkIntGridValueGroupDef): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkIntGridValueGroupDef]; source: string;
                idx: var int): LdtkIntGridValueGroupDef =
  result.color = fromBinary(typeof(result.color), source, idx)
  result.uid = fromBinary(typeof(result.uid), source, idx)
  result.identifier = fromBinary(typeof(result.identifier), source, idx)

proc fromBinary*(_: typedesc[LdtkIntGridValueGroupDef]; source: string): LdtkIntGridValueGroupDef =
  var idx = 0
  return fromBinary(LdtkIntGridValueGroupDef, source, idx)

proc equals(_: typedesc[LdtkIntGridValueDef]; a, b: LdtkIntGridValueDef): bool =
  equals(typeof(a.tile), a.tile, b.tile) and
      equals(typeof(a.color), a.color, b.color) and
      equals(typeof(a.identifier), a.identifier, b.identifier) and
      equals(typeof(a.value), a.value, b.value) and
      equals(typeof(a.groupUid), a.groupUid, b.groupUid)

proc `==`*(a, b: LdtkIntGridValueDef): bool =
  return equals(LdtkIntGridValueDef, a, b)

proc stringify(_: typedesc[LdtkIntGridValueDef]; value: LdtkIntGridValueDef): string =
  stringifyObj("LdtkIntGridValueDef",
               ("tile", stringify(typeof(value.tile), value.tile)),
               ("color", stringify(typeof(value.color), value.color)), (
      "identifier", stringify(typeof(value.identifier), value.identifier)),
               ("value", stringify(typeof(value.value), value.value)),
               ("groupUid", stringify(typeof(value.groupUid), value.groupUid)))

proc `$`*(value: LdtkIntGridValueDef): string =
  stringify(LdtkIntGridValueDef, value)

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

proc toBinary*(target: var string; source: LdtkIntGridValueDef) =
  toBinary(target, source.tile)
  toBinary(target, source.color)
  toBinary(target, source.identifier)
  toBinary(target, source.value)
  toBinary(target, source.groupUid)

proc toBinary*(source: LdtkIntGridValueDef): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkIntGridValueDef]; source: string; idx: var int): LdtkIntGridValueDef =
  result.tile = fromBinary(typeof(result.tile), source, idx)
  result.color = fromBinary(typeof(result.color), source, idx)
  result.identifier = fromBinary(typeof(result.identifier), source, idx)
  result.value = fromBinary(typeof(result.value), source, idx)
  result.groupUid = fromBinary(typeof(result.groupUid), source, idx)

proc fromBinary*(_: typedesc[LdtkIntGridValueDef]; source: string): LdtkIntGridValueDef =
  var idx = 0
  return fromBinary(LdtkIntGridValueDef, source, idx)

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
  
proc equals(_: typedesc[LdtkAutoRuleDef]; a, b: LdtkAutoRuleDef): bool =
  equals(typeof(a.flipX), a.flipX, b.flipX) and
      equals(typeof(a.pivotX), a.pivotX, b.pivotX) and
      equals(typeof(a.perlinActive), a.perlinActive, b.perlinActive) and
      equals(typeof(a.tileRectsIds), a.tileRectsIds, b.tileRectsIds) and
      equals(typeof(a.perlinScale), a.perlinScale, b.perlinScale) and
      equals(typeof(a.outOfBoundsValue), a.outOfBoundsValue, b.outOfBoundsValue) and
      equals(typeof(a.pattern), a.pattern, b.pattern) and
      equals(typeof(a.tileRandomXMin), a.tileRandomXMin, b.tileRandomXMin) and
      equals(typeof(a.checker), a.checker, b.checker) and
      equals(typeof(a.perlinOctaves), a.perlinOctaves, b.perlinOctaves) and
      equals(typeof(a.tileIds), a.tileIds, b.tileIds) and
      equals(typeof(a.alpha), a.alpha, b.alpha) and
      equals(typeof(a.tileXOffset), a.tileXOffset, b.tileXOffset) and
      equals(typeof(a.invalidated), a.invalidated, b.invalidated) and
      equals(typeof(a.xModulo), a.xModulo, b.xModulo) and
      equals(typeof(a.size), a.size, b.size) and
      equals(typeof(a.chance), a.chance, b.chance) and
      equals(typeof(a.breakOnMatch), a.breakOnMatch, b.breakOnMatch) and
      equals(typeof(a.tileYOffset), a.tileYOffset, b.tileYOffset) and
      equals(typeof(a.uid), a.uid, b.uid) and
      equals(typeof(a.perlinSeed), a.perlinSeed, b.perlinSeed) and
      equals(typeof(a.yOffset), a.yOffset, b.yOffset) and
      equals(typeof(a.tileRandomYMax), a.tileRandomYMax, b.tileRandomYMax) and
      equals(typeof(a.tileRandomYMin), a.tileRandomYMin, b.tileRandomYMin) and
      equals(typeof(a.tileMode), a.tileMode, b.tileMode) and
      equals(typeof(a.flipY), a.flipY, b.flipY) and
      equals(typeof(a.tileRandomXMax), a.tileRandomXMax, b.tileRandomXMax) and
      equals(typeof(a.pivotY), a.pivotY, b.pivotY) and
      equals(typeof(a.yModulo), a.yModulo, b.yModulo) and
      equals(typeof(a.active), a.active, b.active) and
      equals(typeof(a.xOffset), a.xOffset, b.xOffset)

proc `==`*(a, b: LdtkAutoRuleDef): bool =
  return equals(LdtkAutoRuleDef, a, b)

proc stringify(_: typedesc[LdtkAutoRuleDef]; value: LdtkAutoRuleDef): string =
  stringifyObj("LdtkAutoRuleDef",
               ("flipX", stringify(typeof(value.flipX), value.flipX)),
               ("pivotX", stringify(typeof(value.pivotX), value.pivotX)), (
      "perlinActive", stringify(typeof(value.perlinActive), value.perlinActive)), (
      "tileRectsIds", stringify(typeof(value.tileRectsIds), value.tileRectsIds)), (
      "perlinScale", stringify(typeof(value.perlinScale), value.perlinScale)), (
      "outOfBoundsValue",
      stringify(typeof(value.outOfBoundsValue), value.outOfBoundsValue)),
               ("pattern", stringify(typeof(value.pattern), value.pattern)), (
      "tileRandomXMin",
      stringify(typeof(value.tileRandomXMin), value.tileRandomXMin)),
               ("checker", stringify(typeof(value.checker), value.checker)), (
      "perlinOctaves",
      stringify(typeof(value.perlinOctaves), value.perlinOctaves)),
               ("tileIds", stringify(typeof(value.tileIds), value.tileIds)),
               ("alpha", stringify(typeof(value.alpha), value.alpha)), (
      "tileXOffset", stringify(typeof(value.tileXOffset), value.tileXOffset)), (
      "invalidated", stringify(typeof(value.invalidated), value.invalidated)),
               ("xModulo", stringify(typeof(value.xModulo), value.xModulo)),
               ("size", stringify(typeof(value.size), value.size)),
               ("chance", stringify(typeof(value.chance), value.chance)), (
      "breakOnMatch", stringify(typeof(value.breakOnMatch), value.breakOnMatch)), (
      "tileYOffset", stringify(typeof(value.tileYOffset), value.tileYOffset)),
               ("uid", stringify(typeof(value.uid), value.uid)), ("perlinSeed",
      stringify(typeof(value.perlinSeed), value.perlinSeed)),
               ("yOffset", stringify(typeof(value.yOffset), value.yOffset)), (
      "tileRandomYMax",
      stringify(typeof(value.tileRandomYMax), value.tileRandomYMax)), (
      "tileRandomYMin",
      stringify(typeof(value.tileRandomYMin), value.tileRandomYMin)), (
      "tileMode", stringify(typeof(value.tileMode), value.tileMode)),
               ("flipY", stringify(typeof(value.flipY), value.flipY)), (
      "tileRandomXMax",
      stringify(typeof(value.tileRandomXMax), value.tileRandomXMax)),
               ("pivotY", stringify(typeof(value.pivotY), value.pivotY)),
               ("yModulo", stringify(typeof(value.yModulo), value.yModulo)),
               ("active", stringify(typeof(value.active), value.active)),
               ("xOffset", stringify(typeof(value.xOffset), value.xOffset)))

proc `$`*(value: LdtkAutoRuleDef): string =
  stringify(LdtkAutoRuleDef, value)

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

proc toBinary*(target: var string; source: LdtkAutoRuleDef) =
  toBinary(target, source.flipX)
  toBinary(target, source.pivotX)
  toBinary(target, source.perlinActive)
  toBinary(target, source.tileRectsIds)
  toBinary(target, source.perlinScale)
  toBinary(target, source.outOfBoundsValue)
  toBinary(target, source.pattern)
  toBinary(target, source.tileRandomXMin)
  toBinary(target, source.checker)
  toBinary(target, source.perlinOctaves)
  toBinary(target, source.tileIds)
  toBinary(target, source.alpha)
  toBinary(target, source.tileXOffset)
  toBinary(target, source.invalidated)
  toBinary(target, source.xModulo)
  toBinary(target, source.size)
  toBinary(target, source.chance)
  toBinary(target, source.breakOnMatch)
  toBinary(target, source.tileYOffset)
  toBinary(target, source.uid)
  toBinary(target, source.perlinSeed)
  toBinary(target, source.yOffset)
  toBinary(target, source.tileRandomYMax)
  toBinary(target, source.tileRandomYMin)
  toBinary(target, source.tileMode)
  toBinary(target, source.flipY)
  toBinary(target, source.tileRandomXMax)
  toBinary(target, source.pivotY)
  toBinary(target, source.yModulo)
  toBinary(target, source.active)
  toBinary(target, source.xOffset)

proc toBinary*(source: LdtkAutoRuleDef): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkAutoRuleDef]; source: string; idx: var int): LdtkAutoRuleDef =
  result.flipX = fromBinary(typeof(result.flipX), source, idx)
  result.pivotX = fromBinary(typeof(result.pivotX), source, idx)
  result.perlinActive = fromBinary(typeof(result.perlinActive), source, idx)
  result.tileRectsIds = fromBinary(typeof(result.tileRectsIds), source, idx)
  result.perlinScale = fromBinary(typeof(result.perlinScale), source, idx)
  result.outOfBoundsValue = fromBinary(typeof(result.outOfBoundsValue), source,
                                       idx)
  result.pattern = fromBinary(typeof(result.pattern), source, idx)
  result.tileRandomXMin = fromBinary(typeof(result.tileRandomXMin), source, idx)
  result.checker = fromBinary(typeof(result.checker), source, idx)
  result.perlinOctaves = fromBinary(typeof(result.perlinOctaves), source, idx)
  result.tileIds = fromBinary(typeof(result.tileIds), source, idx)
  result.alpha = fromBinary(typeof(result.alpha), source, idx)
  result.tileXOffset = fromBinary(typeof(result.tileXOffset), source, idx)
  result.invalidated = fromBinary(typeof(result.invalidated), source, idx)
  result.xModulo = fromBinary(typeof(result.xModulo), source, idx)
  result.size = fromBinary(typeof(result.size), source, idx)
  result.chance = fromBinary(typeof(result.chance), source, idx)
  result.breakOnMatch = fromBinary(typeof(result.breakOnMatch), source, idx)
  result.tileYOffset = fromBinary(typeof(result.tileYOffset), source, idx)
  result.uid = fromBinary(typeof(result.uid), source, idx)
  result.perlinSeed = fromBinary(typeof(result.perlinSeed), source, idx)
  result.yOffset = fromBinary(typeof(result.yOffset), source, idx)
  result.tileRandomYMax = fromBinary(typeof(result.tileRandomYMax), source, idx)
  result.tileRandomYMin = fromBinary(typeof(result.tileRandomYMin), source, idx)
  result.tileMode = fromBinary(typeof(result.tileMode), source, idx)
  result.flipY = fromBinary(typeof(result.flipY), source, idx)
  result.tileRandomXMax = fromBinary(typeof(result.tileRandomXMax), source, idx)
  result.pivotY = fromBinary(typeof(result.pivotY), source, idx)
  result.yModulo = fromBinary(typeof(result.yModulo), source, idx)
  result.active = fromBinary(typeof(result.active), source, idx)
  result.xOffset = fromBinary(typeof(result.xOffset), source, idx)

proc fromBinary*(_: typedesc[LdtkAutoRuleDef]; source: string): LdtkAutoRuleDef =
  var idx = 0
  return fromBinary(LdtkAutoRuleDef, source, idx)

proc equals(_: typedesc[LdtkAutoLayerRuleGroup]; a, b: LdtkAutoLayerRuleGroup): bool =
  equals(typeof(a.name), a.name, b.name) and
      equals(typeof(a.collapsed), a.collapsed, b.collapsed) and
      equals(typeof(a.biomeRequirementMode), a.biomeRequirementMode,
             b.biomeRequirementMode) and
      equals(typeof(a.color), a.color, b.color) and
      equals(typeof(a.isOptional), a.isOptional, b.isOptional) and
      equals(typeof(a.icon), a.icon, b.icon) and
      equals(typeof(a.usesWizard), a.usesWizard, b.usesWizard) and
      equals(typeof(a.uid), a.uid, b.uid) and
      equals(typeof(a.requiredBiomeValues), a.requiredBiomeValues,
             b.requiredBiomeValues) and
      equals(typeof(a.active), a.active, b.active) and
      equals(typeof(a.rules), a.rules, b.rules)

proc `==`*(a, b: LdtkAutoLayerRuleGroup): bool =
  return equals(LdtkAutoLayerRuleGroup, a, b)

proc stringify(_: typedesc[LdtkAutoLayerRuleGroup];
               value: LdtkAutoLayerRuleGroup): string =
  stringifyObj("LdtkAutoLayerRuleGroup",
               ("name", stringify(typeof(value.name), value.name)), (
      "collapsed", stringify(typeof(value.collapsed), value.collapsed)), (
      "biomeRequirementMode",
      stringify(typeof(value.biomeRequirementMode), value.biomeRequirementMode)),
               ("color", stringify(typeof(value.color), value.color)), (
      "isOptional", stringify(typeof(value.isOptional), value.isOptional)),
               ("icon", stringify(typeof(value.icon), value.icon)), (
      "usesWizard", stringify(typeof(value.usesWizard), value.usesWizard)),
               ("uid", stringify(typeof(value.uid), value.uid)), (
      "requiredBiomeValues",
      stringify(typeof(value.requiredBiomeValues), value.requiredBiomeValues)),
               ("active", stringify(typeof(value.active), value.active)),
               ("rules", stringify(typeof(value.rules), value.rules)))

proc `$`*(value: LdtkAutoLayerRuleGroup): string =
  stringify(LdtkAutoLayerRuleGroup, value)

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

proc toBinary*(target: var string; source: LdtkAutoLayerRuleGroup) =
  toBinary(target, source.name)
  toBinary(target, source.collapsed)
  toBinary(target, source.biomeRequirementMode)
  toBinary(target, source.color)
  toBinary(target, source.isOptional)
  toBinary(target, source.icon)
  toBinary(target, source.usesWizard)
  toBinary(target, source.uid)
  toBinary(target, source.requiredBiomeValues)
  toBinary(target, source.active)
  toBinary(target, source.rules)

proc toBinary*(source: LdtkAutoLayerRuleGroup): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkAutoLayerRuleGroup]; source: string;
                idx: var int): LdtkAutoLayerRuleGroup =
  result.name = fromBinary(typeof(result.name), source, idx)
  result.collapsed = fromBinary(typeof(result.collapsed), source, idx)
  result.biomeRequirementMode = fromBinary(typeof(result.biomeRequirementMode),
      source, idx)
  result.color = fromBinary(typeof(result.color), source, idx)
  result.isOptional = fromBinary(typeof(result.isOptional), source, idx)
  result.icon = fromBinary(typeof(result.icon), source, idx)
  result.usesWizard = fromBinary(typeof(result.usesWizard), source, idx)
  result.uid = fromBinary(typeof(result.uid), source, idx)
  result.requiredBiomeValues = fromBinary(typeof(result.requiredBiomeValues),
      source, idx)
  result.active = fromBinary(typeof(result.active), source, idx)
  result.rules = fromBinary(typeof(result.rules), source, idx)

proc fromBinary*(_: typedesc[LdtkAutoLayerRuleGroup]; source: string): LdtkAutoLayerRuleGroup =
  var idx = 0
  return fromBinary(LdtkAutoLayerRuleGroup, source, idx)

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
  
proc equals(_: typedesc[LdtkLayerDef]; a, b: LdtkLayerDef): bool =
  equals(typeof(a.pxOffsetX), a.pxOffsetX, b.pxOffsetX) and
      equals(typeof(a.tilePivotX), a.tilePivotX, b.tilePivotX) and
      equals(typeof(a.uiFilterTags), a.uiFilterTags, b.uiFilterTags) and
      equals(typeof(a.displayOpacity), a.displayOpacity, b.displayOpacity) and
      equals(typeof(a.parallaxFactorY), a.parallaxFactorY, b.parallaxFactorY) and
      equals(typeof(a.hideInList), a.hideInList, b.hideInList) and
      equals(typeof(a.`type`), a.`type`, b.`type`) and
      equals(typeof(a.guideGridHei), a.guideGridHei, b.guideGridHei) and
      equals(typeof(a.uiColor), a.uiColor, b.uiColor) and
      equals(typeof(a.doc), a.doc, b.doc) and
      equals(typeof(a.tilesetDefUid), a.tilesetDefUid, b.tilesetDefUid) and
      equals(typeof(a.canSelectWhenInactive), a.canSelectWhenInactive,
             b.canSelectWhenInactive) and
      equals(typeof(a.useAsyncRender), a.useAsyncRender, b.useAsyncRender) and
      equals(typeof(a.autoSourceLayerDefUid), a.autoSourceLayerDefUid,
             b.autoSourceLayerDefUid) and
      equals(typeof(a.autoTilesetDefUid), a.autoTilesetDefUid,
             b.autoTilesetDefUid) and
      equals(typeof(a.parallaxScaling), a.parallaxScaling, b.parallaxScaling) and
      equals(typeof(a.renderInWorldView), a.renderInWorldView,
             b.renderInWorldView) and
      equals(typeof(a.intGridValuesGroups), a.intGridValuesGroups,
             b.intGridValuesGroups) and
      equals(typeof(a.inactiveOpacity), a.inactiveOpacity, b.inactiveOpacity) and
      equals(typeof(a.uid), a.uid, b.uid) and
      equals(typeof(a.excludedTags), a.excludedTags, b.excludedTags) and
      equals(typeof(a.hideFieldsWhenInactive), a.hideFieldsWhenInactive,
             b.hideFieldsWhenInactive) and
      equals(typeof(a.intGridValues), a.intGridValues, b.intGridValues) and
      equals(typeof(a.autoRuleGroups), a.autoRuleGroups, b.autoRuleGroups) and
      equals(typeof(a.type1), a.type1, b.type1) and
      equals(typeof(a.identifier), a.identifier, b.identifier) and
      equals(typeof(a.guideGridWid), a.guideGridWid, b.guideGridWid) and
      equals(typeof(a.requiredTags), a.requiredTags, b.requiredTags) and
      equals(typeof(a.pxOffsetY), a.pxOffsetY, b.pxOffsetY) and
      equals(typeof(a.tilePivotY), a.tilePivotY, b.tilePivotY) and
      equals(typeof(a.biomeFieldUid), a.biomeFieldUid, b.biomeFieldUid) and
      equals(typeof(a.gridSize), a.gridSize, b.gridSize) and
      equals(typeof(a.parallaxFactorX), a.parallaxFactorX, b.parallaxFactorX) and
      equals(typeof(a.autoTilesKilledByOtherLayerUid),
             a.autoTilesKilledByOtherLayerUid, b.autoTilesKilledByOtherLayerUid)

proc `==`*(a, b: LdtkLayerDef): bool =
  return equals(LdtkLayerDef, a, b)

proc stringify(_: typedesc[LdtkLayerDef]; value: LdtkLayerDef): string =
  stringifyObj("LdtkLayerDef", ("pxOffsetX", stringify(typeof(value.pxOffsetX),
      value.pxOffsetX)), ("tilePivotX",
                          stringify(typeof(value.tilePivotX), value.tilePivotX)), (
      "uiFilterTags", stringify(typeof(value.uiFilterTags), value.uiFilterTags)), (
      "displayOpacity",
      stringify(typeof(value.displayOpacity), value.displayOpacity)), (
      "parallaxFactorY",
      stringify(typeof(value.parallaxFactorY), value.parallaxFactorY)), (
      "hideInList", stringify(typeof(value.hideInList), value.hideInList)),
               ("type", stringify(typeof(value.`type`), value.`type`)), (
      "guideGridHei", stringify(typeof(value.guideGridHei), value.guideGridHei)),
               ("uiColor", stringify(typeof(value.uiColor), value.uiColor)),
               ("doc", stringify(typeof(value.doc), value.doc)), (
      "tilesetDefUid",
      stringify(typeof(value.tilesetDefUid), value.tilesetDefUid)), (
      "canSelectWhenInactive", stringify(typeof(value.canSelectWhenInactive),
      value.canSelectWhenInactive)), ("useAsyncRender", stringify(
      typeof(value.useAsyncRender), value.useAsyncRender)), (
      "autoSourceLayerDefUid", stringify(typeof(value.autoSourceLayerDefUid),
      value.autoSourceLayerDefUid)), ("autoTilesetDefUid", stringify(
      typeof(value.autoTilesetDefUid), value.autoTilesetDefUid)), (
      "parallaxScaling",
      stringify(typeof(value.parallaxScaling), value.parallaxScaling)), (
      "renderInWorldView",
      stringify(typeof(value.renderInWorldView), value.renderInWorldView)), (
      "intGridValuesGroups",
      stringify(typeof(value.intGridValuesGroups), value.intGridValuesGroups)), (
      "inactiveOpacity",
      stringify(typeof(value.inactiveOpacity), value.inactiveOpacity)),
               ("uid", stringify(typeof(value.uid), value.uid)), (
      "excludedTags", stringify(typeof(value.excludedTags), value.excludedTags)), (
      "hideFieldsWhenInactive", stringify(typeof(value.hideFieldsWhenInactive),
      value.hideFieldsWhenInactive)), ("intGridValues", stringify(
      typeof(value.intGridValues), value.intGridValues)), ("autoRuleGroups",
      stringify(typeof(value.autoRuleGroups), value.autoRuleGroups)),
               ("type1", stringify(typeof(value.type1), value.type1)), (
      "identifier", stringify(typeof(value.identifier), value.identifier)), (
      "guideGridWid", stringify(typeof(value.guideGridWid), value.guideGridWid)), (
      "requiredTags", stringify(typeof(value.requiredTags), value.requiredTags)), (
      "pxOffsetY", stringify(typeof(value.pxOffsetY), value.pxOffsetY)), (
      "tilePivotY", stringify(typeof(value.tilePivotY), value.tilePivotY)), (
      "biomeFieldUid",
      stringify(typeof(value.biomeFieldUid), value.biomeFieldUid)), ("gridSize",
      stringify(typeof(value.gridSize), value.gridSize)), ("parallaxFactorX",
      stringify(typeof(value.parallaxFactorX), value.parallaxFactorX)), (
      "autoTilesKilledByOtherLayerUid", stringify(
      typeof(value.autoTilesKilledByOtherLayerUid),
      value.autoTilesKilledByOtherLayerUid)))

proc `$`*(value: LdtkLayerDef): string =
  stringify(LdtkLayerDef, value)

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

proc toBinary*(target: var string; source: LdtkLayerDef) =
  toBinary(target, source.pxOffsetX)
  toBinary(target, source.tilePivotX)
  toBinary(target, source.uiFilterTags)
  toBinary(target, source.displayOpacity)
  toBinary(target, source.parallaxFactorY)
  toBinary(target, source.hideInList)
  toBinary(target, source.`type`)
  toBinary(target, source.guideGridHei)
  toBinary(target, source.uiColor)
  toBinary(target, source.doc)
  toBinary(target, source.tilesetDefUid)
  toBinary(target, source.canSelectWhenInactive)
  toBinary(target, source.useAsyncRender)
  toBinary(target, source.autoSourceLayerDefUid)
  toBinary(target, source.autoTilesetDefUid)
  toBinary(target, source.parallaxScaling)
  toBinary(target, source.renderInWorldView)
  toBinary(target, source.intGridValuesGroups)
  toBinary(target, source.inactiveOpacity)
  toBinary(target, source.uid)
  toBinary(target, source.excludedTags)
  toBinary(target, source.hideFieldsWhenInactive)
  toBinary(target, source.intGridValues)
  toBinary(target, source.autoRuleGroups)
  toBinary(target, source.type1)
  toBinary(target, source.identifier)
  toBinary(target, source.guideGridWid)
  toBinary(target, source.requiredTags)
  toBinary(target, source.pxOffsetY)
  toBinary(target, source.tilePivotY)
  toBinary(target, source.biomeFieldUid)
  toBinary(target, source.gridSize)
  toBinary(target, source.parallaxFactorX)
  toBinary(target, source.autoTilesKilledByOtherLayerUid)

proc toBinary*(source: LdtkLayerDef): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkLayerDef]; source: string; idx: var int): LdtkLayerDef =
  result.pxOffsetX = fromBinary(typeof(result.pxOffsetX), source, idx)
  result.tilePivotX = fromBinary(typeof(result.tilePivotX), source, idx)
  result.uiFilterTags = fromBinary(typeof(result.uiFilterTags), source, idx)
  result.displayOpacity = fromBinary(typeof(result.displayOpacity), source, idx)
  result.parallaxFactorY = fromBinary(typeof(result.parallaxFactorY), source,
                                      idx)
  result.hideInList = fromBinary(typeof(result.hideInList), source, idx)
  result.`type` = fromBinary(typeof(result.`type`), source, idx)
  result.guideGridHei = fromBinary(typeof(result.guideGridHei), source, idx)
  result.uiColor = fromBinary(typeof(result.uiColor), source, idx)
  result.doc = fromBinary(typeof(result.doc), source, idx)
  result.tilesetDefUid = fromBinary(typeof(result.tilesetDefUid), source, idx)
  result.canSelectWhenInactive = fromBinary(
      typeof(result.canSelectWhenInactive), source, idx)
  result.useAsyncRender = fromBinary(typeof(result.useAsyncRender), source, idx)
  result.autoSourceLayerDefUid = fromBinary(
      typeof(result.autoSourceLayerDefUid), source, idx)
  result.autoTilesetDefUid = fromBinary(typeof(result.autoTilesetDefUid),
                                        source, idx)
  result.parallaxScaling = fromBinary(typeof(result.parallaxScaling), source,
                                      idx)
  result.renderInWorldView = fromBinary(typeof(result.renderInWorldView),
                                        source, idx)
  result.intGridValuesGroups = fromBinary(typeof(result.intGridValuesGroups),
      source, idx)
  result.inactiveOpacity = fromBinary(typeof(result.inactiveOpacity), source,
                                      idx)
  result.uid = fromBinary(typeof(result.uid), source, idx)
  result.excludedTags = fromBinary(typeof(result.excludedTags), source, idx)
  result.hideFieldsWhenInactive = fromBinary(
      typeof(result.hideFieldsWhenInactive), source, idx)
  result.intGridValues = fromBinary(typeof(result.intGridValues), source, idx)
  result.autoRuleGroups = fromBinary(typeof(result.autoRuleGroups), source, idx)
  result.type1 = fromBinary(typeof(result.type1), source, idx)
  result.identifier = fromBinary(typeof(result.identifier), source, idx)
  result.guideGridWid = fromBinary(typeof(result.guideGridWid), source, idx)
  result.requiredTags = fromBinary(typeof(result.requiredTags), source, idx)
  result.pxOffsetY = fromBinary(typeof(result.pxOffsetY), source, idx)
  result.tilePivotY = fromBinary(typeof(result.tilePivotY), source, idx)
  result.biomeFieldUid = fromBinary(typeof(result.biomeFieldUid), source, idx)
  result.gridSize = fromBinary(typeof(result.gridSize), source, idx)
  result.parallaxFactorX = fromBinary(typeof(result.parallaxFactorX), source,
                                      idx)
  result.autoTilesKilledByOtherLayerUid = fromBinary(
      typeof(result.autoTilesKilledByOtherLayerUid), source, idx)

proc fromBinary*(_: typedesc[LdtkLayerDef]; source: string): LdtkLayerDef =
  var idx = 0
  return fromBinary(LdtkLayerDef, source, idx)

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
  
proc equals(_: typedesc[LdtkFieldDef]; a, b: LdtkFieldDef): bool =
  equals(typeof(a.acceptFileTypes), a.acceptFileTypes, b.acceptFileTypes) and
      equals(typeof(a.editorDisplayScale), a.editorDisplayScale,
             b.editorDisplayScale) and
      equals(typeof(a.searchable), a.searchable, b.searchable) and
      equals(typeof(a.useForSmartColor), a.useForSmartColor, b.useForSmartColor) and
      equals(typeof(a.editorShowInWorld), a.editorShowInWorld,
             b.editorShowInWorld) and
      equals(typeof(a.allowedRefs), a.allowedRefs, b.allowedRefs) and
      equals(typeof(a.editorAlwaysShow), a.editorAlwaysShow, b.editorAlwaysShow) and
      equals(typeof(a.arrayMinLength), a.arrayMinLength, b.arrayMinLength) and
      equals(typeof(a.editorTextSuffix), a.editorTextSuffix, b.editorTextSuffix) and
      equals(typeof(a.min), a.min, b.min) and
      equals(typeof(a.`type`), a.`type`, b.`type`) and
      equals(typeof(a.editorDisplayMode), a.editorDisplayMode,
             b.editorDisplayMode) and
      equals(typeof(a.editorDisplayColor), a.editorDisplayColor,
             b.editorDisplayColor) and
      equals(typeof(a.canBeNull), a.canBeNull, b.canBeNull) and
      equals(typeof(a.autoChainRef), a.autoChainRef, b.autoChainRef) and
      equals(typeof(a.doc), a.doc, b.doc) and
      equals(typeof(a.allowedRefsEntityUid), a.allowedRefsEntityUid,
             b.allowedRefsEntityUid) and
      equals(typeof(a.tilesetUid), a.tilesetUid, b.tilesetUid) and
      equals(typeof(a.allowedRefTags), a.allowedRefTags, b.allowedRefTags) and
      equals(typeof(a.symmetricalRef), a.symmetricalRef, b.symmetricalRef) and
      equals(typeof(a.uid), a.uid, b.uid) and
      equals(typeof(a.editorTextPrefix), a.editorTextPrefix, b.editorTextPrefix) and
      equals(typeof(a.isArray), a.isArray, b.isArray) and
      equals(typeof(a.exportToToc), a.exportToToc, b.exportToToc) and
      equals(typeof(a.editorDisplayPos), a.editorDisplayPos, b.editorDisplayPos) and
      equals(typeof(a.textLanguageMode), a.textLanguageMode, b.textLanguageMode) and
      equals(typeof(a.max), a.max, b.max) and
      equals(typeof(a.allowOutOfLevelRef), a.allowOutOfLevelRef,
             b.allowOutOfLevelRef) and
      equals(typeof(a.editorCutLongValues), a.editorCutLongValues,
             b.editorCutLongValues) and
      equals(typeof(a.defaultOverride), a.defaultOverride, b.defaultOverride) and
      equals(typeof(a.editorLinkStyle), a.editorLinkStyle, b.editorLinkStyle) and
      equals(typeof(a.regex), a.regex, b.regex) and
      equals(typeof(a.type1), a.type1, b.type1) and
      equals(typeof(a.identifier), a.identifier, b.identifier) and
      equals(typeof(a.arrayMaxLength), a.arrayMaxLength, b.arrayMaxLength)

proc `==`*(a, b: LdtkFieldDef): bool =
  return equals(LdtkFieldDef, a, b)

proc stringify(_: typedesc[LdtkFieldDef]; value: LdtkFieldDef): string =
  stringifyObj("LdtkFieldDef", ("acceptFileTypes", stringify(
      typeof(value.acceptFileTypes), value.acceptFileTypes)), (
      "editorDisplayScale",
      stringify(typeof(value.editorDisplayScale), value.editorDisplayScale)), (
      "searchable", stringify(typeof(value.searchable), value.searchable)), (
      "useForSmartColor",
      stringify(typeof(value.useForSmartColor), value.useForSmartColor)), (
      "editorShowInWorld",
      stringify(typeof(value.editorShowInWorld), value.editorShowInWorld)), (
      "allowedRefs", stringify(typeof(value.allowedRefs), value.allowedRefs)), (
      "editorAlwaysShow",
      stringify(typeof(value.editorAlwaysShow), value.editorAlwaysShow)), (
      "arrayMinLength",
      stringify(typeof(value.arrayMinLength), value.arrayMinLength)), (
      "editorTextSuffix",
      stringify(typeof(value.editorTextSuffix), value.editorTextSuffix)),
               ("min", stringify(typeof(value.min), value.min)),
               ("type", stringify(typeof(value.`type`), value.`type`)), (
      "editorDisplayMode",
      stringify(typeof(value.editorDisplayMode), value.editorDisplayMode)), (
      "editorDisplayColor",
      stringify(typeof(value.editorDisplayColor), value.editorDisplayColor)), (
      "canBeNull", stringify(typeof(value.canBeNull), value.canBeNull)), (
      "autoChainRef", stringify(typeof(value.autoChainRef), value.autoChainRef)),
               ("doc", stringify(typeof(value.doc), value.doc)), (
      "allowedRefsEntityUid",
      stringify(typeof(value.allowedRefsEntityUid), value.allowedRefsEntityUid)), (
      "tilesetUid", stringify(typeof(value.tilesetUid), value.tilesetUid)), (
      "allowedRefTags",
      stringify(typeof(value.allowedRefTags), value.allowedRefTags)), (
      "symmetricalRef",
      stringify(typeof(value.symmetricalRef), value.symmetricalRef)),
               ("uid", stringify(typeof(value.uid), value.uid)), (
      "editorTextPrefix",
      stringify(typeof(value.editorTextPrefix), value.editorTextPrefix)),
               ("isArray", stringify(typeof(value.isArray), value.isArray)), (
      "exportToToc", stringify(typeof(value.exportToToc), value.exportToToc)), (
      "editorDisplayPos",
      stringify(typeof(value.editorDisplayPos), value.editorDisplayPos)), (
      "textLanguageMode",
      stringify(typeof(value.textLanguageMode), value.textLanguageMode)),
               ("max", stringify(typeof(value.max), value.max)), (
      "allowOutOfLevelRef",
      stringify(typeof(value.allowOutOfLevelRef), value.allowOutOfLevelRef)), (
      "editorCutLongValues",
      stringify(typeof(value.editorCutLongValues), value.editorCutLongValues)), (
      "defaultOverride",
      stringify(typeof(value.defaultOverride), value.defaultOverride)), (
      "editorLinkStyle",
      stringify(typeof(value.editorLinkStyle), value.editorLinkStyle)),
               ("regex", stringify(typeof(value.regex), value.regex)),
               ("type1", stringify(typeof(value.type1), value.type1)), (
      "identifier", stringify(typeof(value.identifier), value.identifier)), (
      "arrayMaxLength",
      stringify(typeof(value.arrayMaxLength), value.arrayMaxLength)))

proc `$`*(value: LdtkFieldDef): string =
  stringify(LdtkFieldDef, value)

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

proc toBinary*(target: var string; source: LdtkFieldDef) =
  toBinary(target, source.acceptFileTypes)
  toBinary(target, source.editorDisplayScale)
  toBinary(target, source.searchable)
  toBinary(target, source.useForSmartColor)
  toBinary(target, source.editorShowInWorld)
  toBinary(target, source.allowedRefs)
  toBinary(target, source.editorAlwaysShow)
  toBinary(target, source.arrayMinLength)
  toBinary(target, source.editorTextSuffix)
  toBinary(target, source.min)
  toBinary(target, source.`type`)
  toBinary(target, source.editorDisplayMode)
  toBinary(target, source.editorDisplayColor)
  toBinary(target, source.canBeNull)
  toBinary(target, source.autoChainRef)
  toBinary(target, source.doc)
  toBinary(target, source.allowedRefsEntityUid)
  toBinary(target, source.tilesetUid)
  toBinary(target, source.allowedRefTags)
  toBinary(target, source.symmetricalRef)
  toBinary(target, source.uid)
  toBinary(target, source.editorTextPrefix)
  toBinary(target, source.isArray)
  toBinary(target, source.exportToToc)
  toBinary(target, source.editorDisplayPos)
  toBinary(target, source.textLanguageMode)
  toBinary(target, source.max)
  toBinary(target, source.allowOutOfLevelRef)
  toBinary(target, source.editorCutLongValues)
  toBinary(target, source.defaultOverride)
  toBinary(target, source.editorLinkStyle)
  toBinary(target, source.regex)
  toBinary(target, source.type1)
  toBinary(target, source.identifier)
  toBinary(target, source.arrayMaxLength)

proc toBinary*(source: LdtkFieldDef): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkFieldDef]; source: string; idx: var int): LdtkFieldDef =
  result.acceptFileTypes = fromBinary(typeof(result.acceptFileTypes), source,
                                      idx)
  result.editorDisplayScale = fromBinary(typeof(result.editorDisplayScale),
      source, idx)
  result.searchable = fromBinary(typeof(result.searchable), source, idx)
  result.useForSmartColor = fromBinary(typeof(result.useForSmartColor), source,
                                       idx)
  result.editorShowInWorld = fromBinary(typeof(result.editorShowInWorld),
                                        source, idx)
  result.allowedRefs = fromBinary(typeof(result.allowedRefs), source, idx)
  result.editorAlwaysShow = fromBinary(typeof(result.editorAlwaysShow), source,
                                       idx)
  result.arrayMinLength = fromBinary(typeof(result.arrayMinLength), source, idx)
  result.editorTextSuffix = fromBinary(typeof(result.editorTextSuffix), source,
                                       idx)
  result.min = fromBinary(typeof(result.min), source, idx)
  result.`type` = fromBinary(typeof(result.`type`), source, idx)
  result.editorDisplayMode = fromBinary(typeof(result.editorDisplayMode),
                                        source, idx)
  result.editorDisplayColor = fromBinary(typeof(result.editorDisplayColor),
      source, idx)
  result.canBeNull = fromBinary(typeof(result.canBeNull), source, idx)
  result.autoChainRef = fromBinary(typeof(result.autoChainRef), source, idx)
  result.doc = fromBinary(typeof(result.doc), source, idx)
  result.allowedRefsEntityUid = fromBinary(typeof(result.allowedRefsEntityUid),
      source, idx)
  result.tilesetUid = fromBinary(typeof(result.tilesetUid), source, idx)
  result.allowedRefTags = fromBinary(typeof(result.allowedRefTags), source, idx)
  result.symmetricalRef = fromBinary(typeof(result.symmetricalRef), source, idx)
  result.uid = fromBinary(typeof(result.uid), source, idx)
  result.editorTextPrefix = fromBinary(typeof(result.editorTextPrefix), source,
                                       idx)
  result.isArray = fromBinary(typeof(result.isArray), source, idx)
  result.exportToToc = fromBinary(typeof(result.exportToToc), source, idx)
  result.editorDisplayPos = fromBinary(typeof(result.editorDisplayPos), source,
                                       idx)
  result.textLanguageMode = fromBinary(typeof(result.textLanguageMode), source,
                                       idx)
  result.max = fromBinary(typeof(result.max), source, idx)
  result.allowOutOfLevelRef = fromBinary(typeof(result.allowOutOfLevelRef),
      source, idx)
  result.editorCutLongValues = fromBinary(typeof(result.editorCutLongValues),
      source, idx)
  result.defaultOverride = fromBinary(typeof(result.defaultOverride), source,
                                      idx)
  result.editorLinkStyle = fromBinary(typeof(result.editorLinkStyle), source,
                                      idx)
  result.regex = fromBinary(typeof(result.regex), source, idx)
  result.type1 = fromBinary(typeof(result.type1), source, idx)
  result.identifier = fromBinary(typeof(result.identifier), source, idx)
  result.arrayMaxLength = fromBinary(typeof(result.arrayMaxLength), source, idx)

proc fromBinary*(_: typedesc[LdtkFieldDef]; source: string): LdtkFieldDef =
  var idx = 0
  return fromBinary(LdtkFieldDef, source, idx)

proc equals(_: typedesc[LdtkEnumDefValues]; a, b: LdtkEnumDefValues): bool =
  equals(typeof(a.tileId), a.tileId, b.tileId) and
      equals(typeof(a.color), a.color, b.color) and
      equals(typeof(a.tileRect), a.tileRect, b.tileRect) and
      equals(typeof(a.id), a.id, b.id) and
      equals(typeof(a.tileSrcRect), a.tileSrcRect, b.tileSrcRect)

proc `==`*(a, b: LdtkEnumDefValues): bool =
  return equals(LdtkEnumDefValues, a, b)

proc stringify(_: typedesc[LdtkEnumDefValues]; value: LdtkEnumDefValues): string =
  stringifyObj("LdtkEnumDefValues",
               ("tileId", stringify(typeof(value.tileId), value.tileId)),
               ("color", stringify(typeof(value.color), value.color)), (
      "tileRect", stringify(typeof(value.tileRect), value.tileRect)),
               ("id", stringify(typeof(value.id), value.id)), ("tileSrcRect",
      stringify(typeof(value.tileSrcRect), value.tileSrcRect)))

proc `$`*(value: LdtkEnumDefValues): string =
  stringify(LdtkEnumDefValues, value)

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

proc toBinary*(target: var string; source: LdtkEnumDefValues) =
  toBinary(target, source.tileId)
  toBinary(target, source.color)
  toBinary(target, source.tileRect)
  toBinary(target, source.id)
  toBinary(target, source.tileSrcRect)

proc toBinary*(source: LdtkEnumDefValues): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkEnumDefValues]; source: string; idx: var int): LdtkEnumDefValues =
  result.tileId = fromBinary(typeof(result.tileId), source, idx)
  result.color = fromBinary(typeof(result.color), source, idx)
  result.tileRect = fromBinary(typeof(result.tileRect), source, idx)
  result.id = fromBinary(typeof(result.id), source, idx)
  result.tileSrcRect = fromBinary(typeof(result.tileSrcRect), source, idx)

proc fromBinary*(_: typedesc[LdtkEnumDefValues]; source: string): LdtkEnumDefValues =
  var idx = 0
  return fromBinary(LdtkEnumDefValues, source, idx)

proc equals(_: typedesc[LdtkEnumDef]; a, b: LdtkEnumDef): bool =
  equals(typeof(a.externalFileChecksum), a.externalFileChecksum,
         b.externalFileChecksum) and
      equals(typeof(a.externalRelPath), a.externalRelPath, b.externalRelPath) and
      equals(typeof(a.uid), a.uid, b.uid) and
      equals(typeof(a.values), a.values, b.values) and
      equals(typeof(a.iconTilesetUid), a.iconTilesetUid, b.iconTilesetUid) and
      equals(typeof(a.identifier), a.identifier, b.identifier) and
      equals(typeof(a.tags), a.tags, b.tags)

proc `==`*(a, b: LdtkEnumDef): bool =
  return equals(LdtkEnumDef, a, b)

proc stringify(_: typedesc[LdtkEnumDef]; value: LdtkEnumDef): string =
  stringifyObj("LdtkEnumDef", ("externalFileChecksum", stringify(
      typeof(value.externalFileChecksum), value.externalFileChecksum)), (
      "externalRelPath",
      stringify(typeof(value.externalRelPath), value.externalRelPath)),
               ("uid", stringify(typeof(value.uid), value.uid)),
               ("values", stringify(typeof(value.values), value.values)), (
      "iconTilesetUid",
      stringify(typeof(value.iconTilesetUid), value.iconTilesetUid)), (
      "identifier", stringify(typeof(value.identifier), value.identifier)),
               ("tags", stringify(typeof(value.tags), value.tags)))

proc `$`*(value: LdtkEnumDef): string =
  stringify(LdtkEnumDef, value)

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

proc toBinary*(target: var string; source: LdtkEnumDef) =
  toBinary(target, source.externalFileChecksum)
  toBinary(target, source.externalRelPath)
  toBinary(target, source.uid)
  toBinary(target, source.values)
  toBinary(target, source.iconTilesetUid)
  toBinary(target, source.identifier)
  toBinary(target, source.tags)

proc toBinary*(source: LdtkEnumDef): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkEnumDef]; source: string; idx: var int): LdtkEnumDef =
  result.externalFileChecksum = fromBinary(typeof(result.externalFileChecksum),
      source, idx)
  result.externalRelPath = fromBinary(typeof(result.externalRelPath), source,
                                      idx)
  result.uid = fromBinary(typeof(result.uid), source, idx)
  result.values = fromBinary(typeof(result.values), source, idx)
  result.iconTilesetUid = fromBinary(typeof(result.iconTilesetUid), source, idx)
  result.identifier = fromBinary(typeof(result.identifier), source, idx)
  result.tags = fromBinary(typeof(result.tags), source, idx)

proc fromBinary*(_: typedesc[LdtkEnumDef]; source: string): LdtkEnumDef =
  var idx = 0
  return fromBinary(LdtkEnumDef, source, idx)

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
  
proc equals(_: typedesc[LdtkEntityDef]; a, b: LdtkEntityDef): bool =
  equals(typeof(a.tileId), a.tileId, b.tileId) and
      equals(typeof(a.showName), a.showName, b.showName) and
      equals(typeof(a.tilesetId), a.tilesetId, b.tilesetId) and
      equals(typeof(a.maxHeight), a.maxHeight, b.maxHeight) and
      equals(typeof(a.limitScope), a.limitScope, b.limitScope) and
      equals(typeof(a.pivotX), a.pivotX, b.pivotX) and
      equals(typeof(a.maxCount), a.maxCount, b.maxCount) and
      equals(typeof(a.allowOutOfBounds), a.allowOutOfBounds, b.allowOutOfBounds) and
      equals(typeof(a.hollow), a.hollow, b.hollow) and
      equals(typeof(a.minHeight), a.minHeight, b.minHeight) and
      equals(typeof(a.keepAspectRatio), a.keepAspectRatio, b.keepAspectRatio) and
      equals(typeof(a.color), a.color, b.color) and
      equals(typeof(a.minWidth), a.minWidth, b.minWidth) and
      equals(typeof(a.tileRect), a.tileRect, b.tileRect) and
      equals(typeof(a.doc), a.doc, b.doc) and
      equals(typeof(a.fieldDefs), a.fieldDefs, b.fieldDefs) and
      equals(typeof(a.tileRenderMode), a.tileRenderMode, b.tileRenderMode) and
      equals(typeof(a.limitBehavior), a.limitBehavior, b.limitBehavior) and
      equals(typeof(a.tileOpacity), a.tileOpacity, b.tileOpacity) and
      equals(typeof(a.nineSliceBorders), a.nineSliceBorders, b.nineSliceBorders) and
      equals(typeof(a.resizableX), a.resizableX, b.resizableX) and
      equals(typeof(a.uiTileRect), a.uiTileRect, b.uiTileRect) and
      equals(typeof(a.uid), a.uid, b.uid) and
      equals(typeof(a.lineOpacity), a.lineOpacity, b.lineOpacity) and
      equals(typeof(a.maxWidth), a.maxWidth, b.maxWidth) and
      equals(typeof(a.resizableY), a.resizableY, b.resizableY) and
      equals(typeof(a.exportToToc), a.exportToToc, b.exportToToc) and
      equals(typeof(a.fillOpacity), a.fillOpacity, b.fillOpacity) and
      equals(typeof(a.height), a.height, b.height) and
      equals(typeof(a.identifier), a.identifier, b.identifier) and
      equals(typeof(a.pivotY), a.pivotY, b.pivotY) and
      equals(typeof(a.renderMode), a.renderMode, b.renderMode) and
      equals(typeof(a.tags), a.tags, b.tags) and
      equals(typeof(a.width), a.width, b.width)

proc `==`*(a, b: LdtkEntityDef): bool =
  return equals(LdtkEntityDef, a, b)

proc stringify(_: typedesc[LdtkEntityDef]; value: LdtkEntityDef): string =
  stringifyObj("LdtkEntityDef",
               ("tileId", stringify(typeof(value.tileId), value.tileId)), (
      "showName", stringify(typeof(value.showName), value.showName)), (
      "tilesetId", stringify(typeof(value.tilesetId), value.tilesetId)), (
      "maxHeight", stringify(typeof(value.maxHeight), value.maxHeight)), (
      "limitScope", stringify(typeof(value.limitScope), value.limitScope)),
               ("pivotX", stringify(typeof(value.pivotX), value.pivotX)), (
      "maxCount", stringify(typeof(value.maxCount), value.maxCount)), (
      "allowOutOfBounds",
      stringify(typeof(value.allowOutOfBounds), value.allowOutOfBounds)),
               ("hollow", stringify(typeof(value.hollow), value.hollow)), (
      "minHeight", stringify(typeof(value.minHeight), value.minHeight)), (
      "keepAspectRatio",
      stringify(typeof(value.keepAspectRatio), value.keepAspectRatio)),
               ("color", stringify(typeof(value.color), value.color)), (
      "minWidth", stringify(typeof(value.minWidth), value.minWidth)), (
      "tileRect", stringify(typeof(value.tileRect), value.tileRect)),
               ("doc", stringify(typeof(value.doc), value.doc)), ("fieldDefs",
      stringify(typeof(value.fieldDefs), value.fieldDefs)), ("tileRenderMode",
      stringify(typeof(value.tileRenderMode), value.tileRenderMode)), (
      "limitBehavior",
      stringify(typeof(value.limitBehavior), value.limitBehavior)), (
      "tileOpacity", stringify(typeof(value.tileOpacity), value.tileOpacity)), (
      "nineSliceBorders",
      stringify(typeof(value.nineSliceBorders), value.nineSliceBorders)), (
      "resizableX", stringify(typeof(value.resizableX), value.resizableX)), (
      "uiTileRect", stringify(typeof(value.uiTileRect), value.uiTileRect)),
               ("uid", stringify(typeof(value.uid), value.uid)), ("lineOpacity",
      stringify(typeof(value.lineOpacity), value.lineOpacity)), ("maxWidth",
      stringify(typeof(value.maxWidth), value.maxWidth)), ("resizableY",
      stringify(typeof(value.resizableY), value.resizableY)), ("exportToToc",
      stringify(typeof(value.exportToToc), value.exportToToc)), ("fillOpacity",
      stringify(typeof(value.fillOpacity), value.fillOpacity)),
               ("height", stringify(typeof(value.height), value.height)), (
      "identifier", stringify(typeof(value.identifier), value.identifier)),
               ("pivotY", stringify(typeof(value.pivotY), value.pivotY)), (
      "renderMode", stringify(typeof(value.renderMode), value.renderMode)),
               ("tags", stringify(typeof(value.tags), value.tags)),
               ("width", stringify(typeof(value.width), value.width)))

proc `$`*(value: LdtkEntityDef): string =
  stringify(LdtkEntityDef, value)

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

proc toBinary*(target: var string; source: LdtkEntityDef) =
  toBinary(target, source.tileId)
  toBinary(target, source.showName)
  toBinary(target, source.tilesetId)
  toBinary(target, source.maxHeight)
  toBinary(target, source.limitScope)
  toBinary(target, source.pivotX)
  toBinary(target, source.maxCount)
  toBinary(target, source.allowOutOfBounds)
  toBinary(target, source.hollow)
  toBinary(target, source.minHeight)
  toBinary(target, source.keepAspectRatio)
  toBinary(target, source.color)
  toBinary(target, source.minWidth)
  toBinary(target, source.tileRect)
  toBinary(target, source.doc)
  toBinary(target, source.fieldDefs)
  toBinary(target, source.tileRenderMode)
  toBinary(target, source.limitBehavior)
  toBinary(target, source.tileOpacity)
  toBinary(target, source.nineSliceBorders)
  toBinary(target, source.resizableX)
  toBinary(target, source.uiTileRect)
  toBinary(target, source.uid)
  toBinary(target, source.lineOpacity)
  toBinary(target, source.maxWidth)
  toBinary(target, source.resizableY)
  toBinary(target, source.exportToToc)
  toBinary(target, source.fillOpacity)
  toBinary(target, source.height)
  toBinary(target, source.identifier)
  toBinary(target, source.pivotY)
  toBinary(target, source.renderMode)
  toBinary(target, source.tags)
  toBinary(target, source.width)

proc toBinary*(source: LdtkEntityDef): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkEntityDef]; source: string; idx: var int): LdtkEntityDef =
  result.tileId = fromBinary(typeof(result.tileId), source, idx)
  result.showName = fromBinary(typeof(result.showName), source, idx)
  result.tilesetId = fromBinary(typeof(result.tilesetId), source, idx)
  result.maxHeight = fromBinary(typeof(result.maxHeight), source, idx)
  result.limitScope = fromBinary(typeof(result.limitScope), source, idx)
  result.pivotX = fromBinary(typeof(result.pivotX), source, idx)
  result.maxCount = fromBinary(typeof(result.maxCount), source, idx)
  result.allowOutOfBounds = fromBinary(typeof(result.allowOutOfBounds), source,
                                       idx)
  result.hollow = fromBinary(typeof(result.hollow), source, idx)
  result.minHeight = fromBinary(typeof(result.minHeight), source, idx)
  result.keepAspectRatio = fromBinary(typeof(result.keepAspectRatio), source,
                                      idx)
  result.color = fromBinary(typeof(result.color), source, idx)
  result.minWidth = fromBinary(typeof(result.minWidth), source, idx)
  result.tileRect = fromBinary(typeof(result.tileRect), source, idx)
  result.doc = fromBinary(typeof(result.doc), source, idx)
  result.fieldDefs = fromBinary(typeof(result.fieldDefs), source, idx)
  result.tileRenderMode = fromBinary(typeof(result.tileRenderMode), source, idx)
  result.limitBehavior = fromBinary(typeof(result.limitBehavior), source, idx)
  result.tileOpacity = fromBinary(typeof(result.tileOpacity), source, idx)
  result.nineSliceBorders = fromBinary(typeof(result.nineSliceBorders), source,
                                       idx)
  result.resizableX = fromBinary(typeof(result.resizableX), source, idx)
  result.uiTileRect = fromBinary(typeof(result.uiTileRect), source, idx)
  result.uid = fromBinary(typeof(result.uid), source, idx)
  result.lineOpacity = fromBinary(typeof(result.lineOpacity), source, idx)
  result.maxWidth = fromBinary(typeof(result.maxWidth), source, idx)
  result.resizableY = fromBinary(typeof(result.resizableY), source, idx)
  result.exportToToc = fromBinary(typeof(result.exportToToc), source, idx)
  result.fillOpacity = fromBinary(typeof(result.fillOpacity), source, idx)
  result.height = fromBinary(typeof(result.height), source, idx)
  result.identifier = fromBinary(typeof(result.identifier), source, idx)
  result.pivotY = fromBinary(typeof(result.pivotY), source, idx)
  result.renderMode = fromBinary(typeof(result.renderMode), source, idx)
  result.tags = fromBinary(typeof(result.tags), source, idx)
  result.width = fromBinary(typeof(result.width), source, idx)

proc fromBinary*(_: typedesc[LdtkEntityDef]; source: string): LdtkEntityDef =
  var idx = 0
  return fromBinary(LdtkEntityDef, source, idx)

proc equals(_: typedesc[LdtkDefinitions]; a, b: LdtkDefinitions): bool =
  equals(typeof(a.tilesets), a.tilesets, b.tilesets) and
      equals(typeof(a.layers), a.layers, b.layers) and
      equals(typeof(a.levelFields), a.levelFields, b.levelFields) and
      equals(typeof(a.enums), a.enums, b.enums) and
      equals(typeof(a.entities), a.entities, b.entities) and
      equals(typeof(a.externalEnums), a.externalEnums, b.externalEnums)

proc `==`*(a, b: LdtkDefinitions): bool =
  return equals(LdtkDefinitions, a, b)

proc stringify(_: typedesc[LdtkDefinitions]; value: LdtkDefinitions): string =
  stringifyObj("LdtkDefinitions", ("tilesets", stringify(typeof(value.tilesets),
      value.tilesets)),
               ("layers", stringify(typeof(value.layers), value.layers)), (
      "levelFields", stringify(typeof(value.levelFields), value.levelFields)),
               ("enums", stringify(typeof(value.enums), value.enums)), (
      "entities", stringify(typeof(value.entities), value.entities)), (
      "externalEnums",
      stringify(typeof(value.externalEnums), value.externalEnums)))

proc `$`*(value: LdtkDefinitions): string =
  stringify(LdtkDefinitions, value)

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

proc toBinary*(target: var string; source: LdtkDefinitions) =
  toBinary(target, source.tilesets)
  toBinary(target, source.layers)
  toBinary(target, source.levelFields)
  toBinary(target, source.enums)
  toBinary(target, source.entities)
  toBinary(target, source.externalEnums)

proc toBinary*(source: LdtkDefinitions): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkDefinitions]; source: string; idx: var int): LdtkDefinitions =
  result.tilesets = fromBinary(typeof(result.tilesets), source, idx)
  result.layers = fromBinary(typeof(result.layers), source, idx)
  result.levelFields = fromBinary(typeof(result.levelFields), source, idx)
  result.enums = fromBinary(typeof(result.enums), source, idx)
  result.entities = fromBinary(typeof(result.entities), source, idx)
  result.externalEnums = fromBinary(typeof(result.externalEnums), source, idx)

proc fromBinary*(_: typedesc[LdtkDefinitions]; source: string): LdtkDefinitions =
  var idx = 0
  return fromBinary(LdtkDefinitions, source, idx)

proc equals(_: typedesc[LdtkGridPoint]; a, b: LdtkGridPoint): bool =
  equals(typeof(a.cy), a.cy, b.cy) and equals(typeof(a.cx), a.cx, b.cx)

proc `==`*(a, b: LdtkGridPoint): bool =
  return equals(LdtkGridPoint, a, b)

proc stringify(_: typedesc[LdtkGridPoint]; value: LdtkGridPoint): string =
  stringifyObj("LdtkGridPoint", ("cy", stringify(typeof(value.cy), value.cy)),
               ("cx", stringify(typeof(value.cx), value.cx)))

proc `$`*(value: LdtkGridPoint): string =
  stringify(LdtkGridPoint, value)

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

proc toBinary*(target: var string; source: LdtkGridPoint) =
  toBinary(target, source.cy)
  toBinary(target, source.cx)

proc toBinary*(source: LdtkGridPoint): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkGridPoint]; source: string; idx: var int): LdtkGridPoint =
  result.cy = fromBinary(typeof(result.cy), source, idx)
  result.cx = fromBinary(typeof(result.cx), source, idx)

proc fromBinary*(_: typedesc[LdtkGridPoint]; source: string): LdtkGridPoint =
  var idx = 0
  return fromBinary(LdtkGridPoint, source, idx)

proc equals(_: typedesc[Ldtk_FORCED_REFS]; a, b: Ldtk_FORCED_REFS): bool =
  equals(typeof(a.TilesetRect), a.TilesetRect, b.TilesetRect) and
      equals(typeof(a.FieldInstance), a.FieldInstance, b.FieldInstance) and
      equals(typeof(a.EntityInstance), a.EntityInstance, b.EntityInstance) and
      equals(typeof(a.Definitions), a.Definitions, b.Definitions) and
      equals(typeof(a.EnumTagValue), a.EnumTagValue, b.EnumTagValue) and
      equals(typeof(a.AutoRuleDef), a.AutoRuleDef, b.AutoRuleDef) and
      equals(typeof(a.FieldDef), a.FieldDef, b.FieldDef) and
      equals(typeof(a.CustomCommand), a.CustomCommand, b.CustomCommand) and
      equals(typeof(a.EntityDef), a.EntityDef, b.EntityDef) and
      equals(typeof(a.AutoLayerRuleGroup), a.AutoLayerRuleGroup,
             b.AutoLayerRuleGroup) and
      equals(typeof(a.IntGridValueGroupDef), a.IntGridValueGroupDef,
             b.IntGridValueGroupDef) and
      equals(typeof(a.IntGridValueInstance), a.IntGridValueInstance,
             b.IntGridValueInstance) and
      equals(typeof(a.TocInstanceData), a.TocInstanceData, b.TocInstanceData) and
      equals(typeof(a.NeighbourLevel), a.NeighbourLevel, b.NeighbourLevel) and
      equals(typeof(a.LayerInstance), a.LayerInstance, b.LayerInstance) and
      equals(typeof(a.World), a.World, b.World) and
      equals(typeof(a.EntityReferenceInfos), a.EntityReferenceInfos,
             b.EntityReferenceInfos) and
      equals(typeof(a.TileCustomMetadata), a.TileCustomMetadata,
             b.TileCustomMetadata) and
      equals(typeof(a.TilesetDef), a.TilesetDef, b.TilesetDef) and
      equals(typeof(a.EnumDefValues), a.EnumDefValues, b.EnumDefValues) and
      equals(typeof(a.Tile), a.Tile, b.Tile) and
      equals(typeof(a.LayerDef), a.LayerDef, b.LayerDef) and
      equals(typeof(a.LevelBgPosInfos), a.LevelBgPosInfos, b.LevelBgPosInfos) and
      equals(typeof(a.Level), a.Level, b.Level) and
      equals(typeof(a.TableOfContentEntry), a.TableOfContentEntry,
             b.TableOfContentEntry) and
      equals(typeof(a.EnumDef), a.EnumDef, b.EnumDef) and
      equals(typeof(a.GridPoint), a.GridPoint, b.GridPoint) and
      equals(typeof(a.IntGridValueDef), a.IntGridValueDef, b.IntGridValueDef)

proc `==`*(a, b: Ldtk_FORCED_REFS): bool =
  return equals(Ldtk_FORCED_REFS, a, b)

proc stringify(_: typedesc[Ldtk_FORCED_REFS]; value: Ldtk_FORCED_REFS): string =
  stringifyObj("Ldtk_FORCED_REFS", ("TilesetRect", stringify(
      typeof(value.TilesetRect), value.TilesetRect)), ("FieldInstance",
      stringify(typeof(value.FieldInstance), value.FieldInstance)), (
      "EntityInstance",
      stringify(typeof(value.EntityInstance), value.EntityInstance)), (
      "Definitions", stringify(typeof(value.Definitions), value.Definitions)), (
      "EnumTagValue", stringify(typeof(value.EnumTagValue), value.EnumTagValue)), (
      "AutoRuleDef", stringify(typeof(value.AutoRuleDef), value.AutoRuleDef)), (
      "FieldDef", stringify(typeof(value.FieldDef), value.FieldDef)), (
      "CustomCommand",
      stringify(typeof(value.CustomCommand), value.CustomCommand)), (
      "EntityDef", stringify(typeof(value.EntityDef), value.EntityDef)), (
      "AutoLayerRuleGroup",
      stringify(typeof(value.AutoLayerRuleGroup), value.AutoLayerRuleGroup)), (
      "IntGridValueGroupDef",
      stringify(typeof(value.IntGridValueGroupDef), value.IntGridValueGroupDef)), (
      "IntGridValueInstance",
      stringify(typeof(value.IntGridValueInstance), value.IntGridValueInstance)), (
      "TocInstanceData",
      stringify(typeof(value.TocInstanceData), value.TocInstanceData)), (
      "NeighbourLevel",
      stringify(typeof(value.NeighbourLevel), value.NeighbourLevel)), (
      "LayerInstance",
      stringify(typeof(value.LayerInstance), value.LayerInstance)),
               ("World", stringify(typeof(value.World), value.World)), (
      "EntityReferenceInfos",
      stringify(typeof(value.EntityReferenceInfos), value.EntityReferenceInfos)), (
      "TileCustomMetadata",
      stringify(typeof(value.TileCustomMetadata), value.TileCustomMetadata)), (
      "TilesetDef", stringify(typeof(value.TilesetDef), value.TilesetDef)), (
      "EnumDefValues",
      stringify(typeof(value.EnumDefValues), value.EnumDefValues)),
               ("Tile", stringify(typeof(value.Tile), value.Tile)), ("LayerDef",
      stringify(typeof(value.LayerDef), value.LayerDef)), ("LevelBgPosInfos",
      stringify(typeof(value.LevelBgPosInfos), value.LevelBgPosInfos)),
               ("Level", stringify(typeof(value.Level), value.Level)), (
      "TableOfContentEntry",
      stringify(typeof(value.TableOfContentEntry), value.TableOfContentEntry)),
               ("EnumDef", stringify(typeof(value.EnumDef), value.EnumDef)), (
      "GridPoint", stringify(typeof(value.GridPoint), value.GridPoint)), (
      "IntGridValueDef",
      stringify(typeof(value.IntGridValueDef), value.IntGridValueDef)))

proc `$`*(value: Ldtk_FORCED_REFS): string =
  stringify(Ldtk_FORCED_REFS, value)

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

proc toBinary*(target: var string; source: Ldtk_FORCED_REFS) =
  toBinary(target, source.TilesetRect)
  toBinary(target, source.FieldInstance)
  toBinary(target, source.EntityInstance)
  toBinary(target, source.Definitions)
  toBinary(target, source.EnumTagValue)
  toBinary(target, source.AutoRuleDef)
  toBinary(target, source.FieldDef)
  toBinary(target, source.CustomCommand)
  toBinary(target, source.EntityDef)
  toBinary(target, source.AutoLayerRuleGroup)
  toBinary(target, source.IntGridValueGroupDef)
  toBinary(target, source.IntGridValueInstance)
  toBinary(target, source.TocInstanceData)
  toBinary(target, source.NeighbourLevel)
  toBinary(target, source.LayerInstance)
  toBinary(target, source.World)
  toBinary(target, source.EntityReferenceInfos)
  toBinary(target, source.TileCustomMetadata)
  toBinary(target, source.TilesetDef)
  toBinary(target, source.EnumDefValues)
  toBinary(target, source.Tile)
  toBinary(target, source.LayerDef)
  toBinary(target, source.LevelBgPosInfos)
  toBinary(target, source.Level)
  toBinary(target, source.TableOfContentEntry)
  toBinary(target, source.EnumDef)
  toBinary(target, source.GridPoint)
  toBinary(target, source.IntGridValueDef)

proc toBinary*(source: Ldtk_FORCED_REFS): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[Ldtk_FORCED_REFS]; source: string; idx: var int): Ldtk_FORCED_REFS =
  result.TilesetRect = fromBinary(typeof(result.TilesetRect), source, idx)
  result.FieldInstance = fromBinary(typeof(result.FieldInstance), source, idx)
  result.EntityInstance = fromBinary(typeof(result.EntityInstance), source, idx)
  result.Definitions = fromBinary(typeof(result.Definitions), source, idx)
  result.EnumTagValue = fromBinary(typeof(result.EnumTagValue), source, idx)
  result.AutoRuleDef = fromBinary(typeof(result.AutoRuleDef), source, idx)
  result.FieldDef = fromBinary(typeof(result.FieldDef), source, idx)
  result.CustomCommand = fromBinary(typeof(result.CustomCommand), source, idx)
  result.EntityDef = fromBinary(typeof(result.EntityDef), source, idx)
  result.AutoLayerRuleGroup = fromBinary(typeof(result.AutoLayerRuleGroup),
      source, idx)
  result.IntGridValueGroupDef = fromBinary(typeof(result.IntGridValueGroupDef),
      source, idx)
  result.IntGridValueInstance = fromBinary(typeof(result.IntGridValueInstance),
      source, idx)
  result.TocInstanceData = fromBinary(typeof(result.TocInstanceData), source,
                                      idx)
  result.NeighbourLevel = fromBinary(typeof(result.NeighbourLevel), source, idx)
  result.LayerInstance = fromBinary(typeof(result.LayerInstance), source, idx)
  result.World = fromBinary(typeof(result.World), source, idx)
  result.EntityReferenceInfos = fromBinary(typeof(result.EntityReferenceInfos),
      source, idx)
  result.TileCustomMetadata = fromBinary(typeof(result.TileCustomMetadata),
      source, idx)
  result.TilesetDef = fromBinary(typeof(result.TilesetDef), source, idx)
  result.EnumDefValues = fromBinary(typeof(result.EnumDefValues), source, idx)
  result.Tile = fromBinary(typeof(result.Tile), source, idx)
  result.LayerDef = fromBinary(typeof(result.LayerDef), source, idx)
  result.LevelBgPosInfos = fromBinary(typeof(result.LevelBgPosInfos), source,
                                      idx)
  result.Level = fromBinary(typeof(result.Level), source, idx)
  result.TableOfContentEntry = fromBinary(typeof(result.TableOfContentEntry),
      source, idx)
  result.EnumDef = fromBinary(typeof(result.EnumDef), source, idx)
  result.GridPoint = fromBinary(typeof(result.GridPoint), source, idx)
  result.IntGridValueDef = fromBinary(typeof(result.IntGridValueDef), source,
                                      idx)

proc fromBinary*(_: typedesc[Ldtk_FORCED_REFS]; source: string): Ldtk_FORCED_REFS =
  var idx = 0
  return fromBinary(Ldtk_FORCED_REFS, source, idx)

proc equals(_: typedesc[LdtkLdtkJsonRoot]; a, b: LdtkLdtkJsonRoot): bool =
  equals(typeof(a.backupLimit), a.backupLimit, b.backupLimit) and
      equals(typeof(a.defaultEntityWidth), a.defaultEntityWidth,
             b.defaultEntityWidth) and
      equals(typeof(a.backupOnSave), a.backupOnSave, b.backupOnSave) and
      equals(typeof(a.worldGridWidth), a.worldGridWidth, b.worldGridWidth) and
      equals(typeof(a.iid), a.iid, b.iid) and
      equals(typeof(a.defaultLevelBgColor), a.defaultLevelBgColor,
             b.defaultLevelBgColor) and
      equals(typeof(a.bgColor), a.bgColor, b.bgColor) and
      equals(typeof(a.worlds), a.worlds, b.worlds) and
      equals(typeof(a.toc), a.toc, b.toc) and
      equals(typeof(a.nextUid), a.nextUid, b.nextUid) and
      equals(typeof(a.imageExportMode), a.imageExportMode, b.imageExportMode) and
      equals(typeof(a.identifierStyle), a.identifierStyle, b.identifierStyle) and
      equals(typeof(a.defaultPivotY), a.defaultPivotY, b.defaultPivotY) and
      equals(typeof(a.dummyWorldIid), a.dummyWorldIid, b.dummyWorldIid) and
      equals(typeof(a.customCommands), a.customCommands, b.customCommands) and
      equals(typeof(a.worldGridHeight), a.worldGridHeight, b.worldGridHeight) and
      equals(typeof(a.appBuildId), a.appBuildId, b.appBuildId) and
      equals(typeof(a.defaultGridSize), a.defaultGridSize, b.defaultGridSize) and
      equals(typeof(a.worldLayout), a.worldLayout, b.worldLayout) and
      equals(typeof(a.flags), a.flags, b.flags) and
      equals(typeof(a.levelNamePattern), a.levelNamePattern, b.levelNamePattern) and
      equals(typeof(a.exportPng), a.exportPng, b.exportPng) and
      equals(typeof(a.defaultLevelWidth), a.defaultLevelWidth,
             b.defaultLevelWidth) and
      equals(typeof(a.pngFilePattern), a.pngFilePattern, b.pngFilePattern) and
      equals(typeof(a.FORCED_REFS), a.FORCED_REFS, b.FORCED_REFS) and
      equals(typeof(a.exportTiled), a.exportTiled, b.exportTiled) and
      equals(typeof(a.defs), a.defs, b.defs) and
      equals(typeof(a.levels), a.levels, b.levels) and
      equals(typeof(a.jsonVersion), a.jsonVersion, b.jsonVersion) and
      equals(typeof(a.defaultEntityHeight), a.defaultEntityHeight,
             b.defaultEntityHeight) and
      equals(typeof(a.defaultPivotX), a.defaultPivotX, b.defaultPivotX) and
      equals(typeof(a.defaultLevelHeight), a.defaultLevelHeight,
             b.defaultLevelHeight) and
      equals(typeof(a.simplifiedExport), a.simplifiedExport, b.simplifiedExport) and
      equals(typeof(a.externalLevels), a.externalLevels, b.externalLevels) and
      equals(typeof(a.tutorialDesc), a.tutorialDesc, b.tutorialDesc) and
      equals(typeof(a.minifyJson), a.minifyJson, b.minifyJson) and
      equals(typeof(a.exportLevelBg), a.exportLevelBg, b.exportLevelBg) and
      equals(typeof(a.backupRelPath), a.backupRelPath, b.backupRelPath)

proc `==`*(a, b: LdtkLdtkJsonRoot): bool =
  return equals(LdtkLdtkJsonRoot, a, b)

proc stringify(_: typedesc[LdtkLdtkJsonRoot]; value: LdtkLdtkJsonRoot): string =
  stringifyObj("LdtkLdtkJsonRoot", ("backupLimit", stringify(
      typeof(value.backupLimit), value.backupLimit)), ("defaultEntityWidth",
      stringify(typeof(value.defaultEntityWidth), value.defaultEntityWidth)), (
      "backupOnSave", stringify(typeof(value.backupOnSave), value.backupOnSave)), (
      "worldGridWidth",
      stringify(typeof(value.worldGridWidth), value.worldGridWidth)),
               ("iid", stringify(typeof(value.iid), value.iid)), (
      "defaultLevelBgColor",
      stringify(typeof(value.defaultLevelBgColor), value.defaultLevelBgColor)),
               ("bgColor", stringify(typeof(value.bgColor), value.bgColor)),
               ("worlds", stringify(typeof(value.worlds), value.worlds)),
               ("toc", stringify(typeof(value.toc), value.toc)),
               ("nextUid", stringify(typeof(value.nextUid), value.nextUid)), (
      "imageExportMode",
      stringify(typeof(value.imageExportMode), value.imageExportMode)), (
      "identifierStyle",
      stringify(typeof(value.identifierStyle), value.identifierStyle)), (
      "defaultPivotY",
      stringify(typeof(value.defaultPivotY), value.defaultPivotY)), (
      "dummyWorldIid",
      stringify(typeof(value.dummyWorldIid), value.dummyWorldIid)), (
      "customCommands",
      stringify(typeof(value.customCommands), value.customCommands)), (
      "worldGridHeight",
      stringify(typeof(value.worldGridHeight), value.worldGridHeight)), (
      "appBuildId", stringify(typeof(value.appBuildId), value.appBuildId)), (
      "defaultGridSize",
      stringify(typeof(value.defaultGridSize), value.defaultGridSize)), (
      "worldLayout", stringify(typeof(value.worldLayout), value.worldLayout)),
               ("flags", stringify(typeof(value.flags), value.flags)), (
      "levelNamePattern",
      stringify(typeof(value.levelNamePattern), value.levelNamePattern)), (
      "exportPng", stringify(typeof(value.exportPng), value.exportPng)), (
      "defaultLevelWidth",
      stringify(typeof(value.defaultLevelWidth), value.defaultLevelWidth)), (
      "pngFilePattern",
      stringify(typeof(value.pngFilePattern), value.pngFilePattern)), (
      "FORCED_REFS", stringify(typeof(value.FORCED_REFS), value.FORCED_REFS)), (
      "exportTiled", stringify(typeof(value.exportTiled), value.exportTiled)),
               ("defs", stringify(typeof(value.defs), value.defs)),
               ("levels", stringify(typeof(value.levels), value.levels)), (
      "jsonVersion", stringify(typeof(value.jsonVersion), value.jsonVersion)), (
      "defaultEntityHeight",
      stringify(typeof(value.defaultEntityHeight), value.defaultEntityHeight)), (
      "defaultPivotX",
      stringify(typeof(value.defaultPivotX), value.defaultPivotX)), (
      "defaultLevelHeight",
      stringify(typeof(value.defaultLevelHeight), value.defaultLevelHeight)), (
      "simplifiedExport",
      stringify(typeof(value.simplifiedExport), value.simplifiedExport)), (
      "externalLevels",
      stringify(typeof(value.externalLevels), value.externalLevels)), (
      "tutorialDesc", stringify(typeof(value.tutorialDesc), value.tutorialDesc)), (
      "minifyJson", stringify(typeof(value.minifyJson), value.minifyJson)), (
      "exportLevelBg",
      stringify(typeof(value.exportLevelBg), value.exportLevelBg)), (
      "backupRelPath",
      stringify(typeof(value.backupRelPath), value.backupRelPath)))

proc `$`*(value: LdtkLdtkJsonRoot): string =
  stringify(LdtkLdtkJsonRoot, value)

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

proc toBinary*(target: var string; source: LdtkLdtkJsonRoot) =
  toBinary(target, source.backupLimit)
  toBinary(target, source.defaultEntityWidth)
  toBinary(target, source.backupOnSave)
  toBinary(target, source.worldGridWidth)
  toBinary(target, source.iid)
  toBinary(target, source.defaultLevelBgColor)
  toBinary(target, source.bgColor)
  toBinary(target, source.worlds)
  toBinary(target, source.toc)
  toBinary(target, source.nextUid)
  toBinary(target, source.imageExportMode)
  toBinary(target, source.identifierStyle)
  toBinary(target, source.defaultPivotY)
  toBinary(target, source.dummyWorldIid)
  toBinary(target, source.customCommands)
  toBinary(target, source.worldGridHeight)
  toBinary(target, source.appBuildId)
  toBinary(target, source.defaultGridSize)
  toBinary(target, source.worldLayout)
  toBinary(target, source.flags)
  toBinary(target, source.levelNamePattern)
  toBinary(target, source.exportPng)
  toBinary(target, source.defaultLevelWidth)
  toBinary(target, source.pngFilePattern)
  toBinary(target, source.FORCED_REFS)
  toBinary(target, source.exportTiled)
  toBinary(target, source.defs)
  toBinary(target, source.levels)
  toBinary(target, source.jsonVersion)
  toBinary(target, source.defaultEntityHeight)
  toBinary(target, source.defaultPivotX)
  toBinary(target, source.defaultLevelHeight)
  toBinary(target, source.simplifiedExport)
  toBinary(target, source.externalLevels)
  toBinary(target, source.tutorialDesc)
  toBinary(target, source.minifyJson)
  toBinary(target, source.exportLevelBg)
  toBinary(target, source.backupRelPath)

proc toBinary*(source: LdtkLdtkJsonRoot): string =
  toBinary(result, source)

proc fromBinary(_: typedesc[LdtkLdtkJsonRoot]; source: string; idx: var int): LdtkLdtkJsonRoot =
  result.backupLimit = fromBinary(typeof(result.backupLimit), source, idx)
  result.defaultEntityWidth = fromBinary(typeof(result.defaultEntityWidth),
      source, idx)
  result.backupOnSave = fromBinary(typeof(result.backupOnSave), source, idx)
  result.worldGridWidth = fromBinary(typeof(result.worldGridWidth), source, idx)
  result.iid = fromBinary(typeof(result.iid), source, idx)
  result.defaultLevelBgColor = fromBinary(typeof(result.defaultLevelBgColor),
      source, idx)
  result.bgColor = fromBinary(typeof(result.bgColor), source, idx)
  result.worlds = fromBinary(typeof(result.worlds), source, idx)
  result.toc = fromBinary(typeof(result.toc), source, idx)
  result.nextUid = fromBinary(typeof(result.nextUid), source, idx)
  result.imageExportMode = fromBinary(typeof(result.imageExportMode), source,
                                      idx)
  result.identifierStyle = fromBinary(typeof(result.identifierStyle), source,
                                      idx)
  result.defaultPivotY = fromBinary(typeof(result.defaultPivotY), source, idx)
  result.dummyWorldIid = fromBinary(typeof(result.dummyWorldIid), source, idx)
  result.customCommands = fromBinary(typeof(result.customCommands), source, idx)
  result.worldGridHeight = fromBinary(typeof(result.worldGridHeight), source,
                                      idx)
  result.appBuildId = fromBinary(typeof(result.appBuildId), source, idx)
  result.defaultGridSize = fromBinary(typeof(result.defaultGridSize), source,
                                      idx)
  result.worldLayout = fromBinary(typeof(result.worldLayout), source, idx)
  result.flags = fromBinary(typeof(result.flags), source, idx)
  result.levelNamePattern = fromBinary(typeof(result.levelNamePattern), source,
                                       idx)
  result.exportPng = fromBinary(typeof(result.exportPng), source, idx)
  result.defaultLevelWidth = fromBinary(typeof(result.defaultLevelWidth),
                                        source, idx)
  result.pngFilePattern = fromBinary(typeof(result.pngFilePattern), source, idx)
  result.FORCED_REFS = fromBinary(typeof(result.FORCED_REFS), source, idx)
  result.exportTiled = fromBinary(typeof(result.exportTiled), source, idx)
  result.defs = fromBinary(typeof(result.defs), source, idx)
  result.levels = fromBinary(typeof(result.levels), source, idx)
  result.jsonVersion = fromBinary(typeof(result.jsonVersion), source, idx)
  result.defaultEntityHeight = fromBinary(typeof(result.defaultEntityHeight),
      source, idx)
  result.defaultPivotX = fromBinary(typeof(result.defaultPivotX), source, idx)
  result.defaultLevelHeight = fromBinary(typeof(result.defaultLevelHeight),
      source, idx)
  result.simplifiedExport = fromBinary(typeof(result.simplifiedExport), source,
                                       idx)
  result.externalLevels = fromBinary(typeof(result.externalLevels), source, idx)
  result.tutorialDesc = fromBinary(typeof(result.tutorialDesc), source, idx)
  result.minifyJson = fromBinary(typeof(result.minifyJson), source, idx)
  result.exportLevelBg = fromBinary(typeof(result.exportLevelBg), source, idx)
  result.backupRelPath = fromBinary(typeof(result.backupRelPath), source, idx)

proc fromBinary*(_: typedesc[LdtkLdtkJsonRoot]; source: string): LdtkLdtkJsonRoot =
  var idx = 0
  return fromBinary(LdtkLdtkJsonRoot, source, idx)
{.pop.}
