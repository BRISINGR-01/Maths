module Bounds exposing (..)

-- Constants

cyrilicUpStart: Int
cyrilicUpStart =
    Char.toCode 'А'

cyrilicUpEnd: Int
cyrilicUpEnd =
    Char.toCode 'Я'

cyrilicLowStart: Int
cyrilicLowStart =
    Char.toCode 'а'

cyrilicLowEnd: Int
cyrilicLowEnd =
    Char.toCode 'я'


latinUpStart: Int
latinUpStart =
    Char.toCode 'A'


latinUpEnd: Int
latinUpEnd =
    Char.toCode 'Z'


latinLowStart: Int
latinLowStart =
    Char.toCode 'a'


latinLowEnd: Int
latinLowEnd =
    Char.toCode 'z'


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


type alias Bounds =
    { thisStart: Int
    , thisEnd: Int
    , otherStart: Int
    , otherEnd: Int
    }


latinLowerBounds : Bounds
latinLowerBounds =
    { thisStart = latinLowStart
    , thisEnd = latinLowEnd
    , otherStart = latinUpStart
    , otherEnd = latinUpEnd
    }


latinUpperBounds : Bounds
latinUpperBounds =
    { thisStart = latinUpStart
    , thisEnd = latinUpEnd
    , otherStart = latinLowStart
    , otherEnd = latinLowEnd
    }


cyrilicLowerBounds : Bounds
cyrilicLowerBounds =
    { thisStart = cyrilicLowStart
    , thisEnd = cyrilicLowEnd
    , otherStart = cyrilicUpStart
    , otherEnd = cyrilicUpEnd
    }


cyrilicUpperBounds : Bounds
cyrilicUpperBounds =
    { thisStart = cyrilicUpStart
    , thisEnd = cyrilicUpEnd
    , otherStart = cyrilicLowStart
    , otherEnd = cyrilicLowEnd
    }


greekLowerBounds : Bounds
greekLowerBounds =
    { thisStart = greekLowStart
    , thisEnd = greekLowEnd
    , otherStart = greekUpStart
    , otherEnd = greekUpEnd
    }


greekUpperBounds : Bounds
greekUpperBounds =
    { thisStart = greekUpStart
    , thisEnd = greekUpEnd
    , otherStart = greekLowStart
    , otherEnd = greekLowEnd
    }


boundsList: List Bounds
boundsList = [latinLowerBounds, latinUpperBounds, cyrilicLowerBounds, cyrilicUpperBounds, greekLowerBounds, greekUpperBounds ]
