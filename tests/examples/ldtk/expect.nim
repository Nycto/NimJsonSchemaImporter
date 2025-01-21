{.push warning[UnusedImport]:off.}
import std/[json, jsonutils, tables, options]

type
  TestNeighbourLevel* = object
    levelUid*: Option[BiggestInt]
    levelIid*: string
    dir*: string
  TestFieldInstance* = object
    realEditorValues*: seq[JsonNode]
    value*: JsonNode
    tile*: Option[TestTilesetRect]
    type*: string
    identifier*: string
    defUid*: BiggestInt
  TestEnumDefValues* = object
    tileSrcRect*: Option[seq[BiggestInt]]
    color*: BiggestInt
    id*: string
    tileId*: Option[BiggestInt]
    tileRect*: Option[TestTilesetRect]
  TestIntGridValueInstance* = object
    coordId*: BiggestInt
    v*: BiggestInt
  TestLayerDef* = object
    type1*: TestTestLayerDef_type
    autoTilesetDefUid*: Option[BiggestInt]
    parallaxScaling*: bool
    biomeFieldUid*: Option[BiggestInt]
    autoTilesKilledByOtherLayerUid*: Option[BiggestInt]
    inactiveOpacity*: BiggestFloat
    type*: string
    autoRuleGroups*: seq[TestAutoLayerRuleGroup]
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
    intGridValuesGroups*: seq[TestIntGridValueGroupDef]
    hideFieldsWhenInactive*: bool
    useAsyncRender*: bool
    pxOffsetY*: BiggestInt
    parallaxFactorY*: BiggestFloat
    intGridValues*: seq[TestIntGridValueDef]
    renderInWorldView*: bool
  TestTestFieldDef_editorDisplayPos* = enum
    Beneath, Above, Center
  TestTestEntityDef_limitScope* = enum
    PerLayer, PerWorld, PerLevel
  TestEntityReferenceInfos* = object
    layerIid*: string
    levelIid*: string
    entityIid*: string
    worldIid*: string
  TestTocInstanceData* = object
    worldY*: BiggestInt
    fields*: JsonNode
    widPx*: BiggestInt
    iids*: TestEntityReferenceInfos
    heiPx*: BiggestInt
    worldX*: BiggestInt
  TestTestEntityDef_limitBehavior* = enum
    PreventAdding, MoveLastOne, DiscardOldOnes
  TestTestLdtkJsonRoot_identifierStyle* = enum
    Lowercase, Free, Capitalize, Uppercase
  TestLevel* = object
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
    neighbours*: seq[TestNeighbourLevel]
    uid*: BiggestInt
    bgPos*: Option[TestTestLevel_bgPos]
    layerInstances*: Option[seq[TestLayerInstance]]
    fieldInstances*: seq[TestFieldInstance]
    bgPos1*: Option[TestLevelBgPosInfos]
    worldX*: BiggestInt
    iid*: string
    bgPivotY*: BiggestFloat
    smartColor*: string
  TestTestAutoRuleDef_tileMode* = enum
    Single, Stamp
  TestTestLdtkJsonRoot_imageExportMode* = enum
    LayersAndLevels, OneImagePerLayer, None, OneImagePerLevel
  TestAutoRuleDef* = object
    checker*: TestTestAutoRuleDef_checker
    pivotY*: BiggestFloat
    breakOnMatch*: bool
    perlinOctaves*: BiggestFloat
    yModulo*: BiggestInt
    size*: BiggestInt
    tileMode*: TestTestAutoRuleDef_tileMode
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
  TestIntGridValueGroupDef* = object
    color*: Option[string]
    identifier*: Option[string]
    uid*: BiggestInt
  TestGridPoint* = object
    cx*: BiggestInt
    cy*: BiggestInt
  TestTestLdtkJsonRoot_flags* = enum
    ExportPreCsvIntGridFormat, DiscardPreCsvIntGrid,
    ExportOldTableOfContentData, PrependIndexToLevelFileNames, MultiWorlds,
    UseMultilinesType, IgnoreBackupSuggest
  TestTableOfContentEntry* = object
    instancesData*: seq[TestTocInstanceData]
    identifier*: string
    instances*: Option[seq[TestEntityReferenceInfos]]
  TestEntityInstance* = object
    worldY*: Option[BiggestInt]
    tile*: Option[TestTilesetRect]
    identifier*: string
    tags*: seq[string]
    height*: BiggestInt
    px*: seq[BiggestInt]
    defUid*: BiggestInt
    pivot*: seq[BiggestFloat]
    fieldInstances*: seq[TestFieldInstance]
    iid*: string
    width*: BiggestInt
    worldX*: Option[BiggestInt]
    grid*: seq[BiggestInt]
    smartColor*: string
  TestEnumDef* = object
    values*: seq[TestEnumDefValues]
    externalRelPath*: Option[string]
    identifier*: string
    externalFileChecksum*: Option[string]
    iconTilesetUid*: Option[BiggestInt]
    uid*: BiggestInt
    tags*: seq[string]
  TestTestEntityDef_renderMode* = enum
    Tile, Cross, Ellipse, Rectangle
  TestTestLdtkJsonRoot_worldLayout* = enum
    LinearHorizontal, LinearVertical, GridVania, Free
  TestIntGridValueDef* = object
    tile*: Option[TestTilesetRect]
    color*: string
    identifier*: Option[string]
    groupUid*: BiggestInt
    value*: BiggestInt
  TestTileCustomMetadata* = object
    data*: string
    tileId*: BiggestInt
  TestTestFieldDef_editorDisplayMode* = enum
    PointPath, PointStar, ValueOnly, Hidden, Points, NameAndValue,
    ArrayCountNoLabel, EntityTile, PointPathLoop, RadiusPx, LevelTile,
    RadiusGrid, RefLinkBetweenCenters, RefLinkBetweenPivots, ArrayCountWithLabel
  TestTestLayerDef_type* = enum
    Tiles, Entities, AutoLayer, IntGrid
  TestTestFieldDef_editorLinkStyle* = enum
    DashedLine, CurvedArrow, ArrowsLine, ZigZag, StraightArrow
  TestCustomCommand* = object
    command*: string
    when*: TestTestCustomCommand_when
  TestEnumTagValue* = object
    tileIds*: seq[BiggestInt]
    enumValueId*: string
  TestTestEntityDef_tileRenderMode* = enum
    FullSizeCropped, FullSizeUncropped, Repeat, FitInside, NineSlice, Cover,
    Stretch
  TestTestFieldDef_allowedRefs* = enum
    Any, OnlyTags, OnlySame, OnlySpecificEntity
  TestTilesetDef* = object
    pxHei*: BiggestInt
    savedSelections*: seq[Table[string, JsonNode]]
    padding*: BiggestInt
    spacing*: BiggestInt
    tagsSourceEnumUid*: Option[BiggestInt]
    embedAtlas*: Option[TestTestTilesetDef_embedAtlas]
    identifier*: string
    cachedPixelData*: Option[Table[string, JsonNode]]
    enumTags*: seq[TestEnumTagValue]
    pxWid*: BiggestInt
    tileGridSize*: BiggestInt
    customData*: seq[TestTileCustomMetadata]
    uid*: BiggestInt
    cHei*: BiggestInt
    cWid*: BiggestInt
    relPath*: Option[string]
    tags*: seq[string]
  TestTestFieldDef_textLanguageMode* = enum
    LangMarkdown, LangPython, LangLog, LangC, LangLua, LangHaxe, LangJS,
    LangRuby, LangJson, LangXml
  TestTestWorld_worldLayout* = enum
    LinearHorizontal, LinearVertical, GridVania, Free
  TestAutoLayerRuleGroup* = object
    isOptional*: bool
    color*: Option[string]
    collapsed*: Option[bool]
    usesWizard*: bool
    biomeRequirementMode*: BiggestInt
    rules*: seq[TestAutoRuleDef]
    icon*: Option[TestTilesetRect]
    active*: bool
    uid*: BiggestInt
    name*: string
    requiredBiomeValues*: seq[string]
  TestTestAutoRuleDef_checker* = enum
    Horizontal, Vertical, None
  TestDefinitions* = object
    levelFields*: seq[TestFieldDef]
    tilesets*: seq[TestTilesetDef]
    entities*: seq[TestEntityDef]
    enums*: seq[TestEnumDef]
    layers*: seq[TestLayerDef]
    externalEnums*: seq[TestEnumDef]
  TestTestCustomCommand_when* = enum
    AfterLoad, BeforeSave, AfterSave, Manual
  TestTile* = object
    px*: seq[BiggestInt]
    t*: BiggestInt
    d*: seq[BiggestInt]
    a*: BiggestFloat
    src*: seq[BiggestInt]
    f*: BiggestInt
  TestTestLdtkJsonRoot_FORCED_REFS* = object
    CustomCommand*: Option[TestCustomCommand]
    IntGridValueDef*: Option[TestIntGridValueDef]
    Level*: Option[TestLevel]
    Definitions*: Option[TestDefinitions]
    EnumDef*: Option[TestEnumDef]
    FieldDef*: Option[TestFieldDef]
    AutoLayerRuleGroup*: Option[TestAutoLayerRuleGroup]
    TilesetDef*: Option[TestTilesetDef]
    TableOfContentEntry*: Option[TestTableOfContentEntry]
    EntityDef*: Option[TestEntityDef]
    FieldInstance*: Option[TestFieldInstance]
    EntityReferenceInfos*: Option[TestEntityReferenceInfos]
    LevelBgPosInfos*: Option[TestLevelBgPosInfos]
    TileCustomMetadata*: Option[TestTileCustomMetadata]
    Tile*: Option[TestTile]
    AutoRuleDef*: Option[TestAutoRuleDef]
    NeighbourLevel*: Option[TestNeighbourLevel]
    GridPoint*: Option[TestGridPoint]
    EntityInstance*: Option[TestEntityInstance]
    TilesetRect*: Option[TestTilesetRect]
    EnumTagValue*: Option[TestEnumTagValue]
    LayerInstance*: Option[TestLayerInstance]
    IntGridValueInstance*: Option[TestIntGridValueInstance]
    World*: Option[TestWorld]
    LayerDef*: Option[TestLayerDef]
    IntGridValueGroupDef*: Option[TestIntGridValueGroupDef]
    TocInstanceData*: Option[TestTocInstanceData]
    EnumDefValues*: Option[TestEnumDefValues]
  TestTilesetRect* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  TestTestTilesetDef_embedAtlas* = enum
    LdtkIcons
  TestWorld* = object
    worldGridWidth*: BiggestInt
    defaultLevelHeight*: BiggestInt
    identifier*: string
    worldLayout*: Option[TestTestWorld_worldLayout]
    iid*: string
    defaultLevelWidth*: BiggestInt
    worldGridHeight*: BiggestInt
    levels*: seq[TestLevel]
  TestLayerInstance* = object
    opacity*: BiggestFloat
    optionalRules*: seq[BiggestInt]
    gridSize*: BiggestInt
    pxTotalOffsetX*: BiggestInt
    gridTiles*: seq[TestTile]
    type*: string
    identifier*: string
    overrideTilesetUid*: Option[BiggestInt]
    levelId*: BiggestInt
    intGrid*: Option[seq[TestIntGridValueInstance]]
    autoLayerTiles*: seq[TestTile]
    layerDefUid*: BiggestInt
    entityInstances*: seq[TestEntityInstance]
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
  TestLdtkJsonRoot* = object
    backupLimit*: BiggestInt
    simplifiedExport*: bool
    externalLevels*: bool
    backupRelPath*: Option[string]
    jsonVersion*: string
    bgColor*: string
    appBuildId*: BiggestFloat
    defaultEntityHeight*: BiggestInt
    pngFilePattern*: Option[string]
    customCommands*: seq[TestCustomCommand]
    exportTiled*: bool
    exportPng*: Option[bool]
    worldGridWidth*: Option[BiggestInt]
    defaultLevelHeight*: Option[BiggestInt]
    toc*: seq[TestTableOfContentEntry]
    worlds*: seq[TestWorld]
    imageExportMode*: TestTestLdtkJsonRoot_imageExportMode
    dummyWorldIid*: string
    FORCED_REFS*: Option[TestTestLdtkJsonRoot_FORCED_REFS]
    defaultPivotY*: BiggestFloat
    exportLevelBg*: bool
    nextUid*: BiggestInt
    levelNamePattern*: string
    defs*: TestDefinitions
    defaultPivotX*: BiggestFloat
    tutorialDesc*: Option[string]
    worldLayout*: Option[TestTestLdtkJsonRoot_worldLayout]
    defaultEntityWidth*: BiggestInt
    iid*: string
    defaultGridSize*: BiggestInt
    defaultLevelWidth*: Option[BiggestInt]
    minifyJson*: bool
    backupOnSave*: bool
    flags*: seq[TestTestLdtkJsonRoot_flags]
    defaultLevelBgColor*: string
    identifierStyle*: TestTestLdtkJsonRoot_identifierStyle
    worldGridHeight*: Option[BiggestInt]
    levels*: seq[TestLevel]
  TestEntityDef* = object
    allowOutOfBounds*: bool
    pivotY*: BiggestFloat
    tileOpacity*: BiggestFloat
    color*: string
    limitScope*: TestTestEntityDef_limitScope
    limitBehavior*: TestTestEntityDef_limitBehavior
    hollow*: bool
    height*: BiggestInt
    renderMode*: TestTestEntityDef_renderMode
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
    fieldDefs*: seq[TestFieldDef]
    uid*: BiggestInt
    tileRenderMode*: TestTestEntityDef_tileRenderMode
    uiTileRect*: Option[TestTilesetRect]
    resizableY*: bool
    lineOpacity*: BiggestFloat
    minHeight*: Option[BiggestInt]
    tileRect*: Option[TestTilesetRect]
    nineSliceBorders*: seq[BiggestInt]
    maxWidth*: Option[BiggestInt]
    width*: BiggestInt
    tags*: seq[string]
    maxHeight*: Option[BiggestInt]
    exportToToc*: bool
    fillOpacity*: BiggestFloat
  TestTestLevel_bgPos* = enum
    CoverDirty, Repeat, Contain, Cover, Unscaled
  TestFieldDef* = object
    type1*: string
    editorDisplayScale*: BiggestFloat
    type*: string
    allowedRefsEntityUid*: Option[BiggestInt]
    textLanguageMode*: Option[TestTestFieldDef_textLanguageMode]
    editorAlwaysShow*: bool
    defaultOverride*: Option[JsonNode]
    autoChainRef*: bool
    editorDisplayPos*: TestTestFieldDef_editorDisplayPos
    editorDisplayMode*: TestTestFieldDef_editorDisplayMode
    identifier*: string
    regex*: Option[string]
    isArray*: bool
    editorLinkStyle*: TestTestFieldDef_editorLinkStyle
    allowedRefs*: TestTestFieldDef_allowedRefs
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
  TestLevelBgPosInfos* = object
    scale*: seq[BiggestFloat]
    cropRect*: seq[BiggestFloat]
    topLeftPx*: seq[BiggestInt]
