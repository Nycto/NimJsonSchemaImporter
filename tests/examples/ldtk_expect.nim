type
  backupRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  pngFilePattern* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  when* = enum
    AfterLoad, BeforeSave, AfterSave, Manual
  customCommands* = object
    command*: string
    when*: when
  exportPng* = object
    case kind: range[0 .. 1]
    of 0:
      key0: bool
    of 1:
      key1: pointer
  worldGridWidth* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  defaultLevelHeight* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  iids* = object
    layerIid*: string
    levelIid*: string
    entityIid*: string
    worldIid*: string
  instancesData* = object
    worldY*: BiggestInt
    fields*: JsonNode
    widPx*: BiggestInt
    iids*: iids
    heiPx*: BiggestInt
    worldX*: BiggestInt
  instances* = object
    layerIid*: string
    levelIid*: string
    entityIid*: string
    worldIid*: string
  toc* = object
    instancesData*: seq[instancesData]
    identifier*: string
    instances*: seq[instances]
  worldLayout* = enum
    LinearHorizontal, LinearVertical, , GridVania, Free
  bgColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  externalRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  bgRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  levelUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  __neighbours* = object
    levelUid*: levelUid
    levelIid*: string
    dir*: string
  bgPos* = enum
    CoverDirty, Repeat, , Contain, Cover, Unscaled
  gridTiles* = object
    px*: seq[BiggestInt]
    t*: BiggestInt
    d*: seq[BiggestInt]
    a*: BiggestFloat
    src*: seq[BiggestInt]
    f*: BiggestInt
  overrideTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  intGrid* = object
    coordId*: BiggestInt
    v*: BiggestInt
  autoLayerTiles* = object
    px*: seq[BiggestInt]
    t*: BiggestInt
    d*: seq[BiggestInt]
    a*: BiggestFloat
    src*: seq[BiggestInt]
    f*: BiggestInt
  __worldY* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  __tile1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  __tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: __tile1
  __tile1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  __tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: __tile1
  fieldInstances* = object
    realEditorValues*: seq[JsonNode]
    __value*: JsonNode
    __tile*: __tile
    __type*: string
    __identifier*: string
    defUid*: BiggestInt
  __worldX* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  entityInstances* = object
    __worldY*: __worldY
    __tile*: __tile
    __identifier*: string
    __tags*: seq[string]
    height*: BiggestInt
    px*: seq[BiggestInt]
    defUid*: BiggestInt
    __pivot*: seq[BiggestFloat]
    fieldInstances*: seq[fieldInstances]
    iid*: string
    width*: BiggestInt
    __worldX*: __worldX
    __grid*: seq[BiggestInt]
    __smartColor*: string
  __tilesetRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  __tilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  layerInstances* = object
    __opacity*: BiggestFloat
    optionalRules*: seq[BiggestInt]
    __gridSize*: BiggestInt
    __pxTotalOffsetX*: BiggestInt
    gridTiles*: seq[gridTiles]
    __type*: string
    __identifier*: string
    overrideTilesetUid*: overrideTilesetUid
    levelId*: BiggestInt
    intGrid*: seq[intGrid]
    autoLayerTiles*: seq[autoLayerTiles]
    layerDefUid*: BiggestInt
    entityInstances*: seq[entityInstances]
    intGridCsv*: seq[BiggestInt]
    pxOffsetX*: BiggestInt
    __tilesetRelPath*: __tilesetRelPath
    __tilesetDefUid*: __tilesetDefUid
    __cHei*: BiggestInt
    seed*: BiggestInt
    visible*: bool
    pxOffsetY*: BiggestInt
    iid*: string
    __pxTotalOffsetY*: BiggestInt
    __cWid*: BiggestInt
  __tile1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  __tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: __tile1
  fieldInstances* = object
    realEditorValues*: seq[JsonNode]
    __value*: JsonNode
    __tile*: __tile
    __type*: string
    __identifier*: string
    defUid*: BiggestInt
  __bgPos1* = object
    scale*: seq[BiggestFloat]
    cropRect*: seq[BiggestFloat]
    topLeftPx*: seq[BiggestInt]
  __bgPos* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: __bgPos1
  levels* = object
    pxHei*: BiggestInt
    useAutoIdentifier*: bool
    __bgColor*: string
    bgColor*: bgColor
    externalRelPath*: externalRelPath
    worldY*: BiggestInt
    bgRelPath*: bgRelPath
    identifier*: string
    pxWid*: BiggestInt
    worldDepth*: BiggestInt
    bgPivotX*: BiggestFloat
    __neighbours*: seq[__neighbours]
    uid*: BiggestInt
    bgPos*: bgPos
    layerInstances*: seq[layerInstances]
    fieldInstances*: seq[fieldInstances]
    __bgPos*: __bgPos
    worldX*: BiggestInt
    iid*: string
    bgPivotY*: BiggestFloat
    __smartColor*: string
  worlds* = object
    worldGridWidth*: BiggestInt
    defaultLevelHeight*: BiggestInt
    identifier*: string
    worldLayout*: worldLayout
    iid*: string
    defaultLevelWidth*: BiggestInt
    worldGridHeight*: BiggestInt
    levels*: seq[levels]
  imageExportMode* = enum
    LayersAndLevels, OneImagePerLayer, None, OneImagePerLevel
  when* = enum
    AfterLoad, BeforeSave, AfterSave, Manual
  CustomCommand* = object
    command*: string
    when*: when
  tile1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: tile1
  identifier* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  IntGridValueDef* = object
    tile*: tile
    color*: string
    identifier*: identifier
    groupUid*: BiggestInt
    value*: BiggestInt
  bgColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  externalRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  bgRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  levelUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  __neighbours* = object
    levelUid*: levelUid
    levelIid*: string
    dir*: string
  bgPos* = enum
    CoverDirty, Repeat, , Contain, Cover, Unscaled
  gridTiles* = object
    px*: seq[BiggestInt]
    t*: BiggestInt
    d*: seq[BiggestInt]
    a*: BiggestFloat
    src*: seq[BiggestInt]
    f*: BiggestInt
  overrideTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  intGrid* = object
    coordId*: BiggestInt
    v*: BiggestInt
  autoLayerTiles* = object
    px*: seq[BiggestInt]
    t*: BiggestInt
    d*: seq[BiggestInt]
    a*: BiggestFloat
    src*: seq[BiggestInt]
    f*: BiggestInt
  __worldY* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  __tile1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  __tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: __tile1
  __tile1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  __tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: __tile1
  fieldInstances* = object
    realEditorValues*: seq[JsonNode]
    __value*: JsonNode
    __tile*: __tile
    __type*: string
    __identifier*: string
    defUid*: BiggestInt
  __worldX* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  entityInstances* = object
    __worldY*: __worldY
    __tile*: __tile
    __identifier*: string
    __tags*: seq[string]
    height*: BiggestInt
    px*: seq[BiggestInt]
    defUid*: BiggestInt
    __pivot*: seq[BiggestFloat]
    fieldInstances*: seq[fieldInstances]
    iid*: string
    width*: BiggestInt
    __worldX*: __worldX
    __grid*: seq[BiggestInt]
    __smartColor*: string
  __tilesetRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  __tilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  layerInstances* = object
    __opacity*: BiggestFloat
    optionalRules*: seq[BiggestInt]
    __gridSize*: BiggestInt
    __pxTotalOffsetX*: BiggestInt
    gridTiles*: seq[gridTiles]
    __type*: string
    __identifier*: string
    overrideTilesetUid*: overrideTilesetUid
    levelId*: BiggestInt
    intGrid*: seq[intGrid]
    autoLayerTiles*: seq[autoLayerTiles]
    layerDefUid*: BiggestInt
    entityInstances*: seq[entityInstances]
    intGridCsv*: seq[BiggestInt]
    pxOffsetX*: BiggestInt
    __tilesetRelPath*: __tilesetRelPath
    __tilesetDefUid*: __tilesetDefUid
    __cHei*: BiggestInt
    seed*: BiggestInt
    visible*: bool
    pxOffsetY*: BiggestInt
    iid*: string
    __pxTotalOffsetY*: BiggestInt
    __cWid*: BiggestInt
  __tile1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  __tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: __tile1
  fieldInstances* = object
    realEditorValues*: seq[JsonNode]
    __value*: JsonNode
    __tile*: __tile
    __type*: string
    __identifier*: string
    defUid*: BiggestInt
  __bgPos1* = object
    scale*: seq[BiggestFloat]
    cropRect*: seq[BiggestFloat]
    topLeftPx*: seq[BiggestInt]
  __bgPos* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: __bgPos1
  Level* = object
    pxHei*: BiggestInt
    useAutoIdentifier*: bool
    __bgColor*: string
    bgColor*: bgColor
    externalRelPath*: externalRelPath
    worldY*: BiggestInt
    bgRelPath*: bgRelPath
    identifier*: string
    pxWid*: BiggestInt
    worldDepth*: BiggestInt
    bgPivotX*: BiggestFloat
    __neighbours*: seq[__neighbours]
    uid*: BiggestInt
    bgPos*: bgPos
    layerInstances*: seq[layerInstances]
    fieldInstances*: seq[fieldInstances]
    __bgPos*: __bgPos
    worldX*: BiggestInt
    iid*: string
    bgPivotY*: BiggestFloat
    __smartColor*: string
  allowedRefsEntityUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  textLanguageMode* = enum
    LangMarkdown, LangPython, LangLog, LangC, LangLua, LangHaxe, LangJS,
    LangRuby, , LangJson, LangXml
  editorDisplayPos* = enum
    Beneath, Above, Center
  editorDisplayMode* = enum
    PointPath, PointStar, ValueOnly, Hidden, Points, NameAndValue,
    ArrayCountNoLabel, EntityTile, PointPathLoop, RadiusPx, LevelTile,
    RadiusGrid, RefLinkBetweenCenters, RefLinkBetweenPivots, ArrayCountWithLabel
  regex* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  editorLinkStyle* = enum
    DashedLine, CurvedArrow, ArrowsLine, ZigZag, StraightArrow
  allowedRefs* = enum
    Any, OnlyTags, OnlySame, OnlySpecificEntity
  editorTextSuffix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  doc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  editorTextPrefix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  editorDisplayColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  tilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  arrayMaxLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  arrayMinLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  min* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  max* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  levelFields* = object
    type*: string
    editorDisplayScale*: BiggestFloat
    __type*: string
    allowedRefsEntityUid*: allowedRefsEntityUid
    textLanguageMode*: textLanguageMode
    editorAlwaysShow*: bool
    defaultOverride*: JsonNode
    autoChainRef*: bool
    editorDisplayPos*: editorDisplayPos
    editorDisplayMode*: editorDisplayMode
    identifier*: string
    regex*: regex
    isArray*: bool
    editorLinkStyle*: editorLinkStyle
    allowedRefs*: allowedRefs
    useForSmartColor*: bool
    editorTextSuffix*: editorTextSuffix
    doc*: doc
    editorTextPrefix*: editorTextPrefix
    editorCutLongValues*: bool
    canBeNull*: bool
    allowedRefTags*: seq[string]
    uid*: BiggestInt
    symmetricalRef*: bool
    editorDisplayColor*: editorDisplayColor
    allowOutOfLevelRef*: bool
    acceptFileTypes*: seq[string]
    editorShowInWorld*: bool
    tilesetUid*: tilesetUid
    arrayMaxLength*: arrayMaxLength
    arrayMinLength*: arrayMinLength
    searchable*: bool
    min*: min
    exportToToc*: bool
    max*: max
  tagsSourceEnumUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  embedAtlas* = enum
    LdtkIcons, 
  cachedPixelData* = object
    case kind: range[0 .. 1]
    of 0:
      key0: Table[string, JsonNode]
    of 1:
      key1: pointer
  enumTags* = object
    tileIds*: seq[BiggestInt]
    enumValueId*: string
  customData* = object
    data*: string
    tileId*: BiggestInt
  relPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  tilesets* = object
    pxHei*: BiggestInt
    savedSelections*: seq[Table[string, JsonNode]]
    padding*: BiggestInt
    spacing*: BiggestInt
    tagsSourceEnumUid*: tagsSourceEnumUid
    embedAtlas*: embedAtlas
    identifier*: string
    cachedPixelData*: cachedPixelData
    enumTags*: seq[enumTags]
    pxWid*: BiggestInt
    tileGridSize*: BiggestInt
    customData*: seq[customData]
    uid*: BiggestInt
    __cHei*: BiggestInt
    __cWid*: BiggestInt
    relPath*: relPath
    tags*: seq[string]
  limitScope* = enum
    PerLayer, PerWorld, PerLevel
  limitBehavior* = enum
    PreventAdding, MoveLastOne, DiscardOldOnes
  renderMode* = enum
    Tile, Cross, Ellipse, Rectangle
  tilesetId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  minWidth* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  tileId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  doc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  allowedRefsEntityUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  textLanguageMode* = enum
    LangMarkdown, LangPython, LangLog, LangC, LangLua, LangHaxe, LangJS,
    LangRuby, , LangJson, LangXml
  editorDisplayPos* = enum
    Beneath, Above, Center
  editorDisplayMode* = enum
    PointPath, PointStar, ValueOnly, Hidden, Points, NameAndValue,
    ArrayCountNoLabel, EntityTile, PointPathLoop, RadiusPx, LevelTile,
    RadiusGrid, RefLinkBetweenCenters, RefLinkBetweenPivots, ArrayCountWithLabel
  regex* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  editorLinkStyle* = enum
    DashedLine, CurvedArrow, ArrowsLine, ZigZag, StraightArrow
  allowedRefs* = enum
    Any, OnlyTags, OnlySame, OnlySpecificEntity
  editorTextSuffix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  doc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  editorTextPrefix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  editorDisplayColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  tilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  arrayMaxLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  arrayMinLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  min* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  max* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  fieldDefs* = object
    type*: string
    editorDisplayScale*: BiggestFloat
    __type*: string
    allowedRefsEntityUid*: allowedRefsEntityUid
    textLanguageMode*: textLanguageMode
    editorAlwaysShow*: bool
    defaultOverride*: JsonNode
    autoChainRef*: bool
    editorDisplayPos*: editorDisplayPos
    editorDisplayMode*: editorDisplayMode
    identifier*: string
    regex*: regex
    isArray*: bool
    editorLinkStyle*: editorLinkStyle
    allowedRefs*: allowedRefs
    useForSmartColor*: bool
    editorTextSuffix*: editorTextSuffix
    doc*: doc
    editorTextPrefix*: editorTextPrefix
    editorCutLongValues*: bool
    canBeNull*: bool
    allowedRefTags*: seq[string]
    uid*: BiggestInt
    symmetricalRef*: bool
    editorDisplayColor*: editorDisplayColor
    allowOutOfLevelRef*: bool
    acceptFileTypes*: seq[string]
    editorShowInWorld*: bool
    tilesetUid*: tilesetUid
    arrayMaxLength*: arrayMaxLength
    arrayMinLength*: arrayMinLength
    searchable*: bool
    min*: min
    exportToToc*: bool
    max*: max
  tileRenderMode* = enum
    FullSizeCropped, FullSizeUncropped, Repeat, FitInside, NineSlice, Cover,
    Stretch
  uiTileRect1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  uiTileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: uiTileRect1
  minHeight* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  tileRect1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  tileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: tileRect1
  maxWidth* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  maxHeight* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  entities* = object
    allowOutOfBounds*: bool
    pivotY*: BiggestFloat
    tileOpacity*: BiggestFloat
    color*: string
    limitScope*: limitScope
    limitBehavior*: limitBehavior
    hollow*: bool
    height*: BiggestInt
    renderMode*: renderMode
    tilesetId*: tilesetId
    keepAspectRatio*: bool
    minWidth*: minWidth
    showName*: bool
    resizableX*: bool
    identifier*: string
    maxCount*: BiggestInt
    tileId*: tileId
    pivotX*: BiggestFloat
    doc*: doc
    fieldDefs*: seq[fieldDefs]
    uid*: BiggestInt
    tileRenderMode*: tileRenderMode
    uiTileRect*: uiTileRect
    resizableY*: bool
    lineOpacity*: BiggestFloat
    minHeight*: minHeight
    tileRect*: tileRect
    nineSliceBorders*: seq[BiggestInt]
    maxWidth*: maxWidth
    width*: BiggestInt
    tags*: seq[string]
    maxHeight*: maxHeight
    exportToToc*: bool
    fillOpacity*: BiggestFloat
  tileId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  tileRect1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  tileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: tileRect1
  values* = object
    __tileSrcRect*: seq[BiggestInt]
    color*: BiggestInt
    id*: string
    tileId*: tileId
    tileRect*: tileRect
  externalRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  externalFileChecksum* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  iconTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  enums* = object
    values*: seq[values]
    externalRelPath*: externalRelPath
    identifier*: string
    externalFileChecksum*: externalFileChecksum
    iconTilesetUid*: iconTilesetUid
    uid*: BiggestInt
    tags*: seq[string]
  type* = enum
    Tiles, Entities, AutoLayer, IntGrid
  autoTilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  biomeFieldUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  autoTilesKilledByOtherLayerUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  color* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  collapsed* = object
    case kind: range[0 .. 1]
    of 0:
      key0: bool
    of 1:
      key1: pointer
  checker* = enum
    Horizontal, Vertical, None
  tileMode* = enum
    Single, Stamp
  outOfBoundsValue* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  rules* = object
    checker*: checker
    pivotY*: BiggestFloat
    breakOnMatch*: bool
    perlinOctaves*: BiggestFloat
    yModulo*: BiggestInt
    size*: BiggestInt
    tileMode*: tileMode
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
    outOfBoundsValue*: outOfBoundsValue
    pivotX*: BiggestFloat
    flipY*: bool
    active*: bool
    uid*: BiggestInt
    tileIds*: seq[BiggestInt]
    invalidated*: bool
    pattern*: seq[BiggestInt]
    alpha*: BiggestFloat
    tileRectsIds*: seq[seq[BiggestInt]]
    tileXOffset*: BiggestInt
    xOffset*: BiggestInt
    tileRandomYMin*: BiggestInt
    perlinSeed*: BiggestFloat
  icon1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  icon* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: icon1
  autoRuleGroups* = object
    isOptional*: bool
    color*: color
    collapsed*: collapsed
    usesWizard*: bool
    biomeRequirementMode*: BiggestInt
    rules*: seq[rules]
    icon*: icon
    active*: bool
    uid*: BiggestInt
    name*: string
    requiredBiomeValues*: seq[string]
  tilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  uiColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  doc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  autoSourceLayerDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  color* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  identifier* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  intGridValuesGroups* = object
    color*: color
    identifier*: identifier
    uid*: BiggestInt
  tile1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: tile1
  identifier* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  intGridValues* = object
    tile*: tile
    color*: string
    identifier*: identifier
    groupUid*: BiggestInt
    value*: BiggestInt
  layers* = object
    type*: type
    autoTilesetDefUid*: autoTilesetDefUid
    parallaxScaling*: bool
    biomeFieldUid*: biomeFieldUid
    autoTilesKilledByOtherLayerUid*: autoTilesKilledByOtherLayerUid
    inactiveOpacity*: BiggestFloat
    __type*: string
    autoRuleGroups*: seq[autoRuleGroups]
    gridSize*: BiggestInt
    hideInList*: bool
    tilesetDefUid*: tilesetDefUid
    uiColor*: uiColor
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
    doc*: doc
    uid*: BiggestInt
    guideGridHei*: BiggestInt
    autoSourceLayerDefUid*: autoSourceLayerDefUid
    displayOpacity*: BiggestFloat
    intGridValuesGroups*: seq[intGridValuesGroups]
    hideFieldsWhenInactive*: bool
    useAsyncRender*: bool
    pxOffsetY*: BiggestInt
    parallaxFactorY*: BiggestFloat
    intGridValues*: seq[intGridValues]
    renderInWorldView*: bool
  tileId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  tileRect1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  tileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: tileRect1
  values* = object
    __tileSrcRect*: seq[BiggestInt]
    color*: BiggestInt
    id*: string
    tileId*: tileId
    tileRect*: tileRect
  externalRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  externalFileChecksum* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  iconTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  externalEnums* = object
    values*: seq[values]
    externalRelPath*: externalRelPath
    identifier*: string
    externalFileChecksum*: externalFileChecksum
    iconTilesetUid*: iconTilesetUid
    uid*: BiggestInt
    tags*: seq[string]
  Definitions* = object
    levelFields*: seq[levelFields]
    tilesets*: seq[tilesets]
    entities*: seq[entities]
    enums*: seq[enums]
    layers*: seq[layers]
    externalEnums*: seq[externalEnums]
  tileId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  tileRect1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  tileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: tileRect1
  values* = object
    __tileSrcRect*: seq[BiggestInt]
    color*: BiggestInt
    id*: string
    tileId*: tileId
    tileRect*: tileRect
  externalRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  externalFileChecksum* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  iconTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  EnumDef* = object
    values*: seq[values]
    externalRelPath*: externalRelPath
    identifier*: string
    externalFileChecksum*: externalFileChecksum
    iconTilesetUid*: iconTilesetUid
    uid*: BiggestInt
    tags*: seq[string]
  allowedRefsEntityUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  textLanguageMode* = enum
    LangMarkdown, LangPython, LangLog, LangC, LangLua, LangHaxe, LangJS,
    LangRuby, , LangJson, LangXml
  editorDisplayPos* = enum
    Beneath, Above, Center
  editorDisplayMode* = enum
    PointPath, PointStar, ValueOnly, Hidden, Points, NameAndValue,
    ArrayCountNoLabel, EntityTile, PointPathLoop, RadiusPx, LevelTile,
    RadiusGrid, RefLinkBetweenCenters, RefLinkBetweenPivots, ArrayCountWithLabel
  regex* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  editorLinkStyle* = enum
    DashedLine, CurvedArrow, ArrowsLine, ZigZag, StraightArrow
  allowedRefs* = enum
    Any, OnlyTags, OnlySame, OnlySpecificEntity
  editorTextSuffix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  doc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  editorTextPrefix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  editorDisplayColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  tilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  arrayMaxLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  arrayMinLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  min* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  max* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  FieldDef* = object
    type*: string
    editorDisplayScale*: BiggestFloat
    __type*: string
    allowedRefsEntityUid*: allowedRefsEntityUid
    textLanguageMode*: textLanguageMode
    editorAlwaysShow*: bool
    defaultOverride*: JsonNode
    autoChainRef*: bool
    editorDisplayPos*: editorDisplayPos
    editorDisplayMode*: editorDisplayMode
    identifier*: string
    regex*: regex
    isArray*: bool
    editorLinkStyle*: editorLinkStyle
    allowedRefs*: allowedRefs
    useForSmartColor*: bool
    editorTextSuffix*: editorTextSuffix
    doc*: doc
    editorTextPrefix*: editorTextPrefix
    editorCutLongValues*: bool
    canBeNull*: bool
    allowedRefTags*: seq[string]
    uid*: BiggestInt
    symmetricalRef*: bool
    editorDisplayColor*: editorDisplayColor
    allowOutOfLevelRef*: bool
    acceptFileTypes*: seq[string]
    editorShowInWorld*: bool
    tilesetUid*: tilesetUid
    arrayMaxLength*: arrayMaxLength
    arrayMinLength*: arrayMinLength
    searchable*: bool
    min*: min
    exportToToc*: bool
    max*: max
  color* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  collapsed* = object
    case kind: range[0 .. 1]
    of 0:
      key0: bool
    of 1:
      key1: pointer
  checker* = enum
    Horizontal, Vertical, None
  tileMode* = enum
    Single, Stamp
  outOfBoundsValue* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  rules* = object
    checker*: checker
    pivotY*: BiggestFloat
    breakOnMatch*: bool
    perlinOctaves*: BiggestFloat
    yModulo*: BiggestInt
    size*: BiggestInt
    tileMode*: tileMode
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
    outOfBoundsValue*: outOfBoundsValue
    pivotX*: BiggestFloat
    flipY*: bool
    active*: bool
    uid*: BiggestInt
    tileIds*: seq[BiggestInt]
    invalidated*: bool
    pattern*: seq[BiggestInt]
    alpha*: BiggestFloat
    tileRectsIds*: seq[seq[BiggestInt]]
    tileXOffset*: BiggestInt
    xOffset*: BiggestInt
    tileRandomYMin*: BiggestInt
    perlinSeed*: BiggestFloat
  icon1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  icon* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: icon1
  AutoLayerRuleGroup* = object
    isOptional*: bool
    color*: color
    collapsed*: collapsed
    usesWizard*: bool
    biomeRequirementMode*: BiggestInt
    rules*: seq[rules]
    icon*: icon
    active*: bool
    uid*: BiggestInt
    name*: string
    requiredBiomeValues*: seq[string]
  tagsSourceEnumUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  embedAtlas* = enum
    LdtkIcons, 
  cachedPixelData* = object
    case kind: range[0 .. 1]
    of 0:
      key0: Table[string, JsonNode]
    of 1:
      key1: pointer
  enumTags* = object
    tileIds*: seq[BiggestInt]
    enumValueId*: string
  customData* = object
    data*: string
    tileId*: BiggestInt
  relPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  TilesetDef* = object
    pxHei*: BiggestInt
    savedSelections*: seq[Table[string, JsonNode]]
    padding*: BiggestInt
    spacing*: BiggestInt
    tagsSourceEnumUid*: tagsSourceEnumUid
    embedAtlas*: embedAtlas
    identifier*: string
    cachedPixelData*: cachedPixelData
    enumTags*: seq[enumTags]
    pxWid*: BiggestInt
    tileGridSize*: BiggestInt
    customData*: seq[customData]
    uid*: BiggestInt
    __cHei*: BiggestInt
    __cWid*: BiggestInt
    relPath*: relPath
    tags*: seq[string]
  iids* = object
    layerIid*: string
    levelIid*: string
    entityIid*: string
    worldIid*: string
  instancesData* = object
    worldY*: BiggestInt
    fields*: JsonNode
    widPx*: BiggestInt
    iids*: iids
    heiPx*: BiggestInt
    worldX*: BiggestInt
  instances* = object
    layerIid*: string
    levelIid*: string
    entityIid*: string
    worldIid*: string
  TableOfContentEntry* = object
    instancesData*: seq[instancesData]
    identifier*: string
    instances*: seq[instances]
  limitScope* = enum
    PerLayer, PerWorld, PerLevel
  limitBehavior* = enum
    PreventAdding, MoveLastOne, DiscardOldOnes
  renderMode* = enum
    Tile, Cross, Ellipse, Rectangle
  tilesetId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  minWidth* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  tileId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  doc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  allowedRefsEntityUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  textLanguageMode* = enum
    LangMarkdown, LangPython, LangLog, LangC, LangLua, LangHaxe, LangJS,
    LangRuby, , LangJson, LangXml
  editorDisplayPos* = enum
    Beneath, Above, Center
  editorDisplayMode* = enum
    PointPath, PointStar, ValueOnly, Hidden, Points, NameAndValue,
    ArrayCountNoLabel, EntityTile, PointPathLoop, RadiusPx, LevelTile,
    RadiusGrid, RefLinkBetweenCenters, RefLinkBetweenPivots, ArrayCountWithLabel
  regex* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  editorLinkStyle* = enum
    DashedLine, CurvedArrow, ArrowsLine, ZigZag, StraightArrow
  allowedRefs* = enum
    Any, OnlyTags, OnlySame, OnlySpecificEntity
  editorTextSuffix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  doc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  editorTextPrefix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  editorDisplayColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  tilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  arrayMaxLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  arrayMinLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  min* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  max* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  fieldDefs* = object
    type*: string
    editorDisplayScale*: BiggestFloat
    __type*: string
    allowedRefsEntityUid*: allowedRefsEntityUid
    textLanguageMode*: textLanguageMode
    editorAlwaysShow*: bool
    defaultOverride*: JsonNode
    autoChainRef*: bool
    editorDisplayPos*: editorDisplayPos
    editorDisplayMode*: editorDisplayMode
    identifier*: string
    regex*: regex
    isArray*: bool
    editorLinkStyle*: editorLinkStyle
    allowedRefs*: allowedRefs
    useForSmartColor*: bool
    editorTextSuffix*: editorTextSuffix
    doc*: doc
    editorTextPrefix*: editorTextPrefix
    editorCutLongValues*: bool
    canBeNull*: bool
    allowedRefTags*: seq[string]
    uid*: BiggestInt
    symmetricalRef*: bool
    editorDisplayColor*: editorDisplayColor
    allowOutOfLevelRef*: bool
    acceptFileTypes*: seq[string]
    editorShowInWorld*: bool
    tilesetUid*: tilesetUid
    arrayMaxLength*: arrayMaxLength
    arrayMinLength*: arrayMinLength
    searchable*: bool
    min*: min
    exportToToc*: bool
    max*: max
  tileRenderMode* = enum
    FullSizeCropped, FullSizeUncropped, Repeat, FitInside, NineSlice, Cover,
    Stretch
  uiTileRect1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  uiTileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: uiTileRect1
  minHeight* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  tileRect1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  tileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: tileRect1
  maxWidth* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  maxHeight* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  EntityDef* = object
    allowOutOfBounds*: bool
    pivotY*: BiggestFloat
    tileOpacity*: BiggestFloat
    color*: string
    limitScope*: limitScope
    limitBehavior*: limitBehavior
    hollow*: bool
    height*: BiggestInt
    renderMode*: renderMode
    tilesetId*: tilesetId
    keepAspectRatio*: bool
    minWidth*: minWidth
    showName*: bool
    resizableX*: bool
    identifier*: string
    maxCount*: BiggestInt
    tileId*: tileId
    pivotX*: BiggestFloat
    doc*: doc
    fieldDefs*: seq[fieldDefs]
    uid*: BiggestInt
    tileRenderMode*: tileRenderMode
    uiTileRect*: uiTileRect
    resizableY*: bool
    lineOpacity*: BiggestFloat
    minHeight*: minHeight
    tileRect*: tileRect
    nineSliceBorders*: seq[BiggestInt]
    maxWidth*: maxWidth
    width*: BiggestInt
    tags*: seq[string]
    maxHeight*: maxHeight
    exportToToc*: bool
    fillOpacity*: BiggestFloat
  __tile1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  __tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: __tile1
  FieldInstance* = object
    realEditorValues*: seq[JsonNode]
    __value*: JsonNode
    __tile*: __tile
    __type*: string
    __identifier*: string
    defUid*: BiggestInt
  EntityReferenceInfos* = object
    layerIid*: string
    levelIid*: string
    entityIid*: string
    worldIid*: string
  LevelBgPosInfos* = object
    scale*: seq[BiggestFloat]
    cropRect*: seq[BiggestFloat]
    topLeftPx*: seq[BiggestInt]
  TileCustomMetadata* = object
    data*: string
    tileId*: BiggestInt
  Tile* = object
    px*: seq[BiggestInt]
    t*: BiggestInt
    d*: seq[BiggestInt]
    a*: BiggestFloat
    src*: seq[BiggestInt]
    f*: BiggestInt
  checker* = enum
    Horizontal, Vertical, None
  tileMode* = enum
    Single, Stamp
  outOfBoundsValue* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  AutoRuleDef* = object
    checker*: checker
    pivotY*: BiggestFloat
    breakOnMatch*: bool
    perlinOctaves*: BiggestFloat
    yModulo*: BiggestInt
    size*: BiggestInt
    tileMode*: tileMode
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
    outOfBoundsValue*: outOfBoundsValue
    pivotX*: BiggestFloat
    flipY*: bool
    active*: bool
    uid*: BiggestInt
    tileIds*: seq[BiggestInt]
    invalidated*: bool
    pattern*: seq[BiggestInt]
    alpha*: BiggestFloat
    tileRectsIds*: seq[seq[BiggestInt]]
    tileXOffset*: BiggestInt
    xOffset*: BiggestInt
    tileRandomYMin*: BiggestInt
    perlinSeed*: BiggestFloat
  levelUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  NeighbourLevel* = object
    levelUid*: levelUid
    levelIid*: string
    dir*: string
  GridPoint* = object
    cx*: BiggestInt
    cy*: BiggestInt
  __worldY* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  __tile1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  __tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: __tile1
  __tile1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  __tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: __tile1
  fieldInstances* = object
    realEditorValues*: seq[JsonNode]
    __value*: JsonNode
    __tile*: __tile
    __type*: string
    __identifier*: string
    defUid*: BiggestInt
  __worldX* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  EntityInstance* = object
    __worldY*: __worldY
    __tile*: __tile
    __identifier*: string
    __tags*: seq[string]
    height*: BiggestInt
    px*: seq[BiggestInt]
    defUid*: BiggestInt
    __pivot*: seq[BiggestFloat]
    fieldInstances*: seq[fieldInstances]
    iid*: string
    width*: BiggestInt
    __worldX*: __worldX
    __grid*: seq[BiggestInt]
    __smartColor*: string
  TilesetRect* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  EnumTagValue* = object
    tileIds*: seq[BiggestInt]
    enumValueId*: string
  gridTiles* = object
    px*: seq[BiggestInt]
    t*: BiggestInt
    d*: seq[BiggestInt]
    a*: BiggestFloat
    src*: seq[BiggestInt]
    f*: BiggestInt
  overrideTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  intGrid* = object
    coordId*: BiggestInt
    v*: BiggestInt
  autoLayerTiles* = object
    px*: seq[BiggestInt]
    t*: BiggestInt
    d*: seq[BiggestInt]
    a*: BiggestFloat
    src*: seq[BiggestInt]
    f*: BiggestInt
  __worldY* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  __tile1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  __tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: __tile1
  __tile1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  __tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: __tile1
  fieldInstances* = object
    realEditorValues*: seq[JsonNode]
    __value*: JsonNode
    __tile*: __tile
    __type*: string
    __identifier*: string
    defUid*: BiggestInt
  __worldX* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  entityInstances* = object
    __worldY*: __worldY
    __tile*: __tile
    __identifier*: string
    __tags*: seq[string]
    height*: BiggestInt
    px*: seq[BiggestInt]
    defUid*: BiggestInt
    __pivot*: seq[BiggestFloat]
    fieldInstances*: seq[fieldInstances]
    iid*: string
    width*: BiggestInt
    __worldX*: __worldX
    __grid*: seq[BiggestInt]
    __smartColor*: string
  __tilesetRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  __tilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  LayerInstance* = object
    __opacity*: BiggestFloat
    optionalRules*: seq[BiggestInt]
    __gridSize*: BiggestInt
    __pxTotalOffsetX*: BiggestInt
    gridTiles*: seq[gridTiles]
    __type*: string
    __identifier*: string
    overrideTilesetUid*: overrideTilesetUid
    levelId*: BiggestInt
    intGrid*: seq[intGrid]
    autoLayerTiles*: seq[autoLayerTiles]
    layerDefUid*: BiggestInt
    entityInstances*: seq[entityInstances]
    intGridCsv*: seq[BiggestInt]
    pxOffsetX*: BiggestInt
    __tilesetRelPath*: __tilesetRelPath
    __tilesetDefUid*: __tilesetDefUid
    __cHei*: BiggestInt
    seed*: BiggestInt
    visible*: bool
    pxOffsetY*: BiggestInt
    iid*: string
    __pxTotalOffsetY*: BiggestInt
    __cWid*: BiggestInt
  IntGridValueInstance* = object
    coordId*: BiggestInt
    v*: BiggestInt
  worldLayout* = enum
    LinearHorizontal, LinearVertical, , GridVania, Free
  bgColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  externalRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  bgRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  levelUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  __neighbours* = object
    levelUid*: levelUid
    levelIid*: string
    dir*: string
  bgPos* = enum
    CoverDirty, Repeat, , Contain, Cover, Unscaled
  gridTiles* = object
    px*: seq[BiggestInt]
    t*: BiggestInt
    d*: seq[BiggestInt]
    a*: BiggestFloat
    src*: seq[BiggestInt]
    f*: BiggestInt
  overrideTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  intGrid* = object
    coordId*: BiggestInt
    v*: BiggestInt
  autoLayerTiles* = object
    px*: seq[BiggestInt]
    t*: BiggestInt
    d*: seq[BiggestInt]
    a*: BiggestFloat
    src*: seq[BiggestInt]
    f*: BiggestInt
  __worldY* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  __tile1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  __tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: __tile1
  __tile1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  __tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: __tile1
  fieldInstances* = object
    realEditorValues*: seq[JsonNode]
    __value*: JsonNode
    __tile*: __tile
    __type*: string
    __identifier*: string
    defUid*: BiggestInt
  __worldX* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  entityInstances* = object
    __worldY*: __worldY
    __tile*: __tile
    __identifier*: string
    __tags*: seq[string]
    height*: BiggestInt
    px*: seq[BiggestInt]
    defUid*: BiggestInt
    __pivot*: seq[BiggestFloat]
    fieldInstances*: seq[fieldInstances]
    iid*: string
    width*: BiggestInt
    __worldX*: __worldX
    __grid*: seq[BiggestInt]
    __smartColor*: string
  __tilesetRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  __tilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  layerInstances* = object
    __opacity*: BiggestFloat
    optionalRules*: seq[BiggestInt]
    __gridSize*: BiggestInt
    __pxTotalOffsetX*: BiggestInt
    gridTiles*: seq[gridTiles]
    __type*: string
    __identifier*: string
    overrideTilesetUid*: overrideTilesetUid
    levelId*: BiggestInt
    intGrid*: seq[intGrid]
    autoLayerTiles*: seq[autoLayerTiles]
    layerDefUid*: BiggestInt
    entityInstances*: seq[entityInstances]
    intGridCsv*: seq[BiggestInt]
    pxOffsetX*: BiggestInt
    __tilesetRelPath*: __tilesetRelPath
    __tilesetDefUid*: __tilesetDefUid
    __cHei*: BiggestInt
    seed*: BiggestInt
    visible*: bool
    pxOffsetY*: BiggestInt
    iid*: string
    __pxTotalOffsetY*: BiggestInt
    __cWid*: BiggestInt
  __tile1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  __tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: __tile1
  fieldInstances* = object
    realEditorValues*: seq[JsonNode]
    __value*: JsonNode
    __tile*: __tile
    __type*: string
    __identifier*: string
    defUid*: BiggestInt
  __bgPos1* = object
    scale*: seq[BiggestFloat]
    cropRect*: seq[BiggestFloat]
    topLeftPx*: seq[BiggestInt]
  __bgPos* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: __bgPos1
  levels* = object
    pxHei*: BiggestInt
    useAutoIdentifier*: bool
    __bgColor*: string
    bgColor*: bgColor
    externalRelPath*: externalRelPath
    worldY*: BiggestInt
    bgRelPath*: bgRelPath
    identifier*: string
    pxWid*: BiggestInt
    worldDepth*: BiggestInt
    bgPivotX*: BiggestFloat
    __neighbours*: seq[__neighbours]
    uid*: BiggestInt
    bgPos*: bgPos
    layerInstances*: seq[layerInstances]
    fieldInstances*: seq[fieldInstances]
    __bgPos*: __bgPos
    worldX*: BiggestInt
    iid*: string
    bgPivotY*: BiggestFloat
    __smartColor*: string
  World* = object
    worldGridWidth*: BiggestInt
    defaultLevelHeight*: BiggestInt
    identifier*: string
    worldLayout*: worldLayout
    iid*: string
    defaultLevelWidth*: BiggestInt
    worldGridHeight*: BiggestInt
    levels*: seq[levels]
  type* = enum
    Tiles, Entities, AutoLayer, IntGrid
  autoTilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  biomeFieldUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  autoTilesKilledByOtherLayerUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  color* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  collapsed* = object
    case kind: range[0 .. 1]
    of 0:
      key0: bool
    of 1:
      key1: pointer
  checker* = enum
    Horizontal, Vertical, None
  tileMode* = enum
    Single, Stamp
  outOfBoundsValue* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  rules* = object
    checker*: checker
    pivotY*: BiggestFloat
    breakOnMatch*: bool
    perlinOctaves*: BiggestFloat
    yModulo*: BiggestInt
    size*: BiggestInt
    tileMode*: tileMode
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
    outOfBoundsValue*: outOfBoundsValue
    pivotX*: BiggestFloat
    flipY*: bool
    active*: bool
    uid*: BiggestInt
    tileIds*: seq[BiggestInt]
    invalidated*: bool
    pattern*: seq[BiggestInt]
    alpha*: BiggestFloat
    tileRectsIds*: seq[seq[BiggestInt]]
    tileXOffset*: BiggestInt
    xOffset*: BiggestInt
    tileRandomYMin*: BiggestInt
    perlinSeed*: BiggestFloat
  icon1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  icon* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: icon1
  autoRuleGroups* = object
    isOptional*: bool
    color*: color
    collapsed*: collapsed
    usesWizard*: bool
    biomeRequirementMode*: BiggestInt
    rules*: seq[rules]
    icon*: icon
    active*: bool
    uid*: BiggestInt
    name*: string
    requiredBiomeValues*: seq[string]
  tilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  uiColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  doc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  autoSourceLayerDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  color* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  identifier* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  intGridValuesGroups* = object
    color*: color
    identifier*: identifier
    uid*: BiggestInt
  tile1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: tile1
  identifier* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  intGridValues* = object
    tile*: tile
    color*: string
    identifier*: identifier
    groupUid*: BiggestInt
    value*: BiggestInt
  LayerDef* = object
    type*: type
    autoTilesetDefUid*: autoTilesetDefUid
    parallaxScaling*: bool
    biomeFieldUid*: biomeFieldUid
    autoTilesKilledByOtherLayerUid*: autoTilesKilledByOtherLayerUid
    inactiveOpacity*: BiggestFloat
    __type*: string
    autoRuleGroups*: seq[autoRuleGroups]
    gridSize*: BiggestInt
    hideInList*: bool
    tilesetDefUid*: tilesetDefUid
    uiColor*: uiColor
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
    doc*: doc
    uid*: BiggestInt
    guideGridHei*: BiggestInt
    autoSourceLayerDefUid*: autoSourceLayerDefUid
    displayOpacity*: BiggestFloat
    intGridValuesGroups*: seq[intGridValuesGroups]
    hideFieldsWhenInactive*: bool
    useAsyncRender*: bool
    pxOffsetY*: BiggestInt
    parallaxFactorY*: BiggestFloat
    intGridValues*: seq[intGridValues]
    renderInWorldView*: bool
  color* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  identifier* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  IntGridValueGroupDef* = object
    color*: color
    identifier*: identifier
    uid*: BiggestInt
  iids* = object
    layerIid*: string
    levelIid*: string
    entityIid*: string
    worldIid*: string
  TocInstanceData* = object
    worldY*: BiggestInt
    fields*: JsonNode
    widPx*: BiggestInt
    iids*: iids
    heiPx*: BiggestInt
    worldX*: BiggestInt
  tileId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  tileRect1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  tileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: tileRect1
  EnumDefValues* = object
    __tileSrcRect*: seq[BiggestInt]
    color*: BiggestInt
    id*: string
    tileId*: tileId
    tileRect*: tileRect
  __FORCED_REFS* = object
    CustomCommand*: CustomCommand
    IntGridValueDef*: IntGridValueDef
    Level*: Level
    Definitions*: Definitions
    EnumDef*: EnumDef
    FieldDef*: FieldDef
    AutoLayerRuleGroup*: AutoLayerRuleGroup
    TilesetDef*: TilesetDef
    TableOfContentEntry*: TableOfContentEntry
    EntityDef*: EntityDef
    FieldInstance*: FieldInstance
    EntityReferenceInfos*: EntityReferenceInfos
    LevelBgPosInfos*: LevelBgPosInfos
    TileCustomMetadata*: TileCustomMetadata
    Tile*: Tile
    AutoRuleDef*: AutoRuleDef
    NeighbourLevel*: NeighbourLevel
    GridPoint*: GridPoint
    EntityInstance*: EntityInstance
    TilesetRect*: TilesetRect
    EnumTagValue*: EnumTagValue
    LayerInstance*: LayerInstance
    IntGridValueInstance*: IntGridValueInstance
    World*: World
    LayerDef*: LayerDef
    IntGridValueGroupDef*: IntGridValueGroupDef
    TocInstanceData*: TocInstanceData
    EnumDefValues*: EnumDefValues
  allowedRefsEntityUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  textLanguageMode* = enum
    LangMarkdown, LangPython, LangLog, LangC, LangLua, LangHaxe, LangJS,
    LangRuby, , LangJson, LangXml
  editorDisplayPos* = enum
    Beneath, Above, Center
  editorDisplayMode* = enum
    PointPath, PointStar, ValueOnly, Hidden, Points, NameAndValue,
    ArrayCountNoLabel, EntityTile, PointPathLoop, RadiusPx, LevelTile,
    RadiusGrid, RefLinkBetweenCenters, RefLinkBetweenPivots, ArrayCountWithLabel
  regex* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  editorLinkStyle* = enum
    DashedLine, CurvedArrow, ArrowsLine, ZigZag, StraightArrow
  allowedRefs* = enum
    Any, OnlyTags, OnlySame, OnlySpecificEntity
  editorTextSuffix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  doc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  editorTextPrefix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  editorDisplayColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  tilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  arrayMaxLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  arrayMinLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  min* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  max* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  levelFields* = object
    type*: string
    editorDisplayScale*: BiggestFloat
    __type*: string
    allowedRefsEntityUid*: allowedRefsEntityUid
    textLanguageMode*: textLanguageMode
    editorAlwaysShow*: bool
    defaultOverride*: JsonNode
    autoChainRef*: bool
    editorDisplayPos*: editorDisplayPos
    editorDisplayMode*: editorDisplayMode
    identifier*: string
    regex*: regex
    isArray*: bool
    editorLinkStyle*: editorLinkStyle
    allowedRefs*: allowedRefs
    useForSmartColor*: bool
    editorTextSuffix*: editorTextSuffix
    doc*: doc
    editorTextPrefix*: editorTextPrefix
    editorCutLongValues*: bool
    canBeNull*: bool
    allowedRefTags*: seq[string]
    uid*: BiggestInt
    symmetricalRef*: bool
    editorDisplayColor*: editorDisplayColor
    allowOutOfLevelRef*: bool
    acceptFileTypes*: seq[string]
    editorShowInWorld*: bool
    tilesetUid*: tilesetUid
    arrayMaxLength*: arrayMaxLength
    arrayMinLength*: arrayMinLength
    searchable*: bool
    min*: min
    exportToToc*: bool
    max*: max
  tagsSourceEnumUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  embedAtlas* = enum
    LdtkIcons, 
  cachedPixelData* = object
    case kind: range[0 .. 1]
    of 0:
      key0: Table[string, JsonNode]
    of 1:
      key1: pointer
  enumTags* = object
    tileIds*: seq[BiggestInt]
    enumValueId*: string
  customData* = object
    data*: string
    tileId*: BiggestInt
  relPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  tilesets* = object
    pxHei*: BiggestInt
    savedSelections*: seq[Table[string, JsonNode]]
    padding*: BiggestInt
    spacing*: BiggestInt
    tagsSourceEnumUid*: tagsSourceEnumUid
    embedAtlas*: embedAtlas
    identifier*: string
    cachedPixelData*: cachedPixelData
    enumTags*: seq[enumTags]
    pxWid*: BiggestInt
    tileGridSize*: BiggestInt
    customData*: seq[customData]
    uid*: BiggestInt
    __cHei*: BiggestInt
    __cWid*: BiggestInt
    relPath*: relPath
    tags*: seq[string]
  limitScope* = enum
    PerLayer, PerWorld, PerLevel
  limitBehavior* = enum
    PreventAdding, MoveLastOne, DiscardOldOnes
  renderMode* = enum
    Tile, Cross, Ellipse, Rectangle
  tilesetId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  minWidth* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  tileId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  doc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  allowedRefsEntityUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  textLanguageMode* = enum
    LangMarkdown, LangPython, LangLog, LangC, LangLua, LangHaxe, LangJS,
    LangRuby, , LangJson, LangXml
  editorDisplayPos* = enum
    Beneath, Above, Center
  editorDisplayMode* = enum
    PointPath, PointStar, ValueOnly, Hidden, Points, NameAndValue,
    ArrayCountNoLabel, EntityTile, PointPathLoop, RadiusPx, LevelTile,
    RadiusGrid, RefLinkBetweenCenters, RefLinkBetweenPivots, ArrayCountWithLabel
  regex* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  editorLinkStyle* = enum
    DashedLine, CurvedArrow, ArrowsLine, ZigZag, StraightArrow
  allowedRefs* = enum
    Any, OnlyTags, OnlySame, OnlySpecificEntity
  editorTextSuffix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  doc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  editorTextPrefix* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  editorDisplayColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  tilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  arrayMaxLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  arrayMinLength* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  min* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  max* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestFloat
    of 1:
      key1: pointer
  fieldDefs* = object
    type*: string
    editorDisplayScale*: BiggestFloat
    __type*: string
    allowedRefsEntityUid*: allowedRefsEntityUid
    textLanguageMode*: textLanguageMode
    editorAlwaysShow*: bool
    defaultOverride*: JsonNode
    autoChainRef*: bool
    editorDisplayPos*: editorDisplayPos
    editorDisplayMode*: editorDisplayMode
    identifier*: string
    regex*: regex
    isArray*: bool
    editorLinkStyle*: editorLinkStyle
    allowedRefs*: allowedRefs
    useForSmartColor*: bool
    editorTextSuffix*: editorTextSuffix
    doc*: doc
    editorTextPrefix*: editorTextPrefix
    editorCutLongValues*: bool
    canBeNull*: bool
    allowedRefTags*: seq[string]
    uid*: BiggestInt
    symmetricalRef*: bool
    editorDisplayColor*: editorDisplayColor
    allowOutOfLevelRef*: bool
    acceptFileTypes*: seq[string]
    editorShowInWorld*: bool
    tilesetUid*: tilesetUid
    arrayMaxLength*: arrayMaxLength
    arrayMinLength*: arrayMinLength
    searchable*: bool
    min*: min
    exportToToc*: bool
    max*: max
  tileRenderMode* = enum
    FullSizeCropped, FullSizeUncropped, Repeat, FitInside, NineSlice, Cover,
    Stretch
  uiTileRect1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  uiTileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: uiTileRect1
  minHeight* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  tileRect1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  tileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: tileRect1
  maxWidth* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  maxHeight* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  entities* = object
    allowOutOfBounds*: bool
    pivotY*: BiggestFloat
    tileOpacity*: BiggestFloat
    color*: string
    limitScope*: limitScope
    limitBehavior*: limitBehavior
    hollow*: bool
    height*: BiggestInt
    renderMode*: renderMode
    tilesetId*: tilesetId
    keepAspectRatio*: bool
    minWidth*: minWidth
    showName*: bool
    resizableX*: bool
    identifier*: string
    maxCount*: BiggestInt
    tileId*: tileId
    pivotX*: BiggestFloat
    doc*: doc
    fieldDefs*: seq[fieldDefs]
    uid*: BiggestInt
    tileRenderMode*: tileRenderMode
    uiTileRect*: uiTileRect
    resizableY*: bool
    lineOpacity*: BiggestFloat
    minHeight*: minHeight
    tileRect*: tileRect
    nineSliceBorders*: seq[BiggestInt]
    maxWidth*: maxWidth
    width*: BiggestInt
    tags*: seq[string]
    maxHeight*: maxHeight
    exportToToc*: bool
    fillOpacity*: BiggestFloat
  tileId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  tileRect1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  tileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: tileRect1
  values* = object
    __tileSrcRect*: seq[BiggestInt]
    color*: BiggestInt
    id*: string
    tileId*: tileId
    tileRect*: tileRect
  externalRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  externalFileChecksum* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  iconTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  enums* = object
    values*: seq[values]
    externalRelPath*: externalRelPath
    identifier*: string
    externalFileChecksum*: externalFileChecksum
    iconTilesetUid*: iconTilesetUid
    uid*: BiggestInt
    tags*: seq[string]
  type* = enum
    Tiles, Entities, AutoLayer, IntGrid
  autoTilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  biomeFieldUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  autoTilesKilledByOtherLayerUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  color* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  collapsed* = object
    case kind: range[0 .. 1]
    of 0:
      key0: bool
    of 1:
      key1: pointer
  checker* = enum
    Horizontal, Vertical, None
  tileMode* = enum
    Single, Stamp
  outOfBoundsValue* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  rules* = object
    checker*: checker
    pivotY*: BiggestFloat
    breakOnMatch*: bool
    perlinOctaves*: BiggestFloat
    yModulo*: BiggestInt
    size*: BiggestInt
    tileMode*: tileMode
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
    outOfBoundsValue*: outOfBoundsValue
    pivotX*: BiggestFloat
    flipY*: bool
    active*: bool
    uid*: BiggestInt
    tileIds*: seq[BiggestInt]
    invalidated*: bool
    pattern*: seq[BiggestInt]
    alpha*: BiggestFloat
    tileRectsIds*: seq[seq[BiggestInt]]
    tileXOffset*: BiggestInt
    xOffset*: BiggestInt
    tileRandomYMin*: BiggestInt
    perlinSeed*: BiggestFloat
  icon1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  icon* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: icon1
  autoRuleGroups* = object
    isOptional*: bool
    color*: color
    collapsed*: collapsed
    usesWizard*: bool
    biomeRequirementMode*: BiggestInt
    rules*: seq[rules]
    icon*: icon
    active*: bool
    uid*: BiggestInt
    name*: string
    requiredBiomeValues*: seq[string]
  tilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  uiColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  doc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  autoSourceLayerDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  color* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  identifier* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  intGridValuesGroups* = object
    color*: color
    identifier*: identifier
    uid*: BiggestInt
  tile1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: tile1
  identifier* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  intGridValues* = object
    tile*: tile
    color*: string
    identifier*: identifier
    groupUid*: BiggestInt
    value*: BiggestInt
  layers* = object
    type*: type
    autoTilesetDefUid*: autoTilesetDefUid
    parallaxScaling*: bool
    biomeFieldUid*: biomeFieldUid
    autoTilesKilledByOtherLayerUid*: autoTilesKilledByOtherLayerUid
    inactiveOpacity*: BiggestFloat
    __type*: string
    autoRuleGroups*: seq[autoRuleGroups]
    gridSize*: BiggestInt
    hideInList*: bool
    tilesetDefUid*: tilesetDefUid
    uiColor*: uiColor
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
    doc*: doc
    uid*: BiggestInt
    guideGridHei*: BiggestInt
    autoSourceLayerDefUid*: autoSourceLayerDefUid
    displayOpacity*: BiggestFloat
    intGridValuesGroups*: seq[intGridValuesGroups]
    hideFieldsWhenInactive*: bool
    useAsyncRender*: bool
    pxOffsetY*: BiggestInt
    parallaxFactorY*: BiggestFloat
    intGridValues*: seq[intGridValues]
    renderInWorldView*: bool
  tileId* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  tileRect1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  tileRect* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: tileRect1
  values* = object
    __tileSrcRect*: seq[BiggestInt]
    color*: BiggestInt
    id*: string
    tileId*: tileId
    tileRect*: tileRect
  externalRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  externalFileChecksum* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  iconTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  externalEnums* = object
    values*: seq[values]
    externalRelPath*: externalRelPath
    identifier*: string
    externalFileChecksum*: externalFileChecksum
    iconTilesetUid*: iconTilesetUid
    uid*: BiggestInt
    tags*: seq[string]
  defs* = object
    levelFields*: seq[levelFields]
    tilesets*: seq[tilesets]
    entities*: seq[entities]
    enums*: seq[enums]
    layers*: seq[layers]
    externalEnums*: seq[externalEnums]
  tutorialDesc* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  worldLayout* = enum
    LinearHorizontal, LinearVertical, , GridVania, Free
  defaultLevelWidth* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  flags* = enum
    ExportPreCsvIntGridFormat, DiscardPreCsvIntGrid,
    ExportOldTableOfContentData, PrependIndexToLevelFileNames, MultiWorlds,
    UseMultilinesType, IgnoreBackupSuggest
  identifierStyle* = enum
    Lowercase, Free, Capitalize, Uppercase
  worldGridHeight* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  bgColor* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  externalRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  bgRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  levelUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  __neighbours* = object
    levelUid*: levelUid
    levelIid*: string
    dir*: string
  bgPos* = enum
    CoverDirty, Repeat, , Contain, Cover, Unscaled
  gridTiles* = object
    px*: seq[BiggestInt]
    t*: BiggestInt
    d*: seq[BiggestInt]
    a*: BiggestFloat
    src*: seq[BiggestInt]
    f*: BiggestInt
  overrideTilesetUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  intGrid* = object
    coordId*: BiggestInt
    v*: BiggestInt
  autoLayerTiles* = object
    px*: seq[BiggestInt]
    t*: BiggestInt
    d*: seq[BiggestInt]
    a*: BiggestFloat
    src*: seq[BiggestInt]
    f*: BiggestInt
  __worldY* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  __tile1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  __tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: __tile1
  __tile1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  __tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: __tile1
  fieldInstances* = object
    realEditorValues*: seq[JsonNode]
    __value*: JsonNode
    __tile*: __tile
    __type*: string
    __identifier*: string
    defUid*: BiggestInt
  __worldX* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  entityInstances* = object
    __worldY*: __worldY
    __tile*: __tile
    __identifier*: string
    __tags*: seq[string]
    height*: BiggestInt
    px*: seq[BiggestInt]
    defUid*: BiggestInt
    __pivot*: seq[BiggestFloat]
    fieldInstances*: seq[fieldInstances]
    iid*: string
    width*: BiggestInt
    __worldX*: __worldX
    __grid*: seq[BiggestInt]
    __smartColor*: string
  __tilesetRelPath* = object
    case kind: range[0 .. 1]
    of 0:
      key0: string
    of 1:
      key1: pointer
  __tilesetDefUid* = object
    case kind: range[0 .. 1]
    of 0:
      key0: BiggestInt
    of 1:
      key1: pointer
  layerInstances* = object
    __opacity*: BiggestFloat
    optionalRules*: seq[BiggestInt]
    __gridSize*: BiggestInt
    __pxTotalOffsetX*: BiggestInt
    gridTiles*: seq[gridTiles]
    __type*: string
    __identifier*: string
    overrideTilesetUid*: overrideTilesetUid
    levelId*: BiggestInt
    intGrid*: seq[intGrid]
    autoLayerTiles*: seq[autoLayerTiles]
    layerDefUid*: BiggestInt
    entityInstances*: seq[entityInstances]
    intGridCsv*: seq[BiggestInt]
    pxOffsetX*: BiggestInt
    __tilesetRelPath*: __tilesetRelPath
    __tilesetDefUid*: __tilesetDefUid
    __cHei*: BiggestInt
    seed*: BiggestInt
    visible*: bool
    pxOffsetY*: BiggestInt
    iid*: string
    __pxTotalOffsetY*: BiggestInt
    __cWid*: BiggestInt
  __tile1* = object
    x*: BiggestInt
    w*: BiggestInt
    y*: BiggestInt
    h*: BiggestInt
    tilesetUid*: BiggestInt
  __tile* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: __tile1
  fieldInstances* = object
    realEditorValues*: seq[JsonNode]
    __value*: JsonNode
    __tile*: __tile
    __type*: string
    __identifier*: string
    defUid*: BiggestInt
  __bgPos1* = object
    scale*: seq[BiggestFloat]
    cropRect*: seq[BiggestFloat]
    topLeftPx*: seq[BiggestInt]
  __bgPos* = object
    case kind: range[0 .. 1]
    of 0:
      key0: pointer
    of 1:
      key1: __bgPos1
  levels* = object
    pxHei*: BiggestInt
    useAutoIdentifier*: bool
    __bgColor*: string
    bgColor*: bgColor
    externalRelPath*: externalRelPath
    worldY*: BiggestInt
    bgRelPath*: bgRelPath
    identifier*: string
    pxWid*: BiggestInt
    worldDepth*: BiggestInt
    bgPivotX*: BiggestFloat
    __neighbours*: seq[__neighbours]
    uid*: BiggestInt
    bgPos*: bgPos
    layerInstances*: seq[layerInstances]
    fieldInstances*: seq[fieldInstances]
    __bgPos*: __bgPos
    worldX*: BiggestInt
    iid*: string
    bgPivotY*: BiggestFloat
    __smartColor*: string
  ldtk* = object
    backupLimit*: BiggestInt
    simplifiedExport*: bool
    externalLevels*: bool
    backupRelPath*: backupRelPath
    jsonVersion*: string
    bgColor*: string
    appBuildId*: BiggestFloat
    defaultEntityHeight*: BiggestInt
    pngFilePattern*: pngFilePattern
    customCommands*: seq[customCommands]
    exportTiled*: bool
    exportPng*: exportPng
    worldGridWidth*: worldGridWidth
    defaultLevelHeight*: defaultLevelHeight
    toc*: seq[toc]
    worlds*: seq[worlds]
    imageExportMode*: imageExportMode
    dummyWorldIid*: string
    __FORCED_REFS*: __FORCED_REFS
    defaultPivotY*: BiggestFloat
    exportLevelBg*: bool
    nextUid*: BiggestInt
    levelNamePattern*: string
    defs*: defs
    defaultPivotX*: BiggestFloat
    tutorialDesc*: tutorialDesc
    worldLayout*: worldLayout
    defaultEntityWidth*: BiggestInt
    iid*: string
    defaultGridSize*: BiggestInt
    defaultLevelWidth*: defaultLevelWidth
    minifyJson*: bool
    backupOnSave*: bool
    flags*: seq[flags]
    defaultLevelBgColor*: string
    identifierStyle*: identifierStyle
    worldGridHeight*: worldGridHeight
    levels*: seq[levels]