isWS = (str) -> null isnt str.match(/^[\n ]*$/)

fs = require('fs')
{exec} = require('child_process')
_ = require('customscore')

debug = () -> console.log.apply(console, arguments)

if _.contains(process.argv, '--dry-run')
    genScaffold = ((str) -> console.log(str))
else
    genScaffold = exec

database = fs.readFileSync('database.md').toString()

pattern = /Models *\n=======*\n+((?:.|\n)+?)Relations\n=======*\n+((?:.|\n)+)$/
if ((m = database.match(pattern))) is null
    throw new Error("malformed database.md")
else
    [_, models, relations] = m

for model in models.split('\n\n')
    ((name, attributes...) -> 
        unless name is undefined or isWS(name)
            genScaffold("rails g scaffold #{name} " + 
                 attributes
                    .map((attribute) ->
                            attribute.split(' ').join(':'))
                    .join(' '))
        ).apply({}, model.split('\n'))

console.log("Generating scaffolds...")
console.log("Press enter to create relations")

process.stdin.once('data', ->
    for relation in relations.split(/\n+/)
        if null isnt ((m = relation.match(/([^ ]+) (.+) (.+)/)))
            [_, name, rel, other] = m
            debug([name, rel, other])
            model = fs.readFileSync("app/models/#{name}.rb").toString()
            modelPattern = /([^\n]+)\n((.|\n)+)/
            [_, firstline, rest] = model.match(modelPattern)
            fs.writeFileSync("app/models/#{name}.rb",
                             firstline + '\n' +
                             "    #{rel} :#{other}\n" +
                             rest))




