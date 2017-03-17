$ ->
  $('.group-user-checkbox').change ->
    index = $(this).attr("id").replace('group_user_groups_attributes_', '').replace('_user_id', '')
    if $(this).is(':checked')
      $("#group_group_users_attributes_#{index}__destroy").attr('value', 0)
    else
      $("#group_group_users_attributes_#{index}__destroy").attr('value', 1)
