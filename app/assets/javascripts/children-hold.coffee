# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
 $('#child_group_id').parent().hide()
 groups = $('#child_group_id').html()
 $('#child_location_id').change ->
 	location = $('child_location_id :selected').text
 	escaped_location = location.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
 	options = $(groups).filter("optgroup[label='#{location}']").html()
 	if options
 		$('#child_group_id').html(options)
 		$('#child_group_id').parent().show()
 	else
 		$('#child_group_id').empty()
 		$('#child_group_id').parent().hide()	