proc toJsonHook*(source: TestTestCustomCommand_when): JsonNode =
  case source
  of TestTestCustomCommand_when.AfterLoad:
    return newJString("AfterLoad")
  of TestTestCustomCommand_when.BeforeSave:
    return newJString("BeforeSave")
  of TestTestCustomCommand_when.AfterSave:
    return newJString("AfterSave")
  of TestTestCustomCommand_when.Manual:
    return newJString("Manual")
  
proc fromJsonHook*(target: var TestTestCustomCommand_when; source: JsonNode) =
  target = case getStr(source)
  of "AfterLoad":
    TestTestCustomCommand_when.AfterLoad
  of "BeforeSave":
    TestTestCustomCommand_when.BeforeSave
  of "AfterSave":
    TestTestCustomCommand_when.AfterSave
  of "Manual":
    TestTestCustomCommand_when.Manual
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var TestCustomCommand; source: JsonNode) =
  assert("command" in source,
         "command" & " is missing while decoding " & "TestCustomCommand")
  target.command = jsonTo(source{"command"}, typeof(target.command))
  assert("when" in source,
         "when" & " is missing while decoding " & "TestCustomCommand")
  target.when = jsonTo(source{"when"}, typeof(target.when))

proc toJsonHook*(source: TestCustomCommand): JsonNode =
  result = newJObject()
  result{"command"} = toJson(source.command)
  result{"when"} = toJson(source.when)

proc fromJsonHook*(target: var TestEntityReferenceInfos; source: JsonNode) =
  assert("layerIid" in source, "layerIid" & " is missing while decoding " &
      "TestEntityReferenceInfos")
  target.layerIid = jsonTo(source{"layerIid"}, typeof(target.layerIid))
  assert("levelIid" in source, "levelIid" & " is missing while decoding " &
      "TestEntityReferenceInfos")
  target.levelIid = jsonTo(source{"levelIid"}, typeof(target.levelIid))
  assert("entityIid" in source, "entityIid" & " is missing while decoding " &
      "TestEntityReferenceInfos")
  target.entityIid = jsonTo(source{"entityIid"}, typeof(target.entityIid))
  assert("worldIid" in source, "worldIid" & " is missing while decoding " &
      "TestEntityReferenceInfos")
  target.worldIid = jsonTo(source{"worldIid"}, typeof(target.worldIid))

proc toJsonHook*(source: TestEntityReferenceInfos): JsonNode =
  result = newJObject()
  result{"layerIid"} = toJson(source.layerIid)
  result{"levelIid"} = toJson(source.levelIid)
  result{"entityIid"} = toJson(source.entityIid)
  result{"worldIid"} = toJson(source.worldIid)

proc fromJsonHook*(target: var TestTocInstanceData; source: JsonNode) =
  assert("worldY" in source,
         "worldY" & " is missing while decoding " & "TestTocInstanceData")
  target.worldY = jsonTo(source{"worldY"}, typeof(target.worldY))
  assert("fields" in source,
         "fields" & " is missing while decoding " & "TestTocInstanceData")
  target.fields = jsonTo(source{"fields"}, typeof(target.fields))
  assert("widPx" in source,
         "widPx" & " is missing while decoding " & "TestTocInstanceData")
  target.widPx = jsonTo(source{"widPx"}, typeof(target.widPx))
  assert("iids" in source,
         "iids" & " is missing while decoding " & "TestTocInstanceData")
  target.iids = jsonTo(source{"iids"}, typeof(target.iids))
  assert("heiPx" in source,
         "heiPx" & " is missing while decoding " & "TestTocInstanceData")
  target.heiPx = jsonTo(source{"heiPx"}, typeof(target.heiPx))
  assert("worldX" in source,
         "worldX" & " is missing while decoding " & "TestTocInstanceData")
  target.worldX = jsonTo(source{"worldX"}, typeof(target.worldX))

proc toJsonHook*(source: TestTocInstanceData): JsonNode =
  result = newJObject()
  result{"worldY"} = toJson(source.worldY)
  result{"fields"} = toJson(source.fields)
  result{"widPx"} = toJson(source.widPx)
  result{"iids"} = toJson(source.iids)
  result{"heiPx"} = toJson(source.heiPx)
  result{"worldX"} = toJson(source.worldX)

proc fromJsonHook*(target: var TestTableOfContentEntry; source: JsonNode) =
  assert("instancesData" in source, "instancesData" &
      " is missing while decoding " &
      "TestTableOfContentEntry")
  target.instancesData = jsonTo(source{"instancesData"},
                                typeof(target.instancesData))
  assert("identifier" in source, "identifier" & " is missing while decoding " &
      "TestTableOfContentEntry")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  if "instances" in source and source{"instances"}.kind != JNull:
    target.instances = some(jsonTo(source{"instances"},
                                   typeof(unsafeGet(target.instances))))

proc toJsonHook*(source: TestTableOfContentEntry): JsonNode =
  result = newJObject()
  result{"instancesData"} = toJson(source.instancesData)
  result{"identifier"} = toJson(source.identifier)
  if isSome(source.instances):
    result{"instances"} = toJson(source.instances)

proc toJsonHook*(source: TestTestWorld_worldLayout): JsonNode =
  case source
  of TestTestWorld_worldLayout.LinearHorizontal:
    return newJString("LinearHorizontal")
  of TestTestWorld_worldLayout.LinearVertical:
    return newJString("LinearVertical")
  of TestTestWorld_worldLayout.GridVania:
    return newJString("GridVania")
  of TestTestWorld_worldLayout.Free:
    return newJString("Free")
  
proc fromJsonHook*(target: var TestTestWorld_worldLayout; source: JsonNode) =
  target = case getStr(source)
  of "LinearHorizontal":
    TestTestWorld_worldLayout.LinearHorizontal
  of "LinearVertical":
    TestTestWorld_worldLayout.LinearVertical
  of "GridVania":
    TestTestWorld_worldLayout.GridVania
  of "Free":
    TestTestWorld_worldLayout.Free
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var TestNeighbourLevel; source: JsonNode) =
  if "levelUid" in source and source{"levelUid"}.kind != JNull:
    target.levelUid = some(jsonTo(source{"levelUid"},
                                  typeof(unsafeGet(target.levelUid))))
  assert("levelIid" in source,
         "levelIid" & " is missing while decoding " & "TestNeighbourLevel")
  target.levelIid = jsonTo(source{"levelIid"}, typeof(target.levelIid))
  assert("dir" in source,
         "dir" & " is missing while decoding " & "TestNeighbourLevel")
  target.dir = jsonTo(source{"dir"}, typeof(target.dir))

proc toJsonHook*(source: TestNeighbourLevel): JsonNode =
  result = newJObject()
  if isSome(source.levelUid):
    result{"levelUid"} = toJson(source.levelUid)
  result{"levelIid"} = toJson(source.levelIid)
  result{"dir"} = toJson(source.dir)

proc toJsonHook*(source: TestTestLevel_bgPos): JsonNode =
  case source
  of TestTestLevel_bgPos.CoverDirty:
    return newJString("CoverDirty")
  of TestTestLevel_bgPos.Repeat:
    return newJString("Repeat")
  of TestTestLevel_bgPos.Contain:
    return newJString("Contain")
  of TestTestLevel_bgPos.Cover:
    return newJString("Cover")
  of TestTestLevel_bgPos.Unscaled:
    return newJString("Unscaled")
  
proc fromJsonHook*(target: var TestTestLevel_bgPos; source: JsonNode) =
  target = case getStr(source)
  of "CoverDirty":
    TestTestLevel_bgPos.CoverDirty
  of "Repeat":
    TestTestLevel_bgPos.Repeat
  of "Contain":
    TestTestLevel_bgPos.Contain
  of "Cover":
    TestTestLevel_bgPos.Cover
  of "Unscaled":
    TestTestLevel_bgPos.Unscaled
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var TestTile; source: JsonNode) =
  assert("px" in source, "px" & " is missing while decoding " & "TestTile")
  target.px = jsonTo(source{"px"}, typeof(target.px))
  assert("t" in source, "t" & " is missing while decoding " & "TestTile")
  target.t = jsonTo(source{"t"}, typeof(target.t))
  assert("d" in source, "d" & " is missing while decoding " & "TestTile")
  target.d = jsonTo(source{"d"}, typeof(target.d))
  assert("a" in source, "a" & " is missing while decoding " & "TestTile")
  target.a = jsonTo(source{"a"}, typeof(target.a))
  assert("src" in source, "src" & " is missing while decoding " & "TestTile")
  target.src = jsonTo(source{"src"}, typeof(target.src))
  assert("f" in source, "f" & " is missing while decoding " & "TestTile")
  target.f = jsonTo(source{"f"}, typeof(target.f))

proc toJsonHook*(source: TestTile): JsonNode =
  result = newJObject()
  result{"px"} = toJson(source.px)
  result{"t"} = toJson(source.t)
  result{"d"} = toJson(source.d)
  result{"a"} = toJson(source.a)
  result{"src"} = toJson(source.src)
  result{"f"} = toJson(source.f)

proc fromJsonHook*(target: var TestIntGridValueInstance; source: JsonNode) =
  assert("coordId" in source,
         "coordId" & " is missing while decoding " & "TestIntGridValueInstance")
  target.coordId = jsonTo(source{"coordId"}, typeof(target.coordId))
  assert("v" in source,
         "v" & " is missing while decoding " & "TestIntGridValueInstance")
  target.v = jsonTo(source{"v"}, typeof(target.v))

proc toJsonHook*(source: TestIntGridValueInstance): JsonNode =
  result = newJObject()
  result{"coordId"} = toJson(source.coordId)
  result{"v"} = toJson(source.v)

proc fromJsonHook*(target: var TestTilesetRect; source: JsonNode) =
  assert("x" in source, "x" & " is missing while decoding " & "TestTilesetRect")
  target.x = jsonTo(source{"x"}, typeof(target.x))
  assert("w" in source, "w" & " is missing while decoding " & "TestTilesetRect")
  target.w = jsonTo(source{"w"}, typeof(target.w))
  assert("y" in source, "y" & " is missing while decoding " & "TestTilesetRect")
  target.y = jsonTo(source{"y"}, typeof(target.y))
  assert("h" in source, "h" & " is missing while decoding " & "TestTilesetRect")
  target.h = jsonTo(source{"h"}, typeof(target.h))
  assert("tilesetUid" in source,
         "tilesetUid" & " is missing while decoding " & "TestTilesetRect")
  target.tilesetUid = jsonTo(source{"tilesetUid"}, typeof(target.tilesetUid))

proc toJsonHook*(source: TestTilesetRect): JsonNode =
  result = newJObject()
  result{"x"} = toJson(source.x)
  result{"w"} = toJson(source.w)
  result{"y"} = toJson(source.y)
  result{"h"} = toJson(source.h)
  result{"tilesetUid"} = toJson(source.tilesetUid)

proc fromJsonHook*(target: var TestFieldInstance; source: JsonNode) =
  assert("realEditorValues" in source, "realEditorValues" &
      " is missing while decoding " &
      "TestFieldInstance")
  target.realEditorValues = jsonTo(source{"realEditorValues"},
                                   typeof(target.realEditorValues))
  assert("__value" in source,
         "__value" & " is missing while decoding " & "TestFieldInstance")
  target.value = jsonTo(source{"__value"}, typeof(target.value))
  if "__tile" in source and source{"__tile"}.kind != JNull:
    target.tile = some(jsonTo(source{"__tile"}, typeof(unsafeGet(target.tile))))
  assert("__type" in source,
         "__type" & " is missing while decoding " & "TestFieldInstance")
  target.type = jsonTo(source{"__type"}, typeof(target.type))
  assert("__identifier" in source,
         "__identifier" & " is missing while decoding " & "TestFieldInstance")
  target.identifier = jsonTo(source{"__identifier"}, typeof(target.identifier))
  assert("defUid" in source,
         "defUid" & " is missing while decoding " & "TestFieldInstance")
  target.defUid = jsonTo(source{"defUid"}, typeof(target.defUid))

proc toJsonHook*(source: TestFieldInstance): JsonNode =
  result = newJObject()
  result{"realEditorValues"} = toJson(source.realEditorValues)
  result{"__value"} = toJson(source.value)
  if isSome(source.tile):
    result{"__tile"} = toJson(source.tile)
  result{"__type"} = toJson(source.type)
  result{"__identifier"} = toJson(source.identifier)
  result{"defUid"} = toJson(source.defUid)

