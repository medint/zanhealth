
# List interface:
# list = new List($('#my-list'))
# list = List.fromTable($('table'))
# list.sort('columnname')
# list.search('query')
# list.add({
#     elem: element
#     column1: value1,
#     column2: value2,
#     column3: value3
# })

class List
    constructor: (@elem) ->
        @rows = []
    
    add: (row) ->
        row.searchText = ''
        for prop, val of row
            row.searchText += val
        
        row.shown = true
        
        @rows.push(row)
    
    queryWords: (query) -> query.match(/([^ "]+|"[^"]+")/g)
    
    search: (query) ->
        words = @queryWords(split)
        for row in @rows
            wasShown = row.shown
            row.shown = words.every((word) ->
                row.searchText.match(word))
            
            if wasShown and not row.shown
                row.hide()
            else if not wasShown and row.shown
                row.show()
    
    sort: (column) ->
        @elem.empty()
        _.chain(rows)
            .sortBy(column)
            .each((row) ->
                @elem.append(row))

List.fromTable = (table) ->
    list = new List(table)
    columns = _.invoke(table.children('th'), 'text')
    for row in table.children('tbody tr')
        list.add(_.extend({ elem: row },
                          _.object(_.zip(columns,
                                         _.invoke(row.children('td'), 
                                                  'text')))))
    
    list

# APPROX CONDITION:
if window.locaion.match(/index/) or window.location.match(/my/)
    list = List.fromTable($('table'))
    columns = _.invoke(table.children('th'), 'text')
    for column in columns
        column.click(->
            list.sort(column.text()))
    
    search = -> list.search(searchbox.text())
    $('#list-searchbox-button').click(search)
    $('#list-searchbox').keypress((evt) ->
        if evt.which is 13
            search())
    

