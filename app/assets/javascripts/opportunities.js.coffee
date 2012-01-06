jQuery ->
    $("#opportunity_outcome").change ->
        if @value
            $("#opportunity_outcome_text_input").show()
        else
            $("#opportunity_outcome_text_input").hide()

    if $("#opportunity_outcome").val()
        $("#opportunity_outcome_text_input").show()
    else
        $("#opportunity_outcome_text_input").hide()

