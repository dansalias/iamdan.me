import path from 'node:path'
import fs from 'node:fs/promises'
import chokidar from 'chokidar'
import { glob } from 'glob'

const BUILD_DIR = path.join(__dirname, '..', '.build')

interface SourceEntry {
  filepath: string
  data: Buffer
}

export interface Source {
  get: (filepath: string) => Promise<SourceEntry>
  getAll: (pattern: string | string[]) => Promise<SourceEntry[]>
}

interface Output {
  write: (filepath: string, data: string | Buffer) => Promise<void>
}

type BuilderFunction = (source: Source, output: Output) => void | Promise<void>

const subscriptions: Map<string, BuilderFunction[]> = new Map()
const builderFunctions: BuilderFunction[] = []

export const bob = {
  add: async (builderFunction: BuilderFunction) => {
    console.log('adding builder function...')
    builderFunctions.push(builderFunction)
    await builderFunction(
      {
        get: async (filepath) => {
          subscriptions.set(
            path.join(__dirname, '..', filepath),
            (subscriptions.get(path.join(__dirname, '..', filepath)) || []).concat(builderFunction)
          )

          return { filepath, data: Buffer.from([]) }
        },
        getAll: async (pattern) => {
          (Array.isArray(pattern) ? pattern : [ pattern ]).forEach(pattern => {
            subscriptions.set(
              path.join(__dirname, '..', pattern),
              (subscriptions.get(path.join(__dirname, '..', pattern)) || []).concat(builderFunction)
            )
          })

          return []
        },
      },
      {
        write: async () => {},
      }
    )

    subscriptions.forEach((builders, filepath) => {
      chokidar.watch(filepath, { ignoreInitial: true }).on('raw', (event, resolvedFilepath) => {
        console.log(event, resolvedFilepath, `(${ filepath })`)
        builders.forEach(bob.run)
      })
    })

    bob.run(builderFunction)
  },
  run: (builderFunction: BuilderFunction) => {
    console.log('running builder function...')
    return builderFunction(
      {
        get: async (filepath) => ({
          filepath: path.join(__dirname, '..', filepath),
          data: await fs.readFile(path.join(__dirname, '..', filepath)),
        }),
        getAll: async (pattern) => {
          return Promise.all((await glob(pattern)).map(async (filepath) => ({
            filepath: path.join(__dirname, '..', filepath),
            data: await fs.readFile(path.join(__dirname, '..', filepath)),
          })))
        },
      },
      {
        write: async (filepath, data) => {
          await fs.writeFile(
            path.join(BUILD_DIR, path.basename(filepath)), // mkdir -p ? (relative to source dir)
            data
          )
        },
      }
    )
  },
  build: () => {
    return Promise.all(builderFunctions.map(builderFunction => {
      bob.run(builderFunction)
    }))
  },
}
