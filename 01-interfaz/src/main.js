// import 'bootstrap/dist/css/bootstrap.min.css'
// import 'bootstrap/dist/js/bootstrap.bundle.min.js'
// import 'bootstrap-icons/font/bootstrap-icons.min.css'
import './style.css'
import { getPointsCircle, getPointsTriangle } from './points'


// DEFINICION DEL CANVAS
const canvas = document.querySelector('canvas')
canvas.width = 800
canvas.height = 600

const ctx = canvas.getContext('2d')
const id = ctx.createImageData(canvas.width, canvas.height);

const draw = async (pts, [r, g, b], delay) => {
  for (const [x, y] of pts) {
    if (x < 0 || x >= canvas.width || y < 0 || y >= canvas.height) continue

    const i = (y * canvas.width) + x
    id.data[(i << 2)] = r
    id.data[(i << 2) + 1] = g
    id.data[(i << 2) + 2] = b
    id.data[(i << 2) + 3] = 255

    if (delay)
      await new Promise((resolve) => setTimeout(resolve, delay));
    ctx.putImageData(id, 0, 0);
  }
}

const hexToRGB = (hexa) => {
  const r = parseInt(hexa.substring(1, 3), 16);
  const g = parseInt(hexa.substring(3, 5), 16);
  const b = parseInt(hexa.substring(5, 7), 16);
  return [r, g, b]
}

// ESCUCHAMOS CUANDO SE PRESIONE GRAFICAR
document.addEventListener('DOMContentLoaded', () => {
  const formulario = document.querySelector('form')

  formulario.addEventListener('submit', (e) => {
    e.preventDefault()
    const dibujarCircunferencia = document.getElementById('circleOption').checked
    const color = hexToRGB(document.getElementById('colorContorno').value)
    let pts

    if (dibujarCircunferencia) {
      const px = parseInt(document.getElementById('CircleX').value)
      const py = parseInt(document.getElementById('CircleY').value)
      const pr = parseInt(document.getElementById('CircleRadius').value)

      pts = getPointsCircle(px, py, pr)
    } else {
      const p1x = parseInt(document.getElementById('TriangleFirstX').value)
      const p1y = parseInt(document.getElementById('TriangleFirstY').value)
      const p2x = parseInt(document.getElementById('TriangleSecondX').value)
      const p2y = parseInt(document.getElementById('TriangleSecondY').value)
      const p3x = parseInt(document.getElementById('TriangleThirdX').value)
      const p3y = parseInt(document.getElementById('TriangleThirdY').value)

      pts = getPointsTriangle(p1x, p1y, p2x, p2y, p3x, p3y)
    }

    draw(pts, color, 5)
  })
})
