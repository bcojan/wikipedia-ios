curl
  -X POST
  -H "Content-Type: application/json"
  -H "Sightr-Secret: c99b8a99e2bf44dcb39facb359f7c660"
  -d '{
  "payload": {
       "branch": "develop",
       "ci": "Bamboo",
       "build_number": ${bamboo.buildNumber},
       "commit": "${bamboo.planRepository.revision}"
       }
  }' "https://api.sightr.io/processBuild?apiKey=58bbfa865e4ed2b157ddd921"
