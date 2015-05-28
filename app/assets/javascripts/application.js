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

var form_timout;
var isWinnerSet = false;
var startPolling = true;
var historyIsSet = false;
var popupLoaded = false;
$(document).ready(function(){
  $(document).click(function(e) {
    if (!$(e.target).is(".history") && !$(e.target).is(".f_history_item")) {
      if($(".histbox").is(":visible")) {
        $(".histbox").hide();
      }
    }
  });

  var endtime = $("#countdown").data("end");
  var endtime_food = $("#countdown_food").data("end");
  $("#countdown").countdown({until: new Date(endtime)/*, onExpiry: liftOff */, compact: true,  format: 'HMs'});
  $("#countdown_food").countdown({until: new Date(endtime_food), onExpiry: hideFoodTimer , compact: true,  format: 'HMs'});

  $("#food").blur(function() {
    saveFood();
  });
  $("#food").keyup(function() {
    if(form_timout != null) {
      clearTimeout(form_timout);
    }
    form_timout = setTimeout(function() {
      clearTimeout(form_timout);
      saveFood();
    }, 2000);
  });

  $(".history").click(function(event) {
    if($(".histbox").is(":visible")) {
      $(".histbox").hide();
    } else {
      $(".histbox").show();
    }
  });

  $(".histbox").on('click', 'li', function(){
    $("#food").val($(this).text());
    $(".histbox").hide();
    saveFood();
  });

  $(".copy").click(function(event) {

    if($(this).parent().parent().find("#food").length > 0){
      return;
    }
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
      alert("Empty? Dude c'mon....");
      return;
    }

    saveFood();
  });

  $(".user_name_activefield").click(function(){
    if($(this).parent().parent().find(".food").text().length == 0) {
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
  $(".force_round_end").click(function(event) {
    if (confirm("You fokin serial, mate?")) {
      $.ajax({
        url : 'force_round_end',
        type: "POST",
        data : {force_end_round: true},
        success:function(data, textStatus, jqXHR) {
          roundEnd();
        },
        error: function(jqXHR, textStatus, errorThrown) {
          console.log("Some shitty error occured...");
        }
      });
    }
  });

  if(startPolling){
    waitForMsg();
    startPolling = false;
  }
});


function hideFoodTimer() {
  $("#countdown_food").hide();
}

function saveFood(){
  $("#food_form").submit(function(e) {
    var postData = $("#food_form").serializeArray();
    var formURL = $("#food_form").attr("action");
    $.ajax(
    {
      url : formURL,
      type: "POST",
      data : postData,
      success:function(data, textStatus, jqXHR) {
        console.log("Saved!");
      },
      error: function(jqXHR, textStatus, errorThrown) {
        console.log("Some shitty error occured...");
      }
    });
    e.preventDefault();
  });
  $("#food_form").submit();
}


function addmsg(msg){
  jQuery.each(msg, function(i, item) {
    if(item.food != null && item.food.length > 0) {
     $("#usr_" + item.user_id).find(".user_name").css("background","#97ce68");
     $("#uf_" + item.user_id).html("<span>" + item.food + "</span>");
    } else {
      $("#usr_" + item.user_id).find(".user_name").css("background","#6bcbca");
      $("#uf_" + item.user_id).html("");
    }

    if(item.voted != null && item.voted.length > 0) {
      $("#usr_" + item.user_id).find(".voted").show();
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
    isWinnerSet = true;

    $("#rest_" + msg.id).children().find(".winner_image").css("display","block");
    $("#countdown").hide();
    $(".vote_button").css("display","none");
    $("#user_holder").css("display","block");
    $(".force_round_end").show();
    $("#countdown_food").css("display","block");
    $("#restaurants_holder").children(".shadow_box").each(function(){
      if($(this).attr("id") != "rest_" + msg.id) {
        $(this).css("opacity","0.3");
      }
    });
  }
}
function appendHistory(msg) {
  if(!historyIsSet) {

    var foodHistoryList = "<ul>";
    jQuery.each(msg, function(i, item) {
      if(item.food != null) {
        foodHistoryList += '<li>' + item.food + '</li>';
      }
    });
    foodHistoryList += "</ul>";
    $(".histbox").html(foodHistoryList);
    $(".history").show();
    historyIsSet = true;
  }
}

function parseInfo(msg) {
  addmsg(msg.users);
  addvotes(msg.restaurants);
  if(msg.winner.id != null) {
    setwinner(msg.winner);
  }
  if(msg.food_history.length > 0) {
    appendHistory(msg.food_history);
  }
  if(msg.round_end == 1) {
    roundEnd();
  }
}

function waitForMsg(){
  $.ajax({
      type: "GET",
      url: "get_data.json",

      async: true,
      cache: false,
      timeout:50000,

      success: function(data){
        parseInfo(data);
        setTimeout(
            waitForMsg,
            5000
        );
      },
      error: function(XMLHttpRequest, textStatus, errorThrown){
        addmsg("error", textStatus + " (" + errorThrown + ")");
        setTimeout(
            waitForMsg,
            15000
        );
      }
  });
};

function roundEnd() {
  if(!$("#caller_popup").is(":visible") && !popupLoaded) {
    $("#caller_popup").load("callerpopup #it");
    $("#caller_popup").show();
    popupLoaded = true;
  }
  hideFoodTimer();

  if($('#food').length) {
    $('#food').attr('disabled', true);
  }
}
