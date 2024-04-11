const getPointsLine = (x1, y1, x2, y2) => {
  let dx, dy, incYi, incXi, incXr, incYr, x, y, avR, av, avI
  const points = []

  dx = x2 - x1
  dy = y2 - y1

  if (dy >= 0) {
    incYi = 1
  } else {
    incYi = -1
    dy = -dy
  }

  if (dx >= 0) {
    incXi = 1
  } else {
    incXi = -1
    dx = -dx
  }

  if (dx >= dy) {
    incYr = 0
    incXr = incXi
  } else {
    incXr = 0
    incYr = incYi

    const tmp = dx
    dx = dy
    dy = tmp
  }

  x = x1
  y = y1
  avR = dy << 1
  av = avR - dx
  avI = av - dx

  while (true) {
    points.push([x, y])

    if (av >= 0) {
      x += incXi
      y += incYi
      av += avI
    } else{
      x += incXr
      y += incYr
      av += avR
    }

    if (x === x2 && y === y2) { break }
  }

  return points
}


const getPointsCircle = (x_c, y_c, r) => {
  let x, y, xChange, yChange, radiusError
  const points = []

  x = r 
  y = 0 
  xChange = 1 - (r << 1) 
  yChange = 1 
  radiusError = 0

  while (x >= y) {
    points.push([x_c + x, y_c + y])
    points.push([x_c - x, y_c + y])
    points.push([x_c + x, y_c - y])
    points.push([x_c - x, y_c - y])
    points.push([x_c + y, y_c + x])
    points.push([x_c - y, y_c + x])
    points.push([x_c + y, y_c - x])
    points.push([x_c - y, y_c - x])
    
    y++
    radiusError += yChange
    yChange += 2
    
    if ((radiusError << 1) + xChange > 0) {
      x--
      radiusError += xChange
      xChange += 2
    }
  }

  return points
}


const getPointsTriangle = (x1, y1, x2, y2, x3, y3) => {
  const pts1 = getPointsLine(x1, y1, x2, y2)
  const pts2 = getPointsLine(x2, y2, x3, y3)
  const pts3 = getPointsLine(x3, y3, x1, y1)

  return [...pts1, ...pts2, ...pts3]
}


export { getPointsCircle, getPointsTriangle }
