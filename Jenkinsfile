node() {

    def repoURL = env.repoURL
    def jiraKey= env.jiraKey
	def branch=env.branch


    stage("Prepare Workspace") {
        cleanWs()
        if (env.jiraKey== '') { // and/or whatever condition you want
                currentBuild.result = 'ABORTED'
                error('jiraKey not set')
        }
        env.WORKSPACE_LOCAL = sh(returnStdout: true, script: 'cd').trim().readLines().drop(1).join(" ")
        env.BUILD_TIME = sh(returnStdout: true, script: 'date /t').trim().readLines().drop(1).join(" ")
        echo "Workspace set to:"  + env.WORKSPACE_LOCAL
        echo "Build time:"  + env.BUILD_TIME
        env.PATH = "C:/Program Files/Git/usr/bin;D:/Working/Tools/apache-jmeter-5.4.1/bin;${env.PATH}"
    }
    stage('Checkout Self') {
        git branch: branch, credentialsId: '', url: repoURL
    }
    stage('clean up') {
           echo "Jump to phase CleanUP"
           echo env.PATH
           sh"""bash cleanup.sh"""

        }
    stage('JMeter Tests') {
        echo "Jump to phase Jmeter Tests"
        sh"""bash perf_script.sh"""
    }
    stage('Convert Result') {
        echo "Convert Result"
        sh"""bash convert.sh 'jmeter.jpetstore'"""
    }
    stage('Store Aggerate report') {
        echo "Store Aggerate report"
//                 sh"""bash convert.sh 'jmeter.jpetstore'"""
        //env.AGGERATE_TABLE = sh(returnStdout: true, script: 'python csvtomd.py reports/aggregate_results.csv')
        // env.AGGERATE_TABLE = sh(returnStdout: true, script: 'python --version')
        // env.AGGERATE_TABLE = sh(returnStdout: true, script: 'bash convert_csv_to_md.sh')
        echo "AGGERATE_TABLE result is " + env.AGGERATE_TABLE
    }
    stage('Expose report') {
        echo "Jump to phase Expose report"
        dir('reports') {
            archiveArtifacts artifacts: '**'
        }
        dir('dashboard') {
            archiveArtifacts artifacts: '**'
        }

        archiveArtifacts artifacts: "synthesis_results.csv", followSymlinks: false
        archiveArtifacts artifacts: "results.jtl", followSymlinks: false
//         cucumber '**/cucumber.json'

    }
    stage('Attach report to pre-defined JIRA'){
        def attachment1 = jiraUploadAttachment idOrKey: jiraKey, file: './reports/TransactionsPerSecond.png', site: 'Jira_Cloud'
        def attachment2 = jiraUploadAttachment idOrKey: jiraKey, file: './reports/aggregate_results.csv', site: 'Jira_Cloud'
        echo "=========Attachment 1: " + attachment1.data.toString()
        echo "=========Attachment 2: " + attachment2.data.toString()
    }
    stage('Create Test execution in JIRA') {
        echo "Create Test execution in JIRA"
        def testIssue = [fields: [ project: [key: 'XRAY'],
                                         summary: 'JMeter performance results',
                                         description: 'Build URL:  ' + env.BUILD_URL+ '.\n\nDetailed dashboard report at: ' + env.JOB_URL + 'ws/dashboard/index.html\n\n*Aggregate results summary*\n\n ' + env.AGGERATE_TABLE + '}\n',
                                         issuetype: [id: '10012']]]

        response = jiraNewIssue issue: testIssue, site: 'Jira_Cloud'

        echo response.successful.toString()
        echo response.data.toString()
        def jiraExecutionKey = response.data["key"].toString()
        echo "=========jiraExecutionKey: " + jiraExecutionKey.toString()
        // step([$class: 'XrayImportBuilder', endpointName: '/junit', importFilePath: 'junit.xml', importInParallel: 'false', importToSameExecution: 'false', projectKey: 'DEMO', serverInstance: 'SERVER-e8a41998-c809-4234-8fa1-1951c4a589c6', testExecKey: jiraExecutionKey])
//         step([$class: 'XrayImportBuilder', endpointName: '/junit/multipart', importFilePath: 'alternative_junit.xml', importInParallel: 'false', importInfo: 'testExec.json', importToSameExecution: 'false', serverInstance: 'SERVER-e8a41998-c809-4234-8fa1-1951c4a589c6', testImportInfo: 'test.json'])

        }

}