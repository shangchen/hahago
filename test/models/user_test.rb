require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
  	@user=User.new(name: "Example User", email: "user@example.com",
  		password: "foobar", password_confirmation: "foobar")
  end

	test "should be valid" do
		assert @user.valid?
	end

	test "name should be present" do
		@user.name=" "
		assert_not @user.valid?
	end

	test "name should be less than 50 charactor" do
		@user.name='a'*51
		assert_not @user.valid?
	end


	test "email should be present" do
		@user.name="aaaaaa"
		@user.email=" "
		assert_not @user.valid?
	end

	test "email should be less than 255 charactor" do
		@user.name="aaaaa"
		@user.email="a"*244+"@example.com"
		assert_not @user.valid?
	end

	test "email validate should accept valid address" do
		email_addresses=%w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
        email_addresses.each do |valid_email|
        	@user.email=valid_email
        	assert @user.valid?,"#{valid_email.inspect} should be valid"
        end
	end

	test "email validate should reject invalid address" do
		email_addresses=%w[ser@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
        email_addresses.each do |invalid_email|
        	@user.email=invalid_email
        	assert_not @user.valid?, "#{invalid_email.inspect} should be invalid"
        end
	end

	test "email should be unique" do
		duplicate_user=@user.dup
		@user.save
		assert_not duplicate_user.valid?
		duplicate_user.email=@user.email.upcase
		assert_not duplicate_user.valid?
	end

	test "email should be saved as lower-case" do
		mix_email="NiKo@gmaiL.Com"
		@user.email=mix_email
		@user.save
		assert_equal mix_email.downcase,@user.reload.email
	end

end
