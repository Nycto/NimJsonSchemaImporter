{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  LdtkWhen* = enum
    AfterLoad, BeforeSave, AfterSave, Manual
  LdtkCustomCommand* = object
    command*: string
    `when`*: LdtkWhen
  LdtkEntityReferenceInfos* = object
    layerIid*: string
    levelIid*: string
    entityIid*: string
    worldIid*: string
  LdtkTocInstanceData* = object
    worldY*: BiggestInt
    fields*: JsonNode
    widPx*: BiggestInt
    iids*: LdtkEntityReferenceInfos
    heiPx*: BiggestInt
    worldX*: BiggestInt
  LdtkTableOfContentEntry* = object
    instancesData*: seq[LdtkTocInstanceData]
    identifier*: string
    instances*: Option[seq[LdtkEntityReferenceInfos]]
  LdtkWorldLayout* = enum
    LinearHorizontal, LinearVertical, GridVania, Free
  LdtkNeighbourLevel* = object
    levelUid*: Option[BiggestInt]
    levelIid*: string
    dir*: string
  LdtkBgPos* = enum
    CoverDirty, Repeat, Contain, Cover, Unscaled
  LdtkTile* = object
    px*: seq[BiggestInt]
    t*: BiggestInt
    d*: seq[BiggestInt]
    a*: BiggestFloat
    src*: seq[BiggestInt]
    f*: BiggestInt
  LdtkIntGridValueInstance* = object
    coordId*: BiggestInt
    v*: BiggestInt
  LdtkTilesetRect* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  LdtkFieldInstance* = object
    realEditorValues*: seq[JsonNode]
    value*: JsonNode
    tile*: Option[LdtkTilesetRect]
    `type`*: string
    identifier*: string
    defUid*: BiggestInt
  LdtkEntityInstance* = object
    worldY*: Option[BiggestInt]
    tile*: Option[LdtkTilesetRect]
    identifier*: string
    tags*: seq[string]
    height*: BiggestInt
    px*: seq[BiggestInt]
    defUid*: BiggestInt
    pivot*: seq[BiggestFloat]
    fieldInstances*: seq[LdtkFieldInstance]
    iid*: string
    width*: BiggestInt
    worldX*: Option[BiggestInt]
    grid*: seq[BiggestInt]
    smartColor*: string
  LdtkLayerInstance* = object
    opacity*: BiggestFloat
    optionalRules*: seq[BiggestInt]
    gridSize*: BiggestInt
    pxTotalOffsetX*: BiggestInt
    gridTiles*: seq[LdtkTile]
    `type`*: string
    identifier*: string
    overrideTilesetUid*: Option[BiggestInt]
    levelId*: BiggestInt
    intGrid*: Option[seq[LdtkIntGridValueInstance]]
    autoLayerTiles*: seq[LdtkTile]
    layerDefUid*: BiggestInt
    entityInstances*: seq[LdtkEntityInstance]
    intGridCsv*: seq[BiggestInt]
    pxOffsetX*: BiggestInt
    tilesetRelPath*: Option[string]
    tilesetDefUid*: Option[BiggestInt]
    cHei*: BiggestInt
    seed*: BiggestInt
    visible*: bool
    pxOffsetY*: BiggestInt
    iid*: string
    pxTotalOffsetY*: BiggestInt
    cWid*: BiggestInt
  LdtkLevelBgPosInfos* = object
    scale*: seq[BiggestFloat]
    cropRect*: seq[BiggestFloat]
    topLeftPx*: seq[BiggestInt]
  LdtkLevel* = object
    pxHei*: BiggestInt
    useAutoIdentifier*: bool
    bgColor*: string
    bgColor1*: Option[string]
    externalRelPath*: Option[string]
    worldY*: BiggestInt
    bgRelPath*: Option[string]
    identifier*: string
    pxWid*: BiggestInt
    worldDepth*: BiggestInt
    bgPivotX*: BiggestFloat
    neighbours*: seq[LdtkNeighbourLevel]
    uid*: BiggestInt
    bgPos*: Option[LdtkBgPos]
    layerInstances*: Option[seq[LdtkLayerInstance]]
    fieldInstances*: seq[LdtkFieldInstance]
    bgPos1*: Option[LdtkLevelBgPosInfos]
    worldX*: BiggestInt
    iid*: string
    bgPivotY*: BiggestFloat
    smartColor*: string
  LdtkWorld* = object
    worldGridWidth*: BiggestInt
    defaultLevelHeight*: BiggestInt
    identifier*: string
    worldLayout*: Option[LdtkWorldLayout]
    iid*: string
    defaultLevelWidth*: BiggestInt
    worldGridHeight*: BiggestInt
    levels*: seq[LdtkLevel]
  LdtkImageExportMode* = enum
    LayersAndLevels, OneImagePerLayer, None, OneImagePerLevel
  LdtkIntGridValueDef* = object
    tile*: Option[LdtkTilesetRect]
    color*: string
    identifier*: Option[string]
    groupUid*: BiggestInt
    value*: BiggestInt
  LdtkTextLanguageMode* = enum
    LangMarkdown, LangPython, LangLog, LangC, LangLua, LangHaxe, LangJS,
    LangRuby, LangJson, LangXml
  LdtkEditorDisplayPos* = enum
    Beneath, Above, Center
  LdtkEditorDisplayMode* = enum
    PointPath, PointStar, ValueOnly, Hidden, Points, NameAndValue,
    ArrayCountNoLabel, EntityTile, PointPathLoop, RadiusPx, LevelTile,
    RadiusGrid, RefLinkBetweenCenters, RefLinkBetweenPivots, ArrayCountWithLabel
  LdtkEditorLinkStyle* = enum
    DashedLine, CurvedArrow, ArrowsLine, ZigZag, StraightArrow
  LdtkAllowedRefs* = enum
    Any, OnlyTags, OnlySame, OnlySpecificEntity
  LdtkFieldDef* = object
    type1*: string
    editorDisplayScale*: BiggestFloat
    `type`*: string
    allowedRefsEntityUid*: Option[BiggestInt]
    textLanguageMode*: Option[LdtkTextLanguageMode]
    editorAlwaysShow*: bool
    defaultOverride*: Option[JsonNode]
    autoChainRef*: bool
    editorDisplayPos*: LdtkEditorDisplayPos
    editorDisplayMode*: LdtkEditorDisplayMode
    identifier*: string
    regex*: Option[string]
    isArray*: bool
    editorLinkStyle*: LdtkEditorLinkStyle
    allowedRefs*: LdtkAllowedRefs
    useForSmartColor*: bool
    editorTextSuffix*: Option[string]
    doc*: Option[string]
    editorTextPrefix*: Option[string]
    editorCutLongValues*: bool
    canBeNull*: bool
    allowedRefTags*: seq[string]
    uid*: BiggestInt
    symmetricalRef*: bool
    editorDisplayColor*: Option[string]
    allowOutOfLevelRef*: bool
    acceptFileTypes*: Option[seq[string]]
    editorShowInWorld*: bool
    tilesetUid*: Option[BiggestInt]
    arrayMaxLength*: Option[BiggestInt]
    arrayMinLength*: Option[BiggestInt]
    searchable*: bool
    min*: Option[BiggestFloat]
    exportToToc*: bool
    max*: Option[BiggestFloat]
  LdtkEmbedAtlas* = enum
    LdtkIcons
  LdtkEnumTagValue* = object
    tileIds*: seq[BiggestInt]
    enumValueId*: string
  LdtkTileCustomMetadata* = object
    data*: string
    tileId*: BiggestInt
  LdtkTilesetDef* = object
    pxHei*: BiggestInt
    savedSelections*: seq[Table[string, JsonNode]]
    padding*: BiggestInt
    spacing*: BiggestInt
    tagsSourceEnumUid*: Option[BiggestInt]
    embedAtlas*: Option[LdtkEmbedAtlas]
    identifier*: string
    cachedPixelData*: Option[Table[string, JsonNode]]
    enumTags*: seq[LdtkEnumTagValue]
    pxWid*: BiggestInt
    tileGridSize*: BiggestInt
    customData*: seq[LdtkTileCustomMetadata]
    uid*: BiggestInt
    cHei*: BiggestInt
    cWid*: BiggestInt
    relPath*: Option[string]
    tags*: seq[string]
  LdtkLimitScope* = enum
    PerLayer, PerWorld, PerLevel
  LdtkLimitBehavior* = enum
    PreventAdding, MoveLastOne, DiscardOldOnes
  LdtkRenderMode* = enum
    Tile, Cross, Ellipse, Rectangle
  LdtkTileRenderMode* = enum
    FullSizeCropped, FullSizeUncropped, Repeat, FitInside, NineSlice, Cover,
    Stretch
  LdtkEntityDef* = object
    allowOutOfBounds*: bool
    pivotY*: BiggestFloat
    tileOpacity*: BiggestFloat
    color*: string
    limitScope*: LdtkLimitScope
    limitBehavior*: LdtkLimitBehavior
    hollow*: bool
    height*: BiggestInt
    renderMode*: LdtkRenderMode
    tilesetId*: Option[BiggestInt]
    keepAspectRatio*: bool
    minWidth*: Option[BiggestInt]
    showName*: bool
    resizableX*: bool
    identifier*: string
    maxCount*: BiggestInt
    tileId*: Option[BiggestInt]
    pivotX*: BiggestFloat
    doc*: Option[string]
    fieldDefs*: seq[LdtkFieldDef]
    uid*: BiggestInt
    tileRenderMode*: LdtkTileRenderMode
    uiTileRect*: Option[LdtkTilesetRect]
    resizableY*: bool
    lineOpacity*: BiggestFloat
    minHeight*: Option[BiggestInt]
    tileRect*: Option[LdtkTilesetRect]
    nineSliceBorders*: seq[BiggestInt]
    maxWidth*: Option[BiggestInt]
    width*: BiggestInt
    tags*: seq[string]
    maxHeight*: Option[BiggestInt]
    exportToToc*: bool
    fillOpacity*: BiggestFloat
  LdtkEnumDefValues* = object
    tileSrcRect*: Option[seq[BiggestInt]]
    color*: BiggestInt
    id*: string
    tileId*: Option[BiggestInt]
    tileRect*: Option[LdtkTilesetRect]
  LdtkEnumDef* = object
    values*: seq[LdtkEnumDefValues]
    externalRelPath*: Option[string]
    identifier*: string
    externalFileChecksum*: Option[string]
    iconTilesetUid*: Option[BiggestInt]
    uid*: BiggestInt
    tags*: seq[string]
  LdtkType* = enum
    Tiles, Entities, AutoLayer, IntGrid
  LdtkChecker* = enum
    Horizontal, Vertical, None
  LdtkTileMode* = enum
    Single, Stamp
  LdtkAutoRuleDef* = object
    checker*: LdtkChecker
    pivotY*: BiggestFloat
    breakOnMatch*: bool
    perlinOctaves*: BiggestFloat
    yModulo*: BiggestInt
    size*: BiggestInt
    tileMode*: LdtkTileMode
    tileRandomXMax*: BiggestInt
    tileRandomXMin*: BiggestInt
    xModulo*: BiggestInt
    yOffset*: BiggestInt
    flipX*: bool
    tileYOffset*: BiggestInt
    chance*: BiggestFloat
    tileRandomYMax*: BiggestInt
    perlinActive*: bool
    perlinScale*: BiggestFloat
    outOfBoundsValue*: Option[BiggestInt]
    pivotX*: BiggestFloat
    flipY*: bool
    active*: bool
    uid*: BiggestInt
    tileIds*: Option[seq[BiggestInt]]
    invalidated*: bool
    pattern*: seq[BiggestInt]
    alpha*: BiggestFloat
    tileRectsIds*: seq[seq[BiggestInt]]
    tileXOffset*: BiggestInt
    xOffset*: BiggestInt
    tileRandomYMin*: BiggestInt
    perlinSeed*: BiggestFloat
  LdtkAutoLayerRuleGroup* = object
    isOptional*: bool
    color*: Option[string]
    collapsed*: Option[bool]
    usesWizard*: bool
    biomeRequirementMode*: BiggestInt
    rules*: seq[LdtkAutoRuleDef]
    icon*: Option[LdtkTilesetRect]
    active*: bool
    uid*: BiggestInt
    name*: string
    requiredBiomeValues*: seq[string]
  LdtkIntGridValueGroupDef* = object
    color*: Option[string]
    identifier*: Option[string]
    uid*: BiggestInt
  LdtkLayerDef* = object
    type1*: LdtkType
    autoTilesetDefUid*: Option[BiggestInt]
    parallaxScaling*: bool
    biomeFieldUid*: Option[BiggestInt]
    autoTilesKilledByOtherLayerUid*: Option[BiggestInt]
    inactiveOpacity*: BiggestFloat
    `type`*: string
    autoRuleGroups*: seq[LdtkAutoLayerRuleGroup]
    gridSize*: BiggestInt
    hideInList*: bool
    tilesetDefUid*: Option[BiggestInt]
    uiColor*: Option[string]
    requiredTags*: seq[string]
    tilePivotX*: BiggestFloat
    uiFilterTags*: seq[string]
    guideGridWid*: BiggestInt
    parallaxFactorX*: BiggestFloat
    identifier*: string
    canSelectWhenInactive*: bool
    pxOffsetX*: BiggestInt
    tilePivotY*: BiggestFloat
    excludedTags*: seq[string]
    doc*: Option[string]
    uid*: BiggestInt
    guideGridHei*: BiggestInt
    autoSourceLayerDefUid*: Option[BiggestInt]
    displayOpacity*: BiggestFloat
    intGridValuesGroups*: seq[LdtkIntGridValueGroupDef]
    hideFieldsWhenInactive*: bool
    useAsyncRender*: bool
    pxOffsetY*: BiggestInt
    parallaxFactorY*: BiggestFloat
    intGridValues*: seq[LdtkIntGridValueDef]
    renderInWorldView*: bool
  LdtkDefinitions* = object
    levelFields*: seq[LdtkFieldDef]
    tilesets*: seq[LdtkTilesetDef]
    entities*: seq[LdtkEntityDef]
    enums*: seq[LdtkEnumDef]
    layers*: seq[LdtkLayerDef]
    externalEnums*: seq[LdtkEnumDef]
  LdtkGridPoint* = object
    cx*: BiggestInt
    cy*: BiggestInt
  Ldtk_FORCED_REFS* = object
    CustomCommand*: Option[LdtkCustomCommand]
    IntGridValueDef*: Option[LdtkIntGridValueDef]
    Level*: Option[LdtkLevel]
    Definitions*: Option[LdtkDefinitions]
    EnumDef*: Option[LdtkEnumDef]
    FieldDef*: Option[LdtkFieldDef]
    AutoLayerRuleGroup*: Option[LdtkAutoLayerRuleGroup]
    TilesetDef*: Option[LdtkTilesetDef]
    TableOfContentEntry*: Option[LdtkTableOfContentEntry]
    EntityDef*: Option[LdtkEntityDef]
    FieldInstance*: Option[LdtkFieldInstance]
    EntityReferenceInfos*: Option[LdtkEntityReferenceInfos]
    LevelBgPosInfos*: Option[LdtkLevelBgPosInfos]
    TileCustomMetadata*: Option[LdtkTileCustomMetadata]
    Tile*: Option[LdtkTile]
    AutoRuleDef*: Option[LdtkAutoRuleDef]
    NeighbourLevel*: Option[LdtkNeighbourLevel]
    GridPoint*: Option[LdtkGridPoint]
    EntityInstance*: Option[LdtkEntityInstance]
    TilesetRect*: Option[LdtkTilesetRect]
    EnumTagValue*: Option[LdtkEnumTagValue]
    LayerInstance*: Option[LdtkLayerInstance]
    IntGridValueInstance*: Option[LdtkIntGridValueInstance]
    World*: Option[LdtkWorld]
    LayerDef*: Option[LdtkLayerDef]
    IntGridValueGroupDef*: Option[LdtkIntGridValueGroupDef]
    TocInstanceData*: Option[LdtkTocInstanceData]
    EnumDefValues*: Option[LdtkEnumDefValues]
  LdtkldtkWorldLayout* = enum
    LinearHorizontal, LinearVertical, GridVania, Free
  LdtkFlags* = enum
    ExportPreCsvIntGridFormat, DiscardPreCsvIntGrid,
    ExportOldTableOfContentData, PrependIndexToLevelFileNames, MultiWorlds,
    UseMultilinesType, IgnoreBackupSuggest
  LdtkIdentifierStyle* = enum
    Lowercase, Free, Capitalize, Uppercase
  LdtkLdtkJsonRoot* = object
    backupLimit*: BiggestInt
    simplifiedExport*: bool
    externalLevels*: bool
    backupRelPath*: Option[string]
    jsonVersion*: string
    bgColor*: string
    appBuildId*: BiggestFloat
    defaultEntityHeight*: BiggestInt
    pngFilePattern*: Option[string]
    customCommands*: seq[LdtkCustomCommand]
    exportTiled*: bool
    exportPng*: Option[bool]
    worldGridWidth*: Option[BiggestInt]
    defaultLevelHeight*: Option[BiggestInt]
    toc*: seq[LdtkTableOfContentEntry]
    worlds*: seq[LdtkWorld]
    imageExportMode*: LdtkImageExportMode
    dummyWorldIid*: string
    FORCED_REFS*: Option[Ldtk_FORCED_REFS]
    defaultPivotY*: BiggestFloat
    exportLevelBg*: bool
    nextUid*: BiggestInt
    levelNamePattern*: string
    defs*: LdtkDefinitions
    defaultPivotX*: BiggestFloat
    tutorialDesc*: Option[string]
    worldLayout*: Option[LdtkldtkWorldLayout]
    defaultEntityWidth*: BiggestInt
    iid*: string
    defaultGridSize*: BiggestInt
    defaultLevelWidth*: Option[BiggestInt]
    minifyJson*: bool
    backupOnSave*: bool
    flags*: seq[LdtkFlags]
    defaultLevelBgColor*: string
    identifierStyle*: LdtkIdentifierStyle
    worldGridHeight*: Option[BiggestInt]
    levels*: seq[LdtkLevel]
proc toJsonHook*(source: LdtkWhen): JsonNode =
  case source
  of LdtkWhen.AfterLoad:
    return newJString("AfterLoad")
  of LdtkWhen.BeforeSave:
    return newJString("BeforeSave")
  of LdtkWhen.AfterSave:
    return newJString("AfterSave")
  of LdtkWhen.Manual:
    return newJString("Manual")
  
proc fromJsonHook*(target: var LdtkWhen; source: JsonNode) =
  target = case getStr(source)
  of "AfterLoad":
    LdtkWhen.AfterLoad
  of "BeforeSave":
    LdtkWhen.BeforeSave
  of "AfterSave":
    LdtkWhen.AfterSave
  of "Manual":
    LdtkWhen.Manual
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var LdtkCustomCommand; source: JsonNode) =
  assert("command" in source,
         "command" & " is missing while decoding " & "LdtkCustomCommand")
  target.command = jsonTo(source{"command"}, typeof(target.command))
  assert("when" in source,
         "when" & " is missing while decoding " & "LdtkCustomCommand")
  target.`when` = jsonTo(source{"when"}, typeof(target.`when`))

