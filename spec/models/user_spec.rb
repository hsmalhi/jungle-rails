require "rails_helper"

RSpec.describe User, type: :model do
  subject {
    User.new(first_name: "Test", last_name: "Test", email: "Test@test.com", password: "test123", password_confirmation: "test123")
  }

  describe "Validations" do
    it "creates valid user when passwords match and required fields are filled" do
      expect(subject).to be_valid
      expect(subject.errors.full_messages).to be_empty
    end

    it "creates invalid user when passwords don't match" do
      subject.password_confirmation = "test"
      expect(subject).to be_invalid
      expect(subject.errors.full_messages.first).to eq("Password confirmation doesn't match Password")
    end

    it "creates invalid user when email is already taken" do
      subject.save
      subject2 = User.new(first_name: "Test2", last_name: "Test2", email: "Test@test.com", password: "test123", password_confirmation: "test123")
      expect(subject2).to be_invalid
    end

    it "creates invalid user with email which is off by a case" do
      subject.save
      subject2 = User.new(first_name: "Test2", last_name: "Test2", email: "tEST@test.com", password: "test123", password_confirmation: "test123")
      expect(subject2).to be_invalid
    end

    it "creates invalid user without first_name" do
      subject.first_name = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages.first).to eq("First name can't be blank")
    end

    it "creates invalid user without last_name" do
      subject.last_name = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages.first).to eq("Last name can't be blank")
    end

    it "creates invalid user without email" do
      subject.email = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages.first).to eq("Email can't be blank")
    end

    it "creates invalid user with password shorter than 6" do
      subject.password = "test"
      subject.password_confirmation = "test"
      expect(subject).to be_invalid
      expect(subject.errors.full_messages.first).to eq("Password is too short (minimum is 6 characters)")
    end
  end

  describe ".authenticate_with_credentials" do
    it "authenticates existing user with correct email password" do
      subject.save
      expect(User.authenticate_with_credentials("Test@test.com", "test123")).to be_a User
    end

    it "does not authenticate a user with wrong email" do
      subject.save
      expect(User.authenticate_with_credentials("test1@test.com", "test123")).to be nil
    end

    it "does not authenticate a user with wrong password" do
      subject.save
      expect(User.authenticate_with_credentials("test@test.com", "test1234")).to be nil
    end

    it "authenticates existing user with correct email password with leading and trailing spaces" do
      subject.save
      expect(User.authenticate_with_credentials(" Test@test.com ", "test123")).to be_a User
    end

    it "authenticates existing user with correct email password which is off by case" do
      subject.save
      expect(User.authenticate_with_credentials("TEST@test.com", "test123")).to be_a User
    end
  end
end
