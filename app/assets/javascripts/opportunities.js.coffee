jQuery ->
    $("#opportunity_outcome").change ->
        if @value
            $("#opportunity_outcome_text_div").show()
        else
            $("#opportunity_outcome_text_div").hide()

    $("#calendar_order_by input:radio").click ->
          $("#calendar_order_by").submit()

    if $("#opportunity_outcome").val()
        $("#opportunity_outcome_text_div").show()
    else
        $("#opportunity_outcome_text_div").hide()

