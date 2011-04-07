require 'spec_helper'

describe Opportunity do
  it "should respond to the column names" do
    opp = Opportunity.new
    opp.should respond_to(:acronym         )
    opp.should respond_to(:program           )
    opp.should respond_to(:department        )
    opp.should respond_to(:agency            )
    opp.should respond_to(:description       )
    opp.should respond_to(:location          )
    opp.should respond_to(:input_opportunity_number   )
    opp.should respond_to(:total_value       )
    opp.should respond_to(:win_probability   )
    opp.should respond_to(:contract_length   )
    opp.should respond_to(:solicitation_type )
    opp.should respond_to(:contract_type     )
    opp.should respond_to(:rfp_release_date  )
    opp.should respond_to(:rfp_due_date      )
    opp.should respond_to(:rfp_expected_due_date)
    opp.should respond_to(:award_date        )
    opp.should respond_to(:prime             )
    opp.should respond_to(:capture_phase     )
    opp.should respond_to(:owner_id          )
    opp.should respond_to(:created_at        )
    opp.should respond_to(:updated_at        )
    opp.should respond_to(:input_status      )
    opp.should respond_to(:acquisition_url   )
    opp.should respond_to(:outcome           )
    opp.should respond_to(:our_value         )
  end
end
