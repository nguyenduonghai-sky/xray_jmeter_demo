node() {

    def repoURL = env.repoURL
    def jiraKey= env.jiraKey


    stage("Prepare Workspace") {
        cleanWs()
        if (env.jiraKey== '') { // and/or whatever condition you want
                currentBuild.result = 'ABORTED'
                error('jiraKey not set')
        }
        env.WORKSPACE_LOCAL = bat(returnStdout: true, script: 'cd').trim().readLines().drop(1).join(" ")
        env.BUILD_TIME = bat(returnStdout: true, script: 'date /t').trim().readLines().drop(1).join(" ")
        echo "Workspace set to:"  + env.WORKSPACE_LOCAL
        echo "Build time:"  + env.BUILD_TIME
        env.PATH = "C:/Program Files/Git/usr/bin;D:/Working/Tools/apache-jmeter-5.4.1/bin;${env.PATH}"
    }
    stage('Checkout Self') {
        git branch: 'main', credentialsId: '', url: repoURL
    }
    stage('clean up') {
           echo "Jump to phase CleanUP"
           echo env.PATH
           bat"""bash cleanup.sh"""

        }
    stage('JMeter Tests') {
        echo "Jump to phase Jmeter Tests"
        bat"""bash perf_script.sh"""
    }
    stage('Convert Result') {
        echo "Convert Result"
        bat"""bash convert.sh 'jmeter.jpetstore'"""
    }
    stage('Store Aggerate report') {
        echo "Store Aggerate report"
//                 bat"""bash convert.sh 'jmeter.jpetstore'"""
        env.AGGERATE_TABLE = bat(returnStdout: true, script: 'bash process_aggregate.sh').trim().readLines().drop(1).join(" ")
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
        def attachment1 = jiraUploadAttachment idOrKey: jiraKey, file: './reports/TransactionsPerSecond.png', site: 'local_jira'
        def attachment2 = jiraUploadAttachment idOrKey: jiraKey, file: 'alternate_junit.xml', site: 'local_jira'
        echo "=========Attachment 1: " + attachment1.data.toString()
        echo "=========Attachment 2: " + attachment2.data.toString()
    }
	stage('Create Test execution in JIRA') {
        echo "Create Test execution in JIRA"
        def testIssue = [fields: [ project: [key: 'DEMO'],
                                         summary: 'JMeter performance results',
                                         description: 'Build URL:  ' + env.BUILD_URL+ '.\n\nDetailed dashboard report at: ' + env.JOB_URL + 'ws/dashboard/index.html\n\n*Aggregate results summary*\n\n ' + env.AGGERATE_TABLE + '}\n',
                                         issuetype: [id: '10007']]]

        response = jiraNewIssue issue: testIssue, site: 'local_jira'

        echo response.successful.toString()
        echo response.data.toString()
        def jiraExecutionKey = response["key"].toString()
        echo "=========jiraExecutionKey: " + jiraExecutionKey.toString()
        step([$class: 'XrayImportBuilder', endpointName: '/junit', importFilePath: 'junit.xml', importInParallel: 'false', importToSameExecution: 'false', projectKey: 'DEMO', serverInstance: 'SERVER-e8a41998-c809-4234-8fa1-1951c4a589c6', testExecKey: 'DEMO-5'])
//         step([$class: 'XrayImportBuilder', endpointName: '/junit/multipart', importFilePath: 'alternative_junit.xml', importInParallel: 'false', importInfo: 'testExec.json', importToSameExecution: 'false', serverInstance: 'SERVER-e8a41998-c809-4234-8fa1-1951c4a589c6', testImportInfo: 'test.json'])

// {
//    "fields": {
//       "project": {
//          "key": "CALC"
//       },
//       "summary": "JMeter performance results",
//       "description": "Build URL:  ${BUILD_URL}.\n\nDetailed dashboard report at: ${JOB_URL}ws/dashboard/index.html\n\n*Aggregate results summary*\n\n ${AGGREGATE_TABLE}\n",
//       "issuetype": {
//          "name": "Test Execution"
//       },
//       "customfield_10033": "123",
//       "customfield_11805" : [
//             "staging"
//       ],
//       "customfield_11807": [
//          "CALC-1200"
//       ]
//
//    }
// }

		}

}