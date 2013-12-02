// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
var area_val = null;
$(document).ready(function(){
  
  
  $("#food").focus(function() {
    area_val = $(this).val();
  });
  $("#food").blur(function() {
    saveFood();
  });
  
  $(".copy").click(function() {
    if($("#food").val().length > 0){
      if (confirm("Kopijuoti?")) {
	$("#food").val($(this).parent().parent().find(".food").text());
      }   
    } else {
      $("#food").val($(this).parent().parent().find(".food").text());
    }
   
    saveFood();
  });
 var sdate = $("#countdown").data("stime");
 var edate = $("#countdown").data("etime");
 console.log("START " + sdate + " END TIME " + edate);
  $("#countdown").countdown({until: new Date("11/30/2013 1:30:00"), onExpiry: liftOff , compact: true,  format: 'HMs'});
  waitForMsg(); // Start the inital request 
});
function saveFood(){
 if(area_val != $("#food").val()) {
      $("#food_form").submit(function(e) {
	var postData = $("#food_form").serializeArray();
	var formURL = $("#food_form").attr("action");
	$.ajax(
	{
	    url : formURL,
	    type: "POST",
	    data : postData,
	    success:function(data, textStatus, jqXHR) 
	    {
		
	    },
	    error: function(jqXHR, textStatus, errorThrown) 
	    {
		
	    }
	});
	e.preventDefault(); //STOP default action
      });

      $("#food_form").submit();
    } 
}
function liftOff() {
 alert("well shit"); 
}

function addmsg(msg){
  jQuery.each(msg, function(i, item) {
    $("#uf_" + item.id).html(item.food);
    if(item.food.length > 0) {
     $("#u_" + item.id).css("background","#97ce68");
    } else {
      $("#u_" + item.id).css("background","#6bcbca");
    }
    
    if(item.voted) {
      $("#uv_" + item.id).show();
    }
  });     
}
function addvotes(msg) {
  jQuery.each(msg, function(i, item) {
    $("#r_" + item.id).css("height",item.votes + "0px");
    
  });  
}
function setwinner(msg) {
 console.log(msg.id);
}

function parseInfo(type, msg) {
  addmsg(msg.users);
  addvotes(msg.restaurants);
  //setwinner(msg.winner);
}

function waitForMsg(){
  $.ajax({
      type: "GET",
      url: "getData.json",

      async: true,
      cache: false,
      timeout:50000,

      success: function(data){ 
	  parseInfo("new", data);
	  setTimeout(
	      waitForMsg,
	      5000
	  );
      },
      error: function(XMLHttpRequest, textStatus, errorThrown){
	  addmsg("error", textStatus + " (" + errorThrown + ")");
	  setTimeout(
	      waitForMsg, 
	      15000);  
      }
  });
};
