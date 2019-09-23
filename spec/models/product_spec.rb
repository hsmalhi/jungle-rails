require "rails_helper"

RSpec.describe Product, type: :model do
  subject {
    Product.new(name: "Test", price_cents: 10, quantity: 10, category: Category.new(name: "Test"))
  }

  describe "Validations" do
    it "creates valid product with all required fields" do
      expect(subject).to be_valid
      expect(subject.errors.full_messages).to be_empty
    end

    it "creates invalid product without name" do
      subject.name = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages.first).to eq("Name can't be blank")
    end

    it "creates invalid product without price" do
      subject.price_cents = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages.first).to eq("Price cents is not a number")
    end

    it "creates invalid product without quantity" do
      subject.quantity = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages.first).to eq("Quantity can't be blank")
    end

    it "creates invalid product without category" do
      subject.category = nil
      expect(subject).to be_invalid
      expect(subject.errors.full_messages.first).to eq("Category can't be blank")
    end
  end
end