proc toJsonHook*(source: LdtkCustomCommand): JsonNode =
  result = newJObject()
  result{"command"} = toJson(source.command)
  result{"when"} = toJson(source.`when`)

proc fromJsonHook*(target: var LdtkEntityReferenceInfos; source: JsonNode) =
  assert("layerIid" in source, "layerIid" & " is missing while decoding " &
      "LdtkEntityReferenceInfos")
  target.layerIid = jsonTo(source{"layerIid"}, typeof(target.layerIid))
  assert("levelIid" in source, "levelIid" & " is missing while decoding " &
      "LdtkEntityReferenceInfos")
  target.levelIid = jsonTo(source{"levelIid"}, typeof(target.levelIid))
  assert("entityIid" in source, "entityIid" & " is missing while decoding " &
      "LdtkEntityReferenceInfos")
  target.entityIid = jsonTo(source{"entityIid"}, typeof(target.entityIid))
  assert("worldIid" in source, "worldIid" & " is missing while decoding " &
      "LdtkEntityReferenceInfos")
  target.worldIid = jsonTo(source{"worldIid"}, typeof(target.worldIid))

proc toJsonHook*(source: LdtkEntityReferenceInfos): JsonNode =
  result = newJObject()
  result{"layerIid"} = toJson(source.layerIid)
  result{"levelIid"} = toJson(source.levelIid)
  result{"entityIid"} = toJson(source.entityIid)
  result{"worldIid"} = toJson(source.worldIid)

proc fromJsonHook*(target: var LdtkTocInstanceData; source: JsonNode) =
  assert("worldY" in source,
         "worldY" & " is missing while decoding " & "LdtkTocInstanceData")
  target.worldY = jsonTo(source{"worldY"}, typeof(target.worldY))
  assert("fields" in source,
         "fields" & " is missing while decoding " & "LdtkTocInstanceData")
  target.fields = jsonTo(source{"fields"}, typeof(target.fields))
  assert("widPx" in source,
         "widPx" & " is missing while decoding " & "LdtkTocInstanceData")
  target.widPx = jsonTo(source{"widPx"}, typeof(target.widPx))
  assert("iids" in source,
         "iids" & " is missing while decoding " & "LdtkTocInstanceData")
  target.iids = jsonTo(source{"iids"}, typeof(target.iids))
  assert("heiPx" in source,
         "heiPx" & " is missing while decoding " & "LdtkTocInstanceData")
  target.heiPx = jsonTo(source{"heiPx"}, typeof(target.heiPx))
  assert("worldX" in source,
         "worldX" & " is missing while decoding " & "LdtkTocInstanceData")
  target.worldX = jsonTo(source{"worldX"}, typeof(target.worldX))

proc toJsonHook*(source: LdtkTocInstanceData): JsonNode =
  result = newJObject()
  result{"worldY"} = toJson(source.worldY)
  result{"fields"} = toJson(source.fields)
  result{"widPx"} = toJson(source.widPx)
  result{"iids"} = toJson(source.iids)
  result{"heiPx"} = toJson(source.heiPx)
  result{"worldX"} = toJson(source.worldX)

proc fromJsonHook*(target: var LdtkTableOfContentEntry; source: JsonNode) =
  assert("instancesData" in source, "instancesData" &
      " is missing while decoding " &
      "LdtkTableOfContentEntry")
  target.instancesData = jsonTo(source{"instancesData"},
                                typeof(target.instancesData))
  assert("identifier" in source, "identifier" & " is missing while decoding " &
      "LdtkTableOfContentEntry")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  if "instances" in source and source{"instances"}.kind != JNull:
    target.instances = some(jsonTo(source{"instances"},
                                   typeof(unsafeGet(target.instances))))

proc toJsonHook*(source: LdtkTableOfContentEntry): JsonNode =
  result = newJObject()
  result{"instancesData"} = toJson(source.instancesData)
  result{"identifier"} = toJson(source.identifier)
  if isSome(source.instances):
    result{"instances"} = toJson(source.instances)

proc toJsonHook*(source: LdtkWorldLayout): JsonNode =
  case source
  of LdtkWorldLayout.LinearHorizontal:
    return newJString("LinearHorizontal")
  of LdtkWorldLayout.LinearVertical:
    return newJString("LinearVertical")
  of LdtkWorldLayout.GridVania:
    return newJString("GridVania")
  of LdtkWorldLayout.Free:
    return newJString("Free")
  
proc fromJsonHook*(target: var LdtkWorldLayout; source: JsonNode) =
  target = case getStr(source)
  of "LinearHorizontal":
    LdtkWorldLayout.LinearHorizontal
  of "LinearVertical":
    LdtkWorldLayout.LinearVertical
  of "GridVania":
    LdtkWorldLayout.GridVania
  of "Free":
    LdtkWorldLayout.Free
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var LdtkNeighbourLevel; source: JsonNode) =
  if "levelUid" in source and source{"levelUid"}.kind != JNull:
    target.levelUid = some(jsonTo(source{"levelUid"},
                                  typeof(unsafeGet(target.levelUid))))
  assert("levelIid" in source,
         "levelIid" & " is missing while decoding " & "LdtkNeighbourLevel")
  target.levelIid = jsonTo(source{"levelIid"}, typeof(target.levelIid))
  assert("dir" in source,
         "dir" & " is missing while decoding " & "LdtkNeighbourLevel")
  target.dir = jsonTo(source{"dir"}, typeof(target.dir))

proc toJsonHook*(source: LdtkNeighbourLevel): JsonNode =
  result = newJObject()
  if isSome(source.levelUid):
    result{"levelUid"} = toJson(source.levelUid)
  result{"levelIid"} = toJson(source.levelIid)
  result{"dir"} = toJson(source.dir)

proc toJsonHook*(source: LdtkBgPos): JsonNode =
  case source
  of LdtkBgPos.CoverDirty:
    return newJString("CoverDirty")
  of LdtkBgPos.Repeat:
    return newJString("Repeat")
  of LdtkBgPos.Contain:
    return newJString("Contain")
  of LdtkBgPos.Cover:
    return newJString("Cover")
  of LdtkBgPos.Unscaled:
    return newJString("Unscaled")
  
proc fromJsonHook*(target: var LdtkBgPos; source: JsonNode) =
  target = case getStr(source)
  of "CoverDirty":
    LdtkBgPos.CoverDirty
  of "Repeat":
    LdtkBgPos.Repeat
  of "Contain":
    LdtkBgPos.Contain
  of "Cover":
    LdtkBgPos.Cover
  of "Unscaled":
    LdtkBgPos.Unscaled
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var LdtkTile; source: JsonNode) =
  assert("px" in source, "px" & " is missing while decoding " & "LdtkTile")
  target.px = jsonTo(source{"px"}, typeof(target.px))
  assert("t" in source, "t" & " is missing while decoding " & "LdtkTile")
  target.t = jsonTo(source{"t"}, typeof(target.t))
  assert("d" in source, "d" & " is missing while decoding " & "LdtkTile")
  target.d = jsonTo(source{"d"}, typeof(target.d))
  assert("a" in source, "a" & " is missing while decoding " & "LdtkTile")
  target.a = jsonTo(source{"a"}, typeof(target.a))
  assert("src" in source, "src" & " is missing while decoding " & "LdtkTile")
  target.src = jsonTo(source{"src"}, typeof(target.src))
  assert("f" in source, "f" & " is missing while decoding " & "LdtkTile")
  target.f = jsonTo(source{"f"}, typeof(target.f))

proc toJsonHook*(source: LdtkTile): JsonNode =
  result = newJObject()
  result{"px"} = toJson(source.px)
  result{"t"} = toJson(source.t)
  result{"d"} = toJson(source.d)
  result{"a"} = toJson(source.a)
  result{"src"} = toJson(source.src)
  result{"f"} = toJson(source.f)

proc fromJsonHook*(target: var LdtkIntGridValueInstance; source: JsonNode) =
  assert("coordId" in source,
         "coordId" & " is missing while decoding " & "LdtkIntGridValueInstance")
  target.coordId = jsonTo(source{"coordId"}, typeof(target.coordId))
  assert("v" in source,
         "v" & " is missing while decoding " & "LdtkIntGridValueInstance")
  target.v = jsonTo(source{"v"}, typeof(target.v))

proc toJsonHook*(source: LdtkIntGridValueInstance): JsonNode =
  result = newJObject()
  result{"coordId"} = toJson(source.coordId)
  result{"v"} = toJson(source.v)

proc fromJsonHook*(target: var LdtkTilesetRect; source: JsonNode) =
  assert("x" in source, "x" & " is missing while decoding " & "LdtkTilesetRect")
  target.x = jsonTo(source{"x"}, typeof(target.x))
  assert("w" in source, "w" & " is missing while decoding " & "LdtkTilesetRect")
  target.w = jsonTo(source{"w"}, typeof(target.w))
  assert("y" in source, "y" & " is missing while decoding " & "LdtkTilesetRect")
  target.y = jsonTo(source{"y"}, typeof(target.y))
  assert("h" in source, "h" & " is missing while decoding " & "LdtkTilesetRect")
  target.h = jsonTo(source{"h"}, typeof(target.h))
  assert("tilesetUid" in source,
         "tilesetUid" & " is missing while decoding " & "LdtkTilesetRect")
  target.tilesetUid = jsonTo(source{"tilesetUid"}, typeof(target.tilesetUid))

proc toJsonHook*(source: LdtkTilesetRect): JsonNode =
  result = newJObject()
  result{"x"} = toJson(source.x)
  result{"w"} = toJson(source.w)
  result{"y"} = toJson(source.y)
  result{"h"} = toJson(source.h)
  result{"tilesetUid"} = toJson(source.tilesetUid)

proc fromJsonHook*(target: var LdtkFieldInstance; source: JsonNode) =
  assert("realEditorValues" in source, "realEditorValues" &
      " is missing while decoding " &
      "LdtkFieldInstance")
  target.realEditorValues = jsonTo(source{"realEditorValues"},
                                   typeof(target.realEditorValues))
  assert("__value" in source,
         "__value" & " is missing while decoding " & "LdtkFieldInstance")
  target.value = jsonTo(source{"__value"}, typeof(target.value))
  if "__tile" in source and source{"__tile"}.kind != JNull:
    target.tile = some(jsonTo(source{"__tile"}, typeof(unsafeGet(target.tile))))
  assert("__type" in source,
         "__type" & " is missing while decoding " & "LdtkFieldInstance")
  target.`type` = jsonTo(source{"__type"}, typeof(target.`type`))
  assert("__identifier" in source,
         "__identifier" & " is missing while decoding " & "LdtkFieldInstance")
  target.identifier = jsonTo(source{"__identifier"}, typeof(target.identifier))
  assert("defUid" in source,
         "defUid" & " is missing while decoding " & "LdtkFieldInstance")
  target.defUid = jsonTo(source{"defUid"}, typeof(target.defUid))

proc toJsonHook*(source: LdtkFieldInstance): JsonNode =
  result = newJObject()
  result{"realEditorValues"} = toJson(source.realEditorValues)
  result{"__value"} = toJson(source.value)
  if isSome(source.tile):
    result{"__tile"} = toJson(source.tile)
  result{"__type"} = toJson(source.`type`)
  result{"__identifier"} = toJson(source.identifier)
  result{"defUid"} = toJson(source.defUid)

proc fromJsonHook*(target: var LdtkEntityInstance; source: JsonNode) =
  if "__worldY" in source and source{"__worldY"}.kind != JNull:
    target.worldY = some(jsonTo(source{"__worldY"},
                                typeof(unsafeGet(target.worldY))))
  if "__tile" in source and source{"__tile"}.kind != JNull:
    target.tile = some(jsonTo(source{"__tile"}, typeof(unsafeGet(target.tile))))
  assert("__identifier" in source,
         "__identifier" & " is missing while decoding " & "LdtkEntityInstance")
  target.identifier = jsonTo(source{"__identifier"}, typeof(target.identifier))
  assert("__tags" in source,
         "__tags" & " is missing while decoding " & "LdtkEntityInstance")
  target.tags = jsonTo(source{"__tags"}, typeof(target.tags))
  assert("height" in source,
         "height" & " is missing while decoding " & "LdtkEntityInstance")
  target.height = jsonTo(source{"height"}, typeof(target.height))
  assert("px" in source,
         "px" & " is missing while decoding " & "LdtkEntityInstance")
  target.px = jsonTo(source{"px"}, typeof(target.px))
  assert("defUid" in source,
         "defUid" & " is missing while decoding " & "LdtkEntityInstance")
  target.defUid = jsonTo(source{"defUid"}, typeof(target.defUid))
  assert("__pivot" in source,
         "__pivot" & " is missing while decoding " & "LdtkEntityInstance")
  target.pivot = jsonTo(source{"__pivot"}, typeof(target.pivot))
  assert("fieldInstances" in source, "fieldInstances" &
      " is missing while decoding " &
      "LdtkEntityInstance")
  target.fieldInstances = jsonTo(source{"fieldInstances"},
                                 typeof(target.fieldInstances))
  assert("iid" in source,
         "iid" & " is missing while decoding " & "LdtkEntityInstance")
  target.iid = jsonTo(source{"iid"}, typeof(target.iid))
  assert("width" in source,
         "width" & " is missing while decoding " & "LdtkEntityInstance")
  target.width = jsonTo(source{"width"}, typeof(target.width))
  if "__worldX" in source and source{"__worldX"}.kind != JNull:
    target.worldX = some(jsonTo(source{"__worldX"},
                                typeof(unsafeGet(target.worldX))))
  assert("__grid" in source,
         "__grid" & " is missing while decoding " & "LdtkEntityInstance")
  target.grid = jsonTo(source{"__grid"}, typeof(target.grid))
  assert("__smartColor" in source,
         "__smartColor" & " is missing while decoding " & "LdtkEntityInstance")
  target.smartColor = jsonTo(source{"__smartColor"}, typeof(target.smartColor))

proc toJsonHook*(source: LdtkEntityInstance): JsonNode =
  result = newJObject()
  if isSome(source.worldY):
    result{"__worldY"} = toJson(source.worldY)
  if isSome(source.tile):
    result{"__tile"} = toJson(source.tile)
  result{"__identifier"} = toJson(source.identifier)
  result{"__tags"} = toJson(source.tags)
  result{"height"} = toJson(source.height)
  result{"px"} = toJson(source.px)
  result{"defUid"} = toJson(source.defUid)
  result{"__pivot"} = toJson(source.pivot)
  result{"fieldInstances"} = toJson(source.fieldInstances)
  result{"iid"} = toJson(source.iid)
  result{"width"} = toJson(source.width)
  if isSome(source.worldX):
    result{"__worldX"} = toJson(source.worldX)
  result{"__grid"} = toJson(source.grid)
  result{"__smartColor"} = toJson(source.smartColor)

