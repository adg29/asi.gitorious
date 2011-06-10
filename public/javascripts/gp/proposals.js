/* Proposal wizard state control functions*/

function step_1_setup(){
  $('#gp_step_1').removeClass('gp_step_hide');
  $('#gp_step_2').addClass('gp_step_hide');

  $('#proposal_terms_accepted').change( function(){
    check_terms_update_step_1_button( $(this) );
  });
}

function step_2_setup(){
  if( $('#proposal_terms_accepted').attr( 'checked' ) ){
    $('#gp_step_1').addClass('gp_step_hide');
    $('#gp_step_2').removeClass('gp_step_hide');
  }
  $('#gp_step_1_back').click( function(){
    step_1_setup();
  });

  window.scrollTo(0,0);
}

function check_terms_update_step_1_button( terms_check ){
    if( terms_check.attr('checked') ){
      $('#proposal_step_button_1')
        .removeClass('disabled')
        .removeAttr('disabled');
    }else{
      $('#proposal_step_button_1')
        .addClass('disabled')
        .attr('disabled','disabled');
    }
}

$(function(){
  // ensure state is preserved on page refresh
  check_terms_update_step_1_button( $('#proposal_terms_accepted') );
  step_1_setup(); // default state

  // state update to step 2 of wizard
  $('#proposal_step_button_1').click( function(){
    step_2_setup();
  });
  
});

/*
  Backbone.js code yet to be integrated
*/
/*
var App = {
  Views: {},
  Controllers: {},
  init: function() {
    new App.Controllers.Proposals();
    Backbone.history.start();
  }
};

var Proposal = Backbone.Model.extend({
  url: function() {
    var base = 'proposals';
    if (this.isNew()) return base; // post to /proposals for CREATE
    return base + (base.charAt(base.length - 1) == '/' ? '' : '/') + this.id; // post to /proposals/id for UPDATE
  }
});

App.Views.Index = Backbone.View.extend({
  initialize: function() {
    this.proposals = this.options.proposals;
    this.render();
  },

  render: function() {
    if(this.proposals.length > 0) {
      var out = "<h3><a href='#new'>Create New</a></h3><ul>";
      _(this.proposals).each(function(item) {
        out += "<li><a href='#proposals/" + item.id + "'>" + item.escape('title') + "</a></li>";
      });
      out += "</ul>";
    } else {
      out = "<h3>No proposals! <a href='#new'>Create one</a></h3>";
    }
    $(this.el).html(out);
*/
