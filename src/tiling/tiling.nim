{.compile: "tiling.c"}
proc getDesktopBounds(x, y, w, h: var int) {.importc}
proc moveWindowImpl(x, y, w, h: int) {.importc}

proc tileWindow*(x, y, gap, displayEdgeGap: int) =
  var
    dx, dy, dw, dh = 0

  getDesktopBounds(dx, dy, dw, dh)

  dx += displayEdgeGap
  dy += displayEdgeGap
  dw -= displayEdgeGap * 2
  dh -= displayEdgeGap * 2

  let
    dr = dx + dw
    db = dy + dh

  # Initialize the window location to the top left corner of the desktop
  var
    wx = dx
    wy = dy
    ww = 0
    wh = 0

  if abs(x) == 1:
    ww = (dw / 2).int
  else:
    ww = dw

  if abs(y) == 1:
    wh = (dh / 2).int
  else:
    wh = dh

  wx = x * dw
  if wx < dx:
    wx = dx
  elif wx + ww > dr:
    wx = dr - ww

  wy = y * dh
  if wy < dy:
    wy = dy
  elif wy + wh > db:
    wy = db - wh

  wx += gap
  wy += gap

  ww -= gap * 2
  wh -= gap * 2

  moveWindowImpl(wx, wy, ww, wh)
