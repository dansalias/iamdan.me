import { bob } from './bob'
import './project'

(async () => {
  await bob.build()

  setTimeout(() => {
    console.log('build complete')

    process.exit()
  }, 2000)

})()
