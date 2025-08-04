sudo apt install npm
npm install -g sonar-scanner
sonar-scanner \
  -Dsonar.projectKey=react-devsecops \
  -Dsonar.sources=src \
  -Dsonar.host.url=http://<your-sonarqube-server> \
  -Dsonar.login=$SONAR_TOKEN
