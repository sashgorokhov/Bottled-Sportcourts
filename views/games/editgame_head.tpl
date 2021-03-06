<script src="/view/js/jquery.chained.js"></script>

<script type="text/javascript">
  $(document).on('click', '#inviteoldbutton', function() {
    $.ajax({
      url: '/games/notify/{{game.game_id()}}',
      data: {},
      async: true,
      success: function (responseData, textStatus) {
        data = jQuery.parseJSON(responseData);
        count = data['count'];
        list = data['users'];
        for (var i = 0; i < count; i++) {
          $('#invitelistTable').append('<tr class="success"><td>'+list[i][0]+'</td><td>'+list[i][1]+'</td></tr>');
        };
        $('#invitelistCount').html(count);
        $('#invitelistModal').modal('show');
      },
      error: function (response, status, errorThrown) {
        alert('Все плохо, расскажите нам про эту ошибку \n\r\n\r' + response + status + errorThrown);
      },
      type: "GET",
      dataType: "text"
    });
  });

  $(function () {
    $("#game_add_slider2").slider({
      value: {{game.duration()}},
      min: 30,
      max: 600,
      step: 10,
      slide: function (event, ui) {
          $("#game_add_long_visible").val(ui.value + " минут");
          $("#game_add_long").val(ui.value);
      }
    });
    $("#game_add_long_visible").val($("#game_add_slider2").slider("value") + " минут");
    $("#game_add_long").val($("#game_add_slider2").slider("value"));
  });

  $(function () {
    $("#game_add_slider").slider({
      value: {{game.cost()}},
      min: 0,
      max: 400,
      step: 5,
      slide: function (event, ui) {
        $("#game_add_amount_visible").val(ui.value + " руб.");
        $("#game_add_amount").val(ui.value);
      }
    });
    $("#game_add_amount_visible").val($("#game_add_slider").slider("value") + " руб.");
    $("#game_add_amount").val($("#game_add_slider").slider("value"));
  });

  $(function () {
    $("#game_add_slider1").slider({
      value: {{game.capacity() if game.capacity()>0 else 8}},
      min: 8,
      max: 40,
      step: 1,
      slide: function (event, ui) {
        $("#game_add_count_visible").val(ui.value);
        $("#game_add_count").val(ui.value);
      }
    });
    $("#game_add_count_visible").val($("#game_add_slider1").slider("value"));
    $("#game_add_count").val($("#game_add_slider1").slider("value"));
    % if game.capacity() < 0:
      $("#game_add_count_visible").val("");
      $("#game_add_slider1").slider( "disable" );
    % end
  });


  function showOrHide() {
    if($("#unlimit").is(":checked")){ 
      $("#game_add_count").val("-1");
      $("#game_add_slider1").slider( "disable" );
      $("#game_add_count_visible").val("");
    }else{ 
      $("#game_add_slider1").slider( "enable" );
      $("#game_add_count_visible").val($("#game_add_slider1").slider("value"));
      $("#game_add_count").val($("#game_add_slider1").slider("value"));
    } 
  };

  $("#court").chained("#city");
</script>