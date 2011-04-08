require 'spec_helper'

describe Opportunity do
  it "should respond to the column names" do
    opp = Opportunity.new
    opp.should respond_to(:acronym         )
    opp.should respond_to(:program           )
    opp.should respond_to(:department        )
    opp.should respond_to(:description       )
    opp.should respond_to(:location          )
    opp.should respond_to(:input_opportunity_number   )
    opp.should respond_to(:agency            )
    opp.should respond_to(:win_probability   )
    opp.should respond_to(:total_value       )
    opp.should respond_to(:contract_length   )
    opp.should respond_to(:solicitation_type )
    opp.should respond_to(:contract_type     )
    opp.should respond_to(:rfp_release_date  )
    opp.should respond_to(:rfp_due_date      )
    opp.should respond_to(:rfp_expected_due_date)
    opp.should respond_to(:award_date        )
    opp.should respond_to(:prime             )
    opp.should respond_to(:capture_phase     )
    opp.should respond_to(:business_developer_id          )
    opp.should respond_to(:capture_manager_id          )
    opp.should respond_to(:created_at        )
    opp.should respond_to(:updated_at        )
    opp.should respond_to(:input_status      )
    opp.should respond_to(:acquisition_url   )
    opp.should respond_to(:outcome           )
    opp.should respond_to(:our_value         )
  end
  
  context "searching" do
    
    it "responds to search" do
      Opportunity.should respond_to(:search)
    end

    it "takes a search parameter" do
      opp = Opportunity.search('text')
      opp.should be_empty
    end
    
    it "returns everything with a blank string" do
      opp = Factory(:opportunity, :input_opportunity_number => 1234)
      opp2 = Factory(:opportunity, :input_opportunity_number => 2345)
      opp3 = Factory(:opportunity, :input_opportunity_number => 1111)
      opps = Opportunity.search("")
      opps.should include(opp)
      opps.should include(opp2)
      opps.should include(opp3)
    end

    context "finds an opportunity" do
      it "with an input opportunity number" do
        opp = Factory(:opportunity, :input_opportunity_number => 1234)
        Opportunity.search(1234).should == [opp]
      end
      
      it "with a given string in the acronym" do
        opp = Factory(:opportunity, :acronym => 'TESTING')
        Opportunity.search('TEST').should == [opp]
      end
      
      it "with a given string in the acronym - case-insensitive" do
        opp = Factory(:opportunity, :acronym => 'TESTING')
        Opportunity.search('test').should == [opp]
      end

      it "with a given string in the program" do
        opp = Factory(:opportunity, :program => 'TESTING')
        Opportunity.search('TEST').should == [opp]
      end
      
      it "with a given string in the program - case-insensitive" do
        opp = Factory(:opportunity, :program => 'TESTING')
        Opportunity.search('test').should == [opp]
      end
      
    end
    
    context "finds only the right opportunity" do
      it "with a given input opportunity number" do
        opp = Factory(:opportunity, :input_opportunity_number => 1234)
        opp2 = Factory(:opportunity, :input_opportunity_number => 2345)
        opp3 = Factory(:opportunity, :input_opportunity_number => 1111)
        Opportunity.search(2345).should == [opp2]
      end

      it "with a given string in the acronym" do
        opp = Factory(:opportunity, :acronym => 'TEST')
        Factory(:opportunity, :acronym => 'HELLO')
        Factory(:opportunity, :acronym => 'HELLO2')
        Opportunity.search('TEST').should == [opp]
      end
      
      it "with a given string in the acronym - case-insensitive" do
        opp = Factory(:opportunity, :acronym => 'TESTING')
        Factory(:opportunity, :acronym => 'HELLO')
        Factory(:opportunity, :acronym => 'HELLO2')
        Opportunity.search('test').should == [opp]
      end

      it "with a given string in the program" do
        opp = Factory(:opportunity, :program => 'TEST')
        Factory(:opportunity, :program => 'HELLO')
        Factory(:opportunity, :program => 'HELLO2')
        Opportunity.search('TEST').should == [opp]
      end
      
      it "with a given string in the program - case-insensitive" do
        opp = Factory(:opportunity, :program => 'TESTING')
        Factory(:opportunity, :program => 'HELLO')
        Factory(:opportunity, :program => 'HELLO2')
        Opportunity.search('test').should == [opp]
      end

    end

    context "finds multiple opportunities" do
      it "with a given string in the acronym" do
        opp = Factory(:opportunity, :acronym => 'TESTING')
        opp2 = Factory(:opportunity, :acronym => 'This TEST')
        opp3 = Factory(:opportunity, :acronym => 'HELLO2')
        opps = Opportunity.search('TEST')
        opps.should include(opp)
        opps.should include(opp2)
      end

      it "and only the right opportunities" do
        opp = Factory(:opportunity, :acronym => 'TESTING')
        opp2 = Factory(:opportunity, :acronym => 'This TEST')
        opp3 = Factory(:opportunity, :acronym => 'HELLO2')
        opps = Opportunity.search('TEST')
        opps.should_not include(opp3)
      end

      it "with a given string in the program" do
        opp = Factory(:opportunity, :program => 'TESTING')
        opp2 = Factory(:opportunity, :program => 'This TEST')
        opp3 = Factory(:opportunity, :program => 'HELLO2')
        opps = Opportunity.search('TEST')
        opps.should include(opp)
        opps.should include(opp2)
      end

      it "and only the right opportunities" do
        opp = Factory(:opportunity, :program => 'TESTING')
        opp2 = Factory(:opportunity, :program => 'This TEST')
        opp3 = Factory(:opportunity, :program => 'HELLO2')
        opps = Opportunity.search('TEST')
        opps.should_not include(opp3)
      end

    end
  end
  
end
