// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require_tree .
$(function() {
  $("form[action='/remove']").on("submit", function(e) {
    return (confirm("Are you sure you want to remove this file?") ? true : false);
  });

  var doc = document.documentElement;
  doc.ondragover = function() {
    this.className = 'hover';
    return false;
  };
  doc.ondragend = function() {
    this.className = '';
    return false;
  };
  doc.ondrop = function(event) {
    if ($("form[action='/upload']").length == 0) {
      alert("Remove this file first before uploading a new one.");
      return false;
    }

    event.preventDefault && event.preventDefault();
    this.className = '';
    $("#drag-circle").hide();
    $("#upload-msg").show();
    var _t = $("form[action='/upload'] input[name='t']").attr("value");
    var file = event.dataTransfer.files[0];

    if (_t == "img") {

      var formData = new FormData();
      formData.append('attachment', file);
      formData.append('options', $("form[action='/upload'] input[name='options']").attr("value"));
      formData.append('t', $("form[action='/upload'] input[name='t']").attr("value"));

      var csrf_token = $('meta[name="csrf-token"]').attr('content');

      $.ajax({
        url: '/upload',
        type: 'POST',
        headers: { 'X-CSRF-Token': csrf_token },
        data: formData,
        cache: false,
        processData: false,
        contentType: false,
        success: function() { location.reload(); },
        error: function(xhr) {
          var msg = xhr.responseText;
          $("#error-msg").show();
          var msgText = JSON.parse(msg).message;
          $("#error-msg").text(msgText);
          $("#drag-circle").show();
          $("#upload-msg").hide();
          alert(msgText);
        }
      });

      // imageDimension(file, function(w, h) {
      //   if (/png|jpg|jpeg|gif/.test(file.type) === false) {
      //     $("#error-msg").show();
      //     $("#error-msg").text("Only accept image type like JPG, PNG and GIF");
      //     alert("Only accept image type like JPG, PNG and GIF");
      //     return;
      //   }
      //   if (w > 10) {

      //   } else {
      //     $("#error-msg").show();
      //     $("#error-msg").text("Image is too small. Please make sure image is at least 200px in width and more.");
      //   }
      // });
    } else {
      var formData = new FormData();
      formData.append('attachment', file);
      formData.append('options', $("form[action='/upload'] input[name='options']").attr("value"));
      formData.append('t', $("form[action='/upload'] input[name='t']").attr("value"));


      $.ajax({
        url: '/upload',
        type: 'POST',
        headers: { 'X-CSRF-Token': csrf_token },
        data: formData,
        cache: false,
        processData: false,
        contentType: false,
        success: function() { location.reload(); },
        error: function(xhr) {
          var msg = xhr.responseText;
          $("#error-msg").show();
          var msgText = JSON.parse(msg).message;
          $("#error-msg").text(msgText);
          $("#drag-circle").show();
          $("#upload-msg").hide();
          alert(msgText);
        }
      });
    }
    return false;
  };

  function imageDimension(file, fn) {
    var _reader;
    _reader = new FileReader();
    _reader.onload = function(f) {
      var _i = new Image();
      _i.onload = function(e) {
        fn.call(null, e.target.width, e.target.height);
      };
      _i.src = _reader.result;
    };
    _reader.readAsDataURL(file);
  }
});