proc fromJsonHook*(target: var TestEntityInstance; source: JsonNode) =
  if "__worldY" in source and source{"__worldY"}.kind != JNull:
    target.worldY = some(jsonTo(source{"__worldY"},
                                typeof(unsafeGet(target.worldY))))
  if "__tile" in source and source{"__tile"}.kind != JNull:
    target.tile = some(jsonTo(source{"__tile"}, typeof(unsafeGet(target.tile))))
  assert("__identifier" in source,
         "__identifier" & " is missing while decoding " & "TestEntityInstance")
  target.identifier = jsonTo(source{"__identifier"}, typeof(target.identifier))
  assert("__tags" in source,
         "__tags" & " is missing while decoding " & "TestEntityInstance")
  target.tags = jsonTo(source{"__tags"}, typeof(target.tags))
  assert("height" in source,
         "height" & " is missing while decoding " & "TestEntityInstance")
  target.height = jsonTo(source{"height"}, typeof(target.height))
  assert("px" in source,
         "px" & " is missing while decoding " & "TestEntityInstance")
  target.px = jsonTo(source{"px"}, typeof(target.px))
  assert("defUid" in source,
         "defUid" & " is missing while decoding " & "TestEntityInstance")
  target.defUid = jsonTo(source{"defUid"}, typeof(target.defUid))
  assert("__pivot" in source,
         "__pivot" & " is missing while decoding " & "TestEntityInstance")
  target.pivot = jsonTo(source{"__pivot"}, typeof(target.pivot))
  assert("fieldInstances" in source, "fieldInstances" &
      " is missing while decoding " &
      "TestEntityInstance")
  target.fieldInstances = jsonTo(source{"fieldInstances"},
                                 typeof(target.fieldInstances))
  assert("iid" in source,
         "iid" & " is missing while decoding " & "TestEntityInstance")
  target.iid = jsonTo(source{"iid"}, typeof(target.iid))
  assert("width" in source,
         "width" & " is missing while decoding " & "TestEntityInstance")
  target.width = jsonTo(source{"width"}, typeof(target.width))
  if "__worldX" in source and source{"__worldX"}.kind != JNull:
    target.worldX = some(jsonTo(source{"__worldX"},
                                typeof(unsafeGet(target.worldX))))
  assert("__grid" in source,
         "__grid" & " is missing while decoding " & "TestEntityInstance")
  target.grid = jsonTo(source{"__grid"}, typeof(target.grid))
  assert("__smartColor" in source,
         "__smartColor" & " is missing while decoding " & "TestEntityInstance")
  target.smartColor = jsonTo(source{"__smartColor"}, typeof(target.smartColor))

proc toJsonHook*(source: TestEntityInstance): JsonNode =
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

proc fromJsonHook*(target: var TestLayerInstance; source: JsonNode) =
  assert("__opacity" in source,
         "__opacity" & " is missing while decoding " & "TestLayerInstance")
  target.opacity = jsonTo(source{"__opacity"}, typeof(target.opacity))
  assert("optionalRules" in source,
         "optionalRules" & " is missing while decoding " & "TestLayerInstance")
  target.optionalRules = jsonTo(source{"optionalRules"},
                                typeof(target.optionalRules))
  assert("__gridSize" in source,
         "__gridSize" & " is missing while decoding " & "TestLayerInstance")
  target.gridSize = jsonTo(source{"__gridSize"}, typeof(target.gridSize))
  assert("__pxTotalOffsetX" in source, "__pxTotalOffsetX" &
      " is missing while decoding " &
      "TestLayerInstance")
  target.pxTotalOffsetX = jsonTo(source{"__pxTotalOffsetX"},
                                 typeof(target.pxTotalOffsetX))
  assert("gridTiles" in source,
         "gridTiles" & " is missing while decoding " & "TestLayerInstance")
  target.gridTiles = jsonTo(source{"gridTiles"}, typeof(target.gridTiles))
  assert("__type" in source,
         "__type" & " is missing while decoding " & "TestLayerInstance")
  target.type = jsonTo(source{"__type"}, typeof(target.type))
  assert("__identifier" in source,
         "__identifier" & " is missing while decoding " & "TestLayerInstance")
  target.identifier = jsonTo(source{"__identifier"}, typeof(target.identifier))
  if "overrideTilesetUid" in source and
      source{"overrideTilesetUid"}.kind != JNull:
    target.overrideTilesetUid = some(jsonTo(source{"overrideTilesetUid"},
        typeof(unsafeGet(target.overrideTilesetUid))))
  assert("levelId" in source,
         "levelId" & " is missing while decoding " & "TestLayerInstance")
  target.levelId = jsonTo(source{"levelId"}, typeof(target.levelId))
  if "intGrid" in source and source{"intGrid"}.kind != JNull:
    target.intGrid = some(jsonTo(source{"intGrid"},
                                 typeof(unsafeGet(target.intGrid))))
  assert("autoLayerTiles" in source,
         "autoLayerTiles" & " is missing while decoding " & "TestLayerInstance")
  target.autoLayerTiles = jsonTo(source{"autoLayerTiles"},
                                 typeof(target.autoLayerTiles))
  assert("layerDefUid" in source,
         "layerDefUid" & " is missing while decoding " & "TestLayerInstance")
  target.layerDefUid = jsonTo(source{"layerDefUid"}, typeof(target.layerDefUid))
  assert("entityInstances" in source, "entityInstances" &
      " is missing while decoding " &
      "TestLayerInstance")
  target.entityInstances = jsonTo(source{"entityInstances"},
                                  typeof(target.entityInstances))
  assert("intGridCsv" in source,
         "intGridCsv" & " is missing while decoding " & "TestLayerInstance")
  target.intGridCsv = jsonTo(source{"intGridCsv"}, typeof(target.intGridCsv))
  assert("pxOffsetX" in source,
         "pxOffsetX" & " is missing while decoding " & "TestLayerInstance")
  target.pxOffsetX = jsonTo(source{"pxOffsetX"}, typeof(target.pxOffsetX))
  if "__tilesetRelPath" in source and
      source{"__tilesetRelPath"}.kind != JNull:
    target.tilesetRelPath = some(jsonTo(source{"__tilesetRelPath"}, typeof(
        unsafeGet(target.tilesetRelPath))))
  if "__tilesetDefUid" in source and source{"__tilesetDefUid"}.kind != JNull:
    target.tilesetDefUid = some(jsonTo(source{"__tilesetDefUid"},
                                       typeof(unsafeGet(target.tilesetDefUid))))
  assert("__cHei" in source,
         "__cHei" & " is missing while decoding " & "TestLayerInstance")
  target.cHei = jsonTo(source{"__cHei"}, typeof(target.cHei))
  assert("seed" in source,
         "seed" & " is missing while decoding " & "TestLayerInstance")
  target.seed = jsonTo(source{"seed"}, typeof(target.seed))
  assert("visible" in source,
         "visible" & " is missing while decoding " & "TestLayerInstance")
  target.visible = jsonTo(source{"visible"}, typeof(target.visible))
  assert("pxOffsetY" in source,
         "pxOffsetY" & " is missing while decoding " & "TestLayerInstance")
  target.pxOffsetY = jsonTo(source{"pxOffsetY"}, typeof(target.pxOffsetY))
  assert("iid" in source,
         "iid" & " is missing while decoding " & "TestLayerInstance")
  target.iid = jsonTo(source{"iid"}, typeof(target.iid))
  assert("__pxTotalOffsetY" in source, "__pxTotalOffsetY" &
      " is missing while decoding " &
      "TestLayerInstance")
  target.pxTotalOffsetY = jsonTo(source{"__pxTotalOffsetY"},
                                 typeof(target.pxTotalOffsetY))
  assert("__cWid" in source,
         "__cWid" & " is missing while decoding " & "TestLayerInstance")
  target.cWid = jsonTo(source{"__cWid"}, typeof(target.cWid))

proc toJsonHook*(source: TestLayerInstance): JsonNode =
  result = newJObject()
  result{"__opacity"} = toJson(source.opacity)
  result{"optionalRules"} = toJson(source.optionalRules)
  result{"__gridSize"} = toJson(source.gridSize)
  result{"__pxTotalOffsetX"} = toJson(source.pxTotalOffsetX)
  result{"gridTiles"} = toJson(source.gridTiles)
  result{"__type"} = toJson(source.type)
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

proc fromJsonHook*(target: var TestLevelBgPosInfos; source: JsonNode) =
  assert("scale" in source,
         "scale" & " is missing while decoding " & "TestLevelBgPosInfos")
  target.scale = jsonTo(source{"scale"}, typeof(target.scale))
  assert("cropRect" in source,
         "cropRect" & " is missing while decoding " & "TestLevelBgPosInfos")
  target.cropRect = jsonTo(source{"cropRect"}, typeof(target.cropRect))
  assert("topLeftPx" in source,
         "topLeftPx" & " is missing while decoding " & "TestLevelBgPosInfos")
  target.topLeftPx = jsonTo(source{"topLeftPx"}, typeof(target.topLeftPx))

proc toJsonHook*(source: TestLevelBgPosInfos): JsonNode =
  result = newJObject()
  result{"scale"} = toJson(source.scale)
  result{"cropRect"} = toJson(source.cropRect)
  result{"topLeftPx"} = toJson(source.topLeftPx)

proc fromJsonHook*(target: var TestLevel; source: JsonNode) =
  assert("pxHei" in source,
         "pxHei" & " is missing while decoding " & "TestLevel")
  target.pxHei = jsonTo(source{"pxHei"}, typeof(target.pxHei))
  assert("useAutoIdentifier" in source,
         "useAutoIdentifier" & " is missing while decoding " & "TestLevel")
  target.useAutoIdentifier = jsonTo(source{"useAutoIdentifier"},
                                    typeof(target.useAutoIdentifier))
  assert("__bgColor" in source,
         "__bgColor" & " is missing while decoding " & "TestLevel")
  target.bgColor = jsonTo(source{"__bgColor"}, typeof(target.bgColor))
  if "bgColor" in source and source{"bgColor"}.kind != JNull:
    target.bgColor1 = some(jsonTo(source{"bgColor"},
                                  typeof(unsafeGet(target.bgColor1))))
  if "externalRelPath" in source and source{"externalRelPath"}.kind != JNull:
    target.externalRelPath = some(jsonTo(source{"externalRelPath"},
        typeof(unsafeGet(target.externalRelPath))))
  assert("worldY" in source,
         "worldY" & " is missing while decoding " & "TestLevel")
  target.worldY = jsonTo(source{"worldY"}, typeof(target.worldY))
  if "bgRelPath" in source and source{"bgRelPath"}.kind != JNull:
    target.bgRelPath = some(jsonTo(source{"bgRelPath"},
                                   typeof(unsafeGet(target.bgRelPath))))
  assert("identifier" in source,
         "identifier" & " is missing while decoding " & "TestLevel")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  assert("pxWid" in source,
         "pxWid" & " is missing while decoding " & "TestLevel")
  target.pxWid = jsonTo(source{"pxWid"}, typeof(target.pxWid))
  assert("worldDepth" in source,
         "worldDepth" & " is missing while decoding " & "TestLevel")
  target.worldDepth = jsonTo(source{"worldDepth"}, typeof(target.worldDepth))
  assert("bgPivotX" in source,
         "bgPivotX" & " is missing while decoding " & "TestLevel")
  target.bgPivotX = jsonTo(source{"bgPivotX"}, typeof(target.bgPivotX))
  assert("__neighbours" in source,
         "__neighbours" & " is missing while decoding " & "TestLevel")
  target.neighbours = jsonTo(source{"__neighbours"}, typeof(target.neighbours))
  assert("uid" in source, "uid" & " is missing while decoding " & "TestLevel")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  if "bgPos" in source and source{"bgPos"}.kind != JNull:
    target.bgPos = some(jsonTo(source{"bgPos"}, typeof(unsafeGet(target.bgPos))))
  if "layerInstances" in source and source{"layerInstances"}.kind != JNull:
    target.layerInstances = some(jsonTo(source{"layerInstances"}, typeof(
        unsafeGet(target.layerInstances))))
  assert("fieldInstances" in source,
         "fieldInstances" & " is missing while decoding " & "TestLevel")
  target.fieldInstances = jsonTo(source{"fieldInstances"},
                                 typeof(target.fieldInstances))
  if "__bgPos" in source and source{"__bgPos"}.kind != JNull:
    target.bgPos1 = some(jsonTo(source{"__bgPos"},
                                typeof(unsafeGet(target.bgPos1))))
  assert("worldX" in source,
         "worldX" & " is missing while decoding " & "TestLevel")
  target.worldX = jsonTo(source{"worldX"}, typeof(target.worldX))
  assert("iid" in source, "iid" & " is missing while decoding " & "TestLevel")
  target.iid = jsonTo(source{"iid"}, typeof(target.iid))
  assert("bgPivotY" in source,
         "bgPivotY" & " is missing while decoding " & "TestLevel")
  target.bgPivotY = jsonTo(source{"bgPivotY"}, typeof(target.bgPivotY))
  assert("__smartColor" in source,
         "__smartColor" & " is missing while decoding " & "TestLevel")
  target.smartColor = jsonTo(source{"__smartColor"}, typeof(target.smartColor))

proc toJsonHook*(source: TestLevel): JsonNode =
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

