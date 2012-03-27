require 'spec_helper'

describe User do
  describe "validations" do
    before(:each) do
      @user = Factory.create(:user)
    end

    it 'should require a name' do
      @user.name = ''
      @user.should_not be_valid
      @user.errors[:name].should_not be_empty
    end

    it 'should require an email' do
      @user.email = ''
      @user.should_not be_valid
      @user.errors[:email].should_not be_empty
    end

    it 'should have an unique email address' do
      second_user = User.new(:email => @user.email, :name => @user.name )
      second_user.should_not be_valid
      second_user.errors[:email].should_not be_empty
    end
  end
end
