
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

takeWhile = (thing, iterator) ->
    thing = thing.slice(0)
    result = []
    while iterator(thing[0])
        result.push(thing.shift())
        
    result

Rotor = (possibilities) ->
    result = 
        rotate:
            possibilities.push(possibilities.shift())
    
    for possibility of possibilities
        do (possibility) ->
            result.__defineGetter__(possibility, ->
                possibiliy is possibilities[0])
    
    result

class List
    constructor: (@elem) ->
        @rows = []
    
    add: (row) ->
        row.searchText = ''
        for prop, val of row
            row.searchText += val
        
        row.searchText = row.searchText.toLowerCase()
        row.shown = true
        
        @rows.push(row)
    
    queryWords: (query) -> 
        query
            .match(/([^ "]+|"[^"]+"|)/g)
            .map((word) -> word.toLowerCase())
    
    search: (query) ->
        words = @queryWords(query)
        for row in @rows
            wasShown = row.shown
            row.shown = words.every((word) ->
                row.searchText.match(word))
            
            if wasShown and not row.shown
                row.elem.hide()
            else if not wasShown and row.shown
                row.elem.show()
    
    sort: do -> 
        compare = (a, b) -> 
            if a < b
                -1
            else if a is b
                0
            else 
                1
        
        (columns, desc) ->
            @elem.empty()
            _.chain(@rows)
                .sort((a, b) ->
                    _.find(_.map(_.zip(_.map(columns,
                                             (column) -> a[column]),
                                       _.map(columns,
                                             (column) -> b[column])),
                                 ([a, b]) -> compare(a, b)*(-2*desc + 1))
                           (x) -> x isnt 0))
                .each((row) =>
                    @elem.append(row.elem))


###
_.chain(list.rows).sortBy('ID')
###

List.fromTable = (t) ->
    list = new List(t.find('tbody'))
    columns = _.invoke(t.find('th').toArray().map($), 'text')
    for row in t.find('tbody tr').toArray().map($)
        list.add(_.extend({ elem: row },
                          _.object(_.zip(columns,
                                         _.invoke(row.find('td').toArray().map($), 
                                                  'text')))))
    
    list

$(document).ready(->
    # APPROX CONDITION:
    if window.location.toString().match(/index/) or window.location.toString().match(/my/)
        t = $('table#my-requests')
        list = List.fromTable(t)
        criteria = []
        columns = t.find('th').toArray().map($)
        clicked = []
        for column in columns
            do (column) ->
                text = column.text()
                column.addClass('sortable')
                column.click(->
                    criteria = _.without(criteria, text)
                    criteria.unshift(text)
                    columns.map((column) ->
                        column
                            .removeClass('sort-asc')
                            .removeClass('sort-desc')
                            .addClass('sortable'))
                    
                    column.removeClass('sortable')
                    if takeWhile(clicked,
                                 (x) -> x is column).length % 2 is 0
                        column.addClass('sort-asc')
                    else
                        column.addClass('sort-desc')
                        
                        
                    list.sort(criteria, takeWhile(clicked,
                                                  (x) -> x is column).length % 2 is 1)
                    console.log(clicked)
                    clicked.unshift(column))
        
        searchbox = $('#list-searchbox')
        search = -> list.search(searchbox.val())
        $('#list-searchbox-button').click(search)
        searchbox.keypress((evt) ->
            if evt.which is 13
                search()))
