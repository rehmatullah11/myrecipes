require "test_helper"

class ChefTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup 
    @chef= Chef.new(name:"Ali", email:"ali@gmail.com")
  end

  test "test should be valid" do
  assert @chef.valid?
  end

  test "name should be present" do
    @chef.name=" "
    assert_not @chef.valid?
  end

  test "name should be less than 30 character" do
    @chef.name= "a" *31
    assert_not @chef.valid?
  end

  test "email should be present" do 
    @chef.email = " "
    assert_not @chef.valid?
  end

  test "email should not be too long" do 
    @chef.email= "a" *245 + "@example.com"
    assert_not @chef.valid?
  end

  test "email should accept correct format" do 
    valid_emails= %w[user@example.com REHMAT@gmail.com R.first@yahoo.co john+smith@co.uk.org]
    valid_emails.each do |valids|
       @chef.email=valids
       assert @chef.valid?, "#{valids.inspect} should be valid"
    end
  end

  test "should reject invalid addresses" do 
    invalid_emails= %w[mashrur@example rehmat@gmail,com rehmat.name@gmail. joe@bar+foo.com]
    invalid_emails.each do |invalids|
       @chef.email=invalids
       assert_not @chef.valid?, "#{invalids.inspect} should be invalid"
    end
  end

  test "email should be unique and case insensitive" do 
    duplicate_chef=@chef.dup
    duplicate_chef.email=@chef.email.upcase
    @chef.save
    assert_not duplicate_chef.valid?
  end

  test "email should be lower case before hitting the database" do 
    mixed_email ="ReHmAtUlLaH@ExAmPlE.com"
    @chef.email =mixed_email
    @chef.save
    assert_equal mixed_email.downcase, @chef.reload.email
  end


end
