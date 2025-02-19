module Bounds exposing (..)

-- Constants

bgUpStart: Int
bgUpStart =
    Char.toCode 'А'


bgUpEnd: Int
bgUpEnd =
    Char.toCode 'Я'


bgLowStart: Int
bgLowStart =
    Char.toCode 'а'


bgLowEnd: Int
bgLowEnd =
    Char.toCode 'я'

bgCount: Int
bgCount = 31

upStart: Int
upStart =
    Char.toCode 'A'


upEnd: Int
upEnd =
    Char.toCode 'Z'


lowStart: Int
lowStart =
    Char.toCode 'a'


lowEnd: Int
lowEnd =
    Char.toCode 'z'

latinCount: Int
latinCount = 26

greekUpStart: Int
greekUpStart =
    Char.toCode 'Α'  -- Unicode 913

greekUpEnd: Int
greekUpEnd =
    Char.toCode 'Ω'  -- Unicode 937

greekLowStart: Int
greekLowStart =
    Char.toCode 'α'  -- Unicode 945

greekLowEnd: Int
greekLowEnd =
    Char.toCode 'ω'  -- Unicode 969

greekCount: Int
greekCount = 24

type alias Bounds =
    { thisStart: Int
    , thisEnd: Int
    , otherStart: Int
    , otherEnd: Int
    , total: Int
    }


latinLowerBounds : Bounds
latinLowerBounds =
    { thisStart = lowStart
    , thisEnd = lowEnd
    , otherStart = upStart
    , otherEnd = upEnd
    , total = latinCount
    }


latinUpperBounds : Bounds
latinUpperBounds =
    { thisStart = upStart
    , thisEnd = upEnd
    , otherStart = lowStart
    , otherEnd = lowEnd
    , total = latinCount
    }


bgLowerBounds : Bounds
bgLowerBounds =
    { thisStart = bgLowStart
    , thisEnd = bgLowEnd
    , otherStart = bgUpStart
    , otherEnd = bgUpEnd
    , total = bgCount
    }


bgUpperBounds : Bounds
bgUpperBounds =
    { thisStart = bgUpStart
    , thisEnd = bgUpEnd
    , otherStart = bgLowStart
    , otherEnd = bgLowEnd
    , total = bgCount
    }


greekLowerBounds : Bounds
greekLowerBounds =
    { thisStart = greekLowStart
    , thisEnd = greekLowEnd
    , otherStart = greekUpStart
    , otherEnd = greekUpEnd
    , total = greekCount
    }


greekUpperBounds : Bounds
greekUpperBounds =
    { thisStart = greekUpStart
    , thisEnd = greekUpEnd
    , otherStart = greekLowStart
    , total = greekCount
    , otherEnd = greekLowEnd
    }


boundsList: List Bounds
boundsList = [latinLowerBounds, latinUpperBounds, bgLowerBounds, bgUpperBounds, greekLowerBounds, greekUpperBounds ]
