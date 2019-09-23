require "rails_helper"

RSpec.describe Product, type: :model do
  subject {
    Product.new(name: "Test", price: 10, quantity: 10, category: Category.new(name: "Test"))
  }

  describe "Validations" do
    it "creates valid product with all required fields" do
      expect(subject).to be_valid
    end

    it "creates invalid product without name" do
      subject.name = nil
      expect(subject).to be_invalid
    end

    # it "creates valid product with all required fields" do
    #   expect(subject).to be_valid
    # end

    # it "creates valid product with all required fields" do
    #   expect(subject).to be_valid
    # end

    # it "creates valid product with all required fields" do
    #   expect(subject).to be_valid
    # end
  end
end