proc fromJsonHook*(target: var LdtkLayerInstance; source: JsonNode) =
  assert("__opacity" in source,
         "__opacity" & " is missing while decoding " & "LdtkLayerInstance")
  target.opacity = jsonTo(source{"__opacity"}, typeof(target.opacity))
  assert("optionalRules" in source,
         "optionalRules" & " is missing while decoding " & "LdtkLayerInstance")
  target.optionalRules = jsonTo(source{"optionalRules"},
                                typeof(target.optionalRules))
  assert("__gridSize" in source,
         "__gridSize" & " is missing while decoding " & "LdtkLayerInstance")
  target.gridSize = jsonTo(source{"__gridSize"}, typeof(target.gridSize))
  assert("__pxTotalOffsetX" in source, "__pxTotalOffsetX" &
      " is missing while decoding " &
      "LdtkLayerInstance")
  target.pxTotalOffsetX = jsonTo(source{"__pxTotalOffsetX"},
                                 typeof(target.pxTotalOffsetX))
  assert("gridTiles" in source,
         "gridTiles" & " is missing while decoding " & "LdtkLayerInstance")
  target.gridTiles = jsonTo(source{"gridTiles"}, typeof(target.gridTiles))
  assert("__type" in source,
         "__type" & " is missing while decoding " & "LdtkLayerInstance")
  target.`type` = jsonTo(source{"__type"}, typeof(target.`type`))
  assert("__identifier" in source,
         "__identifier" & " is missing while decoding " & "LdtkLayerInstance")
  target.identifier = jsonTo(source{"__identifier"}, typeof(target.identifier))
  if "overrideTilesetUid" in source and
      source{"overrideTilesetUid"}.kind != JNull:
    target.overrideTilesetUid = some(jsonTo(source{"overrideTilesetUid"},
        typeof(unsafeGet(target.overrideTilesetUid))))
  assert("levelId" in source,
         "levelId" & " is missing while decoding " & "LdtkLayerInstance")
  target.levelId = jsonTo(source{"levelId"}, typeof(target.levelId))
  if "intGrid" in source and source{"intGrid"}.kind != JNull:
    target.intGrid = some(jsonTo(source{"intGrid"},
                                 typeof(unsafeGet(target.intGrid))))
  assert("autoLayerTiles" in source,
         "autoLayerTiles" & " is missing while decoding " & "LdtkLayerInstance")
  target.autoLayerTiles = jsonTo(source{"autoLayerTiles"},
                                 typeof(target.autoLayerTiles))
  assert("layerDefUid" in source,
         "layerDefUid" & " is missing while decoding " & "LdtkLayerInstance")
  target.layerDefUid = jsonTo(source{"layerDefUid"}, typeof(target.layerDefUid))
  assert("entityInstances" in source, "entityInstances" &
      " is missing while decoding " &
      "LdtkLayerInstance")
  target.entityInstances = jsonTo(source{"entityInstances"},
                                  typeof(target.entityInstances))
  assert("intGridCsv" in source,
         "intGridCsv" & " is missing while decoding " & "LdtkLayerInstance")
  target.intGridCsv = jsonTo(source{"intGridCsv"}, typeof(target.intGridCsv))
  assert("pxOffsetX" in source,
         "pxOffsetX" & " is missing while decoding " & "LdtkLayerInstance")
  target.pxOffsetX = jsonTo(source{"pxOffsetX"}, typeof(target.pxOffsetX))
  if "__tilesetRelPath" in source and
      source{"__tilesetRelPath"}.kind != JNull:
    target.tilesetRelPath = some(jsonTo(source{"__tilesetRelPath"}, typeof(
        unsafeGet(target.tilesetRelPath))))
  if "__tilesetDefUid" in source and source{"__tilesetDefUid"}.kind != JNull:
    target.tilesetDefUid = some(jsonTo(source{"__tilesetDefUid"},
                                       typeof(unsafeGet(target.tilesetDefUid))))
  assert("__cHei" in source,
         "__cHei" & " is missing while decoding " & "LdtkLayerInstance")
  target.cHei = jsonTo(source{"__cHei"}, typeof(target.cHei))
  assert("seed" in source,
         "seed" & " is missing while decoding " & "LdtkLayerInstance")
  target.seed = jsonTo(source{"seed"}, typeof(target.seed))
  assert("visible" in source,
         "visible" & " is missing while decoding " & "LdtkLayerInstance")
  target.visible = jsonTo(source{"visible"}, typeof(target.visible))
  assert("pxOffsetY" in source,
         "pxOffsetY" & " is missing while decoding " & "LdtkLayerInstance")
  target.pxOffsetY = jsonTo(source{"pxOffsetY"}, typeof(target.pxOffsetY))
  assert("iid" in source,
         "iid" & " is missing while decoding " & "LdtkLayerInstance")
  target.iid = jsonTo(source{"iid"}, typeof(target.iid))
  assert("__pxTotalOffsetY" in source, "__pxTotalOffsetY" &
      " is missing while decoding " &
      "LdtkLayerInstance")
  target.pxTotalOffsetY = jsonTo(source{"__pxTotalOffsetY"},
                                 typeof(target.pxTotalOffsetY))
  assert("__cWid" in source,
         "__cWid" & " is missing while decoding " & "LdtkLayerInstance")
  target.cWid = jsonTo(source{"__cWid"}, typeof(target.cWid))

proc toJsonHook*(source: LdtkLayerInstance): JsonNode =
  result = newJObject()
  result{"__opacity"} = toJson(source.opacity)
  result{"optionalRules"} = toJson(source.optionalRules)
  result{"__gridSize"} = toJson(source.gridSize)
  result{"__pxTotalOffsetX"} = toJson(source.pxTotalOffsetX)
  result{"gridTiles"} = toJson(source.gridTiles)
  result{"__type"} = toJson(source.`type`)
  result{"__identifier"} = toJson(source.identifier)
  if isSome(source.overrideTilesetUid):
    result{"overrideTilesetUid"} = toJson(source.overrideTilesetUid)
  result{"levelId"} = toJson(source.levelId)
  if isSome(source.intGrid):
    result{"intGrid"} = toJson(source.intGrid)
  result{"autoLayerTiles"} = toJson(source.autoLayerTiles)
  result{"layerDefUid"} = toJson(source.layerDefUid)
  result{"entityInstances"} = toJson(source.entityInstances)
  result{"intGridCsv"} = toJson(source.intGridCsv)
  result{"pxOffsetX"} = toJson(source.pxOffsetX)
  if isSome(source.tilesetRelPath):
    result{"__tilesetRelPath"} = toJson(source.tilesetRelPath)
  if isSome(source.tilesetDefUid):
    result{"__tilesetDefUid"} = toJson(source.tilesetDefUid)
  result{"__cHei"} = toJson(source.cHei)
  result{"seed"} = toJson(source.seed)
  result{"visible"} = toJson(source.visible)
  result{"pxOffsetY"} = toJson(source.pxOffsetY)
  result{"iid"} = toJson(source.iid)
  result{"__pxTotalOffsetY"} = toJson(source.pxTotalOffsetY)
  result{"__cWid"} = toJson(source.cWid)

proc fromJsonHook*(target: var LdtkLevelBgPosInfos; source: JsonNode) =
  assert("scale" in source,
         "scale" & " is missing while decoding " & "LdtkLevelBgPosInfos")
  target.scale = jsonTo(source{"scale"}, typeof(target.scale))
  assert("cropRect" in source,
         "cropRect" & " is missing while decoding " & "LdtkLevelBgPosInfos")
  target.cropRect = jsonTo(source{"cropRect"}, typeof(target.cropRect))
  assert("topLeftPx" in source,
         "topLeftPx" & " is missing while decoding " & "LdtkLevelBgPosInfos")
  target.topLeftPx = jsonTo(source{"topLeftPx"}, typeof(target.topLeftPx))

proc toJsonHook*(source: LdtkLevelBgPosInfos): JsonNode =
  result = newJObject()
  result{"scale"} = toJson(source.scale)
  result{"cropRect"} = toJson(source.cropRect)
  result{"topLeftPx"} = toJson(source.topLeftPx)

proc fromJsonHook*(target: var LdtkLevel; source: JsonNode) =
  assert("pxHei" in source,
         "pxHei" & " is missing while decoding " & "LdtkLevel")
  target.pxHei = jsonTo(source{"pxHei"}, typeof(target.pxHei))
  assert("useAutoIdentifier" in source,
         "useAutoIdentifier" & " is missing while decoding " & "LdtkLevel")
  target.useAutoIdentifier = jsonTo(source{"useAutoIdentifier"},
                                    typeof(target.useAutoIdentifier))
  assert("__bgColor" in source,
         "__bgColor" & " is missing while decoding " & "LdtkLevel")
  target.bgColor = jsonTo(source{"__bgColor"}, typeof(target.bgColor))
  if "bgColor" in source and source{"bgColor"}.kind != JNull:
    target.bgColor1 = some(jsonTo(source{"bgColor"},
                                  typeof(unsafeGet(target.bgColor1))))
  if "externalRelPath" in source and source{"externalRelPath"}.kind != JNull:
    target.externalRelPath = some(jsonTo(source{"externalRelPath"},
        typeof(unsafeGet(target.externalRelPath))))
  assert("worldY" in source,
         "worldY" & " is missing while decoding " & "LdtkLevel")
  target.worldY = jsonTo(source{"worldY"}, typeof(target.worldY))
  if "bgRelPath" in source and source{"bgRelPath"}.kind != JNull:
    target.bgRelPath = some(jsonTo(source{"bgRelPath"},
                                   typeof(unsafeGet(target.bgRelPath))))
  assert("identifier" in source,
         "identifier" & " is missing while decoding " & "LdtkLevel")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  assert("pxWid" in source,
         "pxWid" & " is missing while decoding " & "LdtkLevel")
  target.pxWid = jsonTo(source{"pxWid"}, typeof(target.pxWid))
  assert("worldDepth" in source,
         "worldDepth" & " is missing while decoding " & "LdtkLevel")
  target.worldDepth = jsonTo(source{"worldDepth"}, typeof(target.worldDepth))
  assert("bgPivotX" in source,
         "bgPivotX" & " is missing while decoding " & "LdtkLevel")
  target.bgPivotX = jsonTo(source{"bgPivotX"}, typeof(target.bgPivotX))
  assert("__neighbours" in source,
         "__neighbours" & " is missing while decoding " & "LdtkLevel")
  target.neighbours = jsonTo(source{"__neighbours"}, typeof(target.neighbours))
  assert("uid" in source, "uid" & " is missing while decoding " & "LdtkLevel")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  if "bgPos" in source and source{"bgPos"}.kind != JNull:
    target.bgPos = some(jsonTo(source{"bgPos"}, typeof(unsafeGet(target.bgPos))))
  if "layerInstances" in source and source{"layerInstances"}.kind != JNull:
    target.layerInstances = some(jsonTo(source{"layerInstances"}, typeof(
        unsafeGet(target.layerInstances))))
  assert("fieldInstances" in source,
         "fieldInstances" & " is missing while decoding " & "LdtkLevel")
  target.fieldInstances = jsonTo(source{"fieldInstances"},
                                 typeof(target.fieldInstances))
  if "__bgPos" in source and source{"__bgPos"}.kind != JNull:
    target.bgPos1 = some(jsonTo(source{"__bgPos"},
                                typeof(unsafeGet(target.bgPos1))))
  assert("worldX" in source,
         "worldX" & " is missing while decoding " & "LdtkLevel")
  target.worldX = jsonTo(source{"worldX"}, typeof(target.worldX))
  assert("iid" in source, "iid" & " is missing while decoding " & "LdtkLevel")
  target.iid = jsonTo(source{"iid"}, typeof(target.iid))
  assert("bgPivotY" in source,
         "bgPivotY" & " is missing while decoding " & "LdtkLevel")
  target.bgPivotY = jsonTo(source{"bgPivotY"}, typeof(target.bgPivotY))
  assert("__smartColor" in source,
         "__smartColor" & " is missing while decoding " & "LdtkLevel")
  target.smartColor = jsonTo(source{"__smartColor"}, typeof(target.smartColor))

proc toJsonHook*(source: LdtkLevel): JsonNode =
  result = newJObject()
  result{"pxHei"} = toJson(source.pxHei)
  result{"useAutoIdentifier"} = toJson(source.useAutoIdentifier)
  result{"__bgColor"} = toJson(source.bgColor)
  if isSome(source.bgColor1):
    result{"bgColor"} = toJson(source.bgColor1)
  if isSome(source.externalRelPath):
    result{"externalRelPath"} = toJson(source.externalRelPath)
  result{"worldY"} = toJson(source.worldY)
  if isSome(source.bgRelPath):
    result{"bgRelPath"} = toJson(source.bgRelPath)
  result{"identifier"} = toJson(source.identifier)
  result{"pxWid"} = toJson(source.pxWid)
  result{"worldDepth"} = toJson(source.worldDepth)
  result{"bgPivotX"} = toJson(source.bgPivotX)
  result{"__neighbours"} = toJson(source.neighbours)
  result{"uid"} = toJson(source.uid)
  if isSome(source.bgPos):
    result{"bgPos"} = toJson(source.bgPos)
  if isSome(source.layerInstances):
    result{"layerInstances"} = toJson(source.layerInstances)
  result{"fieldInstances"} = toJson(source.fieldInstances)
  if isSome(source.bgPos1):
    result{"__bgPos"} = toJson(source.bgPos1)
  result{"worldX"} = toJson(source.worldX)
  result{"iid"} = toJson(source.iid)
  result{"bgPivotY"} = toJson(source.bgPivotY)
  result{"__smartColor"} = toJson(source.smartColor)

proc fromJsonHook*(target: var LdtkWorld; source: JsonNode) =
  assert("worldGridWidth" in source,
         "worldGridWidth" & " is missing while decoding " & "LdtkWorld")
  target.worldGridWidth = jsonTo(source{"worldGridWidth"},
                                 typeof(target.worldGridWidth))
  assert("defaultLevelHeight" in source,
         "defaultLevelHeight" & " is missing while decoding " & "LdtkWorld")
  target.defaultLevelHeight = jsonTo(source{"defaultLevelHeight"},
                                     typeof(target.defaultLevelHeight))
  assert("identifier" in source,
         "identifier" & " is missing while decoding " & "LdtkWorld")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  if "worldLayout" in source and source{"worldLayout"}.kind != JNull:
    target.worldLayout = some(jsonTo(source{"worldLayout"},
                                     typeof(unsafeGet(target.worldLayout))))
  assert("iid" in source, "iid" & " is missing while decoding " & "LdtkWorld")
  target.iid = jsonTo(source{"iid"}, typeof(target.iid))
  assert("defaultLevelWidth" in source,
         "defaultLevelWidth" & " is missing while decoding " & "LdtkWorld")
  target.defaultLevelWidth = jsonTo(source{"defaultLevelWidth"},
                                    typeof(target.defaultLevelWidth))
  assert("worldGridHeight" in source,
         "worldGridHeight" & " is missing while decoding " & "LdtkWorld")
  target.worldGridHeight = jsonTo(source{"worldGridHeight"},
                                  typeof(target.worldGridHeight))
  assert("levels" in source,
         "levels" & " is missing while decoding " & "LdtkWorld")
  target.levels = jsonTo(source{"levels"}, typeof(target.levels))

proc toJsonHook*(source: LdtkWorld): JsonNode =
  result = newJObject()
  result{"worldGridWidth"} = toJson(source.worldGridWidth)
  result{"defaultLevelHeight"} = toJson(source.defaultLevelHeight)
  result{"identifier"} = toJson(source.identifier)
  if isSome(source.worldLayout):
    result{"worldLayout"} = toJson(source.worldLayout)
  result{"iid"} = toJson(source.iid)
  result{"defaultLevelWidth"} = toJson(source.defaultLevelWidth)
  result{"worldGridHeight"} = toJson(source.worldGridHeight)
  result{"levels"} = toJson(source.levels)

proc toJsonHook*(source: LdtkImageExportMode): JsonNode =
  case source
  of LdtkImageExportMode.LayersAndLevels:
    return newJString("LayersAndLevels")
  of LdtkImageExportMode.OneImagePerLayer:
    return newJString("OneImagePerLayer")
  of LdtkImageExportMode.None:
    return newJString("None")
  of LdtkImageExportMode.OneImagePerLevel:
    return newJString("OneImagePerLevel")
  
proc fromJsonHook*(target: var LdtkImageExportMode; source: JsonNode) =
  target = case getStr(source)
  of "LayersAndLevels":
    LdtkImageExportMode.LayersAndLevels
  of "OneImagePerLayer":
    LdtkImageExportMode.OneImagePerLayer
  of "None":
    LdtkImageExportMode.None
  of "OneImagePerLevel":
    LdtkImageExportMode.OneImagePerLevel
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var LdtkIntGridValueDef; source: JsonNode) =
  if "tile" in source and source{"tile"}.kind != JNull:
    target.tile = some(jsonTo(source{"tile"}, typeof(unsafeGet(target.tile))))
  assert("color" in source,
         "color" & " is missing while decoding " & "LdtkIntGridValueDef")
  target.color = jsonTo(source{"color"}, typeof(target.color))
  if "identifier" in source and source{"identifier"}.kind != JNull:
    target.identifier = some(jsonTo(source{"identifier"},
                                    typeof(unsafeGet(target.identifier))))
  assert("groupUid" in source,
         "groupUid" & " is missing while decoding " & "LdtkIntGridValueDef")
  target.groupUid = jsonTo(source{"groupUid"}, typeof(target.groupUid))
  assert("value" in source,
         "value" & " is missing while decoding " & "LdtkIntGridValueDef")
  target.value = jsonTo(source{"value"}, typeof(target.value))

proc toJsonHook*(source: LdtkIntGridValueDef): JsonNode =
  result = newJObject()
  if isSome(source.tile):
    result{"tile"} = toJson(source.tile)
  result{"color"} = toJson(source.color)
  if isSome(source.identifier):
    result{"identifier"} = toJson(source.identifier)
  result{"groupUid"} = toJson(source.groupUid)
  result{"value"} = toJson(source.value)

