node() {

//     def repoURL = env.repoURL
//     def branch = env.branch


    properties([[$class: 'JiraProjectProperty'], parameters([string(defaultValue: 'TAG', description: 'add the tag you want to run. WITHOUT the @ sign!', name: 'tag'), choice(choices: ['chrome','chromeINK', 'edge', 'firefox'], description: 'please select a browser according to your TestSet', name: 'browser'), choice(choices: ['sit', 'uat'], description: '', name: 'testedEnv'), choice(choices: ['jenkins'], description: '', name: 'executingEnv'), choice(choices: ['desktop', 'android-ssh', 'ios-ssh'], description: '', name: 'platform'),choice(choices:['feature','wip_pascal','wip_luuviet','wip_bao','wip_nam','wip_ndkhoa','wip_gokul','wip_marco','wip_lehai','wip_guzal','wip_francesco','wip_ahmed','wip_massimo','wip_phuong','wip_danica','wip_hai'], description: 'please select the branch to checkout', name: 'branch')])])
    def token
    def stdout
    def cmd
    def TestSet
    def notify
    pipeline {
        options { disableConcurrentBuilds() }
    agent any
        stages{
            stage('Get TA from GitLab'){
                steps{
                    echo "checkout branch: ${branch}"
                checkout([$class                           : 'GitSCM',
                          branches                         : [[name: "${branch}"]],
                          doGenerateSubmoduleConfigurations: false,
                          extensions                       : [[$class: 'CleanCheckout']],
                          userRemoteConfigs                : [[credentialsId: 'skyGITpk',
                          url                               : 'https://github.com/1703/sky-newCRM-E2E-testautomation-ntt']]
                ])
                }
            }
            stage('Execute XRay Tests') {
                steps {
                        sh 'mvn -Dcucumber.filter.tags=@%tag% -Dbrowser=%browser% -DexecutingEnv=%executingEnv% -DtestedEnv=%testedEnv% -Dplatform=%platform%'
                }
            }
            stage('create Cucumber Report') {
                steps {
                    cucumber buildStatus: "UNSTABLE",
                            fileIncludePattern: "**/cucumber.json",
                            jsonReportDirectory: 'target/cucumber-report'
                }
            }
        }
    }

}