proc fromJsonHook*(target: var TestWorld; source: JsonNode) =
  assert("worldGridWidth" in source,
         "worldGridWidth" & " is missing while decoding " & "TestWorld")
  target.worldGridWidth = jsonTo(source{"worldGridWidth"},
                                 typeof(target.worldGridWidth))
  assert("defaultLevelHeight" in source,
         "defaultLevelHeight" & " is missing while decoding " & "TestWorld")
  target.defaultLevelHeight = jsonTo(source{"defaultLevelHeight"},
                                     typeof(target.defaultLevelHeight))
  assert("identifier" in source,
         "identifier" & " is missing while decoding " & "TestWorld")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  if "worldLayout" in source and source{"worldLayout"}.kind != JNull:
    target.worldLayout = some(jsonTo(source{"worldLayout"},
                                     typeof(unsafeGet(target.worldLayout))))
  assert("iid" in source, "iid" & " is missing while decoding " & "TestWorld")
  target.iid = jsonTo(source{"iid"}, typeof(target.iid))
  assert("defaultLevelWidth" in source,
         "defaultLevelWidth" & " is missing while decoding " & "TestWorld")
  target.defaultLevelWidth = jsonTo(source{"defaultLevelWidth"},
                                    typeof(target.defaultLevelWidth))
  assert("worldGridHeight" in source,
         "worldGridHeight" & " is missing while decoding " & "TestWorld")
  target.worldGridHeight = jsonTo(source{"worldGridHeight"},
                                  typeof(target.worldGridHeight))
  assert("levels" in source,
         "levels" & " is missing while decoding " & "TestWorld")
  target.levels = jsonTo(source{"levels"}, typeof(target.levels))

proc toJsonHook*(source: TestWorld): JsonNode =
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

proc toJsonHook*(source: TestTestLdtkJsonRoot_imageExportMode): JsonNode =
  case source
  of TestTestLdtkJsonRoot_imageExportMode.LayersAndLevels:
    return newJString("LayersAndLevels")
  of TestTestLdtkJsonRoot_imageExportMode.OneImagePerLayer:
    return newJString("OneImagePerLayer")
  of TestTestLdtkJsonRoot_imageExportMode.None:
    return newJString("None")
  of TestTestLdtkJsonRoot_imageExportMode.OneImagePerLevel:
    return newJString("OneImagePerLevel")
  
proc fromJsonHook*(target: var TestTestLdtkJsonRoot_imageExportMode;
                   source: JsonNode) =
  target = case getStr(source)
  of "LayersAndLevels":
    TestTestLdtkJsonRoot_imageExportMode.LayersAndLevels
  of "OneImagePerLayer":
    TestTestLdtkJsonRoot_imageExportMode.OneImagePerLayer
  of "None":
    TestTestLdtkJsonRoot_imageExportMode.None
  of "OneImagePerLevel":
    TestTestLdtkJsonRoot_imageExportMode.OneImagePerLevel
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var TestIntGridValueDef; source: JsonNode) =
  if "tile" in source and source{"tile"}.kind != JNull:
    target.tile = some(jsonTo(source{"tile"}, typeof(unsafeGet(target.tile))))
  assert("color" in source,
         "color" & " is missing while decoding " & "TestIntGridValueDef")
  target.color = jsonTo(source{"color"}, typeof(target.color))
  if "identifier" in source and source{"identifier"}.kind != JNull:
    target.identifier = some(jsonTo(source{"identifier"},
                                    typeof(unsafeGet(target.identifier))))
  assert("groupUid" in source,
         "groupUid" & " is missing while decoding " & "TestIntGridValueDef")
  target.groupUid = jsonTo(source{"groupUid"}, typeof(target.groupUid))
  assert("value" in source,
         "value" & " is missing while decoding " & "TestIntGridValueDef")
  target.value = jsonTo(source{"value"}, typeof(target.value))

proc toJsonHook*(source: TestIntGridValueDef): JsonNode =
  result = newJObject()
  if isSome(source.tile):
    result{"tile"} = toJson(source.tile)
  result{"color"} = toJson(source.color)
  if isSome(source.identifier):
    result{"identifier"} = toJson(source.identifier)
  result{"groupUid"} = toJson(source.groupUid)
  result{"value"} = toJson(source.value)

proc toJsonHook*(source: TestTestFieldDef_textLanguageMode): JsonNode =
  case source
  of TestTestFieldDef_textLanguageMode.LangMarkdown:
    return newJString("LangMarkdown")
  of TestTestFieldDef_textLanguageMode.LangPython:
    return newJString("LangPython")
  of TestTestFieldDef_textLanguageMode.LangLog:
    return newJString("LangLog")
  of TestTestFieldDef_textLanguageMode.LangC:
    return newJString("LangC")
  of TestTestFieldDef_textLanguageMode.LangLua:
    return newJString("LangLua")
  of TestTestFieldDef_textLanguageMode.LangHaxe:
    return newJString("LangHaxe")
  of TestTestFieldDef_textLanguageMode.LangJS:
    return newJString("LangJS")
  of TestTestFieldDef_textLanguageMode.LangRuby:
    return newJString("LangRuby")
  of TestTestFieldDef_textLanguageMode.LangJson:
    return newJString("LangJson")
  of TestTestFieldDef_textLanguageMode.LangXml:
    return newJString("LangXml")
  
proc fromJsonHook*(target: var TestTestFieldDef_textLanguageMode;
                   source: JsonNode) =
  target = case getStr(source)
  of "LangMarkdown":
    TestTestFieldDef_textLanguageMode.LangMarkdown
  of "LangPython":
    TestTestFieldDef_textLanguageMode.LangPython
  of "LangLog":
    TestTestFieldDef_textLanguageMode.LangLog
  of "LangC":
    TestTestFieldDef_textLanguageMode.LangC
  of "LangLua":
    TestTestFieldDef_textLanguageMode.LangLua
  of "LangHaxe":
    TestTestFieldDef_textLanguageMode.LangHaxe
  of "LangJS":
    TestTestFieldDef_textLanguageMode.LangJS
  of "LangRuby":
    TestTestFieldDef_textLanguageMode.LangRuby
  of "LangJson":
    TestTestFieldDef_textLanguageMode.LangJson
  of "LangXml":
    TestTestFieldDef_textLanguageMode.LangXml
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc toJsonHook*(source: TestTestFieldDef_editorDisplayPos): JsonNode =
  case source
  of TestTestFieldDef_editorDisplayPos.Beneath:
    return newJString("Beneath")
  of TestTestFieldDef_editorDisplayPos.Above:
    return newJString("Above")
  of TestTestFieldDef_editorDisplayPos.Center:
    return newJString("Center")
  
proc fromJsonHook*(target: var TestTestFieldDef_editorDisplayPos;
                   source: JsonNode) =
  target = case getStr(source)
  of "Beneath":
    TestTestFieldDef_editorDisplayPos.Beneath
  of "Above":
    TestTestFieldDef_editorDisplayPos.Above
  of "Center":
    TestTestFieldDef_editorDisplayPos.Center
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc toJsonHook*(source: TestTestFieldDef_editorDisplayMode): JsonNode =
  case source
  of TestTestFieldDef_editorDisplayMode.PointPath:
    return newJString("PointPath")
  of TestTestFieldDef_editorDisplayMode.PointStar:
    return newJString("PointStar")
  of TestTestFieldDef_editorDisplayMode.ValueOnly:
    return newJString("ValueOnly")
  of TestTestFieldDef_editorDisplayMode.Hidden:
    return newJString("Hidden")
  of TestTestFieldDef_editorDisplayMode.Points:
    return newJString("Points")
  of TestTestFieldDef_editorDisplayMode.NameAndValue:
    return newJString("NameAndValue")
  of TestTestFieldDef_editorDisplayMode.ArrayCountNoLabel:
    return newJString("ArrayCountNoLabel")
  of TestTestFieldDef_editorDisplayMode.EntityTile:
    return newJString("EntityTile")
  of TestTestFieldDef_editorDisplayMode.PointPathLoop:
    return newJString("PointPathLoop")
  of TestTestFieldDef_editorDisplayMode.RadiusPx:
    return newJString("RadiusPx")
  of TestTestFieldDef_editorDisplayMode.LevelTile:
    return newJString("LevelTile")
  of TestTestFieldDef_editorDisplayMode.RadiusGrid:
    return newJString("RadiusGrid")
  of TestTestFieldDef_editorDisplayMode.RefLinkBetweenCenters:
    return newJString("RefLinkBetweenCenters")
  of TestTestFieldDef_editorDisplayMode.RefLinkBetweenPivots:
    return newJString("RefLinkBetweenPivots")
  of TestTestFieldDef_editorDisplayMode.ArrayCountWithLabel:
    return newJString("ArrayCountWithLabel")
  
proc fromJsonHook*(target: var TestTestFieldDef_editorDisplayMode;
                   source: JsonNode) =
  target = case getStr(source)
  of "PointPath":
    TestTestFieldDef_editorDisplayMode.PointPath
  of "PointStar":
    TestTestFieldDef_editorDisplayMode.PointStar
  of "ValueOnly":
    TestTestFieldDef_editorDisplayMode.ValueOnly
  of "Hidden":
    TestTestFieldDef_editorDisplayMode.Hidden
  of "Points":
    TestTestFieldDef_editorDisplayMode.Points
  of "NameAndValue":
    TestTestFieldDef_editorDisplayMode.NameAndValue
  of "ArrayCountNoLabel":
    TestTestFieldDef_editorDisplayMode.ArrayCountNoLabel
  of "EntityTile":
    TestTestFieldDef_editorDisplayMode.EntityTile
  of "PointPathLoop":
    TestTestFieldDef_editorDisplayMode.PointPathLoop
  of "RadiusPx":
    TestTestFieldDef_editorDisplayMode.RadiusPx
  of "LevelTile":
    TestTestFieldDef_editorDisplayMode.LevelTile
  of "RadiusGrid":
    TestTestFieldDef_editorDisplayMode.RadiusGrid
  of "RefLinkBetweenCenters":
    TestTestFieldDef_editorDisplayMode.RefLinkBetweenCenters
  of "RefLinkBetweenPivots":
    TestTestFieldDef_editorDisplayMode.RefLinkBetweenPivots
  of "ArrayCountWithLabel":
    TestTestFieldDef_editorDisplayMode.ArrayCountWithLabel
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc toJsonHook*(source: TestTestFieldDef_editorLinkStyle): JsonNode =
  case source
  of TestTestFieldDef_editorLinkStyle.DashedLine:
    return newJString("DashedLine")
  of TestTestFieldDef_editorLinkStyle.CurvedArrow:
    return newJString("CurvedArrow")
  of TestTestFieldDef_editorLinkStyle.ArrowsLine:
    return newJString("ArrowsLine")
  of TestTestFieldDef_editorLinkStyle.ZigZag:
    return newJString("ZigZag")
  of TestTestFieldDef_editorLinkStyle.StraightArrow:
    return newJString("StraightArrow")
  
proc fromJsonHook*(target: var TestTestFieldDef_editorLinkStyle;
                   source: JsonNode) =
  target = case getStr(source)
  of "DashedLine":
    TestTestFieldDef_editorLinkStyle.DashedLine
  of "CurvedArrow":
    TestTestFieldDef_editorLinkStyle.CurvedArrow
  of "ArrowsLine":
    TestTestFieldDef_editorLinkStyle.ArrowsLine
  of "ZigZag":
    TestTestFieldDef_editorLinkStyle.ZigZag
  of "StraightArrow":
    TestTestFieldDef_editorLinkStyle.StraightArrow
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc toJsonHook*(source: TestTestFieldDef_allowedRefs): JsonNode =
  case source
  of TestTestFieldDef_allowedRefs.Any:
    return newJString("Any")
  of TestTestFieldDef_allowedRefs.OnlyTags:
    return newJString("OnlyTags")
  of TestTestFieldDef_allowedRefs.OnlySame:
    return newJString("OnlySame")
  of TestTestFieldDef_allowedRefs.OnlySpecificEntity:
    return newJString("OnlySpecificEntity")
  
