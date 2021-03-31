node() {

    def repoURL = 'https://github.com/nguyenduonghai-sky/xray_jmeter_demo.git'

    stage("Prepare Workspace") {
        cleanWs()
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
           env.TEST_DATA = bat(returnStdout: true, script: 'cleanup.sh').trim()
           bat"""bash cleanup.sh"""
           echo "=============:" + env.TEST_DATA

        }
    stage('JMeter Tests') {
        echo "Jump to phase Jmeter Tests"
        bat"""bash perf_script.sh"""
    }
    stage('Expose report') {
        echo "Jump to phase Expose report"
        archive "result.jtl"
        archive "reports"
        archive "dashboard"
        archive "synthesis_results.csv"
//         cucumber '**/cucumber.json'

    }
	stage('Create Issue to JIRA') {
        echo "Create Issue to JIRA"
        def testIssue = [fields: [ project: [key: 'XRAY'],
                                         summary: 'New JIRA Created from Jenkins.',
                                         description: 'New JIRA Created from Jenkins.',
                                         issuetype: [id: '10002']]]

        response = jiraNewIssue issue: testIssue, site: 'local_jira'

        echo response.successful.toString()
        echo response.data.toString()
        def jiraKey = response.data["key"].toString()
        def attachment = jiraUploadAttachment idOrKey: jiraKey, file: '/reports/TransactionsPerSecond.png', site: 'local_jira'
        echo "=========Attachment: " + attachment.data.toString()
		}

}