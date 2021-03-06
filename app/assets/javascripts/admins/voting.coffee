$ ->
  $('.voting-user-checkbox').change ->
    index = $(this).attr("id").replace('voting_submits_attributes_', '').replace('_user_id', '')
    if $(this).is(':checked')
      $("#voting_submits_attributes_#{index}__destroy").attr('value', 0)
    else
      $("#voting_submits_attributes_#{index}__destroy").attr('value', 1)

  $('#groupUsersClear').change ->
    $('.voting-user-checkbox').prop('checked', false)
    $('.voting-user-checkbox').each (index, checkbox) ->
      $("#voting_submits_attributes_#{index}__destroy").attr('value', 1)

  $('.groups-radio').change ->
    id = $(this).attr("value")
    url = "#{location.protocol}//#{location.host}/admins/groups/#{id}.json"
    $.ajax({
      type: 'GET',
      url: url,
      success: (data) ->
        # チェックボックスとhiddenの初期化
        $('.voting-user-checkbox').prop('checked', false)
        $('.voting-user-checkbox').each (index, checkbox) ->
          $("#voting_submits_attributes_#{index}__destroy").attr('value', 1)

        # 新しいチェックで上書き
        data.forEach (user_id) ->
          $(".voting-user-checkbox[value=#{user_id}]").prop('checked', true)
          index = $(".voting-user-checkbox[value=#{user_id}]").attr('id').replace('voting_submits_attributes_', '').replace('_user_id', '')
          $("#voting_submits_attributes_#{index}__destroy").attr('value', 0)
      error: (data) ->
        alert '通信に失敗しました'
    })
    return false

@add_proposal = ->
  index = $('.proposal').length

  #HACK: テンプレート化何かに移動して一箇所にまとめる。タイミングは入力項目が追加になった時
  $('#proposals').append("
    <div class='proposal'>
      <div class='form-group'>
        <label for='inputTitle' class='col-sm-2 control-label'>タイトル</label>
        <div class='col-sm-10'>
          <input class='form-control' id='inputTitle' type='text' value='' name='voting[proposals_attributes][#{index}][title]' />
        </div>
      </div>
      <div class='form-group'>
        <label for='inputBody' class='col-sm-2 control-label'>内容</label>
        <div class='col-sm-10'>
          <textarea class='form-control' id='inputBody' rows='10' name='voting[proposals_attributes][#{index}][body]'></textarea>
        </div>
      </div>

      <div class='form-group'>
        <div class='col-sm-offset-2 col-sm-10'>
          <div class='checkbox'>
            <label>
              <input name='voting[proposals_attributes][#{index}][_destroy]' type='hidden' value='0' />
              <input type='checkbox' value='1' 
                  name='voting[proposals_attributes][#{index}][_destroy]' 
                  id='voting_proposals_attributes_#{index}__destroy' />
                <label for='voting__destroy'>削除</label>
            </label>
          </div>
        </div>
      </div>
    </div>
  ")