proc toJsonHook*(source: LdtkTextLanguageMode): JsonNode =
  case source
  of LdtkTextLanguageMode.LangMarkdown:
    return newJString("LangMarkdown")
  of LdtkTextLanguageMode.LangPython:
    return newJString("LangPython")
  of LdtkTextLanguageMode.LangLog:
    return newJString("LangLog")
  of LdtkTextLanguageMode.LangC:
    return newJString("LangC")
  of LdtkTextLanguageMode.LangLua:
    return newJString("LangLua")
  of LdtkTextLanguageMode.LangHaxe:
    return newJString("LangHaxe")
  of LdtkTextLanguageMode.LangJS:
    return newJString("LangJS")
  of LdtkTextLanguageMode.LangRuby:
    return newJString("LangRuby")
  of LdtkTextLanguageMode.LangJson:
    return newJString("LangJson")
  of LdtkTextLanguageMode.LangXml:
    return newJString("LangXml")
  
proc fromJsonHook*(target: var LdtkTextLanguageMode; source: JsonNode) =
  target = case getStr(source)
  of "LangMarkdown":
    LdtkTextLanguageMode.LangMarkdown
  of "LangPython":
    LdtkTextLanguageMode.LangPython
  of "LangLog":
    LdtkTextLanguageMode.LangLog
  of "LangC":
    LdtkTextLanguageMode.LangC
  of "LangLua":
    LdtkTextLanguageMode.LangLua
  of "LangHaxe":
    LdtkTextLanguageMode.LangHaxe
  of "LangJS":
    LdtkTextLanguageMode.LangJS
  of "LangRuby":
    LdtkTextLanguageMode.LangRuby
  of "LangJson":
    LdtkTextLanguageMode.LangJson
  of "LangXml":
    LdtkTextLanguageMode.LangXml
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc toJsonHook*(source: LdtkEditorDisplayPos): JsonNode =
  case source
  of LdtkEditorDisplayPos.Beneath:
    return newJString("Beneath")
  of LdtkEditorDisplayPos.Above:
    return newJString("Above")
  of LdtkEditorDisplayPos.Center:
    return newJString("Center")
  
proc fromJsonHook*(target: var LdtkEditorDisplayPos; source: JsonNode) =
  target = case getStr(source)
  of "Beneath":
    LdtkEditorDisplayPos.Beneath
  of "Above":
    LdtkEditorDisplayPos.Above
  of "Center":
    LdtkEditorDisplayPos.Center
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc toJsonHook*(source: LdtkEditorDisplayMode): JsonNode =
  case source
  of LdtkEditorDisplayMode.PointPath:
    return newJString("PointPath")
  of LdtkEditorDisplayMode.PointStar:
    return newJString("PointStar")
  of LdtkEditorDisplayMode.ValueOnly:
    return newJString("ValueOnly")
  of LdtkEditorDisplayMode.Hidden:
    return newJString("Hidden")
  of LdtkEditorDisplayMode.Points:
    return newJString("Points")
  of LdtkEditorDisplayMode.NameAndValue:
    return newJString("NameAndValue")
  of LdtkEditorDisplayMode.ArrayCountNoLabel:
    return newJString("ArrayCountNoLabel")
  of LdtkEditorDisplayMode.EntityTile:
    return newJString("EntityTile")
  of LdtkEditorDisplayMode.PointPathLoop:
    return newJString("PointPathLoop")
  of LdtkEditorDisplayMode.RadiusPx:
    return newJString("RadiusPx")
  of LdtkEditorDisplayMode.LevelTile:
    return newJString("LevelTile")
  of LdtkEditorDisplayMode.RadiusGrid:
    return newJString("RadiusGrid")
  of LdtkEditorDisplayMode.RefLinkBetweenCenters:
    return newJString("RefLinkBetweenCenters")
  of LdtkEditorDisplayMode.RefLinkBetweenPivots:
    return newJString("RefLinkBetweenPivots")
  of LdtkEditorDisplayMode.ArrayCountWithLabel:
    return newJString("ArrayCountWithLabel")
  
proc fromJsonHook*(target: var LdtkEditorDisplayMode; source: JsonNode) =
  target = case getStr(source)
  of "PointPath":
    LdtkEditorDisplayMode.PointPath
  of "PointStar":
    LdtkEditorDisplayMode.PointStar
  of "ValueOnly":
    LdtkEditorDisplayMode.ValueOnly
  of "Hidden":
    LdtkEditorDisplayMode.Hidden
  of "Points":
    LdtkEditorDisplayMode.Points
  of "NameAndValue":
    LdtkEditorDisplayMode.NameAndValue
  of "ArrayCountNoLabel":
    LdtkEditorDisplayMode.ArrayCountNoLabel
  of "EntityTile":
    LdtkEditorDisplayMode.EntityTile
  of "PointPathLoop":
    LdtkEditorDisplayMode.PointPathLoop
  of "RadiusPx":
    LdtkEditorDisplayMode.RadiusPx
  of "LevelTile":
    LdtkEditorDisplayMode.LevelTile
  of "RadiusGrid":
    LdtkEditorDisplayMode.RadiusGrid
  of "RefLinkBetweenCenters":
    LdtkEditorDisplayMode.RefLinkBetweenCenters
  of "RefLinkBetweenPivots":
    LdtkEditorDisplayMode.RefLinkBetweenPivots
  of "ArrayCountWithLabel":
    LdtkEditorDisplayMode.ArrayCountWithLabel
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc toJsonHook*(source: LdtkEditorLinkStyle): JsonNode =
  case source
  of LdtkEditorLinkStyle.DashedLine:
    return newJString("DashedLine")
  of LdtkEditorLinkStyle.CurvedArrow:
    return newJString("CurvedArrow")
  of LdtkEditorLinkStyle.ArrowsLine:
    return newJString("ArrowsLine")
  of LdtkEditorLinkStyle.ZigZag:
    return newJString("ZigZag")
  of LdtkEditorLinkStyle.StraightArrow:
    return newJString("StraightArrow")
  
proc fromJsonHook*(target: var LdtkEditorLinkStyle; source: JsonNode) =
  target = case getStr(source)
  of "DashedLine":
    LdtkEditorLinkStyle.DashedLine
  of "CurvedArrow":
    LdtkEditorLinkStyle.CurvedArrow
  of "ArrowsLine":
    LdtkEditorLinkStyle.ArrowsLine
  of "ZigZag":
    LdtkEditorLinkStyle.ZigZag
  of "StraightArrow":
    LdtkEditorLinkStyle.StraightArrow
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc toJsonHook*(source: LdtkAllowedRefs): JsonNode =
  case source
  of LdtkAllowedRefs.Any:
    return newJString("Any")
  of LdtkAllowedRefs.OnlyTags:
    return newJString("OnlyTags")
  of LdtkAllowedRefs.OnlySame:
    return newJString("OnlySame")
  of LdtkAllowedRefs.OnlySpecificEntity:
    return newJString("OnlySpecificEntity")
  
proc fromJsonHook*(target: var LdtkAllowedRefs; source: JsonNode) =
  target = case getStr(source)
  of "Any":
    LdtkAllowedRefs.Any
  of "OnlyTags":
    LdtkAllowedRefs.OnlyTags
  of "OnlySame":
    LdtkAllowedRefs.OnlySame
  of "OnlySpecificEntity":
    LdtkAllowedRefs.OnlySpecificEntity
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var LdtkFieldDef; source: JsonNode) =
  assert("type" in source,
         "type" & " is missing while decoding " & "LdtkFieldDef")
  target.type1 = jsonTo(source{"type"}, typeof(target.type1))
  assert("editorDisplayScale" in source,
         "editorDisplayScale" & " is missing while decoding " & "LdtkFieldDef")
  target.editorDisplayScale = jsonTo(source{"editorDisplayScale"},
                                     typeof(target.editorDisplayScale))
  assert("__type" in source,
         "__type" & " is missing while decoding " & "LdtkFieldDef")
  target.`type` = jsonTo(source{"__type"}, typeof(target.`type`))
  if "allowedRefsEntityUid" in source and
      source{"allowedRefsEntityUid"}.kind != JNull:
    target.allowedRefsEntityUid = some(jsonTo(
        source{"allowedRefsEntityUid"},
        typeof(unsafeGet(target.allowedRefsEntityUid))))
  if "textLanguageMode" in source and
      source{"textLanguageMode"}.kind != JNull:
    target.textLanguageMode = some(jsonTo(source{"textLanguageMode"},
        typeof(unsafeGet(target.textLanguageMode))))
  assert("editorAlwaysShow" in source,
         "editorAlwaysShow" & " is missing while decoding " & "LdtkFieldDef")
  target.editorAlwaysShow = jsonTo(source{"editorAlwaysShow"},
                                   typeof(target.editorAlwaysShow))
  if "defaultOverride" in source and source{"defaultOverride"}.kind != JNull:
    target.defaultOverride = some(jsonTo(source{"defaultOverride"},
        typeof(unsafeGet(target.defaultOverride))))
  assert("autoChainRef" in source,
         "autoChainRef" & " is missing while decoding " & "LdtkFieldDef")
  target.autoChainRef = jsonTo(source{"autoChainRef"},
                               typeof(target.autoChainRef))
  assert("editorDisplayPos" in source,
         "editorDisplayPos" & " is missing while decoding " & "LdtkFieldDef")
  target.editorDisplayPos = jsonTo(source{"editorDisplayPos"},
                                   typeof(target.editorDisplayPos))
  assert("editorDisplayMode" in source,
         "editorDisplayMode" & " is missing while decoding " & "LdtkFieldDef")
  target.editorDisplayMode = jsonTo(source{"editorDisplayMode"},
                                    typeof(target.editorDisplayMode))
  assert("identifier" in source,
         "identifier" & " is missing while decoding " & "LdtkFieldDef")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  if "regex" in source and source{"regex"}.kind != JNull:
    target.regex = some(jsonTo(source{"regex"}, typeof(unsafeGet(target.regex))))
  assert("isArray" in source,
         "isArray" & " is missing while decoding " & "LdtkFieldDef")
  target.isArray = jsonTo(source{"isArray"}, typeof(target.isArray))
  assert("editorLinkStyle" in source,
         "editorLinkStyle" & " is missing while decoding " & "LdtkFieldDef")
  target.editorLinkStyle = jsonTo(source{"editorLinkStyle"},
                                  typeof(target.editorLinkStyle))
  assert("allowedRefs" in source,
         "allowedRefs" & " is missing while decoding " & "LdtkFieldDef")
  target.allowedRefs = jsonTo(source{"allowedRefs"}, typeof(target.allowedRefs))
  assert("useForSmartColor" in source,
         "useForSmartColor" & " is missing while decoding " & "LdtkFieldDef")
  target.useForSmartColor = jsonTo(source{"useForSmartColor"},
                                   typeof(target.useForSmartColor))
  if "editorTextSuffix" in source and
      source{"editorTextSuffix"}.kind != JNull:
    target.editorTextSuffix = some(jsonTo(source{"editorTextSuffix"},
        typeof(unsafeGet(target.editorTextSuffix))))
  if "doc" in source and source{"doc"}.kind != JNull:
    target.doc = some(jsonTo(source{"doc"}, typeof(unsafeGet(target.doc))))
  if "editorTextPrefix" in source and
      source{"editorTextPrefix"}.kind != JNull:
    target.editorTextPrefix = some(jsonTo(source{"editorTextPrefix"},
        typeof(unsafeGet(target.editorTextPrefix))))
  assert("editorCutLongValues" in source,
         "editorCutLongValues" & " is missing while decoding " & "LdtkFieldDef")
  target.editorCutLongValues = jsonTo(source{"editorCutLongValues"},
                                      typeof(target.editorCutLongValues))
  assert("canBeNull" in source,
         "canBeNull" & " is missing while decoding " & "LdtkFieldDef")
  target.canBeNull = jsonTo(source{"canBeNull"}, typeof(target.canBeNull))
  assert("allowedRefTags" in source,
         "allowedRefTags" & " is missing while decoding " & "LdtkFieldDef")
  target.allowedRefTags = jsonTo(source{"allowedRefTags"},
                                 typeof(target.allowedRefTags))
  assert("uid" in source, "uid" & " is missing while decoding " & "LdtkFieldDef")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  assert("symmetricalRef" in source,
         "symmetricalRef" & " is missing while decoding " & "LdtkFieldDef")
  target.symmetricalRef = jsonTo(source{"symmetricalRef"},
                                 typeof(target.symmetricalRef))
  if "editorDisplayColor" in source and
      source{"editorDisplayColor"}.kind != JNull:
    target.editorDisplayColor = some(jsonTo(source{"editorDisplayColor"},
        typeof(unsafeGet(target.editorDisplayColor))))
  assert("allowOutOfLevelRef" in source,
         "allowOutOfLevelRef" & " is missing while decoding " & "LdtkFieldDef")
  target.allowOutOfLevelRef = jsonTo(source{"allowOutOfLevelRef"},
                                     typeof(target.allowOutOfLevelRef))
  if "acceptFileTypes" in source and source{"acceptFileTypes"}.kind != JNull:
    target.acceptFileTypes = some(jsonTo(source{"acceptFileTypes"},
        typeof(unsafeGet(target.acceptFileTypes))))
  assert("editorShowInWorld" in source,
         "editorShowInWorld" & " is missing while decoding " & "LdtkFieldDef")
  target.editorShowInWorld = jsonTo(source{"editorShowInWorld"},
                                    typeof(target.editorShowInWorld))
  if "tilesetUid" in source and source{"tilesetUid"}.kind != JNull:
    target.tilesetUid = some(jsonTo(source{"tilesetUid"},
                                    typeof(unsafeGet(target.tilesetUid))))
  if "arrayMaxLength" in source and source{"arrayMaxLength"}.kind != JNull:
    target.arrayMaxLength = some(jsonTo(source{"arrayMaxLength"}, typeof(
        unsafeGet(target.arrayMaxLength))))
  if "arrayMinLength" in source and source{"arrayMinLength"}.kind != JNull:
    target.arrayMinLength = some(jsonTo(source{"arrayMinLength"}, typeof(
        unsafeGet(target.arrayMinLength))))
  assert("searchable" in source,
         "searchable" & " is missing while decoding " & "LdtkFieldDef")
  target.searchable = jsonTo(source{"searchable"}, typeof(target.searchable))
  if "min" in source and source{"min"}.kind != JNull:
    target.min = some(jsonTo(source{"min"}, typeof(unsafeGet(target.min))))
  assert("exportToToc" in source,
         "exportToToc" & " is missing while decoding " & "LdtkFieldDef")
  target.exportToToc = jsonTo(source{"exportToToc"}, typeof(target.exportToToc))
  if "max" in source and source{"max"}.kind != JNull:
    target.max = some(jsonTo(source{"max"}, typeof(unsafeGet(target.max))))

proc toJsonHook*(source: LdtkFieldDef): JsonNode =
  result = newJObject()
  result{"type"} = toJson(source.type1)
  result{"editorDisplayScale"} = toJson(source.editorDisplayScale)
  result{"__type"} = toJson(source.`type`)
  if isSome(source.allowedRefsEntityUid):
    result{"allowedRefsEntityUid"} = toJson(source.allowedRefsEntityUid)
  if isSome(source.textLanguageMode):
    result{"textLanguageMode"} = toJson(source.textLanguageMode)
  result{"editorAlwaysShow"} = toJson(source.editorAlwaysShow)
  if isSome(source.defaultOverride):
    result{"defaultOverride"} = toJson(source.defaultOverride)
  result{"autoChainRef"} = toJson(source.autoChainRef)
  result{"editorDisplayPos"} = toJson(source.editorDisplayPos)
  result{"editorDisplayMode"} = toJson(source.editorDisplayMode)
  result{"identifier"} = toJson(source.identifier)
  if isSome(source.regex):
    result{"regex"} = toJson(source.regex)
  result{"isArray"} = toJson(source.isArray)
  result{"editorLinkStyle"} = toJson(source.editorLinkStyle)
  result{"allowedRefs"} = toJson(source.allowedRefs)
  result{"useForSmartColor"} = toJson(source.useForSmartColor)
  if isSome(source.editorTextSuffix):
    result{"editorTextSuffix"} = toJson(source.editorTextSuffix)
  if isSome(source.doc):
    result{"doc"} = toJson(source.doc)
  if isSome(source.editorTextPrefix):
    result{"editorTextPrefix"} = toJson(source.editorTextPrefix)
  result{"editorCutLongValues"} = toJson(source.editorCutLongValues)
  result{"canBeNull"} = toJson(source.canBeNull)
  result{"allowedRefTags"} = toJson(source.allowedRefTags)
  result{"uid"} = toJson(source.uid)
  result{"symmetricalRef"} = toJson(source.symmetricalRef)
  if isSome(source.editorDisplayColor):
    result{"editorDisplayColor"} = toJson(source.editorDisplayColor)
  result{"allowOutOfLevelRef"} = toJson(source.allowOutOfLevelRef)
  if isSome(source.acceptFileTypes):
    result{"acceptFileTypes"} = toJson(source.acceptFileTypes)
  result{"editorShowInWorld"} = toJson(source.editorShowInWorld)
  if isSome(source.tilesetUid):
    result{"tilesetUid"} = toJson(source.tilesetUid)
  if isSome(source.arrayMaxLength):
    result{"arrayMaxLength"} = toJson(source.arrayMaxLength)
  if isSome(source.arrayMinLength):
    result{"arrayMinLength"} = toJson(source.arrayMinLength)
  result{"searchable"} = toJson(source.searchable)
  if isSome(source.min):
    result{"min"} = toJson(source.min)
  result{"exportToToc"} = toJson(source.exportToToc)
  if isSome(source.max):
    result{"max"} = toJson(source.max)