proc fromJsonHook*(target: var TestTestFieldDef_allowedRefs; source: JsonNode) =
  target = case getStr(source)
  of "Any":
    TestTestFieldDef_allowedRefs.Any
  of "OnlyTags":
    TestTestFieldDef_allowedRefs.OnlyTags
  of "OnlySame":
    TestTestFieldDef_allowedRefs.OnlySame
  of "OnlySpecificEntity":
    TestTestFieldDef_allowedRefs.OnlySpecificEntity
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var TestFieldDef; source: JsonNode) =
  assert("type" in source,
         "type" & " is missing while decoding " & "TestFieldDef")
  target.type1 = jsonTo(source{"type"}, typeof(target.type1))
  assert("editorDisplayScale" in source,
         "editorDisplayScale" & " is missing while decoding " & "TestFieldDef")
  target.editorDisplayScale = jsonTo(source{"editorDisplayScale"},
                                     typeof(target.editorDisplayScale))
  assert("__type" in source,
         "__type" & " is missing while decoding " & "TestFieldDef")
  target.type = jsonTo(source{"__type"}, typeof(target.type))
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
         "editorAlwaysShow" & " is missing while decoding " & "TestFieldDef")
  target.editorAlwaysShow = jsonTo(source{"editorAlwaysShow"},
                                   typeof(target.editorAlwaysShow))
  if "defaultOverride" in source and source{"defaultOverride"}.kind != JNull:
    target.defaultOverride = some(jsonTo(source{"defaultOverride"},
        typeof(unsafeGet(target.defaultOverride))))
  assert("autoChainRef" in source,
         "autoChainRef" & " is missing while decoding " & "TestFieldDef")
  target.autoChainRef = jsonTo(source{"autoChainRef"},
                               typeof(target.autoChainRef))
  assert("editorDisplayPos" in source,
         "editorDisplayPos" & " is missing while decoding " & "TestFieldDef")
  target.editorDisplayPos = jsonTo(source{"editorDisplayPos"},
                                   typeof(target.editorDisplayPos))
  assert("editorDisplayMode" in source,
         "editorDisplayMode" & " is missing while decoding " & "TestFieldDef")
  target.editorDisplayMode = jsonTo(source{"editorDisplayMode"},
                                    typeof(target.editorDisplayMode))
  assert("identifier" in source,
         "identifier" & " is missing while decoding " & "TestFieldDef")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  if "regex" in source and source{"regex"}.kind != JNull:
    target.regex = some(jsonTo(source{"regex"}, typeof(unsafeGet(target.regex))))
  assert("isArray" in source,
         "isArray" & " is missing while decoding " & "TestFieldDef")
  target.isArray = jsonTo(source{"isArray"}, typeof(target.isArray))
  assert("editorLinkStyle" in source,
         "editorLinkStyle" & " is missing while decoding " & "TestFieldDef")
  target.editorLinkStyle = jsonTo(source{"editorLinkStyle"},
                                  typeof(target.editorLinkStyle))
  assert("allowedRefs" in source,
         "allowedRefs" & " is missing while decoding " & "TestFieldDef")
  target.allowedRefs = jsonTo(source{"allowedRefs"}, typeof(target.allowedRefs))
  assert("useForSmartColor" in source,
         "useForSmartColor" & " is missing while decoding " & "TestFieldDef")
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
         "editorCutLongValues" & " is missing while decoding " & "TestFieldDef")
  target.editorCutLongValues = jsonTo(source{"editorCutLongValues"},
                                      typeof(target.editorCutLongValues))
  assert("canBeNull" in source,
         "canBeNull" & " is missing while decoding " & "TestFieldDef")
  target.canBeNull = jsonTo(source{"canBeNull"}, typeof(target.canBeNull))
  assert("allowedRefTags" in source,
         "allowedRefTags" & " is missing while decoding " & "TestFieldDef")
  target.allowedRefTags = jsonTo(source{"allowedRefTags"},
                                 typeof(target.allowedRefTags))
  assert("uid" in source, "uid" & " is missing while decoding " & "TestFieldDef")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  assert("symmetricalRef" in source,
         "symmetricalRef" & " is missing while decoding " & "TestFieldDef")
  target.symmetricalRef = jsonTo(source{"symmetricalRef"},
                                 typeof(target.symmetricalRef))
  if "editorDisplayColor" in source and
      source{"editorDisplayColor"}.kind != JNull:
    target.editorDisplayColor = some(jsonTo(source{"editorDisplayColor"},
        typeof(unsafeGet(target.editorDisplayColor))))
  assert("allowOutOfLevelRef" in source,
         "allowOutOfLevelRef" & " is missing while decoding " & "TestFieldDef")
  target.allowOutOfLevelRef = jsonTo(source{"allowOutOfLevelRef"},
                                     typeof(target.allowOutOfLevelRef))
  if "acceptFileTypes" in source and source{"acceptFileTypes"}.kind != JNull:
    target.acceptFileTypes = some(jsonTo(source{"acceptFileTypes"},
        typeof(unsafeGet(target.acceptFileTypes))))
  assert("editorShowInWorld" in source,
         "editorShowInWorld" & " is missing while decoding " & "TestFieldDef")
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
         "searchable" & " is missing while decoding " & "TestFieldDef")
  target.searchable = jsonTo(source{"searchable"}, typeof(target.searchable))
  if "min" in source and source{"min"}.kind != JNull:
    target.min = some(jsonTo(source{"min"}, typeof(unsafeGet(target.min))))
  assert("exportToToc" in source,
         "exportToToc" & " is missing while decoding " & "TestFieldDef")
  target.exportToToc = jsonTo(source{"exportToToc"}, typeof(target.exportToToc))
  if "max" in source and source{"max"}.kind != JNull:
    target.max = some(jsonTo(source{"max"}, typeof(unsafeGet(target.max))))

proc toJsonHook*(source: TestFieldDef): JsonNode =
  result = newJObject()
  result{"type"} = toJson(source.type1)
  result{"editorDisplayScale"} = toJson(source.editorDisplayScale)
  result{"__type"} = toJson(source.type)
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

proc toJsonHook*(source: TestTestTilesetDef_embedAtlas): JsonNode =
  case source
  of TestTestTilesetDef_embedAtlas.LdtkIcons:
    return newJString("LdtkIcons")
  
proc fromJsonHook*(target: var TestTestTilesetDef_embedAtlas; source: JsonNode) =
  target = case getStr(source)
  of "LdtkIcons":
    TestTestTilesetDef_embedAtlas.LdtkIcons
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var TestEnumTagValue; source: JsonNode) =
  assert("tileIds" in source,
         "tileIds" & " is missing while decoding " & "TestEnumTagValue")
  target.tileIds = jsonTo(source{"tileIds"}, typeof(target.tileIds))
  assert("enumValueId" in source,
         "enumValueId" & " is missing while decoding " & "TestEnumTagValue")
  target.enumValueId = jsonTo(source{"enumValueId"}, typeof(target.enumValueId))

proc toJsonHook*(source: TestEnumTagValue): JsonNode =
  result = newJObject()
  result{"tileIds"} = toJson(source.tileIds)
  result{"enumValueId"} = toJson(source.enumValueId)

proc fromJsonHook*(target: var TestTileCustomMetadata; source: JsonNode) =
  assert("data" in source,
         "data" & " is missing while decoding " & "TestTileCustomMetadata")
  target.data = jsonTo(source{"data"}, typeof(target.data))
  assert("tileId" in source,
         "tileId" & " is missing while decoding " & "TestTileCustomMetadata")
  target.tileId = jsonTo(source{"tileId"}, typeof(target.tileId))

proc toJsonHook*(source: TestTileCustomMetadata): JsonNode =
  result = newJObject()
  result{"data"} = toJson(source.data)
  result{"tileId"} = toJson(source.tileId)

proc fromJsonHook*(target: var TestTilesetDef; source: JsonNode) =
  assert("pxHei" in source,
         "pxHei" & " is missing while decoding " & "TestTilesetDef")
  target.pxHei = jsonTo(source{"pxHei"}, typeof(target.pxHei))
  assert("savedSelections" in source,
         "savedSelections" & " is missing while decoding " & "TestTilesetDef")
  target.savedSelections = jsonTo(source{"savedSelections"},
                                  typeof(target.savedSelections))
  assert("padding" in source,
         "padding" & " is missing while decoding " & "TestTilesetDef")
  target.padding = jsonTo(source{"padding"}, typeof(target.padding))
  assert("spacing" in source,
         "spacing" & " is missing while decoding " & "TestTilesetDef")
  target.spacing = jsonTo(source{"spacing"}, typeof(target.spacing))
  if "tagsSourceEnumUid" in source and
      source{"tagsSourceEnumUid"}.kind != JNull:
    target.tagsSourceEnumUid = some(jsonTo(source{"tagsSourceEnumUid"},
        typeof(unsafeGet(target.tagsSourceEnumUid))))
  if "embedAtlas" in source and source{"embedAtlas"}.kind != JNull:
    target.embedAtlas = some(jsonTo(source{"embedAtlas"},
                                    typeof(unsafeGet(target.embedAtlas))))
  assert("identifier" in source,
         "identifier" & " is missing while decoding " & "TestTilesetDef")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  if "cachedPixelData" in source and source{"cachedPixelData"}.kind != JNull:
    target.cachedPixelData = some(jsonTo(source{"cachedPixelData"},
        typeof(unsafeGet(target.cachedPixelData))))
  assert("enumTags" in source,
         "enumTags" & " is missing while decoding " & "TestTilesetDef")
  target.enumTags = jsonTo(source{"enumTags"}, typeof(target.enumTags))
  assert("pxWid" in source,
         "pxWid" & " is missing while decoding " & "TestTilesetDef")
  target.pxWid = jsonTo(source{"pxWid"}, typeof(target.pxWid))
  assert("tileGridSize" in source,
         "tileGridSize" & " is missing while decoding " & "TestTilesetDef")
  target.tileGridSize = jsonTo(source{"tileGridSize"},
                               typeof(target.tileGridSize))
  assert("customData" in source,
         "customData" & " is missing while decoding " & "TestTilesetDef")
  target.customData = jsonTo(source{"customData"}, typeof(target.customData))
  assert("uid" in source,
         "uid" & " is missing while decoding " & "TestTilesetDef")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  assert("__cHei" in source,
         "__cHei" & " is missing while decoding " & "TestTilesetDef")
  target.cHei = jsonTo(source{"__cHei"}, typeof(target.cHei))
  assert("__cWid" in source,
         "__cWid" & " is missing while decoding " & "TestTilesetDef")
  target.cWid = jsonTo(source{"__cWid"}, typeof(target.cWid))
  if "relPath" in source and source{"relPath"}.kind != JNull:
    target.relPath = some(jsonTo(source{"relPath"},
                                 typeof(unsafeGet(target.relPath))))
  assert("tags" in source,
         "tags" & " is missing while decoding " & "TestTilesetDef")
  target.tags = jsonTo(source{"tags"}, typeof(target.tags))

proc toJsonHook*(source: TestTilesetDef): JsonNode =
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

proc toJsonHook*(source: TestTestEntityDef_limitScope): JsonNode =
  case source
  of TestTestEntityDef_limitScope.PerLayer:
    return newJString("PerLayer")
  of TestTestEntityDef_limitScope.PerWorld:
    return newJString("PerWorld")
  of TestTestEntityDef_limitScope.PerLevel:
    return newJString("PerLevel")
  
proc fromJsonHook*(target: var TestTestEntityDef_limitScope; source: JsonNode) =
  target = case getStr(source)
  of "PerLayer":
    TestTestEntityDef_limitScope.PerLayer
  of "PerWorld":
    TestTestEntityDef_limitScope.PerWorld
  of "PerLevel":
    TestTestEntityDef_limitScope.PerLevel
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc toJsonHook*(source: TestTestEntityDef_limitBehavior): JsonNode =
  case source
  of TestTestEntityDef_limitBehavior.PreventAdding:
    return newJString("PreventAdding")
  of TestTestEntityDef_limitBehavior.MoveLastOne:
    return newJString("MoveLastOne")
  of TestTestEntityDef_limitBehavior.DiscardOldOnes:
    return newJString("DiscardOldOnes")
  
proc fromJsonHook*(target: var TestTestEntityDef_limitBehavior; source: JsonNode) =
  target = case getStr(source)
  of "PreventAdding":
    TestTestEntityDef_limitBehavior.PreventAdding
  of "MoveLastOne":
    TestTestEntityDef_limitBehavior.MoveLastOne
  of "DiscardOldOnes":
    TestTestEntityDef_limitBehavior.DiscardOldOnes
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc toJsonHook*(source: TestTestEntityDef_renderMode): JsonNode =
  case source
  of TestTestEntityDef_renderMode.Tile:
    return newJString("Tile")
  of TestTestEntityDef_renderMode.Cross:
    return newJString("Cross")
  of TestTestEntityDef_renderMode.Ellipse:
    return newJString("Ellipse")
  of TestTestEntityDef_renderMode.Rectangle:
    return newJString("Rectangle")
  
proc fromJsonHook*(target: var TestTestEntityDef_renderMode; source: JsonNode) =
  target = case getStr(source)
  of "Tile":
    TestTestEntityDef_renderMode.Tile
  of "Cross":
    TestTestEntityDef_renderMode.Cross
  of "Ellipse":
    TestTestEntityDef_renderMode.Ellipse
  of "Rectangle":
    TestTestEntityDef_renderMode.Rectangle
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc toJsonHook*(source: TestTestEntityDef_tileRenderMode): JsonNode =
  case source
  of TestTestEntityDef_tileRenderMode.FullSizeCropped:
    return newJString("FullSizeCropped")
  of TestTestEntityDef_tileRenderMode.FullSizeUncropped:
    return newJString("FullSizeUncropped")
  of TestTestEntityDef_tileRenderMode.Repeat:
    return newJString("Repeat")
  of TestTestEntityDef_tileRenderMode.FitInside:
    return newJString("FitInside")
  of TestTestEntityDef_tileRenderMode.NineSlice:
    return newJString("NineSlice")
  of TestTestEntityDef_tileRenderMode.Cover:
    return newJString("Cover")
  of TestTestEntityDef_tileRenderMode.Stretch:
    return newJString("Stretch")
  
