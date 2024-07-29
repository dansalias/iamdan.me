import { bob } from './bob'
import './project'

(async () => {
  await bob.build()

  console.log('build complete')

  process.exit()
})()
