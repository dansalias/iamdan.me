import * as fs from 'node:fs/promises'
import * as http from 'node:http'
import * as path from 'node:path'
import chokidar from 'chokidar'
import mime from 'mime'
import WebSocket, { WebSocketServer } from 'ws'

const clients: WebSocket[] = []

const BUILD_DIR = path.join(__dirname, '..', '.build')

;(async () => {
  http.createServer(async (req, res) => {
    const reqUrl = req.url || 'index.html'

    try {
      let fileContents = (await fs.readFile(path.join(
        BUILD_DIR,
        reqUrl,
      )))

      if (path.extname(reqUrl) === '.html') {
        const [ before, after ] = fileContents.toString().split('</body>')

        const script = `<script>
        const ws = new WebSocket('ws://localhost:2153')
        ws.onmessage = message => {
          const { path } = JSON.parse(message.data)
          if (path === window.location.pathname) {
            window.location.replace(window.location.href)
          }
        }

        document.addEventListener("DOMContentLoaded", function(event) {
          var scrollpos = localStorage.getItem('__bob_scrollpos')
          if (scrollpos) window.scrollTo(0, scrollpos)
        })

        window.onbeforeunload = function(e) {
            localStorage.setItem('__bob_scrollpos', window.scrollY)
        }
        </script>`

        fileContents = Buffer.from(before + script + '</body>' + after)
      }

      res.writeHead(200, { 'content-type': mime.getType(reqUrl) || 'text/plain' })
      res.end(fileContents)
    } catch {
      res.writeHead(404, { 'content-type': 'text/plain' })
      res.end('Not found')
    }
  }).listen(2152, () => console.log('server ready at localhost:2152'))

  new WebSocketServer({
    port: 2153,
  }).on('connection', (ws) => {
    clients.push(ws)
  })

  console.log('ws server ready at localhost:2153')

  chokidar.watch(BUILD_DIR).on('all', (event, path) => {
    clients.forEach(client => {
      client.send(JSON.stringify({
        event,
        path: path.replace(BUILD_DIR, ''),
      }))
    })
  })
})()