proc fromJsonHook*(target: var TestTestEntityDef_tileRenderMode;
                   source: JsonNode) =
  target = case getStr(source)
  of "FullSizeCropped":
    TestTestEntityDef_tileRenderMode.FullSizeCropped
  of "FullSizeUncropped":
    TestTestEntityDef_tileRenderMode.FullSizeUncropped
  of "Repeat":
    TestTestEntityDef_tileRenderMode.Repeat
  of "FitInside":
    TestTestEntityDef_tileRenderMode.FitInside
  of "NineSlice":
    TestTestEntityDef_tileRenderMode.NineSlice
  of "Cover":
    TestTestEntityDef_tileRenderMode.Cover
  of "Stretch":
    TestTestEntityDef_tileRenderMode.Stretch
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var TestEntityDef; source: JsonNode) =
  assert("allowOutOfBounds" in source,
         "allowOutOfBounds" & " is missing while decoding " & "TestEntityDef")
  target.allowOutOfBounds = jsonTo(source{"allowOutOfBounds"},
                                   typeof(target.allowOutOfBounds))
  assert("pivotY" in source,
         "pivotY" & " is missing while decoding " & "TestEntityDef")
  target.pivotY = jsonTo(source{"pivotY"}, typeof(target.pivotY))
  assert("tileOpacity" in source,
         "tileOpacity" & " is missing while decoding " & "TestEntityDef")
  target.tileOpacity = jsonTo(source{"tileOpacity"}, typeof(target.tileOpacity))
  assert("color" in source,
         "color" & " is missing while decoding " & "TestEntityDef")
  target.color = jsonTo(source{"color"}, typeof(target.color))
  assert("limitScope" in source,
         "limitScope" & " is missing while decoding " & "TestEntityDef")
  target.limitScope = jsonTo(source{"limitScope"}, typeof(target.limitScope))
  assert("limitBehavior" in source,
         "limitBehavior" & " is missing while decoding " & "TestEntityDef")
  target.limitBehavior = jsonTo(source{"limitBehavior"},
                                typeof(target.limitBehavior))
  assert("hollow" in source,
         "hollow" & " is missing while decoding " & "TestEntityDef")
  target.hollow = jsonTo(source{"hollow"}, typeof(target.hollow))
  assert("height" in source,
         "height" & " is missing while decoding " & "TestEntityDef")
  target.height = jsonTo(source{"height"}, typeof(target.height))
  assert("renderMode" in source,
         "renderMode" & " is missing while decoding " & "TestEntityDef")
  target.renderMode = jsonTo(source{"renderMode"}, typeof(target.renderMode))
  if "tilesetId" in source and source{"tilesetId"}.kind != JNull:
    target.tilesetId = some(jsonTo(source{"tilesetId"},
                                   typeof(unsafeGet(target.tilesetId))))
  assert("keepAspectRatio" in source,
         "keepAspectRatio" & " is missing while decoding " & "TestEntityDef")
  target.keepAspectRatio = jsonTo(source{"keepAspectRatio"},
                                  typeof(target.keepAspectRatio))
  if "minWidth" in source and source{"minWidth"}.kind != JNull:
    target.minWidth = some(jsonTo(source{"minWidth"},
                                  typeof(unsafeGet(target.minWidth))))
  assert("showName" in source,
         "showName" & " is missing while decoding " & "TestEntityDef")
  target.showName = jsonTo(source{"showName"}, typeof(target.showName))
  assert("resizableX" in source,
         "resizableX" & " is missing while decoding " & "TestEntityDef")
  target.resizableX = jsonTo(source{"resizableX"}, typeof(target.resizableX))
  assert("identifier" in source,
         "identifier" & " is missing while decoding " & "TestEntityDef")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  assert("maxCount" in source,
         "maxCount" & " is missing while decoding " & "TestEntityDef")
  target.maxCount = jsonTo(source{"maxCount"}, typeof(target.maxCount))
  if "tileId" in source and source{"tileId"}.kind != JNull:
    target.tileId = some(jsonTo(source{"tileId"},
                                typeof(unsafeGet(target.tileId))))
  assert("pivotX" in source,
         "pivotX" & " is missing while decoding " & "TestEntityDef")
  target.pivotX = jsonTo(source{"pivotX"}, typeof(target.pivotX))
  if "doc" in source and source{"doc"}.kind != JNull:
    target.doc = some(jsonTo(source{"doc"}, typeof(unsafeGet(target.doc))))
  assert("fieldDefs" in source,
         "fieldDefs" & " is missing while decoding " & "TestEntityDef")
  target.fieldDefs = jsonTo(source{"fieldDefs"}, typeof(target.fieldDefs))
  assert("uid" in source,
         "uid" & " is missing while decoding " & "TestEntityDef")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  assert("tileRenderMode" in source,
         "tileRenderMode" & " is missing while decoding " & "TestEntityDef")
  target.tileRenderMode = jsonTo(source{"tileRenderMode"},
                                 typeof(target.tileRenderMode))
  if "uiTileRect" in source and source{"uiTileRect"}.kind != JNull:
    target.uiTileRect = some(jsonTo(source{"uiTileRect"},
                                    typeof(unsafeGet(target.uiTileRect))))
  assert("resizableY" in source,
         "resizableY" & " is missing while decoding " & "TestEntityDef")
  target.resizableY = jsonTo(source{"resizableY"}, typeof(target.resizableY))
  assert("lineOpacity" in source,
         "lineOpacity" & " is missing while decoding " & "TestEntityDef")
  target.lineOpacity = jsonTo(source{"lineOpacity"}, typeof(target.lineOpacity))
  if "minHeight" in source and source{"minHeight"}.kind != JNull:
    target.minHeight = some(jsonTo(source{"minHeight"},
                                   typeof(unsafeGet(target.minHeight))))
  if "tileRect" in source and source{"tileRect"}.kind != JNull:
    target.tileRect = some(jsonTo(source{"tileRect"},
                                  typeof(unsafeGet(target.tileRect))))
  assert("nineSliceBorders" in source,
         "nineSliceBorders" & " is missing while decoding " & "TestEntityDef")
  target.nineSliceBorders = jsonTo(source{"nineSliceBorders"},
                                   typeof(target.nineSliceBorders))
  if "maxWidth" in source and source{"maxWidth"}.kind != JNull:
    target.maxWidth = some(jsonTo(source{"maxWidth"},
                                  typeof(unsafeGet(target.maxWidth))))
  assert("width" in source,
         "width" & " is missing while decoding " & "TestEntityDef")
  target.width = jsonTo(source{"width"}, typeof(target.width))
  assert("tags" in source,
         "tags" & " is missing while decoding " & "TestEntityDef")
  target.tags = jsonTo(source{"tags"}, typeof(target.tags))
  if "maxHeight" in source and source{"maxHeight"}.kind != JNull:
    target.maxHeight = some(jsonTo(source{"maxHeight"},
                                   typeof(unsafeGet(target.maxHeight))))
  assert("exportToToc" in source,
         "exportToToc" & " is missing while decoding " & "TestEntityDef")
  target.exportToToc = jsonTo(source{"exportToToc"}, typeof(target.exportToToc))
  assert("fillOpacity" in source,
         "fillOpacity" & " is missing while decoding " & "TestEntityDef")
  target.fillOpacity = jsonTo(source{"fillOpacity"}, typeof(target.fillOpacity))

proc toJsonHook*(source: TestEntityDef): JsonNode =
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

proc fromJsonHook*(target: var TestEnumDefValues; source: JsonNode) =
  if "__tileSrcRect" in source and source{"__tileSrcRect"}.kind != JNull:
    target.tileSrcRect = some(jsonTo(source{"__tileSrcRect"},
                                     typeof(unsafeGet(target.tileSrcRect))))
  assert("color" in source,
         "color" & " is missing while decoding " & "TestEnumDefValues")
  target.color = jsonTo(source{"color"}, typeof(target.color))
  assert("id" in source,
         "id" & " is missing while decoding " & "TestEnumDefValues")
  target.id = jsonTo(source{"id"}, typeof(target.id))
  if "tileId" in source and source{"tileId"}.kind != JNull:
    target.tileId = some(jsonTo(source{"tileId"},
                                typeof(unsafeGet(target.tileId))))
  if "tileRect" in source and source{"tileRect"}.kind != JNull:
    target.tileRect = some(jsonTo(source{"tileRect"},
                                  typeof(unsafeGet(target.tileRect))))

proc toJsonHook*(source: TestEnumDefValues): JsonNode =
  result = newJObject()
  if isSome(source.tileSrcRect):
    result{"__tileSrcRect"} = toJson(source.tileSrcRect)
  result{"color"} = toJson(source.color)
  result{"id"} = toJson(source.id)
  if isSome(source.tileId):
    result{"tileId"} = toJson(source.tileId)
  if isSome(source.tileRect):
    result{"tileRect"} = toJson(source.tileRect)

proc fromJsonHook*(target: var TestEnumDef; source: JsonNode) =
  assert("values" in source,
         "values" & " is missing while decoding " & "TestEnumDef")
  target.values = jsonTo(source{"values"}, typeof(target.values))
  if "externalRelPath" in source and source{"externalRelPath"}.kind != JNull:
    target.externalRelPath = some(jsonTo(source{"externalRelPath"},
        typeof(unsafeGet(target.externalRelPath))))
  assert("identifier" in source,
         "identifier" & " is missing while decoding " & "TestEnumDef")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  if "externalFileChecksum" in source and
      source{"externalFileChecksum"}.kind != JNull:
    target.externalFileChecksum = some(jsonTo(
        source{"externalFileChecksum"},
        typeof(unsafeGet(target.externalFileChecksum))))
  if "iconTilesetUid" in source and source{"iconTilesetUid"}.kind != JNull:
    target.iconTilesetUid = some(jsonTo(source{"iconTilesetUid"}, typeof(
        unsafeGet(target.iconTilesetUid))))
  assert("uid" in source, "uid" & " is missing while decoding " & "TestEnumDef")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  assert("tags" in source,
         "tags" & " is missing while decoding " & "TestEnumDef")
  target.tags = jsonTo(source{"tags"}, typeof(target.tags))

proc toJsonHook*(source: TestEnumDef): JsonNode =
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

proc toJsonHook*(source: TestTestLayerDef_type): JsonNode =
  case source
  of TestTestLayerDef_type.Tiles:
    return newJString("Tiles")
  of TestTestLayerDef_type.Entities:
    return newJString("Entities")
  of TestTestLayerDef_type.AutoLayer:
    return newJString("AutoLayer")
  of TestTestLayerDef_type.IntGrid:
    return newJString("IntGrid")
  
proc fromJsonHook*(target: var TestTestLayerDef_type; source: JsonNode) =
  target = case getStr(source)
  of "Tiles":
    TestTestLayerDef_type.Tiles
  of "Entities":
    TestTestLayerDef_type.Entities
  of "AutoLayer":
    TestTestLayerDef_type.AutoLayer
  of "IntGrid":
    TestTestLayerDef_type.IntGrid
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc toJsonHook*(source: TestTestAutoRuleDef_checker): JsonNode =
  case source
  of TestTestAutoRuleDef_checker.Horizontal:
    return newJString("Horizontal")
  of TestTestAutoRuleDef_checker.Vertical:
    return newJString("Vertical")
  of TestTestAutoRuleDef_checker.None:
    return newJString("None")
  
proc fromJsonHook*(target: var TestTestAutoRuleDef_checker; source: JsonNode) =
  target = case getStr(source)
  of "Horizontal":
    TestTestAutoRuleDef_checker.Horizontal
  of "Vertical":
    TestTestAutoRuleDef_checker.Vertical
  of "None":
    TestTestAutoRuleDef_checker.None
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc toJsonHook*(source: TestTestAutoRuleDef_tileMode): JsonNode =
  case source
  of TestTestAutoRuleDef_tileMode.Single:
    return newJString("Single")
  of TestTestAutoRuleDef_tileMode.Stamp:
    return newJString("Stamp")
  
proc fromJsonHook*(target: var TestTestAutoRuleDef_tileMode; source: JsonNode) =
  target = case getStr(source)
  of "Single":
    TestTestAutoRuleDef_tileMode.Single
  of "Stamp":
    TestTestAutoRuleDef_tileMode.Stamp
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var TestAutoRuleDef; source: JsonNode) =
  assert("checker" in source,
         "checker" & " is missing while decoding " & "TestAutoRuleDef")
  target.checker = jsonTo(source{"checker"}, typeof(target.checker))
  assert("pivotY" in source,
         "pivotY" & " is missing while decoding " & "TestAutoRuleDef")
  target.pivotY = jsonTo(source{"pivotY"}, typeof(target.pivotY))
  assert("breakOnMatch" in source,
         "breakOnMatch" & " is missing while decoding " & "TestAutoRuleDef")
  target.breakOnMatch = jsonTo(source{"breakOnMatch"},
                               typeof(target.breakOnMatch))
  assert("perlinOctaves" in source,
         "perlinOctaves" & " is missing while decoding " & "TestAutoRuleDef")
  target.perlinOctaves = jsonTo(source{"perlinOctaves"},
                                typeof(target.perlinOctaves))
  assert("yModulo" in source,
         "yModulo" & " is missing while decoding " & "TestAutoRuleDef")
  target.yModulo = jsonTo(source{"yModulo"}, typeof(target.yModulo))
  assert("size" in source,
         "size" & " is missing while decoding " & "TestAutoRuleDef")
  target.size = jsonTo(source{"size"}, typeof(target.size))
  assert("tileMode" in source,
         "tileMode" & " is missing while decoding " & "TestAutoRuleDef")
  target.tileMode = jsonTo(source{"tileMode"}, typeof(target.tileMode))
  assert("tileRandomXMax" in source,
         "tileRandomXMax" & " is missing while decoding " & "TestAutoRuleDef")
  target.tileRandomXMax = jsonTo(source{"tileRandomXMax"},
                                 typeof(target.tileRandomXMax))
  assert("tileRandomXMin" in source,
         "tileRandomXMin" & " is missing while decoding " & "TestAutoRuleDef")
  target.tileRandomXMin = jsonTo(source{"tileRandomXMin"},
                                 typeof(target.tileRandomXMin))
  assert("xModulo" in source,
         "xModulo" & " is missing while decoding " & "TestAutoRuleDef")
  target.xModulo = jsonTo(source{"xModulo"}, typeof(target.xModulo))
  assert("yOffset" in source,
         "yOffset" & " is missing while decoding " & "TestAutoRuleDef")
  target.yOffset = jsonTo(source{"yOffset"}, typeof(target.yOffset))
  assert("flipX" in source,
         "flipX" & " is missing while decoding " & "TestAutoRuleDef")
  target.flipX = jsonTo(source{"flipX"}, typeof(target.flipX))
  assert("tileYOffset" in source,
         "tileYOffset" & " is missing while decoding " & "TestAutoRuleDef")
  target.tileYOffset = jsonTo(source{"tileYOffset"}, typeof(target.tileYOffset))
  assert("chance" in source,
         "chance" & " is missing while decoding " & "TestAutoRuleDef")
  target.chance = jsonTo(source{"chance"}, typeof(target.chance))
  assert("tileRandomYMax" in source,
         "tileRandomYMax" & " is missing while decoding " & "TestAutoRuleDef")
  target.tileRandomYMax = jsonTo(source{"tileRandomYMax"},
                                 typeof(target.tileRandomYMax))
  assert("perlinActive" in source,
         "perlinActive" & " is missing while decoding " & "TestAutoRuleDef")
  target.perlinActive = jsonTo(source{"perlinActive"},
                               typeof(target.perlinActive))
  assert("perlinScale" in source,
         "perlinScale" & " is missing while decoding " & "TestAutoRuleDef")
  target.perlinScale = jsonTo(source{"perlinScale"}, typeof(target.perlinScale))
  if "outOfBoundsValue" in source and
      source{"outOfBoundsValue"}.kind != JNull:
    target.outOfBoundsValue = some(jsonTo(source{"outOfBoundsValue"},
        typeof(unsafeGet(target.outOfBoundsValue))))
  assert("pivotX" in source,
         "pivotX" & " is missing while decoding " & "TestAutoRuleDef")
  target.pivotX = jsonTo(source{"pivotX"}, typeof(target.pivotX))
  assert("flipY" in source,
         "flipY" & " is missing while decoding " & "TestAutoRuleDef")
  target.flipY = jsonTo(source{"flipY"}, typeof(target.flipY))
  assert("active" in source,
         "active" & " is missing while decoding " & "TestAutoRuleDef")
  target.active = jsonTo(source{"active"}, typeof(target.active))
  assert("uid" in source,
         "uid" & " is missing while decoding " & "TestAutoRuleDef")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  if "tileIds" in source and source{"tileIds"}.kind != JNull:
    target.tileIds = some(jsonTo(source{"tileIds"},
                                 typeof(unsafeGet(target.tileIds))))
  assert("invalidated" in source,
         "invalidated" & " is missing while decoding " & "TestAutoRuleDef")
  target.invalidated = jsonTo(source{"invalidated"}, typeof(target.invalidated))
  assert("pattern" in source,
         "pattern" & " is missing while decoding " & "TestAutoRuleDef")
  target.pattern = jsonTo(source{"pattern"}, typeof(target.pattern))
  assert("alpha" in source,
         "alpha" & " is missing while decoding " & "TestAutoRuleDef")
  target.alpha = jsonTo(source{"alpha"}, typeof(target.alpha))
  assert("tileRectsIds" in source,
         "tileRectsIds" & " is missing while decoding " & "TestAutoRuleDef")
  target.tileRectsIds = jsonTo(source{"tileRectsIds"},
                               typeof(target.tileRectsIds))
  assert("tileXOffset" in source,
         "tileXOffset" & " is missing while decoding " & "TestAutoRuleDef")
  target.tileXOffset = jsonTo(source{"tileXOffset"}, typeof(target.tileXOffset))
  assert("xOffset" in source,
         "xOffset" & " is missing while decoding " & "TestAutoRuleDef")
  target.xOffset = jsonTo(source{"xOffset"}, typeof(target.xOffset))
  assert("tileRandomYMin" in source,
         "tileRandomYMin" & " is missing while decoding " & "TestAutoRuleDef")
  target.tileRandomYMin = jsonTo(source{"tileRandomYMin"},
                                 typeof(target.tileRandomYMin))
  assert("perlinSeed" in source,
         "perlinSeed" & " is missing while decoding " & "TestAutoRuleDef")
  target.perlinSeed = jsonTo(source{"perlinSeed"}, typeof(target.perlinSeed))

