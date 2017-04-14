# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


$(document).ready ->
  $('#contact-table').dataTable
    'ordering': true
    'info': true
    'columns': [
      { 'orderDataType': 'dom-text-numeric' }
      { 'orderDataType': 'dom-text-numeric' }
      { 'orderDataType': 'dom-text-numeric' }
      { 'orderDataType': 'dom-text-numeric' }
      { 'orderDataType': 'dom-text-numeric' }
      { 'orderDataType': 'dom-text-numeric' }
    ]
  return
