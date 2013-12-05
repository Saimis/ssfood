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
//= require jquery.turbolinks
//= require_tree .

var area_val = null;
var isWinnerSet = false;
$(document).ready(function(){

  
  var endtime = $("#countdown").data("end");
 
 $("#countdown").countdown({until: new Date(endtime)/*, onExpiry: liftOff */, compact: true,  format: 'HMs'});
  
  
  $("#food").focus(function() {
    area_val = $(this).val();
  });
  $("#food").blur(function() {
    saveFood();
  });
  
  $(".copy").click(function(event) {
    
    
    event.stopPropagation();
       
    var friends_food = $(this).parent().parent().find(".food").text();
    
    if(friends_food.length > 0) {
      if($("#food").val().length > 0){
	if (confirm("Kopijuoti?")) {
	  $("#food").val(friends_food);
	}   
      } else {
	$("#food").val(friends_food);
      }
    } else {
      alert("Dude c'mon....");
      return;
    }
       
    saveFood();
  });
  
  $(".user_name_activefield").click(function(){
    console.log($(this).parent().parent().find("#food").val());
    if($(this).parent().parent().find(".food").text().length == 0) {
      console.log("shit");
      $(this).parent().parent().css({
	"background": "red",
	"color": "#fff"
      });
      return;
    }
      
    var x = $(this).parent().parent().css('backgroundColor');
     if(x != "rgb(39, 174, 96)") {
      $(this).parent().parent().css({
	"background": "#27ae60",
	"color": "#fff"
      });
    } else {
      $(this).parent().parent().css({
	"background": "#ecf0f1",
	"color": "#96846c"
      });
    }
    
  });
  
 
  
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
 alert("Laikas baigesi!"); 
}

function addmsg(msg){
  jQuery.each(msg, function(i, item) {
    $("#uf_" + item.id).html("<span>" + item.food + "</span>");
    if(item.food.length > 0) {
     $("#usr_" + item.id).find(".user_name").css("background","#97ce68");
    } else {
      $("#usr_" + item.id).find(".user_name").css("background","#6bcbca");
    }
    
    if(item.voted) {
      $("#usr_" + item.id).find(".voted").show();
    }
  });     
}
function addvotes(msg) {
  jQuery.each(msg, function(i, item) {
    $("#rest_" + item.id).children().find(".vote_bar").css("height",item.votes + "0px");
    $("#rest_" + item.id).children().find(".votes").html(item.votes);
  });  
}
function setwinner(msg) {
  if(isWinnerSet == false && msg.id != null) {
      console.log(msg.id);
      isWinnerSet = true;
      
      $("#rest_" + msg.id).children().find(".winner_image").css("display","block");
      $("#countdown").hide();
      $(".vote_button").css("display","none");
      $("#restaurants_holder").children(".shadow_box").each(function(){
	if($(this).attr("id") != "rest_" + msg.id) {
	  $(this).css("opacity","0.3");
	}
      });
  
  }
 
}

function parseInfo(type, msg) {
  addmsg(msg.users);
  addvotes(msg.restaurants);
  setwinner(msg.winner);
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
