// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require sweetalert
//= require_tree .


$(document).ready(function(){
  $("#myInput").on("keyup", function() {
    var value = $(this).val().toLowerCase();
    $("#myTable tr").filter(function() {
      $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
    });
  });

  $(".numeric").keypress(function (e) {
    if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
      toastr.info('Numbers only allowed!','Information')
      return false;
    }
  });
});

$(document).ready(function(){
  var date_input=$('input[id="date"]'); //our date input has the name "date"
  var container=$('.bootstrap-iso form').length>0 ? $('.bootstrap-iso form').parent() : "body";
  var options={
    format: 'dd-mm-yyyy',
    container: container,
    todayHighlight: true,
    autoclose: true,
  };
  date_input.datepicker(options);
});

$(document).ready(function(){
  $(".checkempid").blur(function(){
    var value = $(this).val();
    $.ajax({
      type: 'get',
      url: '/cemp',
      data: {empid : value},
      dataType: 'json',
      success : function(response){
        if (response == 1){
          toastr.error('Employee ID already exist, Please enter a unique ID!', 'Error')
          $('.checkempid').css('border', '1px solid red')
          $('.checkempid').val('');
          $('.checkempid').focus();
        } else {
          $('.checkempid').css('border', '1px solid green')
        }
      }
    });
  });
});

function deleteemp(id){
  swal({
    title: "Are you sure you want to delete user account?",
    text: "If you are sure, type in your password:",
    type: "input",
    inputType: "password",
    showCancelButton: true,
    closeOnConfirm: false,
    showLoaderOnConfirm: true
  }, function(password) {
    if (password === "") {
      swal.showInputError("You need to type in your password in order to do this!");
      return false;
    }
    $.ajax({
      type: 'get',
      url: '/check_pass',
      data : {password: password},
      dataType: 'json',
      success : function(response){
        if (response == 1){
          setTimeout(function () {
            confirmdelete(id)
          }, 2000);
        } else {
          swal.showInputError("Your password is wrong!");
          return false;
        }
      }
    });
  });
}

function deactive(id, status){
  if (status == 1){
    stat = "deactive"
  } else {
    stat = "active"
  }
  swal({
    title: "Are you sure you want to " + stat + " user account?",
    text: "If you are sure, type in your password:",
    type: "input",
    inputType: "password",
    showCancelButton: true,
    closeOnConfirm: false,
    showLoaderOnConfirm: true
  }, function(password) {
    if (password === "") {
      swal.showInputError("You need to type in your password in order to do this!");
      return false;
    }
    $.ajax({
      type: 'get',
      url: '/check_pass',
      data : {password: password},
      dataType: 'json',
      success : function(response){
        if (response == 1){
          setTimeout(function () {
            confirmstatus(id, status)
          }, 2000);
        } else {
          swal.showInputError("Your password is wrong!");
          return false;
        }
      }
    });
  });
}

function confirmdelete(id){
  $.ajax({
    type: 'get',
    url: '/delemp',
    data : {id: id},
    dataType: 'json',
    success : function(response){
      if (response == 1){
        swal({
          title: 'Success',
          text: 'User account has been successfully deleted!',
          type: 'success'
        }, function(){
          location.reload();
        });
      }
    }
  });
}

function confirmstatus(id, status){
  $.ajax({
    type: 'get',
    url: '/accdeact',
    data : {id: id, status: status},
    dataType: 'json',
    success : function(response){
      if (response == 0){
        swal({
          title: 'Success',
          text: 'User account has been successfully activated!',
          type: 'success'
        }, function(){
          location.reload();
        });
        //swal('Success', 'User account has been successfully activated!', 'success');
      } else {
        swal({
          title: 'Success',
          text: 'User account has been successfully deactivated!',
          type: 'success'
        }, function(){
          location.reload();
        });
      }
    }
  });
}