proc toJsonHook*(source: TestAutoRuleDef): JsonNode =
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

proc fromJsonHook*(target: var TestAutoLayerRuleGroup; source: JsonNode) =
  assert("isOptional" in source, "isOptional" & " is missing while decoding " &
      "TestAutoLayerRuleGroup")
  target.isOptional = jsonTo(source{"isOptional"}, typeof(target.isOptional))
  if "color" in source and source{"color"}.kind != JNull:
    target.color = some(jsonTo(source{"color"}, typeof(unsafeGet(target.color))))
  if "collapsed" in source and source{"collapsed"}.kind != JNull:
    target.collapsed = some(jsonTo(source{"collapsed"},
                                   typeof(unsafeGet(target.collapsed))))
  assert("usesWizard" in source, "usesWizard" & " is missing while decoding " &
      "TestAutoLayerRuleGroup")
  target.usesWizard = jsonTo(source{"usesWizard"}, typeof(target.usesWizard))
  assert("biomeRequirementMode" in source, "biomeRequirementMode" &
      " is missing while decoding " &
      "TestAutoLayerRuleGroup")
  target.biomeRequirementMode = jsonTo(source{"biomeRequirementMode"},
                                       typeof(target.biomeRequirementMode))
  assert("rules" in source,
         "rules" & " is missing while decoding " & "TestAutoLayerRuleGroup")
  target.rules = jsonTo(source{"rules"}, typeof(target.rules))
  if "icon" in source and source{"icon"}.kind != JNull:
    target.icon = some(jsonTo(source{"icon"}, typeof(unsafeGet(target.icon))))
  assert("active" in source,
         "active" & " is missing while decoding " & "TestAutoLayerRuleGroup")
  target.active = jsonTo(source{"active"}, typeof(target.active))
  assert("uid" in source,
         "uid" & " is missing while decoding " & "TestAutoLayerRuleGroup")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  assert("name" in source,
         "name" & " is missing while decoding " & "TestAutoLayerRuleGroup")
  target.name = jsonTo(source{"name"}, typeof(target.name))
  assert("requiredBiomeValues" in source, "requiredBiomeValues" &
      " is missing while decoding " &
      "TestAutoLayerRuleGroup")
  target.requiredBiomeValues = jsonTo(source{"requiredBiomeValues"},
                                      typeof(target.requiredBiomeValues))

proc toJsonHook*(source: TestAutoLayerRuleGroup): JsonNode =
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

proc fromJsonHook*(target: var TestIntGridValueGroupDef; source: JsonNode) =
  if "color" in source and source{"color"}.kind != JNull:
    target.color = some(jsonTo(source{"color"}, typeof(unsafeGet(target.color))))
  if "identifier" in source and source{"identifier"}.kind != JNull:
    target.identifier = some(jsonTo(source{"identifier"},
                                    typeof(unsafeGet(target.identifier))))
  assert("uid" in source,
         "uid" & " is missing while decoding " & "TestIntGridValueGroupDef")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))

proc toJsonHook*(source: TestIntGridValueGroupDef): JsonNode =
  result = newJObject()
  if isSome(source.color):
    result{"color"} = toJson(source.color)
  if isSome(source.identifier):
    result{"identifier"} = toJson(source.identifier)
  result{"uid"} = toJson(source.uid)

proc fromJsonHook*(target: var TestLayerDef; source: JsonNode) =
  assert("type" in source,
         "type" & " is missing while decoding " & "TestLayerDef")
  target.type1 = jsonTo(source{"type"}, typeof(target.type1))
  if "autoTilesetDefUid" in source and
      source{"autoTilesetDefUid"}.kind != JNull:
    target.autoTilesetDefUid = some(jsonTo(source{"autoTilesetDefUid"},
        typeof(unsafeGet(target.autoTilesetDefUid))))
  assert("parallaxScaling" in source,
         "parallaxScaling" & " is missing while decoding " & "TestLayerDef")
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
         "inactiveOpacity" & " is missing while decoding " & "TestLayerDef")
  target.inactiveOpacity = jsonTo(source{"inactiveOpacity"},
                                  typeof(target.inactiveOpacity))
  assert("__type" in source,
         "__type" & " is missing while decoding " & "TestLayerDef")
  target.type = jsonTo(source{"__type"}, typeof(target.type))
  assert("autoRuleGroups" in source,
         "autoRuleGroups" & " is missing while decoding " & "TestLayerDef")
  target.autoRuleGroups = jsonTo(source{"autoRuleGroups"},
                                 typeof(target.autoRuleGroups))
  assert("gridSize" in source,
         "gridSize" & " is missing while decoding " & "TestLayerDef")
  target.gridSize = jsonTo(source{"gridSize"}, typeof(target.gridSize))
  assert("hideInList" in source,
         "hideInList" & " is missing while decoding " & "TestLayerDef")
  target.hideInList = jsonTo(source{"hideInList"}, typeof(target.hideInList))
  if "tilesetDefUid" in source and source{"tilesetDefUid"}.kind != JNull:
    target.tilesetDefUid = some(jsonTo(source{"tilesetDefUid"},
                                       typeof(unsafeGet(target.tilesetDefUid))))
  if "uiColor" in source and source{"uiColor"}.kind != JNull:
    target.uiColor = some(jsonTo(source{"uiColor"},
                                 typeof(unsafeGet(target.uiColor))))
  assert("requiredTags" in source,
         "requiredTags" & " is missing while decoding " & "TestLayerDef")
  target.requiredTags = jsonTo(source{"requiredTags"},
                               typeof(target.requiredTags))
  assert("tilePivotX" in source,
         "tilePivotX" & " is missing while decoding " & "TestLayerDef")
  target.tilePivotX = jsonTo(source{"tilePivotX"}, typeof(target.tilePivotX))
  assert("uiFilterTags" in source,
         "uiFilterTags" & " is missing while decoding " & "TestLayerDef")
  target.uiFilterTags = jsonTo(source{"uiFilterTags"},
                               typeof(target.uiFilterTags))
  assert("guideGridWid" in source,
         "guideGridWid" & " is missing while decoding " & "TestLayerDef")
  target.guideGridWid = jsonTo(source{"guideGridWid"},
                               typeof(target.guideGridWid))
  assert("parallaxFactorX" in source,
         "parallaxFactorX" & " is missing while decoding " & "TestLayerDef")
  target.parallaxFactorX = jsonTo(source{"parallaxFactorX"},
                                  typeof(target.parallaxFactorX))
  assert("identifier" in source,
         "identifier" & " is missing while decoding " & "TestLayerDef")
  target.identifier = jsonTo(source{"identifier"}, typeof(target.identifier))
  assert("canSelectWhenInactive" in source, "canSelectWhenInactive" &
      " is missing while decoding " &
      "TestLayerDef")
  target.canSelectWhenInactive = jsonTo(source{"canSelectWhenInactive"},
                                        typeof(target.canSelectWhenInactive))
  assert("pxOffsetX" in source,
         "pxOffsetX" & " is missing while decoding " & "TestLayerDef")
  target.pxOffsetX = jsonTo(source{"pxOffsetX"}, typeof(target.pxOffsetX))
  assert("tilePivotY" in source,
         "tilePivotY" & " is missing while decoding " & "TestLayerDef")
  target.tilePivotY = jsonTo(source{"tilePivotY"}, typeof(target.tilePivotY))
  assert("excludedTags" in source,
         "excludedTags" & " is missing while decoding " & "TestLayerDef")
  target.excludedTags = jsonTo(source{"excludedTags"},
                               typeof(target.excludedTags))
  if "doc" in source and source{"doc"}.kind != JNull:
    target.doc = some(jsonTo(source{"doc"}, typeof(unsafeGet(target.doc))))
  assert("uid" in source, "uid" & " is missing while decoding " & "TestLayerDef")
  target.uid = jsonTo(source{"uid"}, typeof(target.uid))
  assert("guideGridHei" in source,
         "guideGridHei" & " is missing while decoding " & "TestLayerDef")
  target.guideGridHei = jsonTo(source{"guideGridHei"},
                               typeof(target.guideGridHei))
  if "autoSourceLayerDefUid" in source and
      source{"autoSourceLayerDefUid"}.kind != JNull:
    target.autoSourceLayerDefUid = some(jsonTo(
        source{"autoSourceLayerDefUid"},
        typeof(unsafeGet(target.autoSourceLayerDefUid))))
  assert("displayOpacity" in source,
         "displayOpacity" & " is missing while decoding " & "TestLayerDef")
  target.displayOpacity = jsonTo(source{"displayOpacity"},
                                 typeof(target.displayOpacity))
  assert("intGridValuesGroups" in source,
         "intGridValuesGroups" & " is missing while decoding " & "TestLayerDef")
  target.intGridValuesGroups = jsonTo(source{"intGridValuesGroups"},
                                      typeof(target.intGridValuesGroups))
  assert("hideFieldsWhenInactive" in source, "hideFieldsWhenInactive" &
      " is missing while decoding " &
      "TestLayerDef")
  target.hideFieldsWhenInactive = jsonTo(source{"hideFieldsWhenInactive"},
      typeof(target.hideFieldsWhenInactive))
  assert("useAsyncRender" in source,
         "useAsyncRender" & " is missing while decoding " & "TestLayerDef")
  target.useAsyncRender = jsonTo(source{"useAsyncRender"},
                                 typeof(target.useAsyncRender))
  assert("pxOffsetY" in source,
         "pxOffsetY" & " is missing while decoding " & "TestLayerDef")
  target.pxOffsetY = jsonTo(source{"pxOffsetY"}, typeof(target.pxOffsetY))
  assert("parallaxFactorY" in source,
         "parallaxFactorY" & " is missing while decoding " & "TestLayerDef")
  target.parallaxFactorY = jsonTo(source{"parallaxFactorY"},
                                  typeof(target.parallaxFactorY))
  assert("intGridValues" in source,
         "intGridValues" & " is missing while decoding " & "TestLayerDef")
  target.intGridValues = jsonTo(source{"intGridValues"},
                                typeof(target.intGridValues))
  assert("renderInWorldView" in source,
         "renderInWorldView" & " is missing while decoding " & "TestLayerDef")
  target.renderInWorldView = jsonTo(source{"renderInWorldView"},
                                    typeof(target.renderInWorldView))

proc toJsonHook*(source: TestLayerDef): JsonNode =
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
  result{"__type"} = toJson(source.type)
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

