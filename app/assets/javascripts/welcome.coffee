
if window.location.toString().match(/login/)
    $(document).ready(->
        $('#button').click(->
            window.location = "/models?username=
#{$('[name=username]').val()}
&encrypted_password=
#{CryptoJS.MD5($('[name=encrypted_password]').val()).toString()}"))