proc toJsonHook*(source: LdtkEmbedAtlas): JsonNode =
  case source
  of LdtkEmbedAtlas.LdtkIcons:
    return newJString("LdtkIcons")
  
proc fromJsonHook*(target: var LdtkEmbedAtlas; source: JsonNode) =
  target = case getStr(source)
  of "LdtkIcons":
    LdtkEmbedAtlas.LdtkIcons
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var LdtkEnumTagValue; source: JsonNode) =
  assert("tileIds" in source,
         "tileIds" & " is missing while decoding " & "LdtkEnumTagValue")
  target.tileIds = jsonTo(source{"tileIds"}, typeof(target.tileIds))
  assert("enumValueId" in source,
         "enumValueId" & " is missing while decoding " & "LdtkEnumTagValue")
  target.enumValueId = jsonTo(source{"enumValueId"}, typeof(target.enumValueId))

proc toJsonHook*(source: LdtkEnumTagValue): JsonNode =
  result = newJObject()
  result{"tileIds"} = toJson(source.tileIds)
  result{"enumValueId"} = toJson(source.enumValueId)

proc fromJsonHook*(target: var LdtkTileCustomMetadata; source: JsonNode) =
  assert("data" in source,
         "data" & " is missing while decoding " & "LdtkTileCustomMetadata")
  target.data = jsonTo(source{"data"}, typeof(target.data))
  assert("tileId" in source,
         "tileId" & " is missing while decoding " & "LdtkTileCustomMetadata")
  target.tileId = jsonTo(source{"tileId"}, typeof(target.tileId))

proc toJsonHook*(source: LdtkTileCustomMetadata): JsonNode =
  result = newJObject()
  result{"data"} = toJson(source.data)
  result{"tileId"} = toJson(source.tileId)

proc fromJsonHook*(target: var LdtkTilesetDef; source: JsonNode) =
  assert("pxHei" in source,
         "pxHei" & " is missing while decoding " & "LdtkTilesetDef")
  target.pxHei = jsonTo(source{"pxHei"}, typeof(target.pxHei))
  assert("savedSelections" in source,
         "savedSelections" & " is missing while decoding " & "LdtkTilesetDef")
  target.savedSelections = jsonTo(source{"savedSelections"},
                                  typeof(target.savedSelections))
  assert("padding" in source,
         "padding" & " is missing while decoding " & "LdtkTilesetDef")
  target.padding = jsonTo(source{"padding"}, typeof(target.padding))
  assert("spacing" in source,
         "spacing" & " is missing while decoding " & "LdtkTilesetDef")
  target.spacing = jsonTo(source{"spacing"}, typeof(target.spacing))
  if "tagsSourceEnumUid" in source and
      source{"tagsSourceEnumUid"}.kind != JNull:
    target.tagsSourceEnumUid = some(jsonTo(source{"tagsSourceEnumUid"},
        typeof(unsafeGet(target.tagsSourceEnumUid))))
  if "embedAtlas" in source and source{"embedAtlas"}.kind != JNull:
    target.embedAtlas = some(jsonTo(source{"embedAtlas"},
                                    typeof(unsafeGet(target.embedAtlas))))
  assert("identifier" in source,
         "identifier" & " is missing while decoding " & "LdtkTilesetDef")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  if "cachedPixelData" in source and source{"cachedPixelData"}.kind != JNull:
    target.cachedPixelData = some(jsonTo(source{"cachedPixelData"},
        typeof(unsafeGet(target.cachedPixelData))))
  assert("enumTags" in source,
         "enumTags" & " is missing while decoding " & "LdtkTilesetDef")
  target.enumTags = jsonTo(source{"enumTags"}, typeof(target.enumTags))
  assert("pxWid" in source,
         "pxWid" & " is missing while decoding " & "LdtkTilesetDef")
  target.pxWid = jsonTo(source{"pxWid"}, typeof(target.pxWid))
  assert("tileGridSize" in source,
         "tileGridSize" & " is missing while decoding " & "LdtkTilesetDef")
  target.tileGridSize = jsonTo(source{"tileGridSize"},
                               typeof(target.tileGridSize))
  assert("customData" in source,
         "customData" & " is missing while decoding " & "LdtkTilesetDef")
  target.customData = jsonTo(source{"customData"}, typeof(target.customData))
  assert("uid" in source,
         "uid" & " is missing while decoding " & "LdtkTilesetDef")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  assert("__cHei" in source,
         "__cHei" & " is missing while decoding " & "LdtkTilesetDef")
  target.cHei = jsonTo(source{"__cHei"}, typeof(target.cHei))
  assert("__cWid" in source,
         "__cWid" & " is missing while decoding " & "LdtkTilesetDef")
  target.cWid = jsonTo(source{"__cWid"}, typeof(target.cWid))
  if "relPath" in source and source{"relPath"}.kind != JNull:
    target.relPath = some(jsonTo(source{"relPath"},
                                 typeof(unsafeGet(target.relPath))))
  assert("tags" in source,
         "tags" & " is missing while decoding " & "LdtkTilesetDef")
  target.tags = jsonTo(source{"tags"}, typeof(target.tags))

proc toJsonHook*(source: LdtkTilesetDef): JsonNode =
  result = newJObject()
  result{"pxHei"} = toJson(source.pxHei)
  result{"savedSelections"} = toJson(source.savedSelections)
  result{"padding"} = toJson(source.padding)
  result{"spacing"} = toJson(source.spacing)
  if isSome(source.tagsSourceEnumUid):
    result{"tagsSourceEnumUid"} = toJson(source.tagsSourceEnumUid)
  if isSome(source.embedAtlas):
    result{"embedAtlas"} = toJson(source.embedAtlas)
  result{"identifier"} = toJson(source.identifier)
  if isSome(source.cachedPixelData):
    result{"cachedPixelData"} = toJson(source.cachedPixelData)
  result{"enumTags"} = toJson(source.enumTags)
  result{"pxWid"} = toJson(source.pxWid)
  result{"tileGridSize"} = toJson(source.tileGridSize)
  result{"customData"} = toJson(source.customData)
  result{"uid"} = toJson(source.uid)
  result{"__cHei"} = toJson(source.cHei)
  result{"__cWid"} = toJson(source.cWid)
  if isSome(source.relPath):
    result{"relPath"} = toJson(source.relPath)
  result{"tags"} = toJson(source.tags)

proc toJsonHook*(source: LdtkLimitScope): JsonNode =
  case source
  of LdtkLimitScope.PerLayer:
    return newJString("PerLayer")
  of LdtkLimitScope.PerWorld:
    return newJString("PerWorld")
  of LdtkLimitScope.PerLevel:
    return newJString("PerLevel")
  
proc fromJsonHook*(target: var LdtkLimitScope; source: JsonNode) =
  target = case getStr(source)
  of "PerLayer":
    LdtkLimitScope.PerLayer
  of "PerWorld":
    LdtkLimitScope.PerWorld
  of "PerLevel":
    LdtkLimitScope.PerLevel
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc toJsonHook*(source: LdtkLimitBehavior): JsonNode =
  case source
  of LdtkLimitBehavior.PreventAdding:
    return newJString("PreventAdding")
  of LdtkLimitBehavior.MoveLastOne:
    return newJString("MoveLastOne")
  of LdtkLimitBehavior.DiscardOldOnes:
    return newJString("DiscardOldOnes")
  
proc fromJsonHook*(target: var LdtkLimitBehavior; source: JsonNode) =
  target = case getStr(source)
  of "PreventAdding":
    LdtkLimitBehavior.PreventAdding
  of "MoveLastOne":
    LdtkLimitBehavior.MoveLastOne
  of "DiscardOldOnes":
    LdtkLimitBehavior.DiscardOldOnes
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc toJsonHook*(source: LdtkRenderMode): JsonNode =
  case source
  of LdtkRenderMode.Tile:
    return newJString("Tile")
  of LdtkRenderMode.Cross:
    return newJString("Cross")
  of LdtkRenderMode.Ellipse:
    return newJString("Ellipse")
  of LdtkRenderMode.Rectangle:
    return newJString("Rectangle")
  
proc fromJsonHook*(target: var LdtkRenderMode; source: JsonNode) =
  target = case getStr(source)
  of "Tile":
    LdtkRenderMode.Tile
  of "Cross":
    LdtkRenderMode.Cross
  of "Ellipse":
    LdtkRenderMode.Ellipse
  of "Rectangle":
    LdtkRenderMode.Rectangle
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc toJsonHook*(source: LdtkTileRenderMode): JsonNode =
  case source
  of LdtkTileRenderMode.FullSizeCropped:
    return newJString("FullSizeCropped")
  of LdtkTileRenderMode.FullSizeUncropped:
    return newJString("FullSizeUncropped")
  of LdtkTileRenderMode.Repeat:
    return newJString("Repeat")
  of LdtkTileRenderMode.FitInside:
    return newJString("FitInside")
  of LdtkTileRenderMode.NineSlice:
    return newJString("NineSlice")
  of LdtkTileRenderMode.Cover:
    return newJString("Cover")
  of LdtkTileRenderMode.Stretch:
    return newJString("Stretch")
  
proc fromJsonHook*(target: var LdtkTileRenderMode; source: JsonNode) =
  target = case getStr(source)
  of "FullSizeCropped":
    LdtkTileRenderMode.FullSizeCropped
  of "FullSizeUncropped":
    LdtkTileRenderMode.FullSizeUncropped
  of "Repeat":
    LdtkTileRenderMode.Repeat
  of "FitInside":
    LdtkTileRenderMode.FitInside
  of "NineSlice":
    LdtkTileRenderMode.NineSlice
  of "Cover":
    LdtkTileRenderMode.Cover
  of "Stretch":
    LdtkTileRenderMode.Stretch
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var LdtkEntityDef; source: JsonNode) =
  assert("allowOutOfBounds" in source,
         "allowOutOfBounds" & " is missing while decoding " & "LdtkEntityDef")
  target.allowOutOfBounds = jsonTo(source{"allowOutOfBounds"},
                                   typeof(target.allowOutOfBounds))
  assert("pivotY" in source,
         "pivotY" & " is missing while decoding " & "LdtkEntityDef")
  target.pivotY = jsonTo(source{"pivotY"}, typeof(target.pivotY))
  assert("tileOpacity" in source,
         "tileOpacity" & " is missing while decoding " & "LdtkEntityDef")
  target.tileOpacity = jsonTo(source{"tileOpacity"}, typeof(target.tileOpacity))
  assert("color" in source,
         "color" & " is missing while decoding " & "LdtkEntityDef")
  target.color = jsonTo(source{"color"}, typeof(target.color))
  assert("limitScope" in source,
         "limitScope" & " is missing while decoding " & "LdtkEntityDef")
  target.limitScope = jsonTo(source{"limitScope"}, typeof(target.limitScope))
  assert("limitBehavior" in source,
         "limitBehavior" & " is missing while decoding " & "LdtkEntityDef")
  target.limitBehavior = jsonTo(source{"limitBehavior"},
                                typeof(target.limitBehavior))
  assert("hollow" in source,
         "hollow" & " is missing while decoding " & "LdtkEntityDef")
  target.hollow = jsonTo(source{"hollow"}, typeof(target.hollow))
  assert("height" in source,
         "height" & " is missing while decoding " & "LdtkEntityDef")
  target.height = jsonTo(source{"height"}, typeof(target.height))
  assert("renderMode" in source,
         "renderMode" & " is missing while decoding " & "LdtkEntityDef")
  target.renderMode = jsonTo(source{"renderMode"}, typeof(target.renderMode))
  if "tilesetId" in source and source{"tilesetId"}.kind != JNull:
    target.tilesetId = some(jsonTo(source{"tilesetId"},
                                   typeof(unsafeGet(target.tilesetId))))
  assert("keepAspectRatio" in source,
         "keepAspectRatio" & " is missing while decoding " & "LdtkEntityDef")
  target.keepAspectRatio = jsonTo(source{"keepAspectRatio"},
                                  typeof(target.keepAspectRatio))
  if "minWidth" in source and source{"minWidth"}.kind != JNull:
    target.minWidth = some(jsonTo(source{"minWidth"},
                                  typeof(unsafeGet(target.minWidth))))
  assert("showName" in source,
         "showName" & " is missing while decoding " & "LdtkEntityDef")
  target.showName = jsonTo(source{"showName"}, typeof(target.showName))
  assert("resizableX" in source,
         "resizableX" & " is missing while decoding " & "LdtkEntityDef")
  target.resizableX = jsonTo(source{"resizableX"}, typeof(target.resizableX))
  assert("identifier" in source,
         "identifier" & " is missing while decoding " & "LdtkEntityDef")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  assert("maxCount" in source,
         "maxCount" & " is missing while decoding " & "LdtkEntityDef")
  target.maxCount = jsonTo(source{"maxCount"}, typeof(target.maxCount))
  if "tileId" in source and source{"tileId"}.kind != JNull:
    target.tileId = some(jsonTo(source{"tileId"},
                                typeof(unsafeGet(target.tileId))))
  assert("pivotX" in source,
         "pivotX" & " is missing while decoding " & "LdtkEntityDef")
  target.pivotX = jsonTo(source{"pivotX"}, typeof(target.pivotX))
  if "doc" in source and source{"doc"}.kind != JNull:
    target.doc = some(jsonTo(source{"doc"}, typeof(unsafeGet(target.doc))))
  assert("fieldDefs" in source,
         "fieldDefs" & " is missing while decoding " & "LdtkEntityDef")
  target.fieldDefs = jsonTo(source{"fieldDefs"}, typeof(target.fieldDefs))
  assert("uid" in source,
         "uid" & " is missing while decoding " & "LdtkEntityDef")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  assert("tileRenderMode" in source,
         "tileRenderMode" & " is missing while decoding " & "LdtkEntityDef")
  target.tileRenderMode = jsonTo(source{"tileRenderMode"},
                                 typeof(target.tileRenderMode))
  if "uiTileRect" in source and source{"uiTileRect"}.kind != JNull:
    target.uiTileRect = some(jsonTo(source{"uiTileRect"},
                                    typeof(unsafeGet(target.uiTileRect))))
  assert("resizableY" in source,
         "resizableY" & " is missing while decoding " & "LdtkEntityDef")
  target.resizableY = jsonTo(source{"resizableY"}, typeof(target.resizableY))
  assert("lineOpacity" in source,
         "lineOpacity" & " is missing while decoding " & "LdtkEntityDef")
  target.lineOpacity = jsonTo(source{"lineOpacity"}, typeof(target.lineOpacity))
  if "minHeight" in source and source{"minHeight"}.kind != JNull:
    target.minHeight = some(jsonTo(source{"minHeight"},
                                   typeof(unsafeGet(target.minHeight))))
  if "tileRect" in source and source{"tileRect"}.kind != JNull:
    target.tileRect = some(jsonTo(source{"tileRect"},
                                  typeof(unsafeGet(target.tileRect))))
  assert("nineSliceBorders" in source,
         "nineSliceBorders" & " is missing while decoding " & "LdtkEntityDef")
  target.nineSliceBorders = jsonTo(source{"nineSliceBorders"},
                                   typeof(target.nineSliceBorders))
  if "maxWidth" in source and source{"maxWidth"}.kind != JNull:
    target.maxWidth = some(jsonTo(source{"maxWidth"},
                                  typeof(unsafeGet(target.maxWidth))))
  assert("width" in source,
         "width" & " is missing while decoding " & "LdtkEntityDef")
  target.width = jsonTo(source{"width"}, typeof(target.width))
  assert("tags" in source,
         "tags" & " is missing while decoding " & "LdtkEntityDef")
  target.tags = jsonTo(source{"tags"}, typeof(target.tags))
  if "maxHeight" in source and source{"maxHeight"}.kind != JNull:
    target.maxHeight = some(jsonTo(source{"maxHeight"},
                                   typeof(unsafeGet(target.maxHeight))))
  assert("exportToToc" in source,
         "exportToToc" & " is missing while decoding " & "LdtkEntityDef")
  target.exportToToc = jsonTo(source{"exportToToc"}, typeof(target.exportToToc))
  assert("fillOpacity" in source,
         "fillOpacity" & " is missing while decoding " & "LdtkEntityDef")
  target.fillOpacity = jsonTo(source{"fillOpacity"}, typeof(target.fillOpacity))

