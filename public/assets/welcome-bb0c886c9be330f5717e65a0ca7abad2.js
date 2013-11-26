(function() {
  if (window.location.toString().match(/login/)) {
    $(document).ready(function() {
      return $('#button').click(function() {
        return window.location = "/models?username=" + ($('[name=username]').val()) + "&encrypted_password=" + (CryptoJS.MD5($('[name=encrypted_password]').val()).toString());
      });
    });
  }

}).call(this);
