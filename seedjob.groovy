job('seed_job') {
 scm {
  git {
   remote {
    url('https://github.com/sarthak-m-das/Devops-Automation.git')
   }
   branch('main')
  }
 }
}