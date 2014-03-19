
if window.location.toString().match(/login/)
    login = ->
        window.location = """
            /facility_work_orders?username=
            #{$('[name=username]').val()}
            &encrypted_password=
            #{CryptoJS.MD5($('[name=password]').val()).toString()}
                          """

    $(document).ready(->
        $('[name=username]').focus()

        $('#button').click(login)

        $('[name=username], 
           [name=password]').keypress((evt) ->
            switch evt.which
                when 13
                    login()))