proc toJsonHook*(source: LdtkEntityDef): JsonNode =
  result = newJObject()
  result{"allowOutOfBounds"} = toJson(source.allowOutOfBounds)
  result{"pivotY"} = toJson(source.pivotY)
  result{"tileOpacity"} = toJson(source.tileOpacity)
  result{"color"} = toJson(source.color)
  result{"limitScope"} = toJson(source.limitScope)
  result{"limitBehavior"} = toJson(source.limitBehavior)
  result{"hollow"} = toJson(source.hollow)
  result{"height"} = toJson(source.height)
  result{"renderMode"} = toJson(source.renderMode)
  if isSome(source.tilesetId):
    result{"tilesetId"} = toJson(source.tilesetId)
  result{"keepAspectRatio"} = toJson(source.keepAspectRatio)
  if isSome(source.minWidth):
    result{"minWidth"} = toJson(source.minWidth)
  result{"showName"} = toJson(source.showName)
  result{"resizableX"} = toJson(source.resizableX)
  result{"identifier"} = toJson(source.identifier)
  result{"maxCount"} = toJson(source.maxCount)
  if isSome(source.tileId):
    result{"tileId"} = toJson(source.tileId)
  result{"pivotX"} = toJson(source.pivotX)
  if isSome(source.doc):
    result{"doc"} = toJson(source.doc)
  result{"fieldDefs"} = toJson(source.fieldDefs)
  result{"uid"} = toJson(source.uid)
  result{"tileRenderMode"} = toJson(source.tileRenderMode)
  if isSome(source.uiTileRect):
    result{"uiTileRect"} = toJson(source.uiTileRect)
  result{"resizableY"} = toJson(source.resizableY)
  result{"lineOpacity"} = toJson(source.lineOpacity)
  if isSome(source.minHeight):
    result{"minHeight"} = toJson(source.minHeight)
  if isSome(source.tileRect):
    result{"tileRect"} = toJson(source.tileRect)
  result{"nineSliceBorders"} = toJson(source.nineSliceBorders)
  if isSome(source.maxWidth):
    result{"maxWidth"} = toJson(source.maxWidth)
  result{"width"} = toJson(source.width)
  result{"tags"} = toJson(source.tags)
  if isSome(source.maxHeight):
    result{"maxHeight"} = toJson(source.maxHeight)
  result{"exportToToc"} = toJson(source.exportToToc)
  result{"fillOpacity"} = toJson(source.fillOpacity)

proc fromJsonHook*(target: var LdtkEnumDefValues; source: JsonNode) =
  if "__tileSrcRect" in source and source{"__tileSrcRect"}.kind != JNull:
    target.tileSrcRect = some(jsonTo(source{"__tileSrcRect"},
                                     typeof(unsafeGet(target.tileSrcRect))))
  assert("color" in source,
         "color" & " is missing while decoding " & "LdtkEnumDefValues")
  target.color = jsonTo(source{"color"}, typeof(target.color))
  assert("id" in source,
         "id" & " is missing while decoding " & "LdtkEnumDefValues")
  target.id = jsonTo(source{"id"}, typeof(target.id))
  if "tileId" in source and source{"tileId"}.kind != JNull:
    target.tileId = some(jsonTo(source{"tileId"},
                                typeof(unsafeGet(target.tileId))))
  if "tileRect" in source and source{"tileRect"}.kind != JNull:
    target.tileRect = some(jsonTo(source{"tileRect"},
                                  typeof(unsafeGet(target.tileRect))))

proc toJsonHook*(source: LdtkEnumDefValues): JsonNode =
  result = newJObject()
  if isSome(source.tileSrcRect):
    result{"__tileSrcRect"} = toJson(source.tileSrcRect)
  result{"color"} = toJson(source.color)
  result{"id"} = toJson(source.id)
  if isSome(source.tileId):
    result{"tileId"} = toJson(source.tileId)
  if isSome(source.tileRect):
    result{"tileRect"} = toJson(source.tileRect)

proc fromJsonHook*(target: var LdtkEnumDef; source: JsonNode) =
  assert("values" in source,
         "values" & " is missing while decoding " & "LdtkEnumDef")
  target.values = jsonTo(source{"values"}, typeof(target.values))
  if "externalRelPath" in source and source{"externalRelPath"}.kind != JNull:
    target.externalRelPath = some(jsonTo(source{"externalRelPath"},
        typeof(unsafeGet(target.externalRelPath))))
  assert("identifier" in source,
         "identifier" & " is missing while decoding " & "LdtkEnumDef")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  if "externalFileChecksum" in source and
      source{"externalFileChecksum"}.kind != JNull:
    target.externalFileChecksum = some(jsonTo(
        source{"externalFileChecksum"},
        typeof(unsafeGet(target.externalFileChecksum))))
  if "iconTilesetUid" in source and source{"iconTilesetUid"}.kind != JNull:
    target.iconTilesetUid = some(jsonTo(source{"iconTilesetUid"}, typeof(
        unsafeGet(target.iconTilesetUid))))
  assert("uid" in source, "uid" & " is missing while decoding " & "LdtkEnumDef")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  assert("tags" in source,
         "tags" & " is missing while decoding " & "LdtkEnumDef")
  target.tags = jsonTo(source{"tags"}, typeof(target.tags))

proc toJsonHook*(source: LdtkEnumDef): JsonNode =
  result = newJObject()
  result{"values"} = toJson(source.values)
  if isSome(source.externalRelPath):
    result{"externalRelPath"} = toJson(source.externalRelPath)
  result{"identifier"} = toJson(source.identifier)
  if isSome(source.externalFileChecksum):
    result{"externalFileChecksum"} = toJson(source.externalFileChecksum)
  if isSome(source.iconTilesetUid):
    result{"iconTilesetUid"} = toJson(source.iconTilesetUid)
  result{"uid"} = toJson(source.uid)
  result{"tags"} = toJson(source.tags)

proc toJsonHook*(source: LdtkType): JsonNode =
  case source
  of LdtkType.Tiles:
    return newJString("Tiles")
  of LdtkType.Entities:
    return newJString("Entities")
  of LdtkType.AutoLayer:
    return newJString("AutoLayer")
  of LdtkType.IntGrid:
    return newJString("IntGrid")
  
proc fromJsonHook*(target: var LdtkType; source: JsonNode) =
  target = case getStr(source)
  of "Tiles":
    LdtkType.Tiles
  of "Entities":
    LdtkType.Entities
  of "AutoLayer":
    LdtkType.AutoLayer
  of "IntGrid":
    LdtkType.IntGrid
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc toJsonHook*(source: LdtkChecker): JsonNode =
  case source
  of LdtkChecker.Horizontal:
    return newJString("Horizontal")
  of LdtkChecker.Vertical:
    return newJString("Vertical")
  of LdtkChecker.None:
    return newJString("None")
  