$( document ).ready(function() {
  var countryval = 0;
  var stateval = 0;
  var districtval = 0;
  var talukval = 0;
  var pincodeval = 0;
  var maincatval = 0;
  var subcatval = 0;

  $('.country').on('change', function() {
    countryval = this.value;
    $("select.state").empty();
    $.ajax({
      type : 'get',
      url : "/find_state",
      data : {country: countryval},
      dataType : 'json',
      async : false,
      context : document.body,
      success : function(response){
        $("<option value=0>Select State...</option>").appendTo("select.state")
        if (response != ""){
          $.each(response, function(i, j) {
            row = "<option value=\"" + j.id + "\">" + j.state_name + "</option>";
            $(row).appendTo("select.state");
          });
        } else {
          toastr.info('No States are found!','Information')
        }
      }
    });
  });

  $('.state').on('change', function() {
    stateval = this.value;
    $("select.district").empty();
    $.ajax({
      type : 'get',
      url : "/find_district",
      data : {state: stateval},
      dataType : 'json',
      async : false,
      context : document.body,
      success : function(response){
        $("<option value=0>Select District...</option>").appendTo("select.district")
        if (response != ""){
          $.each(response, function(i, j) {
            row = "<option value=\"" + j.id + "\">" + j.district_name + "</option>";
            $(row).appendTo("select.district");
          });
        } else {
          toastr.info('No Districts are found!','Information')
        }
      }
    });
  });

  $('.district').on('change', function() {
    districtval = this.value;
    $("select.taluk").empty();
    $.ajax({
      type : 'get',
      url : "/find_taluk",
      data : {district: districtval},
      dataType : 'json',
      async : false,
      context : document.body,
      success : function(response){
        $("<option value=0>Select Taluk...</option>").appendTo("select.taluk")
        if (response != ""){
          $.each(response, function(i, j) {
            row = "<option value=\"" + j.id + "\">" + j.taluk_name + "</option>";
            $(row).appendTo("select.taluk");
          });
        } else {
          toastr.info('No Talukas are found!','Information')
        }
      }
    });
  });

  $('.taluk').on('change', function() {
    talukval = this.value;
    $("select.pincode").empty();
    $.ajax({
      type : 'get',
      url : "/find_pincode",
      data : {taluk: talukval},
      dataType : 'json',
      async : false,
      context : document.body,
      success : function(response){
        $("<option value=0>Select Pincode...</option>").appendTo("select.pincode")
        if (response != ""){
          $.each(response, function(i, j) {
            row = "<option value=\"" + j.id + "\">" + j.pincode + "</option>";
            $(row).appendTo("select.pincode");
          });
        } else {
          toastr.info('No pincodes are found!','Information')
        }
      }
    });
  });

  $('.pincode').on('change', function() {
    pincodeval = this.value;
    $("select.village").empty();
    $.ajax({
      type : 'get',
      url : "/find_village",
      data : {pin: this.value, talid: talukval},
      dataType : 'json',
      async : false,
      context : document.body,
      success : function(response){
        $("<option value=0>Select Village...</option>").appendTo("select.village")
        if (response != ""){
          $.each(response, function(i, j) {
            row = "<option value=\"" + j.id + "\">" + j.village_name + "</option>";
            $(row).appendTo("select.village");
          });
        } else {
          toastr.info('No villages are found!','Information')
        }
      }
    });
  });

  $('.category').on('change', function(){
    maincatval = this.value;
    $("select.subcat").empty();
    $.ajax({
      type: 'get',
      url: '/find_subcat',
      data: {catid : this.value},
      dataType: 'json',
      async: false,
      context : document.body,
      success : function(response){
        $("<option value=0>Select Sub-Category...</option>").appendTo("select.subcat")
        if (response != ""){
          $.each(response, function(i, j){
            row = "<option value=\"" + j.id + "\">" + j.cat_name + "</option>";
            $(row).appendTo('select.subcat')
          })
        } else {
          toastr.info('No sub-categories are found!','Information')
        }
      }
    })
  })

  $('.addform').on('click', function(){
    var error = 0;
    if (countryval == '0'){
      error = 1
      $('select.country').focus();
      toastr.error("Country can't be blank!", 'Error');
    } else if (countryval != '0' && stateval == '0'){
      error = 1
      $('select.state').focus();
      toastr.error("State can't be blank!", 'Error');
    } else if (countryval != '0' && stateval != '0' && districtval == '0'){
      error = 1
      $('select.district').focus();
      toastr.error("District can't be blank!", 'Error');
    } else if (countryval != '0' && stateval != '0' && districtval != '0' && talukval == '0'){
      error = 1
      $('select.taluk').focus();
      toastr.error("Taluk can't be blank!", 'Error');
    } else if (countryval != '0' && stateval != '0' && districtval != '0' && talukval != '0' && pincodeval == '0'){
      error = 1
      $('select.pincode').focus();
      toastr.error("Pincode can't be blank!", 'Error');
    } else if (countryval != '0' && stateval != '0' && districtval != '0' && talukval != '0' && pincodeval != '0' && maincatval == '0'){
      error = 1
      $('select.category').focus();
      toastr.error("Category can't be blank!", 'Error');
    } else {

    }

    if (error) {
      return false;
    } else {
      //return true;
    }
  });
});

/*$(document).ready(function(){
  $('.addform').on('click', function(){
    var error = 0;
    var country = $('.country').val();
    var state = $('.state').val();
    var district = $('.district').val();
    var taluk = $('.taluk').val();
    var pincode = $('.pincode').val();
    var maincat = $('.category').val();
    var subcat = $('.subcat').val();

    alert(country)
    if (country == '0'){
      error = 1
      $('select.country').focus();
      toastr.error("Country can't be blank!", 'Error');
    } else if (country != '0' && state == '0'){
      error = 1
      $('select.state').focus();
      toastr.error("State can't be blank!", 'Error');
    } else if (country != '0' && state != '0' && district == '0'){
      error = 1
      $('select.district').focus();
      toastr.error("District can't be blank!", 'Error');
    } else if (country != '0' && state != '0' && district != '0' && taluk == '0'){
      error = 1
      $('select.taluk').focus();
      toastr.error("Taluk can't be blank!", 'Error');
    } else if (country != '0' && state != '0' && district != '0' && taluk != '0' && pincode == '0'){
      error = 1
      $('select.pincode').focus();
      toastr.error("Pincode can't be blank!", 'Error');
    } else if (country != '0' && state != '0' && district != '0' && taluk != '0' && pincode != '0' && maincat == '0'){
      error = 1
      $('select.category').focus();
      toastr.error("Category can't be blank!", 'Error');
    } else if (country != '0' && state != '0' && city != '0' && pincode != '0' && maincat != '0' && subcat == '0'){
      error = 1
      swal('', 'Please select a Sub-Category.', 'error');
    }

    if (error) {
      return false;
    } else {
      return true;
    }
  });
});*/

$(document).ready(function(){
  $("#entcat").bind('change', function(){
    if ($(this).val() == 1){
      $("#xlssheet").hide();
      $("#textplain").show();
      $('#addform').attr("disabled", false);
      $('#addressentry').focus();      
    } else if ($(this).val() == 2){
      $("#textplain").hide();
      $('#xlssheet').show();
      $('#addform').attr("disabled", false);
    } else {
      $("#xlssheet").hide();
      $("#textplain").hide();
      $('#addform').attr("disabled", true);
    }
  });
});