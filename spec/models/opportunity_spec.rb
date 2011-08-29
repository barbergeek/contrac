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
  
  context "owning" do
    it "lets anyone own an opportunity" do
      opp = Factory(:opportunity)
      user = Factory(:user)
      opp.own(user)
      opp.should be_owned_by(user)
    end
    
    it "sets a bd user as the business developer" do
      opp = Factory(:opportunity)
      user = Factory(:user, :roles => ["business_developer"])
      opp.own(user)
      opp.business_developer.should == user
    end
    
    it "sets a capture user as the capture manager" do
      opp = Factory(:opportunity)
      user = Factory(:user, :roles => ["capture_manager"])
      opp.own(user)
      opp.capture_manager.should == user
    end
    
    it "sets a general user as the capture manager" do
      opp = Factory(:opportunity)
      user = Factory(:user)
      opp.own(user)
      opp.capture_manager.should == user
    end
  end
  
  context "watching" do
    it "lets anyone watch an opportunity" do
      opp = Factory(:opportunity)
      user = Factory(:user)
      opp.should_not be_watched_by(user)
      opp.watch(user)
      opp.should be_watched_by(user)
    end
    
    it "lets anyone unwatch an opportunity" do
      opp = Factory(:opportunity)
      user = Factory(:user)
      opp.watch(user)
      opp.unwatch(user)
      opp.should_not be_watched_by(user)
    end
    
    it "lets you toggle watching an opportunity" do
      opp = Factory(:opportunity)
      user = Factory(:user)
      opp.should_not be_watched_by(user)
      opp.toggle_watch(user)
      opp.should be_watched_by(user)
      opp.toggle_watch(user)
      opp.should_not be_watched_by(user)
    end
    
    it "should not change bd or capture manager ownership" do
      opp = Factory(:opportunity)
      user = Factory(:user)
      bd_user = Factory(:user, :roles => ["business_developer"])
      cm_user = Factory(:user, :roles => ["capture_manager"])
      opp.business_developer = bd_user
      opp.capture_manager = cm_user
      opp.watch(user)
      opp.business_developer.should == bd_user
      opp.capture_manager.should == cm_user
    end
    
  end
  
  context "own_or_watch" do
    it "sets a capture manager as the capture manager if there isn't one already" do
      opp = Factory(:opportunity)
      user = Factory(:user, :roles => ["capture_manager"])
      opp.capture_manager.should be_nil
      opp.own_or_watch(user)
      opp.capture_manager.should == user
    end

    it "sets a capture manager as a watcher if there is a capture manager" do
      opp = Factory(:opportunity)
      user = Factory(:user, :roles => ["capture_manager"])
      user2 = Factory(:user, :roles => ["capture_manager"])
      opp.capture_manager = user
      opp.own_or_watch(user2)
      opp.capture_manager.should == user
      opp.should be_watched_by(user2)
    end

    it "sets a business developer as the business developer if there isn't one already" do
      opp = Factory(:opportunity)
      user = Factory(:user, :roles => ["business_developer"])
      opp.business_developer.should be_nil
      opp.own_or_watch(user)
      opp.business_developer.should == user
    end

    it "sets a business developer as a watcher if there is a business developer" do
      opp = Factory(:opportunity)
      user = Factory(:user, :roles => ["business_developer"])
      user2 = Factory(:user, :roles => ["business_developer"])
      opp.business_developer = user
      opp.own_or_watch(user2)
      opp.business_developer.should == user
      opp.should be_watched_by(user2)
    end

    it "sets a general user as a watcher, even if there aren't capture managers or business developers" do
      opp = Factory(:opportunity)
      user = Factory(:user)
      opp.capture_manager.should be_nil
      opp.business_developer.should be_nil
      opp.own_or_watch(user)
      opp.capture_manager.should be_nil
      opp.business_developer.should be_nil
      opp.should be_watched_by(user)
    end

  end

  context "ignoring" do
    it "should ignore 'destroy'ed records" do
      opp = Factory(:opportunity)
      id = opp.id
      opps = Opportunity.find_by_id(id)
      opps.should == opp
      opp.destroy
      opps = Opportunity.find_by_id(id)
      opps.should_not == opp
    end
  end
end

# == Schema Information
#
# Table name: opportunities
#
#  id                       :integer         not null, primary key
#  acronym                  :string(255)
#  program                  :string(255)
#  department               :string(255)
#  agency                   :string(255)
#  description              :text
#  location                 :string(255)
#  input_opportunity_number :integer
#  total_value              :integer
#  win_probability          :integer
#  contract_length          :string(255)
#  solicitation_type        :string(255)
#  contract_type            :string(255)
#  rfp_release_date         :date
#  rfp_due_date             :date
#  award_date               :date
#  prime                    :string(255)
#  capture_phase            :string(255)
#  business_developer_id    :integer
#  created_at               :datetime
#  updated_at               :datetime
#  input_status             :string(255)
#  acquisition_url          :string(255)
#  outcome                  :string(255)
#  our_value                :integer
#  search_sink              :text
#  capture_manager_id       :integer
#  ignored                  :boolean         default(FALSE), not null
#  priority                 :integer
#  solicitation             :string(255)
#  solicitation_source      :string(255)
#  vehicle                  :string(255)
#