proc fromJsonHook*(target: var LdtkChecker; source: JsonNode) =
  target = case getStr(source)
  of "Horizontal":
    LdtkChecker.Horizontal
  of "Vertical":
    LdtkChecker.Vertical
  of "None":
    LdtkChecker.None
  else:
    raise newException(ValueError, "Unable to decode enum")
  
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
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var LdtkAutoRuleDef; source: JsonNode) =
  assert("checker" in source,
         "checker" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.checker = jsonTo(source{"checker"}, typeof(target.checker))
  assert("pivotY" in source,
         "pivotY" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.pivotY = jsonTo(source{"pivotY"}, typeof(target.pivotY))
  assert("breakOnMatch" in source,
         "breakOnMatch" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.breakOnMatch = jsonTo(source{"breakOnMatch"},
                               typeof(target.breakOnMatch))
  assert("perlinOctaves" in source,
         "perlinOctaves" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.perlinOctaves = jsonTo(source{"perlinOctaves"},
                                typeof(target.perlinOctaves))
  assert("yModulo" in source,
         "yModulo" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.yModulo = jsonTo(source{"yModulo"}, typeof(target.yModulo))
  assert("size" in source,
         "size" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.size = jsonTo(source{"size"}, typeof(target.size))
  assert("tileMode" in source,
         "tileMode" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.tileMode = jsonTo(source{"tileMode"}, typeof(target.tileMode))
  assert("tileRandomXMax" in source,
         "tileRandomXMax" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.tileRandomXMax = jsonTo(source{"tileRandomXMax"},
                                 typeof(target.tileRandomXMax))
  assert("tileRandomXMin" in source,
         "tileRandomXMin" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.tileRandomXMin = jsonTo(source{"tileRandomXMin"},
                                 typeof(target.tileRandomXMin))
  assert("xModulo" in source,
         "xModulo" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.xModulo = jsonTo(source{"xModulo"}, typeof(target.xModulo))
  assert("yOffset" in source,
         "yOffset" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.yOffset = jsonTo(source{"yOffset"}, typeof(target.yOffset))
  assert("flipX" in source,
         "flipX" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.flipX = jsonTo(source{"flipX"}, typeof(target.flipX))
  assert("tileYOffset" in source,
         "tileYOffset" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.tileYOffset = jsonTo(source{"tileYOffset"}, typeof(target.tileYOffset))
  assert("chance" in source,
         "chance" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.chance = jsonTo(source{"chance"}, typeof(target.chance))
  assert("tileRandomYMax" in source,
         "tileRandomYMax" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.tileRandomYMax = jsonTo(source{"tileRandomYMax"},
                                 typeof(target.tileRandomYMax))
  assert("perlinActive" in source,
         "perlinActive" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.perlinActive = jsonTo(source{"perlinActive"},
                               typeof(target.perlinActive))
  assert("perlinScale" in source,
         "perlinScale" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.perlinScale = jsonTo(source{"perlinScale"}, typeof(target.perlinScale))
  if "outOfBoundsValue" in source and
      source{"outOfBoundsValue"}.kind != JNull:
    target.outOfBoundsValue = some(jsonTo(source{"outOfBoundsValue"},
        typeof(unsafeGet(target.outOfBoundsValue))))
  assert("pivotX" in source,
         "pivotX" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.pivotX = jsonTo(source{"pivotX"}, typeof(target.pivotX))
  assert("flipY" in source,
         "flipY" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.flipY = jsonTo(source{"flipY"}, typeof(target.flipY))
  assert("active" in source,
         "active" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.active = jsonTo(source{"active"}, typeof(target.active))
  assert("uid" in source,
         "uid" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  if "tileIds" in source and source{"tileIds"}.kind != JNull:
    target.tileIds = some(jsonTo(source{"tileIds"},
                                 typeof(unsafeGet(target.tileIds))))
  assert("invalidated" in source,
         "invalidated" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.invalidated = jsonTo(source{"invalidated"}, typeof(target.invalidated))
  assert("pattern" in source,
         "pattern" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.pattern = jsonTo(source{"pattern"}, typeof(target.pattern))
  assert("alpha" in source,
         "alpha" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.alpha = jsonTo(source{"alpha"}, typeof(target.alpha))
  assert("tileRectsIds" in source,
         "tileRectsIds" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.tileRectsIds = jsonTo(source{"tileRectsIds"},
                               typeof(target.tileRectsIds))
  assert("tileXOffset" in source,
         "tileXOffset" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.tileXOffset = jsonTo(source{"tileXOffset"}, typeof(target.tileXOffset))
  assert("xOffset" in source,
         "xOffset" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.xOffset = jsonTo(source{"xOffset"}, typeof(target.xOffset))
  assert("tileRandomYMin" in source,
         "tileRandomYMin" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.tileRandomYMin = jsonTo(source{"tileRandomYMin"},
                                 typeof(target.tileRandomYMin))
  assert("perlinSeed" in source,
         "perlinSeed" & " is missing while decoding " & "LdtkAutoRuleDef")
  target.perlinSeed = jsonTo(source{"perlinSeed"}, typeof(target.perlinSeed))

proc toJsonHook*(source: LdtkAutoRuleDef): JsonNode =
  result = newJObject()
  result{"checker"} = toJson(source.checker)
  result{"pivotY"} = toJson(source.pivotY)
  result{"breakOnMatch"} = toJson(source.breakOnMatch)
  result{"perlinOctaves"} = toJson(source.perlinOctaves)
  result{"yModulo"} = toJson(source.yModulo)
  result{"size"} = toJson(source.size)
  result{"tileMode"} = toJson(source.tileMode)
  result{"tileRandomXMax"} = toJson(source.tileRandomXMax)
  result{"tileRandomXMin"} = toJson(source.tileRandomXMin)
  result{"xModulo"} = toJson(source.xModulo)
  result{"yOffset"} = toJson(source.yOffset)
  result{"flipX"} = toJson(source.flipX)
  result{"tileYOffset"} = toJson(source.tileYOffset)
  result{"chance"} = toJson(source.chance)
  result{"tileRandomYMax"} = toJson(source.tileRandomYMax)
  result{"perlinActive"} = toJson(source.perlinActive)
  result{"perlinScale"} = toJson(source.perlinScale)
  if isSome(source.outOfBoundsValue):
    result{"outOfBoundsValue"} = toJson(source.outOfBoundsValue)
  result{"pivotX"} = toJson(source.pivotX)
  result{"flipY"} = toJson(source.flipY)
  result{"active"} = toJson(source.active)
  result{"uid"} = toJson(source.uid)
  if isSome(source.tileIds):
    result{"tileIds"} = toJson(source.tileIds)
  result{"invalidated"} = toJson(source.invalidated)
  result{"pattern"} = toJson(source.pattern)
  result{"alpha"} = toJson(source.alpha)
  result{"tileRectsIds"} = toJson(source.tileRectsIds)
  result{"tileXOffset"} = toJson(source.tileXOffset)
  result{"xOffset"} = toJson(source.xOffset)
  result{"tileRandomYMin"} = toJson(source.tileRandomYMin)
  result{"perlinSeed"} = toJson(source.perlinSeed)

proc fromJsonHook*(target: var LdtkAutoLayerRuleGroup; source: JsonNode) =
  assert("isOptional" in source, "isOptional" & " is missing while decoding " &
      "LdtkAutoLayerRuleGroup")
  target.isOptional = jsonTo(source{"isOptional"}, typeof(target.isOptional))
  if "color" in source and source{"color"}.kind != JNull:
    target.color = some(jsonTo(source{"color"}, typeof(unsafeGet(target.color))))
  if "collapsed" in source and source{"collapsed"}.kind != JNull:
    target.collapsed = some(jsonTo(source{"collapsed"},
                                   typeof(unsafeGet(target.collapsed))))
  assert("usesWizard" in source, "usesWizard" & " is missing while decoding " &
      "LdtkAutoLayerRuleGroup")
  target.usesWizard = jsonTo(source{"usesWizard"}, typeof(target.usesWizard))
  assert("biomeRequirementMode" in source, "biomeRequirementMode" &
      " is missing while decoding " &
      "LdtkAutoLayerRuleGroup")
  target.biomeRequirementMode = jsonTo(source{"biomeRequirementMode"},
                                       typeof(target.biomeRequirementMode))
  assert("rules" in source,
         "rules" & " is missing while decoding " & "LdtkAutoLayerRuleGroup")
  target.rules = jsonTo(source{"rules"}, typeof(target.rules))
  if "icon" in source and source{"icon"}.kind != JNull:
    target.icon = some(jsonTo(source{"icon"}, typeof(unsafeGet(target.icon))))
  assert("active" in source,
         "active" & " is missing while decoding " & "LdtkAutoLayerRuleGroup")
  target.active = jsonTo(source{"active"}, typeof(target.active))
  assert("uid" in source,
         "uid" & " is missing while decoding " & "LdtkAutoLayerRuleGroup")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  assert("name" in source,
         "name" & " is missing while decoding " & "LdtkAutoLayerRuleGroup")
  target.name = jsonTo(source{"name"}, typeof(target.name))
  assert("requiredBiomeValues" in source, "requiredBiomeValues" &
      " is missing while decoding " &
      "LdtkAutoLayerRuleGroup")
  target.requiredBiomeValues = jsonTo(source{"requiredBiomeValues"},
                                      typeof(target.requiredBiomeValues))

proc toJsonHook*(source: LdtkAutoLayerRuleGroup): JsonNode =
  result = newJObject()
  result{"isOptional"} = toJson(source.isOptional)
  if isSome(source.color):
    result{"color"} = toJson(source.color)
  if isSome(source.collapsed):
    result{"collapsed"} = toJson(source.collapsed)
  result{"usesWizard"} = toJson(source.usesWizard)
  result{"biomeRequirementMode"} = toJson(source.biomeRequirementMode)
  result{"rules"} = toJson(source.rules)
  if isSome(source.icon):
    result{"icon"} = toJson(source.icon)
  result{"active"} = toJson(source.active)
  result{"uid"} = toJson(source.uid)
  result{"name"} = toJson(source.name)
  result{"requiredBiomeValues"} = toJson(source.requiredBiomeValues)

proc fromJsonHook*(target: var LdtkIntGridValueGroupDef; source: JsonNode) =
  if "color" in source and source{"color"}.kind != JNull:
    target.color = some(jsonTo(source{"color"}, typeof(unsafeGet(target.color))))
  if "identifier" in source and source{"identifier"}.kind != JNull:
    target.identifier = some(jsonTo(source{"identifier"},
                                    typeof(unsafeGet(target.identifier))))
  assert("uid" in source,
         "uid" & " is missing while decoding " & "LdtkIntGridValueGroupDef")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))

proc toJsonHook*(source: LdtkIntGridValueGroupDef): JsonNode =
  result = newJObject()
  if isSome(source.color):
    result{"color"} = toJson(source.color)
  if isSome(source.identifier):
    result{"identifier"} = toJson(source.identifier)
  result{"uid"} = toJson(source.uid)

proc fromJsonHook*(target: var LdtkLayerDef; source: JsonNode) =
  assert("type" in source,
         "type" & " is missing while decoding " & "LdtkLayerDef")
  target.type1 = jsonTo(source{"type"}, typeof(target.type1))
  if "autoTilesetDefUid" in source and
      source{"autoTilesetDefUid"}.kind != JNull:
    target.autoTilesetDefUid = some(jsonTo(source{"autoTilesetDefUid"},
        typeof(unsafeGet(target.autoTilesetDefUid))))
  assert("parallaxScaling" in source,
         "parallaxScaling" & " is missing while decoding " & "LdtkLayerDef")
  target.parallaxScaling = jsonTo(source{"parallaxScaling"},
                                  typeof(target.parallaxScaling))
  if "biomeFieldUid" in source and source{"biomeFieldUid"}.kind != JNull:
    target.biomeFieldUid = some(jsonTo(source{"biomeFieldUid"},
                                       typeof(unsafeGet(target.biomeFieldUid))))
  if "autoTilesKilledByOtherLayerUid" in source and
      source{"autoTilesKilledByOtherLayerUid"}.kind != JNull:
    target.autoTilesKilledByOtherLayerUid = some(jsonTo(
        source{"autoTilesKilledByOtherLayerUid"},
        typeof(unsafeGet(target.autoTilesKilledByOtherLayerUid))))
  assert("inactiveOpacity" in source,
         "inactiveOpacity" & " is missing while decoding " & "LdtkLayerDef")
  target.inactiveOpacity = jsonTo(source{"inactiveOpacity"},
                                  typeof(target.inactiveOpacity))
  assert("__type" in source,
         "__type" & " is missing while decoding " & "LdtkLayerDef")
  target.`type` = jsonTo(source{"__type"}, typeof(target.`type`))
  assert("autoRuleGroups" in source,
         "autoRuleGroups" & " is missing while decoding " & "LdtkLayerDef")
  target.autoRuleGroups = jsonTo(source{"autoRuleGroups"},
                                 typeof(target.autoRuleGroups))
  assert("gridSize" in source,
         "gridSize" & " is missing while decoding " & "LdtkLayerDef")
  target.gridSize = jsonTo(source{"gridSize"}, typeof(target.gridSize))
  assert("hideInList" in source,
         "hideInList" & " is missing while decoding " & "LdtkLayerDef")
  target.hideInList = jsonTo(source{"hideInList"}, typeof(target.hideInList))
  if "tilesetDefUid" in source and source{"tilesetDefUid"}.kind != JNull:
    target.tilesetDefUid = some(jsonTo(source{"tilesetDefUid"},
                                       typeof(unsafeGet(target.tilesetDefUid))))
  if "uiColor" in source and source{"uiColor"}.kind != JNull:
    target.uiColor = some(jsonTo(source{"uiColor"},
                                 typeof(unsafeGet(target.uiColor))))
  assert("requiredTags" in source,
         "requiredTags" & " is missing while decoding " & "LdtkLayerDef")
  target.requiredTags = jsonTo(source{"requiredTags"},
                               typeof(target.requiredTags))
  assert("tilePivotX" in source,
         "tilePivotX" & " is missing while decoding " & "LdtkLayerDef")
  target.tilePivotX = jsonTo(source{"tilePivotX"}, typeof(target.tilePivotX))
  assert("uiFilterTags" in source,
         "uiFilterTags" & " is missing while decoding " & "LdtkLayerDef")
  target.uiFilterTags = jsonTo(source{"uiFilterTags"},
                               typeof(target.uiFilterTags))
  assert("guideGridWid" in source,
         "guideGridWid" & " is missing while decoding " & "LdtkLayerDef")
  target.guideGridWid = jsonTo(source{"guideGridWid"},
                               typeof(target.guideGridWid))
  assert("parallaxFactorX" in source,
         "parallaxFactorX" & " is missing while decoding " & "LdtkLayerDef")
  target.parallaxFactorX = jsonTo(source{"parallaxFactorX"},
                                  typeof(target.parallaxFactorX))
  assert("identifier" in source,
         "identifier" & " is missing while decoding " & "LdtkLayerDef")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  assert("canSelectWhenInactive" in source, "canSelectWhenInactive" &
      " is missing while decoding " &
      "LdtkLayerDef")
  target.canSelectWhenInactive = jsonTo(source{"canSelectWhenInactive"},
                                        typeof(target.canSelectWhenInactive))
  assert("pxOffsetX" in source,
         "pxOffsetX" & " is missing while decoding " & "LdtkLayerDef")
  target.pxOffsetX = jsonTo(source{"pxOffsetX"}, typeof(target.pxOffsetX))
  assert("tilePivotY" in source,
         "tilePivotY" & " is missing while decoding " & "LdtkLayerDef")
  target.tilePivotY = jsonTo(source{"tilePivotY"}, typeof(target.tilePivotY))
  assert("excludedTags" in source,
         "excludedTags" & " is missing while decoding " & "LdtkLayerDef")
  target.excludedTags = jsonTo(source{"excludedTags"},
                               typeof(target.excludedTags))
  if "doc" in source and source{"doc"}.kind != JNull:
    target.doc = some(jsonTo(source{"doc"}, typeof(unsafeGet(target.doc))))
  assert("uid" in source, "uid" & " is missing while decoding " & "LdtkLayerDef")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  assert("guideGridHei" in source,
         "guideGridHei" & " is missing while decoding " & "LdtkLayerDef")
  target.guideGridHei = jsonTo(source{"guideGridHei"},
                               typeof(target.guideGridHei))
  if "autoSourceLayerDefUid" in source and
      source{"autoSourceLayerDefUid"}.kind != JNull:
    target.autoSourceLayerDefUid = some(jsonTo(
        source{"autoSourceLayerDefUid"},
        typeof(unsafeGet(target.autoSourceLayerDefUid))))
  assert("displayOpacity" in source,
         "displayOpacity" & " is missing while decoding " & "LdtkLayerDef")
  target.displayOpacity = jsonTo(source{"displayOpacity"},
                                 typeof(target.displayOpacity))
  assert("intGridValuesGroups" in source,
         "intGridValuesGroups" & " is missing while decoding " & "LdtkLayerDef")
  target.intGridValuesGroups = jsonTo(source{"intGridValuesGroups"},
                                      typeof(target.intGridValuesGroups))
  assert("hideFieldsWhenInactive" in source, "hideFieldsWhenInactive" &
      " is missing while decoding " &
      "LdtkLayerDef")
  target.hideFieldsWhenInactive = jsonTo(source{"hideFieldsWhenInactive"},
      typeof(target.hideFieldsWhenInactive))
  assert("useAsyncRender" in source,
         "useAsyncRender" & " is missing while decoding " & "LdtkLayerDef")
  target.useAsyncRender = jsonTo(source{"useAsyncRender"},
                                 typeof(target.useAsyncRender))
  assert("pxOffsetY" in source,
         "pxOffsetY" & " is missing while decoding " & "LdtkLayerDef")
  target.pxOffsetY = jsonTo(source{"pxOffsetY"}, typeof(target.pxOffsetY))
  assert("parallaxFactorY" in source,
         "parallaxFactorY" & " is missing while decoding " & "LdtkLayerDef")
  target.parallaxFactorY = jsonTo(source{"parallaxFactorY"},
                                  typeof(target.parallaxFactorY))
  assert("intGridValues" in source,
         "intGridValues" & " is missing while decoding " & "LdtkLayerDef")
  target.intGridValues = jsonTo(source{"intGridValues"},
                                typeof(target.intGridValues))
  assert("renderInWorldView" in source,
         "renderInWorldView" & " is missing while decoding " & "LdtkLayerDef")
  target.renderInWorldView = jsonTo(source{"renderInWorldView"},
                                    typeof(target.renderInWorldView))

proc toJsonHook*(source: LdtkLayerDef): JsonNode =
  result = newJObject()
  result{"type"} = toJson(source.type1)
  if isSome(source.autoTilesetDefUid):
    result{"autoTilesetDefUid"} = toJson(source.autoTilesetDefUid)
  result{"parallaxScaling"} = toJson(source.parallaxScaling)
  if isSome(source.biomeFieldUid):
    result{"biomeFieldUid"} = toJson(source.biomeFieldUid)
  if isSome(source.autoTilesKilledByOtherLayerUid):
    result{"autoTilesKilledByOtherLayerUid"} = toJson(
        source.autoTilesKilledByOtherLayerUid)
  result{"inactiveOpacity"} = toJson(source.inactiveOpacity)
  result{"__type"} = toJson(source.`type`)
  result{"autoRuleGroups"} = toJson(source.autoRuleGroups)
  result{"gridSize"} = toJson(source.gridSize)
  result{"hideInList"} = toJson(source.hideInList)
  if isSome(source.tilesetDefUid):
    result{"tilesetDefUid"} = toJson(source.tilesetDefUid)
  if isSome(source.uiColor):
    result{"uiColor"} = toJson(source.uiColor)
  result{"requiredTags"} = toJson(source.requiredTags)
  result{"tilePivotX"} = toJson(source.tilePivotX)
  result{"uiFilterTags"} = toJson(source.uiFilterTags)
  result{"guideGridWid"} = toJson(source.guideGridWid)
  result{"parallaxFactorX"} = toJson(source.parallaxFactorX)
  result{"identifier"} = toJson(source.identifier)
  result{"canSelectWhenInactive"} = toJson(source.canSelectWhenInactive)
  result{"pxOffsetX"} = toJson(source.pxOffsetX)
  result{"tilePivotY"} = toJson(source.tilePivotY)
  result{"excludedTags"} = toJson(source.excludedTags)
  if isSome(source.doc):
    result{"doc"} = toJson(source.doc)
  result{"uid"} = toJson(source.uid)
  result{"guideGridHei"} = toJson(source.guideGridHei)
  if isSome(source.autoSourceLayerDefUid):
    result{"autoSourceLayerDefUid"} = toJson(source.autoSourceLayerDefUid)
  result{"displayOpacity"} = toJson(source.displayOpacity)
  result{"intGridValuesGroups"} = toJson(source.intGridValuesGroups)
  result{"hideFieldsWhenInactive"} = toJson(source.hideFieldsWhenInactive)
  result{"useAsyncRender"} = toJson(source.useAsyncRender)
  result{"pxOffsetY"} = toJson(source.pxOffsetY)
  result{"parallaxFactorY"} = toJson(source.parallaxFactorY)
  result{"intGridValues"} = toJson(source.intGridValues)
  result{"renderInWorldView"} = toJson(source.renderInWorldView)

proc fromJsonHook*(target: var LdtkDefinitions; source: JsonNode) =
  assert("levelFields" in source,
         "levelFields" & " is missing while decoding " & "LdtkDefinitions")
  target.levelFields = jsonTo(source{"levelFields"}, typeof(target.levelFields))
  assert("tilesets" in source,
         "tilesets" & " is missing while decoding " & "LdtkDefinitions")
  target.tilesets = jsonTo(source{"tilesets"}, typeof(target.tilesets))
  assert("entities" in source,
         "entities" & " is missing while decoding " & "LdtkDefinitions")
  target.entities = jsonTo(source{"entities"}, typeof(target.entities))
  assert("enums" in source,
         "enums" & " is missing while decoding " & "LdtkDefinitions")
  target.enums = jsonTo(source{"enums"}, typeof(target.enums))
  assert("layers" in source,
         "layers" & " is missing while decoding " & "LdtkDefinitions")
  target.layers = jsonTo(source{"layers"}, typeof(target.layers))
  assert("externalEnums" in source,
         "externalEnums" & " is missing while decoding " & "LdtkDefinitions")
  target.externalEnums = jsonTo(source{"externalEnums"},
                                typeof(target.externalEnums))

proc toJsonHook*(source: LdtkDefinitions): JsonNode =
  result = newJObject()
  result{"levelFields"} = toJson(source.levelFields)
  result{"tilesets"} = toJson(source.tilesets)
  result{"entities"} = toJson(source.entities)
  result{"enums"} = toJson(source.enums)
  result{"layers"} = toJson(source.layers)
  result{"externalEnums"} = toJson(source.externalEnums)

proc fromJsonHook*(target: var LdtkGridPoint; source: JsonNode) =
  assert("cx" in source, "cx" & " is missing while decoding " & "LdtkGridPoint")
  target.cx = jsonTo(source{"cx"}, typeof(target.cx))
  assert("cy" in source, "cy" & " is missing while decoding " & "LdtkGridPoint")
  target.cy = jsonTo(source{"cy"}, typeof(target.cy))

proc toJsonHook*(source: LdtkGridPoint): JsonNode =
  result = newJObject()
  result{"cx"} = toJson(source.cx)
  result{"cy"} = toJson(source.cy)

proc fromJsonHook*(target: var Ldtk_FORCED_REFS; source: JsonNode) =
  if "CustomCommand" in source and source{"CustomCommand"}.kind != JNull:
    target.CustomCommand = some(jsonTo(source{"CustomCommand"},
                                       typeof(unsafeGet(target.CustomCommand))))
  if "IntGridValueDef" in source and source{"IntGridValueDef"}.kind != JNull:
    target.IntGridValueDef = some(jsonTo(source{"IntGridValueDef"},
        typeof(unsafeGet(target.IntGridValueDef))))
  if "Level" in source and source{"Level"}.kind != JNull:
    target.Level = some(jsonTo(source{"Level"}, typeof(unsafeGet(target.Level))))
  if "Definitions" in source and source{"Definitions"}.kind != JNull:
    target.Definitions = some(jsonTo(source{"Definitions"},
                                     typeof(unsafeGet(target.Definitions))))
  if "EnumDef" in source and source{"EnumDef"}.kind != JNull:
    target.EnumDef = some(jsonTo(source{"EnumDef"},
                                 typeof(unsafeGet(target.EnumDef))))
  if "FieldDef" in source and source{"FieldDef"}.kind != JNull:
    target.FieldDef = some(jsonTo(source{"FieldDef"},
                                  typeof(unsafeGet(target.FieldDef))))
  if "AutoLayerRuleGroup" in source and
      source{"AutoLayerRuleGroup"}.kind != JNull:
    target.AutoLayerRuleGroup = some(jsonTo(source{"AutoLayerRuleGroup"},
        typeof(unsafeGet(target.AutoLayerRuleGroup))))
  if "TilesetDef" in source and source{"TilesetDef"}.kind != JNull:
    target.TilesetDef = some(jsonTo(source{"TilesetDef"},
                                    typeof(unsafeGet(target.TilesetDef))))
  if "TableOfContentEntry" in source and
      source{"TableOfContentEntry"}.kind != JNull:
    target.TableOfContentEntry = some(jsonTo(source{"TableOfContentEntry"},
        typeof(unsafeGet(target.TableOfContentEntry))))
  if "EntityDef" in source and source{"EntityDef"}.kind != JNull:
    target.EntityDef = some(jsonTo(source{"EntityDef"},
                                   typeof(unsafeGet(target.EntityDef))))
  if "FieldInstance" in source and source{"FieldInstance"}.kind != JNull:
    target.FieldInstance = some(jsonTo(source{"FieldInstance"},
                                       typeof(unsafeGet(target.FieldInstance))))
  if "EntityReferenceInfos" in source and
      source{"EntityReferenceInfos"}.kind != JNull:
    target.EntityReferenceInfos = some(jsonTo(
        source{"EntityReferenceInfos"},
        typeof(unsafeGet(target.EntityReferenceInfos))))
  if "LevelBgPosInfos" in source and source{"LevelBgPosInfos"}.kind != JNull:
    target.LevelBgPosInfos = some(jsonTo(source{"LevelBgPosInfos"},
        typeof(unsafeGet(target.LevelBgPosInfos))))
  if "TileCustomMetadata" in source and
      source{"TileCustomMetadata"}.kind != JNull:
    target.TileCustomMetadata = some(jsonTo(source{"TileCustomMetadata"},
        typeof(unsafeGet(target.TileCustomMetadata))))
  if "Tile" in source and source{"Tile"}.kind != JNull:
    target.Tile = some(jsonTo(source{"Tile"}, typeof(unsafeGet(target.Tile))))
  if "AutoRuleDef" in source and source{"AutoRuleDef"}.kind != JNull:
    target.AutoRuleDef = some(jsonTo(source{"AutoRuleDef"},
                                     typeof(unsafeGet(target.AutoRuleDef))))
  if "NeighbourLevel" in source and source{"NeighbourLevel"}.kind != JNull:
    target.NeighbourLevel = some(jsonTo(source{"NeighbourLevel"}, typeof(
        unsafeGet(target.NeighbourLevel))))
  if "GridPoint" in source and source{"GridPoint"}.kind != JNull:
    target.GridPoint = some(jsonTo(source{"GridPoint"},
                                   typeof(unsafeGet(target.GridPoint))))
  if "EntityInstance" in source and source{"EntityInstance"}.kind != JNull:
    target.EntityInstance = some(jsonTo(source{"EntityInstance"}, typeof(
        unsafeGet(target.EntityInstance))))
  if "TilesetRect" in source and source{"TilesetRect"}.kind != JNull:
    target.TilesetRect = some(jsonTo(source{"TilesetRect"},
                                     typeof(unsafeGet(target.TilesetRect))))
  if "EnumTagValue" in source and source{"EnumTagValue"}.kind != JNull:
    target.EnumTagValue = some(jsonTo(source{"EnumTagValue"},
                                      typeof(unsafeGet(target.EnumTagValue))))
  if "LayerInstance" in source and source{"LayerInstance"}.kind != JNull:
    target.LayerInstance = some(jsonTo(source{"LayerInstance"},
                                       typeof(unsafeGet(target.LayerInstance))))
  if "IntGridValueInstance" in source and
      source{"IntGridValueInstance"}.kind != JNull:
    target.IntGridValueInstance = some(jsonTo(
        source{"IntGridValueInstance"},
        typeof(unsafeGet(target.IntGridValueInstance))))
  if "World" in source and source{"World"}.kind != JNull:
    target.World = some(jsonTo(source{"World"}, typeof(unsafeGet(target.World))))
  if "LayerDef" in source and source{"LayerDef"}.kind != JNull:
    target.LayerDef = some(jsonTo(source{"LayerDef"},
                                  typeof(unsafeGet(target.LayerDef))))
  if "IntGridValueGroupDef" in source and
      source{"IntGridValueGroupDef"}.kind != JNull:
    target.IntGridValueGroupDef = some(jsonTo(
        source{"IntGridValueGroupDef"},
        typeof(unsafeGet(target.IntGridValueGroupDef))))
  if "TocInstanceData" in source and source{"TocInstanceData"}.kind != JNull:
    target.TocInstanceData = some(jsonTo(source{"TocInstanceData"},
        typeof(unsafeGet(target.TocInstanceData))))
  if "EnumDefValues" in source and source{"EnumDefValues"}.kind != JNull:
    target.EnumDefValues = some(jsonTo(source{"EnumDefValues"},
                                       typeof(unsafeGet(target.EnumDefValues))))

proc toJsonHook*(source: Ldtk_FORCED_REFS): JsonNode =
  result = newJObject()
  if isSome(source.CustomCommand):
    result{"CustomCommand"} = toJson(source.CustomCommand)
  if isSome(source.IntGridValueDef):
    result{"IntGridValueDef"} = toJson(source.IntGridValueDef)
  if isSome(source.Level):
    result{"Level"} = toJson(source.Level)
  if isSome(source.Definitions):
    result{"Definitions"} = toJson(source.Definitions)
  if isSome(source.EnumDef):
    result{"EnumDef"} = toJson(source.EnumDef)
  if isSome(source.FieldDef):
    result{"FieldDef"} = toJson(source.FieldDef)
  if isSome(source.AutoLayerRuleGroup):
    result{"AutoLayerRuleGroup"} = toJson(source.AutoLayerRuleGroup)
  if isSome(source.TilesetDef):
    result{"TilesetDef"} = toJson(source.TilesetDef)
  if isSome(source.TableOfContentEntry):
    result{"TableOfContentEntry"} = toJson(source.TableOfContentEntry)
  if isSome(source.EntityDef):
    result{"EntityDef"} = toJson(source.EntityDef)
  if isSome(source.FieldInstance):
    result{"FieldInstance"} = toJson(source.FieldInstance)
  if isSome(source.EntityReferenceInfos):
    result{"EntityReferenceInfos"} = toJson(source.EntityReferenceInfos)
  if isSome(source.LevelBgPosInfos):
    result{"LevelBgPosInfos"} = toJson(source.LevelBgPosInfos)
  if isSome(source.TileCustomMetadata):
    result{"TileCustomMetadata"} = toJson(source.TileCustomMetadata)
  if isSome(source.Tile):
    result{"Tile"} = toJson(source.Tile)
  if isSome(source.AutoRuleDef):
    result{"AutoRuleDef"} = toJson(source.AutoRuleDef)
  if isSome(source.NeighbourLevel):
    result{"NeighbourLevel"} = toJson(source.NeighbourLevel)
  if isSome(source.GridPoint):
    result{"GridPoint"} = toJson(source.GridPoint)
  if isSome(source.EntityInstance):
    result{"EntityInstance"} = toJson(source.EntityInstance)
  if isSome(source.TilesetRect):
    result{"TilesetRect"} = toJson(source.TilesetRect)
  if isSome(source.EnumTagValue):
    result{"EnumTagValue"} = toJson(source.EnumTagValue)
  if isSome(source.LayerInstance):
    result{"LayerInstance"} = toJson(source.LayerInstance)
  if isSome(source.IntGridValueInstance):
    result{"IntGridValueInstance"} = toJson(source.IntGridValueInstance)
  if isSome(source.World):
    result{"World"} = toJson(source.World)
  if isSome(source.LayerDef):
    result{"LayerDef"} = toJson(source.LayerDef)
  if isSome(source.IntGridValueGroupDef):
    result{"IntGridValueGroupDef"} = toJson(source.IntGridValueGroupDef)
  if isSome(source.TocInstanceData):
    result{"TocInstanceData"} = toJson(source.TocInstanceData)
  if isSome(source.EnumDefValues):
    result{"EnumDefValues"} = toJson(source.EnumDefValues)

proc toJsonHook*(source: LdtkldtkWorldLayout): JsonNode =
  case source
  of LdtkldtkWorldLayout.LinearHorizontal:
    return newJString("LinearHorizontal")
  of LdtkldtkWorldLayout.LinearVertical:
    return newJString("LinearVertical")
  of LdtkldtkWorldLayout.GridVania:
    return newJString("GridVania")
  of LdtkldtkWorldLayout.Free:
    return newJString("Free")
  
proc fromJsonHook*(target: var LdtkldtkWorldLayout; source: JsonNode) =
  target = case getStr(source)
  of "LinearHorizontal":
    LdtkldtkWorldLayout.LinearHorizontal
  of "LinearVertical":
    LdtkldtkWorldLayout.LinearVertical
  of "GridVania":
    LdtkldtkWorldLayout.GridVania
  of "Free":
    LdtkldtkWorldLayout.Free
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc toJsonHook*(source: LdtkFlags): JsonNode =
  case source
  of LdtkFlags.ExportPreCsvIntGridFormat:
    return newJString("ExportPreCsvIntGridFormat")
  of LdtkFlags.DiscardPreCsvIntGrid:
    return newJString("DiscardPreCsvIntGrid")
  of LdtkFlags.ExportOldTableOfContentData:
    return newJString("ExportOldTableOfContentData")
  of LdtkFlags.PrependIndexToLevelFileNames:
    return newJString("PrependIndexToLevelFileNames")
  of LdtkFlags.MultiWorlds:
    return newJString("MultiWorlds")
  of LdtkFlags.UseMultilinesType:
    return newJString("UseMultilinesType")
  of LdtkFlags.IgnoreBackupSuggest:
    return newJString("IgnoreBackupSuggest")
  
proc fromJsonHook*(target: var LdtkFlags; source: JsonNode) =
  target = case getStr(source)
  of "ExportPreCsvIntGridFormat":
    LdtkFlags.ExportPreCsvIntGridFormat
  of "DiscardPreCsvIntGrid":
    LdtkFlags.DiscardPreCsvIntGrid
  of "ExportOldTableOfContentData":
    LdtkFlags.ExportOldTableOfContentData
  of "PrependIndexToLevelFileNames":
    LdtkFlags.PrependIndexToLevelFileNames
  of "MultiWorlds":
    LdtkFlags.MultiWorlds
  of "UseMultilinesType":
    LdtkFlags.UseMultilinesType
  of "IgnoreBackupSuggest":
    LdtkFlags.IgnoreBackupSuggest
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc toJsonHook*(source: LdtkIdentifierStyle): JsonNode =
  case source
  of LdtkIdentifierStyle.Lowercase:
    return newJString("Lowercase")
  of LdtkIdentifierStyle.Free:
    return newJString("Free")
  of LdtkIdentifierStyle.Capitalize:
    return newJString("Capitalize")
  of LdtkIdentifierStyle.Uppercase:
    return newJString("Uppercase")
  
proc fromJsonHook*(target: var LdtkIdentifierStyle; source: JsonNode) =
  target = case getStr(source)
  of "Lowercase":
    LdtkIdentifierStyle.Lowercase
  of "Free":
    LdtkIdentifierStyle.Free
  of "Capitalize":
    LdtkIdentifierStyle.Capitalize
  of "Uppercase":
    LdtkIdentifierStyle.Uppercase
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var LdtkLdtkJsonRoot; source: JsonNode) =
  assert("backupLimit" in source,
         "backupLimit" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.backupLimit = jsonTo(source{"backupLimit"}, typeof(target.backupLimit))
  assert("simplifiedExport" in source, "simplifiedExport" &
      " is missing while decoding " &
      "LdtkLdtkJsonRoot")
  target.simplifiedExport = jsonTo(source{"simplifiedExport"},
                                   typeof(target.simplifiedExport))
  assert("externalLevels" in source,
         "externalLevels" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.externalLevels = jsonTo(source{"externalLevels"},
                                 typeof(target.externalLevels))
  if "backupRelPath" in source and source{"backupRelPath"}.kind != JNull:
    target.backupRelPath = some(jsonTo(source{"backupRelPath"},
                                       typeof(unsafeGet(target.backupRelPath))))
  assert("jsonVersion" in source,
         "jsonVersion" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.jsonVersion = jsonTo(source{"jsonVersion"}, typeof(target.jsonVersion))
  assert("bgColor" in source,
         "bgColor" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.bgColor = jsonTo(source{"bgColor"}, typeof(target.bgColor))
  assert("appBuildId" in source,
         "appBuildId" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.appBuildId = jsonTo(source{"appBuildId"}, typeof(target.appBuildId))
  assert("defaultEntityHeight" in source, "defaultEntityHeight" &
      " is missing while decoding " &
      "LdtkLdtkJsonRoot")
  target.defaultEntityHeight = jsonTo(source{"defaultEntityHeight"},
                                      typeof(target.defaultEntityHeight))
  if "pngFilePattern" in source and source{"pngFilePattern"}.kind != JNull:
    target.pngFilePattern = some(jsonTo(source{"pngFilePattern"}, typeof(
        unsafeGet(target.pngFilePattern))))
  assert("customCommands" in source,
         "customCommands" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.customCommands = jsonTo(source{"customCommands"},
                                 typeof(target.customCommands))
  assert("exportTiled" in source,
         "exportTiled" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.exportTiled = jsonTo(source{"exportTiled"}, typeof(target.exportTiled))
  if "exportPng" in source and source{"exportPng"}.kind != JNull:
    target.exportPng = some(jsonTo(source{"exportPng"},
                                   typeof(unsafeGet(target.exportPng))))
  if "worldGridWidth" in source and source{"worldGridWidth"}.kind != JNull:
    target.worldGridWidth = some(jsonTo(source{"worldGridWidth"}, typeof(
        unsafeGet(target.worldGridWidth))))
  if "defaultLevelHeight" in source and
      source{"defaultLevelHeight"}.kind != JNull:
    target.defaultLevelHeight = some(jsonTo(source{"defaultLevelHeight"},
        typeof(unsafeGet(target.defaultLevelHeight))))
  assert("toc" in source,
         "toc" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.toc = jsonTo(source{"toc"}, typeof(target.toc))
  assert("worlds" in source,
         "worlds" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.worlds = jsonTo(source{"worlds"}, typeof(target.worlds))
  assert("imageExportMode" in source,
         "imageExportMode" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.imageExportMode = jsonTo(source{"imageExportMode"},
                                  typeof(target.imageExportMode))
  assert("dummyWorldIid" in source,
         "dummyWorldIid" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.dummyWorldIid = jsonTo(source{"dummyWorldIid"},
                                typeof(target.dummyWorldIid))
  if "__FORCED_REFS" in source and source{"__FORCED_REFS"}.kind != JNull:
    target.FORCED_REFS = some(jsonTo(source{"__FORCED_REFS"},
                                     typeof(unsafeGet(target.FORCED_REFS))))
  assert("defaultPivotY" in source,
         "defaultPivotY" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.defaultPivotY = jsonTo(source{"defaultPivotY"},
                                typeof(target.defaultPivotY))
  assert("exportLevelBg" in source,
         "exportLevelBg" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.exportLevelBg = jsonTo(source{"exportLevelBg"},
                                typeof(target.exportLevelBg))
  assert("nextUid" in source,
         "nextUid" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.nextUid = jsonTo(source{"nextUid"}, typeof(target.nextUid))
  assert("levelNamePattern" in source, "levelNamePattern" &
      " is missing while decoding " &
      "LdtkLdtkJsonRoot")
  target.levelNamePattern = jsonTo(source{"levelNamePattern"},
                                   typeof(target.levelNamePattern))
  assert("defs" in source,
         "defs" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.defs = jsonTo(source{"defs"}, typeof(target.defs))
  assert("defaultPivotX" in source,
         "defaultPivotX" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.defaultPivotX = jsonTo(source{"defaultPivotX"},
                                typeof(target.defaultPivotX))
  if "tutorialDesc" in source and source{"tutorialDesc"}.kind != JNull:
    target.tutorialDesc = some(jsonTo(source{"tutorialDesc"},
                                      typeof(unsafeGet(target.tutorialDesc))))
  if "worldLayout" in source and source{"worldLayout"}.kind != JNull:
    target.worldLayout = some(jsonTo(source{"worldLayout"},
                                     typeof(unsafeGet(target.worldLayout))))
  assert("defaultEntityWidth" in source, "defaultEntityWidth" &
      " is missing while decoding " &
      "LdtkLdtkJsonRoot")
  target.defaultEntityWidth = jsonTo(source{"defaultEntityWidth"},
                                     typeof(target.defaultEntityWidth))
  assert("iid" in source,
         "iid" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.iid = jsonTo(source{"iid"}, typeof(target.iid))
  assert("defaultGridSize" in source,
         "defaultGridSize" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.defaultGridSize = jsonTo(source{"defaultGridSize"},
                                  typeof(target.defaultGridSize))
  if "defaultLevelWidth" in source and
      source{"defaultLevelWidth"}.kind != JNull:
    target.defaultLevelWidth = some(jsonTo(source{"defaultLevelWidth"},
        typeof(unsafeGet(target.defaultLevelWidth))))
  assert("minifyJson" in source,
         "minifyJson" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.minifyJson = jsonTo(source{"minifyJson"}, typeof(target.minifyJson))
  assert("backupOnSave" in source,
         "backupOnSave" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.backupOnSave = jsonTo(source{"backupOnSave"},
                               typeof(target.backupOnSave))
  assert("flags" in source,
         "flags" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.flags = jsonTo(source{"flags"}, typeof(target.flags))
  assert("defaultLevelBgColor" in source, "defaultLevelBgColor" &
      " is missing while decoding " &
      "LdtkLdtkJsonRoot")
  target.defaultLevelBgColor = jsonTo(source{"defaultLevelBgColor"},
                                      typeof(target.defaultLevelBgColor))
  assert("identifierStyle" in source,
         "identifierStyle" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.identifierStyle = jsonTo(source{"identifierStyle"},
                                  typeof(target.identifierStyle))
  if "worldGridHeight" in source and source{"worldGridHeight"}.kind != JNull:
    target.worldGridHeight = some(jsonTo(source{"worldGridHeight"},
        typeof(unsafeGet(target.worldGridHeight))))
  assert("levels" in source,
         "levels" & " is missing while decoding " & "LdtkLdtkJsonRoot")
  target.levels = jsonTo(source{"levels"}, typeof(target.levels))

proc toJsonHook*(source: LdtkLdtkJsonRoot): JsonNode =
  result = newJObject()
  result{"backupLimit"} = toJson(source.backupLimit)
  result{"simplifiedExport"} = toJson(source.simplifiedExport)
  result{"externalLevels"} = toJson(source.externalLevels)
  if isSome(source.backupRelPath):
    result{"backupRelPath"} = toJson(source.backupRelPath)
  result{"jsonVersion"} = toJson(source.jsonVersion)
  result{"bgColor"} = toJson(source.bgColor)
  result{"appBuildId"} = toJson(source.appBuildId)
  result{"defaultEntityHeight"} = toJson(source.defaultEntityHeight)
  if isSome(source.pngFilePattern):
    result{"pngFilePattern"} = toJson(source.pngFilePattern)
  result{"customCommands"} = toJson(source.customCommands)
  result{"exportTiled"} = toJson(source.exportTiled)
  if isSome(source.exportPng):
    result{"exportPng"} = toJson(source.exportPng)
  if isSome(source.worldGridWidth):
    result{"worldGridWidth"} = toJson(source.worldGridWidth)
  if isSome(source.defaultLevelHeight):
    result{"defaultLevelHeight"} = toJson(source.defaultLevelHeight)
  result{"toc"} = toJson(source.toc)
  result{"worlds"} = toJson(source.worlds)
  result{"imageExportMode"} = toJson(source.imageExportMode)
  result{"dummyWorldIid"} = toJson(source.dummyWorldIid)
  if isSome(source.FORCED_REFS):
    result{"__FORCED_REFS"} = toJson(source.FORCED_REFS)
  result{"defaultPivotY"} = toJson(source.defaultPivotY)
  result{"exportLevelBg"} = toJson(source.exportLevelBg)
  result{"nextUid"} = toJson(source.nextUid)
  result{"levelNamePattern"} = toJson(source.levelNamePattern)
  result{"defs"} = toJson(source.defs)
  result{"defaultPivotX"} = toJson(source.defaultPivotX)
  if isSome(source.tutorialDesc):
    result{"tutorialDesc"} = toJson(source.tutorialDesc)
  if isSome(source.worldLayout):
    result{"worldLayout"} = toJson(source.worldLayout)
  result{"defaultEntityWidth"} = toJson(source.defaultEntityWidth)
  result{"iid"} = toJson(source.iid)
  result{"defaultGridSize"} = toJson(source.defaultGridSize)
  if isSome(source.defaultLevelWidth):
    result{"defaultLevelWidth"} = toJson(source.defaultLevelWidth)
  result{"minifyJson"} = toJson(source.minifyJson)
  result{"backupOnSave"} = toJson(source.backupOnSave)
  result{"flags"} = toJson(source.flags)
  result{"defaultLevelBgColor"} = toJson(source.defaultLevelBgColor)
  result{"identifierStyle"} = toJson(source.identifierStyle)
  if isSome(source.worldGridHeight):
    result{"worldGridHeight"} = toJson(source.worldGridHeight)
  result{"levels"} = toJson(source.levels)
