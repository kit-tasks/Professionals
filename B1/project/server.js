const express = require('express')
const { exec } = require('child_process')
const app = express()

function Invoke(res, method, args) {
    exec(`wsl ./invoke.sh ${method} '${args}'`, (error, stdout, stderr) => {
        let body = {}
        console.log(stdout)
        // console.log(stderr)
        if (stderr.includes('result')) {
            body.result = 'success'
            if (stderr.includes('payload')) {
                body.result = stderr.split('payload:')[1]
                body.result = JSON.parse(body.result)
                body.result = body.result.toString()
                body.result = JSON.parse(body.result)
            }
        } else {
            body.error = stderr.split('message:')[1]
        }
        res.end(JSON.stringify(body, '', 2))
    })
}

app.get('/invoke', (req, res) => {
    let { method, args = [] } = req.query
    if (args != '') {
        args = args.split('$')
        for (let i = 0; i < args.length; i++) {
            args[i] = `"${args[i]}"`
        }
        args = args.join(',')
    }
    Invoke(res, method, args)
})

app.get('/', (req, res) => {
    res.sendFile(__dirname + '/index.html')
})

app.get('/*', (req, res) => {
    res.sendFile(__dirname + req.query)
})

app.listen(8080)
