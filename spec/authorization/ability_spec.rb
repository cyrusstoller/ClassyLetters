require 'spec_helper'
require "cancan/matchers"

describe Ability do
  before(:each) do
    @user = Factory(:user)
    @ability = Ability.new(@user)
  end
  describe "LettreOrder" do
    subject { @ability }
    it { should be_able_to(:manage, Factory(:lettre_order, :user_id => @user.id))}
    it { should_not be_able_to(:show, Factory(:lettre_order, :user_id => @user.id + 1))}
    it { should_not be_able_to(:update, Factory(:lettre_order, :user_id => @user.id + 1))}
    it { should_not be_able_to(:destroy, Factory(:lettre_order, :user_id => @user.id + 1))}
    it { should_not be_able_to(:manage, Factory(:lettre_order, :user_id => @user.id + 1))}
    
    it { should_not be_able_to(:update, Factory(:lettre_order, :delivery_status => 1, :user_id => @user.id))}
    it { should_not be_able_to(:destroy, Factory(:lettre_order, :delivery_status => 1, :user_id => @user.id))}
  end
end