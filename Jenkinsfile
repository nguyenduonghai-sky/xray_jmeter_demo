node() {

    def repoURL = 'https://github.com/nguyenduonghai-sky/xray_jmeter_demo.git'

    stage("Prepare Workspace") {
        cleanWs()
        env.WORKSPACE_LOCAL = bat(returnStdout: true, script: 'cd').trim().readLines().drop(1).join(" ")
        env.BUILD_TIME = bat(returnStdout: true, script: 'date /t').trim().readLines().drop(1).join(" ")
        echo "Workspace set to:"  + env.WORKSPACE_LOCAL
        echo "Build time:"  + env.BUILD_TIME
        env.PATH = "D:\Working\Tools\apache-jmeter-5.4.1\bin:$PATH"
    }
    stage('Checkout Self') {
        git branch: 'main', credentialsId: '', url: repoURL
    }
    stage('clean up') {
           echo "Jump to phase CleanUP"
           echo env.PATH
           env.TEST_DATA = bat(returnStdout: true, script: 'cleanup.sh').trim()
           bat"""cleanup.sh"""
           bat"""whoami"""
           bat"""jmeter -H 10.225.3.1 -P 3128 -n -t  jpetstore_configurable_host.jmx -l results.jtl -e -o dashboard;"""
           echo "=============:" + env.TEST_DATA

        }
    stage('JMeter Tests') {
        echo "Jump to phase Jmeter Tests"
        bat"""perf_script.sh"""
    }
    stage('Expose report') {
//         archive "**/cucumber.json"
//         cucumber '**/cucumber.json'
           echo "Jump to phase Expose report"
    }
	stage('Import results to Xray') {
        echo "Import results to Xray"
// 		def description = "[BUILD_URL|${env.BUILD_URL}]"
// 		def labels = '["regression","automated_regression"]'
// 		def environment = "DEV"
// 		def testExecutionFieldId = 10008
// // 		def testEnvironmentFieldName = "customfield_10132"
// 		def projectKey = "XRAY"
// 		def xrayConnectorId = 'CLOUD-e48ff983-d452-4a78-99bb-1f5d68a19c69'
// 		def info = '''{
// 				"fields": {
// 					"project": {
// 					"key": "''' + projectKey + '''"
// 				},
// 				"labels":''' + labels + ''',
// 				"description":"''' + description + '''",
// 				"summary": "Automated Regression Execution @ ''' + env.BUILD_TIME + ' ' + environment + ''' " ,
// 				"issuetype": {
// 				"id": "''' + testExecutionFieldId + '''"
// 				}
// 				}
// 				}'''
//
// 			echo info
//
// // 			step([$class: 'XrayImportBuilder', endpointName: '/cucumber/multipart', importFilePath: 'target/cucumber.json', importInfo: info, inputInfoSwitcher: 'fileContent', serverInstance: xrayConnectorId])
// //             step([$class: 'XrayImportBuilder', endpointName: '/multipart', importFilePath: 'target/cucumber.json', importInParallel: 'false', importInfo: 'projectKey=XRAY', inputInfoSwitcher: 'fileContent', serverInstance: 'CLOUD-e48ff983-d452-4a78-99bb-1f5d68a19c69'])
//             step([$class: 'XrayImportBuilder', endpointName: '/cucumber/multipart', importFilePath: 'target/cucumber.json', importInParallel: 'false', importInfo: info, inputInfoSwitcher: 'fileContent', serverInstance: xrayConnectorId])
		}

}