proc fromJsonHook*(target: var TestDefinitions; source: JsonNode) =
  assert("levelFields" in source,
         "levelFields" & " is missing while decoding " & "TestDefinitions")
  target.levelFields = jsonTo(source{"levelFields"}, typeof(target.levelFields))
  assert("tilesets" in source,
         "tilesets" & " is missing while decoding " & "TestDefinitions")
  target.tilesets = jsonTo(source{"tilesets"}, typeof(target.tilesets))
  assert("entities" in source,
         "entities" & " is missing while decoding " & "TestDefinitions")
  target.entities = jsonTo(source{"entities"}, typeof(target.entities))
  assert("enums" in source,
         "enums" & " is missing while decoding " & "TestDefinitions")
  target.enums = jsonTo(source{"enums"}, typeof(target.enums))
  assert("layers" in source,
         "layers" & " is missing while decoding " & "TestDefinitions")
  target.layers = jsonTo(source{"layers"}, typeof(target.layers))
  assert("externalEnums" in source,
         "externalEnums" & " is missing while decoding " & "TestDefinitions")
  target.externalEnums = jsonTo(source{"externalEnums"},
                                typeof(target.externalEnums))

proc toJsonHook*(source: TestDefinitions): JsonNode =
  result = newJObject()
  result{"levelFields"} = toJson(source.levelFields)
  result{"tilesets"} = toJson(source.tilesets)
  result{"entities"} = toJson(source.entities)
  result{"enums"} = toJson(source.enums)
  result{"layers"} = toJson(source.layers)
  result{"externalEnums"} = toJson(source.externalEnums)

proc fromJsonHook*(target: var TestGridPoint; source: JsonNode) =
  assert("cx" in source, "cx" & " is missing while decoding " & "TestGridPoint")
  target.cx = jsonTo(source{"cx"}, typeof(target.cx))
  assert("cy" in source, "cy" & " is missing while decoding " & "TestGridPoint")
  target.cy = jsonTo(source{"cy"}, typeof(target.cy))

proc toJsonHook*(source: TestGridPoint): JsonNode =
  result = newJObject()
  result{"cx"} = toJson(source.cx)
  result{"cy"} = toJson(source.cy)

proc fromJsonHook*(target: var TestTestLdtkJsonRoot_FORCED_REFS;
                   source: JsonNode) =
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

proc toJsonHook*(source: TestTestLdtkJsonRoot_FORCED_REFS): JsonNode =
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

proc toJsonHook*(source: TestTestLdtkJsonRoot_worldLayout): JsonNode =
  case source
  of TestTestLdtkJsonRoot_worldLayout.LinearHorizontal:
    return newJString("LinearHorizontal")
  of TestTestLdtkJsonRoot_worldLayout.LinearVertical:
    return newJString("LinearVertical")
  of TestTestLdtkJsonRoot_worldLayout.GridVania:
    return newJString("GridVania")
  of TestTestLdtkJsonRoot_worldLayout.Free:
    return newJString("Free")
  
proc fromJsonHook*(target: var TestTestLdtkJsonRoot_worldLayout;
                   source: JsonNode) =
  target = case getStr(source)
  of "LinearHorizontal":
    TestTestLdtkJsonRoot_worldLayout.LinearHorizontal
  of "LinearVertical":
    TestTestLdtkJsonRoot_worldLayout.LinearVertical
  of "GridVania":
    TestTestLdtkJsonRoot_worldLayout.GridVania
  of "Free":
    TestTestLdtkJsonRoot_worldLayout.Free
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc toJsonHook*(source: TestTestLdtkJsonRoot_flags): JsonNode =
  case source
  of TestTestLdtkJsonRoot_flags.ExportPreCsvIntGridFormat:
    return newJString("ExportPreCsvIntGridFormat")
  of TestTestLdtkJsonRoot_flags.DiscardPreCsvIntGrid:
    return newJString("DiscardPreCsvIntGrid")
  of TestTestLdtkJsonRoot_flags.ExportOldTableOfContentData:
    return newJString("ExportOldTableOfContentData")
  of TestTestLdtkJsonRoot_flags.PrependIndexToLevelFileNames:
    return newJString("PrependIndexToLevelFileNames")
  of TestTestLdtkJsonRoot_flags.MultiWorlds:
    return newJString("MultiWorlds")
  of TestTestLdtkJsonRoot_flags.UseMultilinesType:
    return newJString("UseMultilinesType")
  of TestTestLdtkJsonRoot_flags.IgnoreBackupSuggest:
    return newJString("IgnoreBackupSuggest")
  
proc fromJsonHook*(target: var TestTestLdtkJsonRoot_flags; source: JsonNode) =
  target = case getStr(source)
  of "ExportPreCsvIntGridFormat":
    TestTestLdtkJsonRoot_flags.ExportPreCsvIntGridFormat
  of "DiscardPreCsvIntGrid":
    TestTestLdtkJsonRoot_flags.DiscardPreCsvIntGrid
  of "ExportOldTableOfContentData":
    TestTestLdtkJsonRoot_flags.ExportOldTableOfContentData
  of "PrependIndexToLevelFileNames":
    TestTestLdtkJsonRoot_flags.PrependIndexToLevelFileNames
  of "MultiWorlds":
    TestTestLdtkJsonRoot_flags.MultiWorlds
  of "UseMultilinesType":
    TestTestLdtkJsonRoot_flags.UseMultilinesType
  of "IgnoreBackupSuggest":
    TestTestLdtkJsonRoot_flags.IgnoreBackupSuggest
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc toJsonHook*(source: TestTestLdtkJsonRoot_identifierStyle): JsonNode =
  case source
  of TestTestLdtkJsonRoot_identifierStyle.Lowercase:
    return newJString("Lowercase")
  of TestTestLdtkJsonRoot_identifierStyle.Free:
    return newJString("Free")
  of TestTestLdtkJsonRoot_identifierStyle.Capitalize:
    return newJString("Capitalize")
  of TestTestLdtkJsonRoot_identifierStyle.Uppercase:
    return newJString("Uppercase")
  
proc fromJsonHook*(target: var TestTestLdtkJsonRoot_identifierStyle;
                   source: JsonNode) =
  target = case getStr(source)
  of "Lowercase":
    TestTestLdtkJsonRoot_identifierStyle.Lowercase
  of "Free":
    TestTestLdtkJsonRoot_identifierStyle.Free
  of "Capitalize":
    TestTestLdtkJsonRoot_identifierStyle.Capitalize
  of "Uppercase":
    TestTestLdtkJsonRoot_identifierStyle.Uppercase
  else:
    raise newException(ValueError, "Unable to decode enum")
  
proc fromJsonHook*(target: var TestLdtkJsonRoot; source: JsonNode) =
  assert("backupLimit" in source,
         "backupLimit" & " is missing while decoding " & "TestLdtkJsonRoot")
  target.backupLimit = jsonTo(source{"backupLimit"}, typeof(target.backupLimit))
  assert("simplifiedExport" in source, "simplifiedExport" &
      " is missing while decoding " &
      "TestLdtkJsonRoot")
  target.simplifiedExport = jsonTo(source{"simplifiedExport"},
                                   typeof(target.simplifiedExport))
  assert("externalLevels" in source,
         "externalLevels" & " is missing while decoding " & "TestLdtkJsonRoot")
  target.externalLevels = jsonTo(source{"externalLevels"},
                                 typeof(target.externalLevels))
  if "backupRelPath" in source and source{"backupRelPath"}.kind != JNull:
    target.backupRelPath = some(jsonTo(source{"backupRelPath"},
                                       typeof(unsafeGet(target.backupRelPath))))
  assert("jsonVersion" in source,
         "jsonVersion" & " is missing while decoding " & "TestLdtkJsonRoot")
  target.jsonVersion = jsonTo(source{"jsonVersion"}, typeof(target.jsonVersion))
  assert("bgColor" in source,
         "bgColor" & " is missing while decoding " & "TestLdtkJsonRoot")
  target.bgColor = jsonTo(source{"bgColor"}, typeof(target.bgColor))
  assert("appBuildId" in source,
         "appBuildId" & " is missing while decoding " & "TestLdtkJsonRoot")
  target.appBuildId = jsonTo(source{"appBuildId"}, typeof(target.appBuildId))
  assert("defaultEntityHeight" in source, "defaultEntityHeight" &
      " is missing while decoding " &
      "TestLdtkJsonRoot")
  target.defaultEntityHeight = jsonTo(source{"defaultEntityHeight"},
                                      typeof(target.defaultEntityHeight))
  if "pngFilePattern" in source and source{"pngFilePattern"}.kind != JNull:
    target.pngFilePattern = some(jsonTo(source{"pngFilePattern"}, typeof(
        unsafeGet(target.pngFilePattern))))
  assert("customCommands" in source,
         "customCommands" & " is missing while decoding " & "TestLdtkJsonRoot")
  target.customCommands = jsonTo(source{"customCommands"},
                                 typeof(target.customCommands))
  assert("exportTiled" in source,
         "exportTiled" & " is missing while decoding " & "TestLdtkJsonRoot")
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
         "toc" & " is missing while decoding " & "TestLdtkJsonRoot")
  target.toc = jsonTo(source{"toc"}, typeof(target.toc))
  assert("worlds" in source,
         "worlds" & " is missing while decoding " & "TestLdtkJsonRoot")
  target.worlds = jsonTo(source{"worlds"}, typeof(target.worlds))
  assert("imageExportMode" in source,
         "imageExportMode" & " is missing while decoding " & "TestLdtkJsonRoot")
  target.imageExportMode = jsonTo(source{"imageExportMode"},
                                  typeof(target.imageExportMode))
  assert("dummyWorldIid" in source,
         "dummyWorldIid" & " is missing while decoding " & "TestLdtkJsonRoot")
  target.dummyWorldIid = jsonTo(source{"dummyWorldIid"},
                                typeof(target.dummyWorldIid))
  if "__FORCED_REFS" in source and source{"__FORCED_REFS"}.kind != JNull:
    target.FORCED_REFS = some(jsonTo(source{"__FORCED_REFS"},
                                     typeof(unsafeGet(target.FORCED_REFS))))
  assert("defaultPivotY" in source,
         "defaultPivotY" & " is missing while decoding " & "TestLdtkJsonRoot")
  target.defaultPivotY = jsonTo(source{"defaultPivotY"},
                                typeof(target.defaultPivotY))
  assert("exportLevelBg" in source,
         "exportLevelBg" & " is missing while decoding " & "TestLdtkJsonRoot")
  target.exportLevelBg = jsonTo(source{"exportLevelBg"},
                                typeof(target.exportLevelBg))
  assert("nextUid" in source,
         "nextUid" & " is missing while decoding " & "TestLdtkJsonRoot")
  target.nextUid = jsonTo(source{"nextUid"}, typeof(target.nextUid))
  assert("levelNamePattern" in source, "levelNamePattern" &
      " is missing while decoding " &
      "TestLdtkJsonRoot")
  target.levelNamePattern = jsonTo(source{"levelNamePattern"},
                                   typeof(target.levelNamePattern))
  assert("defs" in source,
         "defs" & " is missing while decoding " & "TestLdtkJsonRoot")
  target.defs = jsonTo(source{"defs"}, typeof(target.defs))
  assert("defaultPivotX" in source,
         "defaultPivotX" & " is missing while decoding " & "TestLdtkJsonRoot")
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
      "TestLdtkJsonRoot")
  target.defaultEntityWidth = jsonTo(source{"defaultEntityWidth"},
                                     typeof(target.defaultEntityWidth))
  assert("iid" in source,
         "iid" & " is missing while decoding " & "TestLdtkJsonRoot")
  target.iid = jsonTo(source{"iid"}, typeof(target.iid))
  assert("defaultGridSize" in source,
         "defaultGridSize" & " is missing while decoding " & "TestLdtkJsonRoot")
  target.defaultGridSize = jsonTo(source{"defaultGridSize"},
                                  typeof(target.defaultGridSize))
  if "defaultLevelWidth" in source and
      source{"defaultLevelWidth"}.kind != JNull:
    target.defaultLevelWidth = some(jsonTo(source{"defaultLevelWidth"},
        typeof(unsafeGet(target.defaultLevelWidth))))
  assert("minifyJson" in source,
         "minifyJson" & " is missing while decoding " & "TestLdtkJsonRoot")
  target.minifyJson = jsonTo(source{"minifyJson"}, typeof(target.minifyJson))
  assert("backupOnSave" in source,
         "backupOnSave" & " is missing while decoding " & "TestLdtkJsonRoot")
  target.backupOnSave = jsonTo(source{"backupOnSave"},
                               typeof(target.backupOnSave))
  assert("flags" in source,
         "flags" & " is missing while decoding " & "TestLdtkJsonRoot")
  target.flags = jsonTo(source{"flags"}, typeof(target.flags))
  assert("defaultLevelBgColor" in source, "defaultLevelBgColor" &
      " is missing while decoding " &
      "TestLdtkJsonRoot")
  target.defaultLevelBgColor = jsonTo(source{"defaultLevelBgColor"},
                                      typeof(target.defaultLevelBgColor))
  assert("identifierStyle" in source,
         "identifierStyle" & " is missing while decoding " & "TestLdtkJsonRoot")
  target.identifierStyle = jsonTo(source{"identifierStyle"},
                                  typeof(target.identifierStyle))
  if "worldGridHeight" in source and source{"worldGridHeight"}.kind != JNull:
    target.worldGridHeight = some(jsonTo(source{"worldGridHeight"},
        typeof(unsafeGet(target.worldGridHeight))))
  assert("levels" in source,
         "levels" & " is missing while decoding " & "TestLdtkJsonRoot")
  target.levels = jsonTo(source{"levels"}, typeof(target.levels))

proc toJsonHook*(source: TestLdtkJsonRoot): JsonNode =
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
